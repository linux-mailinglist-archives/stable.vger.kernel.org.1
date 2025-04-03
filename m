Return-Path: <stable+bounces-127769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1B4A7AAC9
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6067189A2E9
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4C325E83C;
	Thu,  3 Apr 2025 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9QKwvcl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8ED25E831;
	Thu,  3 Apr 2025 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707047; cv=none; b=DEZKABBoDMJBfiaBnx60p1/pMUPKteYj855ugyHVAT1FVH+4ls1XJiiLsq2gBLFglnemjOwFgj63YhD8MSQIeYcUuX6y6vP8QzTWgYytvhz9rmunX44ovWPlhzMOG9c/0zGiLU4zEFLWubL4ZvuwsQKrarOciYKeMmmdnuO2usk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707047; c=relaxed/simple;
	bh=bpPpE/rG6+ikuFZ4ik6t/fonvsCano5SoUQii6vDr84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ta0yBHdWZyQ0V0uYnZe5DnijGmqPBy2m8Gshjbi+A5svO5nInqmpKO2hGYeO3wbQXNsKPKrhK3TpXgQil07TbYszfyeeHSNekerLwCJXvb1pcIjzyaE0Jm23N8acdf4/oYskGqTbIhW/vDaMwwalE9CkPsJfnuQgF03bCfgBpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9QKwvcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1A8C4CEE3;
	Thu,  3 Apr 2025 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707047;
	bh=bpPpE/rG6+ikuFZ4ik6t/fonvsCano5SoUQii6vDr84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t9QKwvclQm51sSK+76vKEu6ukn+mR5dZGJ9Jr/0qbeL8Z2e5fMeyahappIWw+FCpb
	 B1NlVbz6ynCbxvBtapAsHInzA73rv5/r6JnkgnmGEjIHSYEHt0GZiXfBZA0bkukfHN
	 Qc/63KVshd4hV840T++Y5gWIDYc37jl9qV6vMZ+IvYKX18kouTqDDO+OFH3HxZUqSe
	 dYCoUb+J1rVqbiuPJL4UXnRy9VnTpYkze8E3lStjAheqfVilTfBGsjuYiCeaG/wVRM
	 TummnDdhqFqa8aWbHMBWXLoIFvfMpN4egyo356wJTnwmBt8ylpdofl161DseNJ2lFf
	 bFYDJectYBoWw==
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
Subject: [PATCH AUTOSEL 6.14 54/54] Bluetooth: Add quirk for broken READ_PAGE_SCAN_TYPE
Date: Thu,  3 Apr 2025 15:02:09 -0400
Message-Id: <20250403190209.2675485-54-sashal@kernel.org>
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

[ Upstream commit 127881334eaad639e0a19a399ee8c91d6c9dc982 ]

Some fake controllers cannot be initialized because they return a smaller
report than expected for READ_PAGE_SCAN_TYPE.

Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci.h | 8 ++++++++
 net/bluetooth/hci_sync.c    | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 295d97e312e1d..aa684d2b079fa 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -362,6 +362,14 @@ enum {
 	 * This quirk must be set before hci_register_dev is called.
 	 */
 	HCI_QUIRK_BROKEN_READ_VOICE_SETTING,
+
+	/* When this quirk is set, the HCI_OP_READ_PAGE_SCAN_TYPE command is
+	 * skipped. This is required for a subset of the CSR controller clones
+	 * which erroneously claim to support it.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0c6a85abba2c5..cf60a8da943a5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4132,7 +4132,8 @@ static int hci_read_page_scan_type_sync(struct hci_dev *hdev)
 	 * support the Read Page Scan Type command. Check support for
 	 * this command in the bit mask of supported commands.
 	 */
-	if (!(hdev->commands[13] & 0x01))
+	if (!(hdev->commands[13] & 0x01) ||
+	    test_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->quirks))
 		return 0;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_READ_PAGE_SCAN_TYPE,
-- 
2.39.5


