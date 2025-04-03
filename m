Return-Path: <stable+bounces-127768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C0AA7AB16
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A697A8663
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731EF25E80B;
	Thu,  3 Apr 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuFPJhSK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D0825E453;
	Thu,  3 Apr 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707045; cv=none; b=BfjR94CMyRoCLlDH6DiRAHx3hIr3Iqi7rz0R7tTIgdiih5HIz8jbqpbGAZ+7d4i8OtZpFDk/dG52cMJR7e+wdBznN8FwQSCQ80UcPeHbG0gS92gUQ8wdgfMaDYk7Q+/IxsSjKUytjyG2NY+e0b0FfBSPT0h/hA9gMSzA+m2zusM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707045; c=relaxed/simple;
	bh=/GOvjR6+ruCiKS+6eiovIJZLOi5YQH76980EKGF3pG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VZ+ML5HdPvU+fqZYU/UH1XEdn1li9jF5LlkcjmfrUCk3/hho5VF4W/3cs4DsI+81threo59SjOxOBNCxXZhedDlUstRgtvHBl/EfWC9BNrgPOBUgOoYerkfph0pTKSzpm0u9M8FLkpNN5D0jLnaijHgO/QVbPWr14KMkT2+Hqgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuFPJhSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FDEC4CEE3;
	Thu,  3 Apr 2025 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707045;
	bh=/GOvjR6+ruCiKS+6eiovIJZLOi5YQH76980EKGF3pG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SuFPJhSKMdy8eTsMa6fasV9u6RAazguEa9b+s7a3eDzLwJdU38yug0454NTXXyiN1
	 +c902QTyW5pc5tjrrONiEsemSCKt7iB4SUaPe46AnQHAXglNKs+UtDEt/Z/gyyShTj
	 eX4/SGhazcf/m2PaPzWoM/QV2gaGcmgzJ6PO7giN9Yc94pAr7suVlBK5duRV82dCfX
	 3wHwBrHCMDP8hlzqADalAdkDexTWqrq/Iyc+OWg3YRcihZ9AWBlgEx29nILTf3cLEm
	 k/aXVvhG5RSacixulkFQaIalqFqqPrzx3zhTBF8GLUAU2leOx+nQMtuOQgCFfd8Dsa
	 NBmIicB5aDEmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pedro Nishiyama <nishiyama.pedro@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 53/54] Bluetooth: Add quirk for broken READ_VOICE_SETTING
Date: Thu,  3 Apr 2025 15:02:08 -0400
Message-Id: <20250403190209.2675485-53-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Pedro Nishiyama <nishiyama.pedro@gmail.com>

[ Upstream commit ff26b2dd6568392f60fa67a4e58279938025c3af ]

Some fake controllers cannot be initialized because they return a smaller
report than expected for READ_VOICE_SETTING.

Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci.h      | 8 ++++++++
 include/net/bluetooth/hci_core.h | 4 ++++
 net/bluetooth/hci_sync.c         | 3 +++
 3 files changed, 15 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3ec915738112b..295d97e312e1d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -354,6 +354,14 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY,
+
+	/* When this quirk is set, the HCI_OP_READ_VOICE_SETTING command is
+	 * skipped. This is required for a subset of the CSR controller clones
+	 * which erroneously claim to support it.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_BROKEN_READ_VOICE_SETTING,
 };
 
 /* HCI device flags */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6281063cbd8e4..8649ad17408bb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1925,6 +1925,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 	((dev)->commands[20] & 0x10 && \
 	 !test_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks))
 
+#define read_voice_setting_capable(dev) \
+	((dev)->commands[9] & 0x04 && \
+	 !test_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &(dev)->quirks))
+
 /* Use enhanced synchronous connection if command is supported and its quirk
  * has not been set.
  */
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index dd770ef5ec368..0c6a85abba2c5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3696,6 +3696,9 @@ static int hci_read_local_name_sync(struct hci_dev *hdev)
 /* Read Voice Setting */
 static int hci_read_voice_setting_sync(struct hci_dev *hdev)
 {
+	if (!read_voice_setting_capable(hdev))
+		return 0;
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_READ_VOICE_SETTING,
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
-- 
2.39.5


