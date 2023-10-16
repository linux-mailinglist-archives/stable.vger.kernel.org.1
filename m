Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DB27CA2BC
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjJPIxs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjJPIxs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:53:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7A6E3
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:53:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2B2C433C7;
        Mon, 16 Oct 2023 08:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446426;
        bh=dZTE5gWukudq7XbVchNgfk8B5LjFAq+ft6jLsZ8NwN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ix6j/A2tj+/jkOdNAYCtJ8V0Q08PuaLL5LibhsJu8WkdsdXxbNnNO5rIapZN+RMp9
         CzYL+kZ64n6PA81Q/rHGLznThlwiwhyLydxBJByVMVOlQLjb2h4Wkyuv8XWhD62f44
         r/HqXx7lndhU8Xj19ZQI/8k/Uq1k8VpuKumLGkJA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 6.1 009/131] HID: logitech-hidpp: Fix kernel crash on receiver USB disconnect
Date:   Mon, 16 Oct 2023 10:39:52 +0200
Message-ID: <20231016084000.296335361@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit dac501397b9d81e4782232c39f94f4307b137452 upstream.

hidpp_connect_event() has *four* time-of-check vs time-of-use (TOCTOU)
races when it races with itself.

hidpp_connect_event() primarily runs from a workqueue but it also runs
on probe() and if a "device-connected" packet is received by the hw
when the thread running hidpp_connect_event() from probe() is waiting on
the hw, then a second thread running hidpp_connect_event() will be
started from the workqueue.

This opens the following races (note the below code is simplified):

1. Retrieving + printing the protocol (harmless race):

	if (!hidpp->protocol_major) {
		hidpp_root_get_protocol_version()
		hidpp->protocol_major = response.rap.params[0];
	}

We can actually see this race hit in the dmesg in the abrt output
attached to rhbz#2227968:

[ 3064.624215] logitech-hidpp-device 0003:046D:4071.0049: HID++ 4.5 device connected.
[ 3064.658184] logitech-hidpp-device 0003:046D:4071.0049: HID++ 4.5 device connected.

Testing with extra logging added has shown that after this the 2 threads
take turn grabbing the hw access mutex (send_mutex) so they ping-pong
through all the other TOCTOU cases managing to hit all of them:

2. Updating the name to the HIDPP name (harmless race):

	if (hidpp->name == hdev->name) {
		...
		hidpp->name = new_name;
	}

3. Initializing the power_supply class for the battery (problematic!):

hidpp_initialize_battery()
{
        if (hidpp->battery.ps)
                return 0;

	probe_battery(); /* Blocks, threads take turns executing this */

	hidpp->battery.desc.properties =
		devm_kmemdup(dev, hidpp_battery_props, cnt, GFP_KERNEL);

	hidpp->battery.ps =
		devm_power_supply_register(&hidpp->hid_dev->dev,
					   &hidpp->battery.desc, cfg);
}

4. Creating delayed input_device (potentially problematic):

	if (hidpp->delayed_input)
		return;

	hidpp->delayed_input = hidpp_allocate_input(hdev);

The really big problem here is 3. Hitting the race leads to the following
sequence:

	hidpp->battery.desc.properties =
		devm_kmemdup(dev, hidpp_battery_props, cnt, GFP_KERNEL);

	hidpp->battery.ps =
		devm_power_supply_register(&hidpp->hid_dev->dev,
					   &hidpp->battery.desc, cfg);

	...

	hidpp->battery.desc.properties =
		devm_kmemdup(dev, hidpp_battery_props, cnt, GFP_KERNEL);

	hidpp->battery.ps =
		devm_power_supply_register(&hidpp->hid_dev->dev,
					   &hidpp->battery.desc, cfg);

So now we have registered 2 power supplies for the same battery,
which looks a bit weird from userspace's pov but this is not even
the really big problem.

Notice how:

1. This is all devm-maganaged
2. The hidpp->battery.desc struct is shared between the 2 power supplies
3. hidpp->battery.desc.properties points to the result from the second
   devm_kmemdup()

This causes a use after free scenario on USB disconnect of the receiver:
1. The last registered power supply class device gets unregistered
2. The memory from the last devm_kmemdup() call gets freed,
   hidpp->battery.desc.properties now points to freed memory
