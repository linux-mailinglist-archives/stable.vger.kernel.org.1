Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB377D3536
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjJWLqX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbjJWLqE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:46:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909B11704
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:45:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E6EC433C8;
        Mon, 23 Oct 2023 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061552;
        bh=CHdY694qwkMJBO81ZXCzjfPC7szp+zFVAaq7iRd2JUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Di8Brd6fSibA21HeVIMUwY99bu79BGzEQM3cFBI6Bi0IvrWcfctBqWY7lol2mG9PQ
         XJOptdt01Uu+Nlm1UEQ5ApMr6xCNh0pQnx+R2zgc+8KwhcLYKd+o+wRtGEHVBnClZd
         EAQCQKnD9fB8/H8XppEpTDJo3kiOcfd8oUqtg37c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Subject: [PATCH 5.10 085/202] usb: hub: Guard against accesses to uninitialized BOS descriptors
Date:   Mon, 23 Oct 2023 12:56:32 +0200
Message-ID: <20231023104829.022014457@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Cañuelo <ricardo.canuelo@collabora.com>

commit f74a7afc224acd5e922c7a2e52244d891bbe44ee upstream.

Many functions in drivers/usb/core/hub.c and drivers/usb/core/hub.h
access fields inside udev->bos without checking if it was allocated and
initialized. If usb_get_bos_descriptor() fails for whatever
reason, udev->bos will be NULL and those accesses will result in a
crash:

BUG: kernel NULL pointer dereference, address: 0000000000000018
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 5 PID: 17818 Comm: kworker/5:1 Tainted: G W 5.15.108-18910-gab0e1cb584e1 #1 <HASH:1f9e 1>
Hardware name: Google Kindred/Kindred, BIOS Google_Kindred.12672.413.0 02/03/2021
Workqueue: usb_hub_wq hub_event
RIP: 0010:hub_port_reset+0x193/0x788
Code: 89 f7 e8 20 f7 15 00 48 8b 43 08 80 b8 96 03 00 00 03 75 36 0f b7 88 92 03 00 00 81 f9 10 03 00 00 72 27 48 8b 80 a8 03 00 00 <48> 83 78 18 00 74 19 48 89 df 48 8b 75 b0 ba 02 00 00 00 4c 89 e9
RSP: 0018:ffffab740c53fcf8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffa1bc5f678000 RCX: 0000000000000310
RDX: fffffffffffffdff RSI: 0000000000000286 RDI: ffffa1be9655b840
RBP: ffffab740c53fd70 R08: 00001b7d5edaa20c R09: ffffffffb005e060
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: ffffab740c53fd3e R14: 0000000000000032 R15: 0000000000000000
FS: 0000000000000000(0000) GS:ffffa1be96540000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000018 CR3: 000000022e80c005 CR4: 00000000003706e0
Call Trace:
hub_event+0x73f/0x156e
? hub_activate+0x5b7/0x68f
process_one_work+0x1a2/0x487
worker_thread+0x11a/0x288
kthread+0x13a/0x152
? process_one_work+0x487/0x487
? kthread_associate_blkcg+0x70/0x70
ret_from_fork+0x1f/0x30

Fall back to a default behavior if the BOS descriptor isn't accessible
and skip all the functionalities that depend on it: LPM support checks,
Super Speed capabilitiy checks, U1/U2 states setup.

Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230830100418.1952143-1-ricardo.canuelo@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/hub.c |   28 ++++++++++++++++++++++++----
 drivers/usb/core/hub.h |    2 +-
 2 files changed, 25 insertions(+), 5 deletions(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -149,6 +149,10 @@ int usb_device_supports_lpm(struct usb_d
 	if (udev->quirks & USB_QUIRK_NO_LPM)
 		return 0;
 
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return 0;
+
 	/* USB 2.1 (and greater) devices indicate LPM support through
 	 * their USB 2.0 Extended Capabilities BOS descriptor.
 	 */
@@ -325,6 +329,10 @@ static void usb_set_lpm_parameters(struc
 	if (!udev->lpm_capable || udev->speed < USB_SPEED_SUPER)
 		return;
 
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return;
+
 	hub = usb_hub_to_struct_hub(udev->parent);
 	/* It doesn't take time to transition the roothub into U0, since it
 	 * doesn't have an upstream link.
@@ -2684,7 +2692,8 @@ out_authorized:
 }
 
 /*
- * Return 1 if port speed is SuperSpeedPlus, 0 otherwise
+ * Return 1 if port speed is SuperSpeedPlus, 0 otherwise or if the
+ * capability couldn't be checked.
  * check it from the link protocol field of the current speed ID attribute.
  * current speed ID is got from ext port status request. Sublink speed attribute
  * table is returned with the hub BOS SSP device capability descriptor
@@ -2694,8 +2703,12 @@ static int port_speed_is_ssp(struct usb_
 	int ssa_count;
 	u32 ss_attr;
 	int i;
-	struct usb_ssp_cap_descriptor *ssp_cap = hdev->bos->ssp_cap;
+	struct usb_ssp_cap_descriptor *ssp_cap;
 
+	if (!hdev->bos)
+		return 0;
+
+	ssp_cap = hdev->bos->ssp_cap;
 	if (!ssp_cap)
 		return 0;
 
@@ -4114,8 +4127,15 @@ static void usb_enable_link_state(struct
 		enum usb3_link_state state)
 {
 	int timeout, ret;
-	__u8 u1_mel = udev->bos->ss_cap->bU1devExitLat;
-	__le16 u2_mel = udev->bos->ss_cap->bU2DevExitLat;
+	__u8 u1_mel;
+	__le16 u2_mel;
+
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return;
+
+	u1_mel = udev->bos->ss_cap->bU1devExitLat;
+	u2_mel = udev->bos->ss_cap->bU2DevExitLat;
 
 	/* If the device says it doesn't have *any* exit latency to come out of
 	 * U1 or U2, it's probably lying.  Assume it doesn't implement that link
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -141,7 +141,7 @@ static inline int hub_is_superspeedplus(
 {
 	return (hdev->descriptor.bDeviceProtocol == USB_HUB_PR_SS &&
 		le16_to_cpu(hdev->descriptor.bcdUSB) >= 0x0310 &&
-		hdev->bos->ssp_cap);
+		hdev->bos && hdev->bos->ssp_cap);
 }
 
 static inline unsigned hub_power_on_good_delay(struct usb_hub *hub)


