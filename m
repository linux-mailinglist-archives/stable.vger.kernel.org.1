Return-Path: <stable+bounces-45212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A088C6BCB
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 20:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C9A283E10
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03B7158DAF;
	Wed, 15 May 2024 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE+WV4uC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD70158845;
	Wed, 15 May 2024 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796195; cv=none; b=Ejjpo7M8OSKMN7eVaoVb0vkP7hFjYQU5umF/peQAdZ4YUvWfwCFDk9h6PIPCAKnXocBec4yGAad9OlA/mzNaJu3sW6Lc3s4BuwJrJuNNp21iIPDTUWgaAGH+i5zjnV9Ufcv04UqKRHVhSE98K+5GwV4IJlz7KRaHAxyjezbp22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796195; c=relaxed/simple;
	bh=txhE9yLbvyINoFRx5oOhUzn9ez170Ndrwlt6oJvNTlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qEsRPobBvbzufstsPWfidunbsZtyUXjxOydt7UP3EByJdZLuQ9Bm2YtF8Pw+BmYI5vbPbVD7Z381lOo7h8LugX09L7ECHDM5Gz9wag6pPdY6ctRUsm1KakPWlq474LxSKXSkntXcjWnR7Ex1UR0afewa6IgEhTDqrHQy9VyJh/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE+WV4uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16D13C116B1;
	Wed, 15 May 2024 18:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715796195;
	bh=txhE9yLbvyINoFRx5oOhUzn9ez170Ndrwlt6oJvNTlQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=BE+WV4uChXDQFO14BluQcqHrF5XnHC0NSLWQDElFDAcPGzEFiJEmu+wI9pCIeX8FX
	 /HF1gZTCIAvYculxY2UNhMxUNsp9DEkLallesCcAHBoLCm9NaxXZuSDSYMqVgLH1Q0
	 WDK3Wd5oNYEkSVdKql/wKfoR2bIee5at2huxyVhFBP9cE6LlFUOiX7DrQzQQk/cAHP
	 YAdptMkkdPUXFUgmvD1+kVOFwRLUJHTOf3fsxKhXpDLwnZ1J6V92/ON9Gu1ITMLSI1
	 Mzk09eORgRPY7lSLRxMYdFnYfwcOPC3mNVLes8TWkCFaZ6zNpDeLx5H9Te0Qjz46EU
	 lpM2NZHaz/ATg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E88C25B75;
	Wed, 15 May 2024 18:03:15 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Wed, 15 May 2024 18:02:58 +0000
Subject: [PATCH] Bluetooth: Add quirk to ignore reserved PHY bits in LE
 Extended Adv Report
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-btfix-v1-1-d88caf3d5a3f@svenpeter.dev>
X-B4-Tracking: v=1; b=H4sIANH4RGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0Mj3aSStMwKXUvTZEODZBNTszRDcyWg2oKiVKAw2Jzo2NpaAPN4C8p
 XAAAA
To: Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Janne Grunau <j@jannau.net>, 
 Sven Peter <sven@svenpeter.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715796194; l=5308;
 i=sven@svenpeter.dev; s=20240512; h=from:subject:message-id;
 bh=N3jPT0a7Bc9Iqlik/IqY6WdxMUFPNtu8Dd/3uc+uB5g=;
 b=s2gbtsDtqS4P/rxXMSdSDrD77BS9mVPDMrQNTs/T26DiVTOaYpPNVCvVmTJS4ue4+bKcLSqzD
 3Sj7oGaNKtQAfVYitPpVvscgk0rLlBCz3lcTWpTFytXAY6P2hDVxhSH
X-Developer-Key: i=sven@svenpeter.dev; a=ed25519;
 pk=jIiCK29HFM4fFOT2YTiA6N+4N7W+xZYQDGiO0E37bNU=
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/20240512 with
 auth_id=159
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Sven Peter <sven@svenpeter.dev>

Some Broadcom controllers found on Apple Silicon machines abuse the
reserved bits inside the PHY fields of LE Extended Advertising Report
events for additional flags. Add a quirk to drop these and correctly
extract the Primary/Secondary_PHY field.

