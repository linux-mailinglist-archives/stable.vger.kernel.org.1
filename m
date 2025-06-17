Return-Path: <stable+bounces-154126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B8EADD86A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B50B4A4D4E
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D872ECE80;
	Tue, 17 Jun 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DFBbFA+j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BFC2ECD33;
	Tue, 17 Jun 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178185; cv=none; b=H9u8GzhOrBdv0wlcEMBj3DDIW2rAUClBHt3kxpU+FtSBOJpL+B8kWKstBmacvnIKzF9MQBZeV2p3RPzLR3IzT0KqXcJf9gRM1Xmlwo+zyHrgqUpm420/ucgXsyI3XyiN1A6aKcj3WBHeNzdRjZBeIt1CCet6cX0eWUm0tAUqrV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178185; c=relaxed/simple;
	bh=adF2D8o5y1jWPRLIdtuxNSHWFd4gxAtdxg6Kk9bvBos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alyfJ98w90sW5+XwPtlhqNbPxF7oQ0gxfmTNbyigOUQBJkkw+3vZW3/OHv/k0k+R7Lgg7ramUxkxZXSmXJMvjEUOeIx6tloer9tNK5DYIczv5KBGLDQlNrs00aFg2HlXErFOROF/uRgoMCmliwYc+OfvVL2C1YJIv/29AgtPITQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DFBbFA+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB145C4CEE3;
	Tue, 17 Jun 2025 16:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178185;
	bh=adF2D8o5y1jWPRLIdtuxNSHWFd4gxAtdxg6Kk9bvBos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DFBbFA+j3QY1lvmXm3Yr7H5hYMrz0iVmhH8hB58MmUjm92Uk9+4TXYanprlkoUf9f
	 Ge+gmEIKtEgu+CZc7LBSsk78tGXHxFU4JxAO9P1XMk0dK/yl2kNO3c/urr6hqgPgI/
	 evGejzACA/iVKrxyQw4jk5P1xdst8z1u5MKp2DD0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 458/512] Bluetooth: eir: Fix possible crashes on eir_create_adv_data
Date: Tue, 17 Jun 2025 17:27:04 +0200
Message-ID: <20250617152438.128469350@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 47c03902269aff377f959dc3fd94a9733aa31d6e ]

eir_create_adv_data may attempt to add EIR_FLAGS and EIR_TX_POWER
without checking if that would fit.

Link: https://github.com/bluez/bluez/issues/1117#issuecomment-2958244066
Fixes: 01ce70b0a274 ("Bluetooth: eir: Move EIR/Adv Data functions to its own file")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/eir.c      | 7 ++++---
 net/bluetooth/eir.h      | 2 +-
 net/bluetooth/hci_sync.c | 5 +++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 3e1713673ecc9..3f72111ba651f 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -242,7 +242,7 @@ u8 eir_create_per_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 	return ad_len;
 }
 
-u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
+u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size)
 {
 	struct adv_info *adv = NULL;
 	u8 ad_len = 0, flags = 0;
@@ -286,7 +286,7 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		/* If flags would still be empty, then there is no need to
 		 * include the "Flags" AD field".
 		 */
-		if (flags) {
+		if (flags && (ad_len + eir_precalc_len(1) <= size)) {
 			ptr[0] = 0x02;
 			ptr[1] = EIR_FLAGS;
 			ptr[2] = flags;
@@ -316,7 +316,8 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		}
 
 		/* Provide Tx Power only if we can provide a valid value for it */
-		if (adv_tx_power != HCI_TX_POWER_INVALID) {
+		if (adv_tx_power != HCI_TX_POWER_INVALID &&
+		    (ad_len + eir_precalc_len(1) <= size)) {
 			ptr[0] = 0x02;
 			ptr[1] = EIR_TX_POWER;
 			ptr[2] = (u8)adv_tx_power;
diff --git a/net/bluetooth/eir.h b/net/bluetooth/eir.h
index 5c89a05e8b290..9372db83f912f 100644
--- a/net/bluetooth/eir.h
+++ b/net/bluetooth/eir.h
@@ -9,7 +9,7 @@
 
 void eir_create(struct hci_dev *hdev, u8 *data);
 
-u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr);
+u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size);
 u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr);
 u8 eir_create_per_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3fb70b4ee8c8a..a00316d79dbf5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1846,7 +1846,8 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 			return 0;
 	}
 
-	len = eir_create_adv_data(hdev, instance, pdu->data);
+	len = eir_create_adv_data(hdev, instance, pdu->data,
+				  HCI_MAX_EXT_AD_LENGTH);
 
 	pdu->length = len;
 	pdu->handle = adv ? adv->handle : instance;
@@ -1877,7 +1878,7 @@ static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
 
 	memset(&cp, 0, sizeof(cp));
 
-	len = eir_create_adv_data(hdev, instance, cp.data);
+	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
 
 	/* There's nothing to do if the data hasn't changed */
 	if (hdev->adv_data_len == len &&
-- 
2.39.5




