Return-Path: <stable+bounces-158325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAA6AE5D09
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 08:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B8B166B2F
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 06:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AA924678E;
	Tue, 24 Jun 2025 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OSkH3z5k"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4F62405EB
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750747500; cv=none; b=OFu422hQKyXFwWfUqzX1KCTtsl8JYgs8IZcTNsWxfyfs8Cj3Qp0eimZ+gmij7lkYJwWP0I2IREeiqp1nDOrFhURea2IZNRNU2B1x5VhD5Onr3ju05gclql4q5ieANox/bKKnNuvvTWH3w6yhxoCdTyTnXv93Yd90Ierg9qV0edw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750747500; c=relaxed/simple;
	bh=UvEzmQ2P9YFloYGf/8N0kv07Y8BVFIQrMBCVxGKEIZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kTGTqaCSntj4nLxQTpT5NrJ4HF+a4t+kfOwsX25DnJ856263xug8FsarGwcKoY+z9odlmAJNDTOXKT0Lrs3rgnZP8NUdSzf7WaNssg9P85xhxli0fRVlozg6vKdywQnFk7Ma1TIzTioL6IdOpn86Yna4rvmxC6lX2fmM6yPqDlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OSkH3z5k; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9L
	m/COKTCaSQekKfmd0gD1I6B+WiHDivnJkRUzCOtDg=; b=OSkH3z5k6KRY7/E7eb
	fP/c2jS6bcKhgYMSw7bTGqNp3SLSJsvgyLypI/RFoJjX8oddM3BWiH/0waMXzNh2
	4gCH1ePzR9qDrvcyR0P+ME3J7KDglczOn6kyUiW1ZALxt7Rv2dwdNWNdm3SC8mGy
	9rcWYWoP1a4Yj2DJK2ElqkM8c=
Received: from pek-blan-cn-l1.corp.ad.wrs.com (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAXwWFFSVpozugbAA--.3324S4;
	Tue, 24 Jun 2025 14:44:37 +0800 (CST)
From: jetlan9@163.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.12.y] net: libwx: fix Tx L4 checksum
Date: Tue, 24 Jun 2025 14:44:07 +0800
Message-Id: <20250624064407.1716-1-jetlan9@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAXwWFFSVpozugbAA--.3324S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW8JFWxtrykCw4rXryrZwb_yoW8Wr15pw
	s8KrWrZwsrXr18W39rCa1xZr98Xayrtr9Y9ry2kw4Y9ryjyFy5JFW5tr17WFs3XaykAa4f
	AFnFvw13G3Z5Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR89NwUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/1tbiQxB1yGhZy1ubAAACsW

From: Jiawen Wu <jiawenwu@trustnetic.com>

[ Upstream commit c7d82913d5f9e97860772ee4051eaa66b56a6273 ]

The hardware only supports L4 checksum offload for TCP/UDP/SCTP protocol.
There was a bug to set Tx checksum flag for the other protocol that results
in Tx ring hang. Fix to compute software checksum for these packets.

Fixes: 3403960cdf86 ("net: wangxun: libwx add tx offload functions")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Link: https://patch.msgid.link/20250324103235.823096-2-jiawenwu@trustnetic.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 71c891d14fb6..0896742b3f30 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1336,6 +1336,7 @@ static void wx_tx_csum(struct wx_ring *tx_ring, struct wx_tx_buffer *first,
 	u8 tun_prot = 0;
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL) {
+csum_failed:
 		if (!(first->tx_flags & WX_TX_FLAGS_HW_VLAN) &&
 		    !(first->tx_flags & WX_TX_FLAGS_CC))
 			return;
@@ -1429,7 +1430,8 @@ static void wx_tx_csum(struct wx_ring *tx_ring, struct wx_tx_buffer *first,
 					WX_TXD_L4LEN_SHIFT;
 			break;
 		default:
-			break;
+			skb_checksum_help(skb);
+			goto csum_failed;
 		}
 
 		/* update TX checksum flag */
-- 
2.39.4


