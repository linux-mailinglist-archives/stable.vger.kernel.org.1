Return-Path: <stable+bounces-127864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E78B0A7AC9B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8AC33BC001
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CF027CB13;
	Thu,  3 Apr 2025 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwiTYz3r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6CA2586C1;
	Thu,  3 Apr 2025 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707263; cv=none; b=d4FTwD0aWxFQ83tiLLmpseVQEWlmhpngM5+Qicke2g4LuZd96JLnSVnxnldynLrnImabbF9aGCZq3FMTz9b6oKCLwklqs0V3HV9GUfPZdA9jyEQ/BvuQTLu3dgdrEYMNZ5BBhzmJXxD7jpV+hPCfGGYI4rQrYp83EHJ2Ze62xus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707263; c=relaxed/simple;
	bh=4T8SxLR859KrQQbU2znvOqTs43Jf/1bNvj7gtu9Qg+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZQZ7P+fRhj0PyjTil1F1kLA1kw8eNsq3ADh/BvjF3AacIuB5f3xV7VimoHUX+8h8sTgXFrsCEUtLuiBDLepCs4afULHkDOhw/nc7abj+1CXzRumjSFjbiNGwzpe70fQSW4FuCrB5ZYOvOb2cEO3JvHtZJCvfSoWUMkbMoGVQi7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwiTYz3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE9BC4CEE8;
	Thu,  3 Apr 2025 19:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707262;
	bh=4T8SxLR859KrQQbU2znvOqTs43Jf/1bNvj7gtu9Qg+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YwiTYz3rQWgEKbAFDQe0yCIyspqLLUwAMrKWX2E4wMVNyzuSH+/BMkTIuL7Wx9q+X
	 nVMRf9n38gbAAU2VfIYa9SQ+XuquMA82iJiDoAe4bq7x2cvbYqAQ1oUode7Du82Z+7
	 zK4JOOCcnT4yDt4/t5ZKwNMVsF/qBi4sAKosuxDoixuqF7B2N4EbJyJ4UjGmywVBFg
	 p4Lbk0FS3Tcybv4r3nK7rbPfpJtwHUn5/8NNJxxoXxyDyQ3qu1N5CAu66i4bxKtK3K
	 +6bvtXKcgTL9GWd87/LX6yM3la1mT18g7ntub5BeNCmzvPB/l9ejKDRCl6UHjHEjgJ
	 /feRnqb24HoNw==
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
Subject: [PATCH AUTOSEL 6.12 46/47] Bluetooth: Add quirk for broken READ_VOICE_SETTING
Date: Thu,  3 Apr 2025 15:05:54 -0400
Message-Id: <20250403190555.2677001-46-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
index 5bb4eaa52e14c..dc8a3e4002e87 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -353,6 +353,14 @@ enum {
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
index c95f7e6ba2551..4245910ffc4a2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1921,6 +1921,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
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
index 7b2b04d6b8563..bb455e96a715a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3720,6 +3720,9 @@ static int hci_read_local_name_sync(struct hci_dev *hdev)
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


