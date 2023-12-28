Return-Path: <stable+bounces-8635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07E681F788
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 12:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98577283EDC
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 11:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2777663DB;
	Thu, 28 Dec 2023 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uoeMKcbG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F4B6FB6
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 11:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197E3C433C7;
	Thu, 28 Dec 2023 11:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703761556;
	bh=idkJKu3IrHpWaUfBOOBT+fuPNQVXHRpNVNC1ssQuV+k=;
	h=Subject:To:Cc:From:Date:From;
	b=uoeMKcbGvcfZWo8WAG/4eeL0L/ta89raSfPYPIwXzVAUugfjMfPTC17e/drPG3oqf
	 DsBedU4N+Oqk8SnVlMZbee/jsEd50P1oIbEhane4CeHBaSY0YLa1JHez8JjOvXpRlE
	 ITQ4sjO1hMF/yrNmOzGkoUALRqItK0q1Ev7AdQ/0=
Subject: FAILED: patch "[PATCH] Bluetooth: Add more enc key size check" failed to apply to 4.19-stable tree
To: alex_lu@realsil.com.cn,luiz.von.dentz@intel.com,max.chou@realtek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 Dec 2023 11:05:53 +0000
Message-ID: <2023122853-sneer-gradient-e007@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 04a342cc49a8522e99c9b3346371c329d841dcd2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023122853-sneer-gradient-e007@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

04a342cc49a8 ("Bluetooth: Add more enc key size check")
278d933e12f1 ("Bluetooth: Normalize HCI_OP_READ_ENC_KEY_SIZE cmdcmplt")
c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to handle Command Complete")
3e54c5890c87 ("Bluetooth: hci_event: Use of a function table to handle HCI events")
12cfe4176ad6 ("Bluetooth: HCI: Use skb_pull_data to parse LE Metaevents")
70a6b8de6af5 ("Bluetooth: HCI: Use skb_pull_data to parse Extended Inquiry Result event")
8d08d324fdcb ("Bluetooth: HCI: Use skb_pull_data to parse Inquiry Result with RSSI event")
27d9eb4bcac1 ("Bluetooth: HCI: Use skb_pull_data to parse Inquiry Result event")
aadc3d2f42a5 ("Bluetooth: HCI: Use skb_pull_data to parse Number of Complete Packets event")
e3f3a1aea871 ("Bluetooth: HCI: Use skb_pull_data to parse Command Complete event")
ae61a10d9d46 ("Bluetooth: HCI: Use skb_pull_data to parse BR/EDR events")
3244845c6307 ("Bluetooth: hci_sync: Convert MGMT_OP_SSP")
6f6ff38a1e14 ("Bluetooth: hci_sync: Convert MGMT_OP_SET_LOCAL_NAME")
cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")
ad383c2c65a5 ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
e8907f76544f ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 3")
cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
161510ccf91c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 1")
6a98e3836fa2 ("Bluetooth: Add helper for serialized HCI command execution")
4139ff008330 ("Bluetooth: Fix wrong opcode when LL privacy enabled")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 04a342cc49a8522e99c9b3346371c329d841dcd2 Mon Sep 17 00:00:00 2001
From: Alex Lu <alex_lu@realsil.com.cn>
Date: Tue, 12 Dec 2023 10:30:34 +0800
Subject: [PATCH] Bluetooth: Add more enc key size check

When we are slave role and receives l2cap conn req when encryption has
started, we should check the enc key size to avoid KNOB attack or BLUFFS
attack.
From SIG recommendation, implementations are advised to reject
service-level connections on an encrypted baseband link with key
strengths below 7 octets.
A simple and clear way to achieve this is to place the enc key size
check in hci_cc_read_enc_key_size()

The btmon log below shows the case that lacks enc key size check.

> HCI Event: Connect Request (0x04) plen 10
        Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Class: 0x480104
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Desktop workstation
          Capturing (Scanner, Microphone)
          Telephony (Cordless telephony, Modem, Headset)
        Link type: ACL (0x01)
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
        Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Role: Peripheral (0x01)
> HCI Event: Command Status (0x0f) plen 4
      Accept Connection Request (0x01|0x0009) ncmd 2
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11
        Status: Success (0x00)
        Handle: 1
        Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
...

> HCI Event: Encryption Change (0x08) plen 4
        Status: Success (0x00)
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Encryption: Enabled with E0 (0x01)
< HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
> HCI Event: Command Complete (0x0e) plen 7
      Read Encryption Key Size (0x05|0x0008) ncmd 2
        Status: Success (0x00)
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Key size: 6
// We should check the enc key size
...

> ACL Data RX: Handle 1 flags 0x02 dlen 12
      L2CAP: Connection Request (0x02) ident 3 len 4
        PSM: 25 (0x0019)
        Source CID: 64
< ACL Data TX: Handle 1 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection pending (0x0001)
        Status: Authorization pending (0x0002)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Count: 1
        #35: len 16 (25 Kb/s)
        Latency: 5 msec (2-7 msec ~4 msec)
< ACL Data TX: Handle 1 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)

Cc: stable@vger.kernel.org
Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Max Chou <max.chou@realtek.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cc5fd290d529..ebf17b51072f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -750,9 +750,23 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
 	} else {
 		conn->enc_key_size = rp->key_size;
 		status = 0;
+
+		if (conn->enc_key_size < hdev->min_enc_key_size) {
+			/* As slave role, the conn->state has been set to
+			 * BT_CONNECTED and l2cap conn req might not be received
+			 * yet, at this moment the l2cap layer almost does
+			 * nothing with the non-zero status.
+			 * So we also clear encrypt related bits, and then the
+			 * handler of l2cap conn req will get the right secure
+			 * state at a later time.
+			 */
+			status = HCI_ERROR_AUTH_FAILURE;
+			clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
+			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+		}
 	}
 
-	hci_encrypt_cfm(conn, 0);
+	hci_encrypt_cfm(conn, status);
 
 done:
 	hci_dev_unlock(hdev);


