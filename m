Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FC47CA14C
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJPIJw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPIJv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:09:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE14E1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:09:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a0c:5a83:9102:3700:b556:740c:ec6e:dc39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 13C6066072AF;
        Mon, 16 Oct 2023 09:09:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697443788;
        bh=kHjIXiXYD8eXEGlw7YFyZ+OpIGO/wmieLDENvt5wHkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ProD+4Co5e6d3IrV8nzpa0glew9UyHZsGYN6j+8J3+PeNOfp4rYnrHsiHMIqgDadw
         LW/qX5WCTqSLX7jiX0FQKWNhzO7Gzswes1au2V97Y7axTTOmvI0n6KqPbEmFRyX0Tu
         kkybbnx1d44F4nWM2GVJACZDA1GAF35KPeRHZ3YwiKeWKTUJ2fgCTlDim4pVUMzz3C
         g7vkx1gmStzHgu5xutXlOegzCSJ5q4LkV7FF0FLZvOlwmyknXB4RewsqDcJ/0Xy3ST
         8Dw2eq5hHwu8FvW9b1IfDEQo9gdBQ1CFwI3VIZ2E/d6FSl/wraX74DGvOmDxHv8Fsf
         +RGIaHosubcqA==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     stable@vger.kernel.org
Cc:     kernel@collabora.com
Subject: [PATCH 5.15.y] usb: hub: Guard against accesses to uninitialized BOS descriptors
Date:   Mon, 16 Oct 2023 10:09:30 +0200
Message-Id: <20231016080930.3351178-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023101546-blinker-remote-0be1@gregkh>
References: <2023101546-blinker-remote-0be1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
(cherry picked from commit f74a7afc224acd5e922c7a2e52244d891bbe44ee)
---
 drivers/usb/core/hub.c | 25 ++++++++++++++++++++++---
 drivers/usb/core/hub.h |  2 +-
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 4eb453d7e6f8..4bed41ca6b0f 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -150,6 +150,10 @@ int usb_device_supports_lpm(struct usb_device *udev)
 	if (udev->quirks & USB_QUIRK_NO_LPM)
 		return 0;
 
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return 0;
+
 	/* USB 2.1 (and greater) devices indicate LPM support through
 	 * their USB 2.0 Extended Capabilities BOS descriptor.
 	 */
@@ -326,6 +330,10 @@ static void usb_set_lpm_parameters(struct usb_device *udev)
 	if (!udev->lpm_capable || udev->speed < USB_SPEED_SUPER)
 		return;
 
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return;
+
 	hub = usb_hub_to_struct_hub(udev->parent);
 	/* It doesn't take time to transition the roothub into U0, since it
 	 * doesn't have an upstream link.
@@ -2698,13 +2706,17 @@ int usb_authorize_device(struct usb_device *usb_dev)
 static enum usb_ssp_rate get_port_ssp_rate(struct usb_device *hdev,
 					   u32 ext_portstatus)
 {
-	struct usb_ssp_cap_descriptor *ssp_cap = hdev->bos->ssp_cap;
+	struct usb_ssp_cap_descriptor *ssp_cap;
 	u32 attr;
 	u8 speed_id;
 	u8 ssac;
 	u8 lanes;
 	int i;
 
+	if (!hdev->bos)
+		goto out;
+
+	ssp_cap = hdev->bos->ssp_cap;
 	if (!ssp_cap)
 		goto out;
 
@@ -4186,8 +4198,15 @@ static void usb_enable_link_state(struct usb_hcd *hcd, struct usb_device *udev,
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
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 22ea1f4f2d66..db4c7e2c5960 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -141,7 +141,7 @@ static inline int hub_is_superspeedplus(struct usb_device *hdev)
 {
 	return (hdev->descriptor.bDeviceProtocol == USB_HUB_PR_SS &&
 		le16_to_cpu(hdev->descriptor.bcdUSB) >= 0x0310 &&
-		hdev->bos->ssp_cap);
+		hdev->bos && hdev->bos->ssp_cap);
 }
 
 static inline unsigned hub_power_on_good_delay(struct usb_hub *hub)
-- 
2.25.1

