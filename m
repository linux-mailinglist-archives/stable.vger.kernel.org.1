Return-Path: <stable+bounces-127817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43319A7AC1A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0ED17DBCB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2CE268FC7;
	Thu,  3 Apr 2025 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rikYMoCx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77745268C79;
	Thu,  3 Apr 2025 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707152; cv=none; b=F9SSrWMDMdP5nokGvf2uMYbf0skt57ei6Mxve2FBTBTqIleiIzpstAPw9cZvaI8yhNmICLONgFIxaM6zOARQts1QV287yaEyrCkYo0hzUkvoNrzuJRAIKFhTnJPiilmyX5qcy2+GzfZ19V3RK2dd0JYAAdE9LTy2lcBePeLLUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707152; c=relaxed/simple;
	bh=HitsAg6pmYFZf2yLH62ARWmF/7q598X1GbMeIHSzOfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BX/6mQHI5RzWHCxUzS3h0STwLBbXPOxVCb27xJuK6t8NWbvIGcsjeyH2jcRUvVmJqQQgRTe2+LXi17lvYlatvkZ/0UTnUP4E3EDucjY1NxWWYDYV0RlZcr9Bq/fsaSJqfELHXddoQYSkwk6Ixo+xXnBpscya1RPIaNS4S7fEaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rikYMoCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AC3C4CEEA;
	Thu,  3 Apr 2025 19:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707152;
	bh=HitsAg6pmYFZf2yLH62ARWmF/7q598X1GbMeIHSzOfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rikYMoCxWSyZn/0Dt4bffeR6nFFOCZ6WvX7SaYsU4KBH4ebM8ky9znRhyzHeezytm
	 vCQHtshL55zUOsjsJm4xw5uA9sPCnzG3nY4FbrCzqtxibp+JvqzfXsn73E9AToNRec
	 V1aeUdEci0Z/rmSavxLGFVe9S02B03M5IjDurbUP9tc8rTkhm6G+wX9g50Hq5usoxv
	 LhXwigVwF0PqONT7CogIZK8Hnpk8tdFSw1xrCd2gwyPBRrYt1TjNYnQKjQIMLp/AUM
	 8hAA5X9VwzJw8hItA5w1gx9VcVSbRfjLc5aqp59z+aWAAziAgvBjnTLaXBFniQQ1Fe
	 Z7/+IUmPxREgg==
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
Subject: [PATCH AUTOSEL 6.13 48/49] Bluetooth: Add quirk for broken READ_VOICE_SETTING
Date: Thu,  3 Apr 2025 15:04:07 -0400
Message-Id: <20250403190408.2676344-48-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 6203bd8663b74..6f06d20093a7a 100644
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
index ea798f07c5a2d..71921367f0f06 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1931,6 +1931,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
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


