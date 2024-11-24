Return-Path: <stable+bounces-94994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D5E9D7212
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC679284C49
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594D81EE010;
	Sun, 24 Nov 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNi7CHk/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066CF1EBFFA;
	Sun, 24 Nov 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455524; cv=none; b=oIjhrvym+8wX+ipz/heFqtKkdBWiNalhFoh4nuztD6yMehvqFSty9H5iex/dw1oYgmtzRcUjISPcmq8p3ZjuUQUFmJY/sjJ8BmPnMq0Mo13aUcsp7K0bH0J3ls2EZgscrz3UPYYQ8diFxFJR8iPnyv5vfYqEZMtfSsGnJWsRGUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455524; c=relaxed/simple;
	bh=7dLbQ4b1KkaaB2tlAbRfkGsNPo0Q8NHsU+EPFb87k2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ci/HIzz+js3kB1Gy5Ym+o8pI2kAC+SHvPRfoD2Bjn6nzRF2ijzcJYajZ2CC7/N9/maq1XBavINVp7BuyH7xyD7ToamjGVPQLjj9Act22Y08rr3UBnosH1quplRApNe8A20M91+KfmcQMG4I0lb8s0YUEugvDi6nNnlUmTJLOEIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNi7CHk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C29BC4CED6;
	Sun, 24 Nov 2024 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455523;
	bh=7dLbQ4b1KkaaB2tlAbRfkGsNPo0Q8NHsU+EPFb87k2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNi7CHk/oplgjfgOHmg5BVj+9KDBfVJInA3DW175hzVYjk2qXrLhi6CokuaRzhT2d
	 e7rEhiF+EtEbMydaNR+JwF5PBhLAyD3/fZohMncadGBlRTGfocU4edeuMCZG7DTAP0
	 tBsSU6p5wpIgcEKhEJMB+oD/FcmXLsBpws3yXnqFEpi+QzJJG8tjw4oNthcRpDnYuj
	 ffI2Q+ZNJ9tEYvSon1UzlDXJO44wipfurNmznDmexJSnMeFmUXxIFXZQZLIxC9KkH9
	 XPtSTTcW9WOG9CC40o5B1qsNTgftKjNjHklVVgj+VLIjmUWcrK6t8vvJ44wa49rO3l
	 k87vxzaNQwuZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Danil Pylaev <danstiv404@gmail.com>,
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
Subject: [PATCH AUTOSEL 6.12 098/107] Bluetooth: Add new quirks for ATS2851
Date: Sun, 24 Nov 2024 08:29:58 -0500
Message-ID: <20241124133301.3341829-98-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Danil Pylaev <danstiv404@gmail.com>

[ Upstream commit 94464a7b71634037b13d54021e0dfd0fb0d8c1f0 ]

This adds quirks for broken extended create connection,
and write auth payload timeout.

Signed-off-by: Danil Pylaev <danstiv404@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci.h      | 14 ++++++++++++++
 include/net/bluetooth/hci_core.h | 10 ++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bab1e3d7452a2..4f64066915beb 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -300,6 +300,20 @@ enum {
 	 */
 	HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT,
 
+	/*
+	 * When this quirk is set, the HCI_OP_LE_EXT_CREATE_CONN command is
+	 * disabled. This is required for the Actions Semiconductor ATS2851
+	 * based controllers, which erroneously claims to support it.
+	 */
+	HCI_QUIRK_BROKEN_EXT_CREATE_CONN,
+
+	/*
+	 * When this quirk is set, the command WRITE_AUTH_PAYLOAD_TIMEOUT is
+	 * skipped. This is required for the Actions Semiconductor ATS2851
+	 * based controllers, due to a race condition in pairing process.
+	 */
+	HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT,
+
 	/* When this quirk is set, MSFT extension monitor tracking by
 	 * address filter is supported. Since tracking quantity of each
 	 * pattern is limited, this feature supports tracking multiple
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 88265d37aa72e..94ddc86849733 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1871,8 +1871,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 			   !test_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &(dev)->quirks))
 
 /* Use ext create connection if command is supported */
-#define use_ext_conn(dev) ((dev)->commands[37] & 0x80)
-
+#define use_ext_conn(dev) (((dev)->commands[37] & 0x80) && \
+	!test_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &(dev)->quirks))
 /* Extended advertising support */
 #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
 
@@ -1885,8 +1885,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
  * C24: Mandatory if the LE Controller supports Connection State and either
  * LE Feature (LL Privacy) or LE Feature (Extended Advertising) is supported
  */
-#define use_enhanced_conn_complete(dev) (ll_privacy_capable(dev) || \
-					 ext_adv_capable(dev))
+#define use_enhanced_conn_complete(dev) ((ll_privacy_capable(dev) || \
+					 ext_adv_capable(dev)) && \
+					 !test_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, \
+						 &(dev)->quirks))
 
 /* Periodic advertising support */
 #define per_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_PERIODIC_ADV))
-- 
2.43.0


