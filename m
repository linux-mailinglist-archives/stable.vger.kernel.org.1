Return-Path: <stable+bounces-38342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AE48A0E1F
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D761F216A1
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C352214659B;
	Thu, 11 Apr 2024 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N5Jmnj20"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B81448EF;
	Thu, 11 Apr 2024 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830272; cv=none; b=uz0zzOH+L5RKYDMozt33Wdf1yKXdVMbGCB4bJmcbjgT2AFi05krXeNMb8uJXAcg1XA9JwOnvtB5KF2Xb3sGrf80EONhtQHMPymaM91OBW47MzhnM6xGy3QNYgicJpaeIyhAeOG7r3bssmku80SdMCRGhSBCmTaYVtwBK5Pr3fBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830272; c=relaxed/simple;
	bh=0bmVc2pA9MRlvNLbdeDYPN6axeDlNjdXMY2KEwY9/WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHXGebFyf3qvURT1cqZMYtSihtWF+zIr8rUSd73nUnsBrttp3PHqTzJ9mG+/pKUL3CtmNu+ci0gOpnHra/qDKHjuIOEnG9LC1ADOnzxO5VB462qCT1fuPWhwn2SSvlShvxx82/p1HcumIoicZgrZO/jdWyb60zdM6xKJjlXWTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N5Jmnj20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FB5C433F1;
	Thu, 11 Apr 2024 10:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830272;
	bh=0bmVc2pA9MRlvNLbdeDYPN6axeDlNjdXMY2KEwY9/WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5Jmnj206tt+fSFCHHLsYzDhSdSC+c2SHoF7yyw05HjNsWxuU/NL/rEICYn80Mbjj
	 FgRC61bnhZgkQbnMPnck/yRQWnfq6BZrcYf5ZLcREUWogJKw5xwnn1QsM8S0PUZKdJ
	 REKtoOcNDpLqxy+osxE1A8OsoMCVh+RtiReDxrcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vinicius Peixoto <nukelet64@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 056/143] Bluetooth: Add new quirk for broken read key length on ATS2851
Date: Thu, 11 Apr 2024 11:55:24 +0200
Message-ID: <20240411095422.602701774@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
References: <20240411095420.903937140@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinicius Peixoto <nukelet64@gmail.com>

[ Upstream commit 48201a3b3f398be6a01f78a14b18bd5d31c47458 ]

The ATS2851 controller erroneously reports support for the "Read
Encryption Key Length" HCI command. This makes it unable to connect
to any devices, since this command is issued by the kernel during the
connection process in response to an "Encryption Change" HCI event.

Add a new quirk (HCI_QUIRK_BROKEN_ENC_KEY_SIZE) to hint that the command
is unsupported, preventing it from interrupting the connection process.

This is the error log from btmon before this patch:

> HCI Event: Encryption Change (0x08) plen 4
        Status: Success (0x00)
        Handle: 2048 Address: ...
        Encryption: Enabled with E0 (0x01)
< HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2
        Handle: 2048 Address: ...
> HCI Event: Command Status (0x0f) plen 4
      Read Encryption Key Size (0x05|0x0008) ncmd 1
        Status: Unknown HCI Command (0x01)

Signed-off-by: Vinicius Peixoto <nukelet64@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c   | 1 +
 include/net/bluetooth/hci.h | 8 ++++++++
 net/bluetooth/hci_event.c   | 3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6cb87d47ad7d5..f684108dc2f1c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4483,6 +4483,7 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks);
 	}
 
 	if (!reset)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 03e68a8e229f5..35c5f75a3a5ee 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -339,6 +339,14 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_BROKEN_LE_CODED,
+
+	/*
+	 * When this quirk is set, the HCI_OP_READ_ENC_KEY_SIZE command is
+	 * skipped during an HCI_EV_ENCRYPT_CHANGE event. This is required
+	 * for Actions Semiconductor ATS2851 based controllers, which erroneously
+	 * claim to support it.
+	 */
+	HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3b63513f57ba8..3992e18f0babb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3679,7 +3679,8 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 		 * controller really supports it. If it doesn't, assume
 		 * the default size (16).
 		 */
-		if (!(hdev->commands[20] & 0x10)) {
+		if (!(hdev->commands[20] & 0x10) ||
+		    test_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks)) {
 			conn->enc_key_size = HCI_LINK_KEY_SIZE;
 			goto notify;
 		}
-- 
2.43.0