The following excerpt from a btmon trace shows a report received with
"Reserved" for "Primary PHY" on a 4388 controller:

> HCI Event: LE Meta Event (0x3e) plen 26
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x2515
            Props: 0x0015
              Connectable
              Directed
              Use legacy advertising PDUs
            Data status: Complete
            Reserved (0x2500)
         Legacy PDU Type: Reserved (0x2515)
          Address type: Random (0x01)
          Address: 00:00:00:00:00:00 (Static)
          Primary PHY: Reserved
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -60 dBm (0xc4)
          Periodic advertising interval: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (Apple, Inc.)
          Data length: 0x00

Cc: stable@vger.kernel.org
Fixes: 2e7ed5f5e69b ("Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sync")
Reported-by: Janne Grunau <j@jannau.net>
Closes: https://lore.kernel.org/all/Zjz0atzRhFykROM9@robin
Tested-by: Janne Grunau <j@jannau.net>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/bluetooth/hci_bcm4377.c |  8 ++++++++
 include/net/bluetooth/hci.h     | 11 +++++++++++
 net/bluetooth/hci_event.c       |  7 +++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 9a7243d5db71..55109ad45115 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -495,6 +495,10 @@ struct bcm4377_data;
  *                  extended scanning
  * broken_mws_transport_config: Set to true if the chip erroneously claims to
  *                              support MWS Transport Configuration
+ * broken_le_ext_adv_report_phy: Set to true if this chip stuffs flags inside
+ *                               reserved bits of Primary/Secondary_PHY inside
+ *                               LE Extended Advertising Report events which
+ *                               have to be ignored
  * send_calibration: Optional callback to send calibration data
  * send_ptb: Callback to send "PTB" regulatory/calibration data
  */
@@ -513,6 +517,7 @@ struct bcm4377_hw {
 	unsigned long broken_ext_scan : 1;
 	unsigned long broken_mws_transport_config : 1;
 	unsigned long broken_le_coded : 1;
+	unsigned long broken_le_ext_adv_report_phy : 1;
 
 	int (*send_calibration)(struct bcm4377_data *bcm4377);
 	int (*send_ptb)(struct bcm4377_data *bcm4377,
@@ -2374,6 +2379,8 @@ static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
 	if (bcm4377->hw->broken_le_coded)
 		set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
+	if (bcm4377->hw->broken_le_ext_adv_report_phy)
+		set_bit(HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY, &hdev->quirks);
 
 	pci_set_drvdata(pdev, bcm4377);
 	hci_set_drvdata(hdev, bcm4377);
@@ -2478,6 +2485,7 @@ static const struct bcm4377_hw bcm4377_hw_variants[] = {
 		.clear_pciecfg_subsystem_ctrl_bit19 = true,
 		.broken_mws_transport_config = true,
 		.broken_le_coded = true,
+		.broken_le_ext_adv_report_phy = true,
 		.send_calibration = bcm4387_send_calibration,
 		.send_ptb = bcm4378_send_ptb,
 	},
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5c12761cbc0e..342aab86dad6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -347,6 +347,17 @@ enum {
 	 * claim to support it.
 	 */
 	HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE,
+
+	/*
+	 * When this quirk is set, the reserved bits of Primary/Secondary_PHY
+	 * inside the LE Extended Advertising Report events are discarded.
+	 * This is required for some Apple/Broadcom controllers which
+	 * abuse these reserved bits for unrelated flags.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d72d238c1656..01d3a8d343f1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6446,6 +6446,13 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
 
 		evt_type = __le16_to_cpu(info->type) & LE_EXT_ADV_EVT_TYPE_MASK;
 		legacy_evt_type = ext_evt_type_to_legacy(hdev, evt_type);
+
+		if (test_bit(HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY,
+			     &hdev->quirks)) {
+			info->primary_phy &= 0x1f;
+			info->secondary_phy &= 0x1f;
+		}
+
 		if (legacy_evt_type != LE_ADV_INVALID) {
 			process_adv_report(hdev, legacy_evt_type, &info->bdaddr,
 					   info->bdaddr_type, NULL, 0,

---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240512-btfix-95c10c456f17

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>