3. The first registered power supply class device gets unregistered,
   this involves sending a remove uevent to userspace which invokes
   power_supply_uevent() to fill the uevent data
4. power_supply_uevent() uses hidpp->battery.desc.properties which
   now points to freed memory leading to backtraces like this one:

Sep 22 20:01:35 eric kernel: BUG: unable to handle page fault for address: ffffb2140e017f08
...
Sep 22 20:01:35 eric kernel: Workqueue: usb_hub_wq hub_event
Sep 22 20:01:35 eric kernel: RIP: 0010:power_supply_uevent+0xee/0x1d0
...
Sep 22 20:01:35 eric kernel:  ? asm_exc_page_fault+0x26/0x30
Sep 22 20:01:35 eric kernel:  ? power_supply_uevent+0xee/0x1d0
Sep 22 20:01:35 eric kernel:  ? power_supply_uevent+0x10d/0x1d0
Sep 22 20:01:35 eric kernel:  dev_uevent+0x10f/0x2d0
Sep 22 20:01:35 eric kernel:  kobject_uevent_env+0x291/0x680
Sep 22 20:01:35 eric kernel:  power_supply_unregister+0x8e/0xa0
Sep 22 20:01:35 eric kernel:  release_nodes+0x3d/0xb0
Sep 22 20:01:35 eric kernel:  devres_release_group+0xfc/0x130
Sep 22 20:01:35 eric kernel:  hid_device_remove+0x56/0xa0
Sep 22 20:01:35 eric kernel:  device_release_driver_internal+0x19f/0x200
Sep 22 20:01:35 eric kernel:  bus_remove_device+0xc6/0x130
Sep 22 20:01:35 eric kernel:  device_del+0x15c/0x3f0
Sep 22 20:01:35 eric kernel:  ? __queue_work+0x1df/0x440
Sep 22 20:01:35 eric kernel:  hid_destroy_device+0x4b/0x60
Sep 22 20:01:35 eric kernel:  logi_dj_remove+0x9a/0x100 [hid_logitech_dj 5c91534a0ead2b65e04dd799a0437e3b99b21bc4]
Sep 22 20:01:35 eric kernel:  hid_device_remove+0x44/0xa0
Sep 22 20:01:35 eric kernel:  device_release_driver_internal+0x19f/0x200
Sep 22 20:01:35 eric kernel:  bus_remove_device+0xc6/0x130
Sep 22 20:01:35 eric kernel:  device_del+0x15c/0x3f0
Sep 22 20:01:35 eric kernel:  ? __queue_work+0x1df/0x440
Sep 22 20:01:35 eric kernel:  hid_destroy_device+0x4b/0x60
Sep 22 20:01:35 eric kernel:  usbhid_disconnect+0x47/0x60 [usbhid 727dcc1c0b94e6b4418727a468398ac3bca492f3]
Sep 22 20:01:35 eric kernel:  usb_unbind_interface+0x90/0x270
Sep 22 20:01:35 eric kernel:  device_release_driver_internal+0x19f/0x200
Sep 22 20:01:35 eric kernel:  bus_remove_device+0xc6/0x130
Sep 22 20:01:35 eric kernel:  device_del+0x15c/0x3f0
Sep 22 20:01:35 eric kernel:  ? kobject_put+0xa0/0x1d0
Sep 22 20:01:35 eric kernel:  usb_disable_device+0xcd/0x1e0
Sep 22 20:01:35 eric kernel:  usb_disconnect+0xde/0x2c0
Sep 22 20:01:35 eric kernel:  usb_disconnect+0xc3/0x2c0
Sep 22 20:01:35 eric kernel:  hub_event+0xe80/0x1c10

There have been quite a few bug reports (see Link tags) about this crash.

Fix all the TOCTOU issues, including the really bad power-supply related
system crash on USB disconnect, by making probe() use the workqueue for
running hidpp_connect_event() too, so that it can never run more then once.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2227221
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2227968
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2227968
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2242189
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217412#c58
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231005182638.3776-1-hdegoede@redhat.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-logitech-hidpp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4275,7 +4275,8 @@ static int hidpp_probe(struct hid_device
 			goto hid_hw_init_fail;
 	}
 
-	hidpp_connect_event(hidpp);
+	schedule_work(&hidpp->work);
+	flush_work(&hidpp->work);
 
 	if (will_restart) {
 		/* Reset the HID node state */


