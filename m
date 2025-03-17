Return-Path: <stable+bounces-124580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B399FA63F1F
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 06:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D0C188F22C
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 05:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2211A59;
	Mon, 17 Mar 2025 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j6xgfsJj"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D49215160
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 05:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742187954; cv=none; b=Wa/wAnlfZ4l8V8LIqBE0iFFF1C60PXVwz2oHwRmwUQ8IpLOqkurhiA5m/51du6ytnEm9/g/Fi/COx9Vw5zwqSGB/q1mRbUt3l3kRphXRbZZE6yygvX2PJAE7HKqa2U7qtq4WO+fyz5fU7uWXHyNcINmK3uSu0W6kecS9bjqxxhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742187954; c=relaxed/simple;
	bh=zJ2ydvGZpXZSKh06LPfHlou2uq0I9Cf9bXcHf+XmSqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ZispZbgws91LEBlELYB4XrS0b1lqZBDeeZHNeZgWHFXbzeDEbU8xMX3ag2ATt62z7NHFClw9KXAODhLM5jZZwR2aEzyd6Sw+uJsGGdA3f2IdYpr25idc5PWo09ASyhqqYGkvbOQhFcX8CprSg1k+Tad/W8iepsXRYQshUSa07Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=j6xgfsJj; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250317050551epoutp0171145d133049584248c4bb22e2c30326~tfrYKTFES1475414754epoutp011
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 05:05:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250317050551epoutp0171145d133049584248c4bb22e2c30326~tfrYKTFES1475414754epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742187951;
	bh=rIzqE/GfctqKUT/YyTcqdyiD5bCBxVqmql92379E7B4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=j6xgfsJjSyNS21j6090b1yIn5VEEsRoehrIH3JlFQxDAQuXubtmP/sWSDl0SJWCnW
	 KJMZSJJI6S+yqly9Mpfm9bWIDz7JJHA0s65jFLruZuq342dFposgwpsln79kLGf3gY
	 J3iBsG3mWxigaVNSS2vGJY0yX09bZHqKkSVQMZYs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20250317050550epcas2p348d7e0b47c527f433a6bfedf45be9f1c~tfrXVrCSj2943229432epcas2p3l;
	Mon, 17 Mar 2025 05:05:50 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.68]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4ZGNGP4f9Xz4x9QH; Mon, 17 Mar
	2025 05:05:49 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	6C.08.22094.DADA7D76; Mon, 17 Mar 2025 14:05:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20250317050548epcas2p158c1bfcef5059e51afeab70680da5e5d~tfrWGXQUT0060500605epcas2p1M;
	Mon, 17 Mar 2025 05:05:48 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250317050548epsmtrp10fa2c41dbd599bb5b5634ea10eebe0c4~tfrWFCWlq0320703207epsmtrp1P;
	Mon, 17 Mar 2025 05:05:48 +0000 (GMT)
X-AuditID: b6c32a46-484397000000564e-a9-67d7adadf39d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	34.81.33707.CADA7D76; Mon, 17 Mar 2025 14:05:48 +0900 (KST)
Received: from perf.dsn.sec.samsung.com (unknown [10.229.95.91]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250317050548epsmtip10c6198c273b0feac956ff180a737f2fd~tfrVyzbuE2597525975epsmtip1j;
	Mon, 17 Mar 2025 05:05:48 +0000 (GMT)
From: Youngmin Nam <youngmin.nam@samsung.com>
To: stable@vger.kernel.org
Cc: ncardwell@google.com, edumazet@google.com, kuba@kernel.org,
	davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com,
	horms@kernel.org, guo88.liu@samsung.com, yiwang.cai@samsung.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com,
	sw.ju@samsung.com, dujeong.lee@samsung.com, ycheng@google.com,
	yyd@google.com, kuro@kuroa.me, youngmin.nam@samsung.com,
	cmllamas@google.com, willdeacon@google.com, maennich@google.com,
	gregkh@google.com, lorenzo@google.com, kerneljasonxing@gmail.com
Subject: [PATCH v2 stable 5.15 1/2] tcp: fix races in tcp_abort()
Date: Mon, 17 Mar 2025 14:09:49 +0900
Message-Id: <20250317050950.2351143-1-youngmin.nam@samsung.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzO6b32Xpks1/roSfeQXPbiaQsUjkzURYI3wyyMZUtkmayhd4XR
	13qLmY8o4Q0yHoIOCmZFpmNkPKy1AzoGAQWROVQElGmYIEUUUKBCIKIrLTr/+873+77z+37n
	QWKCSb6ITFDrWZ1apqT5bril3SvYr6ZmQCE+2Ugje+t1AvU3FxKovCcNR7VN6TxkM5bgaLRj
	mEC2uQUMFRUDlNJyHUPD+Zf4qM86hSGr5UcCXbXkrUJt7WME6m0q56O67imA5ponCJR1uxlH
	HcaNaK57AiDj2WGA0kdmCZS58BBH9pE+PpruTCFQZesMgVIravEdbzDmX2/xmEbDHYIxmpIY
	U3U2nzHmEcyjP/v4TJ65GjCzprejyJjErfGsTM7qPFh1nEaeoFaE0ZGfxe6MlQaLJX6SLSiE
	9lDLVGwYHb47yi8iQemYmvbYJ1MmOagoGcfRm7dt1WmS9KxHvIbTh9GsVq7Uhmj9OZmKS1Ir
	/NWsPlQiFgdIHcKvE+P/6ioD2vw139+3lxPJ4KRbDlhNQioItphu4DnAjRRQDQD2/j1IuBYz
	AI7eMOIvF72ZVvyFxTzSgbkKjQD2P69ZsTwB8ObPdmxZxaf8oOXSM5ADSHI9JYJDfR8uazDq
	Ag67f5skljXrqI/g1KnfnRqcehc+sguWaXdqO6zoWcSWaUhtgpX/Qhe9FnaV3nNmwBx06vky
	ZwZITZDQWmdY5QoXDs9bjvNdeB180GkmXFgEx/MzVjAHk4cGV8xpAF4euI+5CoHQYMt05sEo
	L1jXtNmVwRNeGFzp+zrMal8iXLQ7zMoQuIzvwcXieuDCb0JrZdXKhgxcPHHT2VVAfQWnFwt4
	BWCT4ZVpDK9MY/i/rxFg1WAjq+VUCpYL0Aa8vNM4jcoEnO/eO6IBFE8+9m8DPBK0AUhi9Hr3
	/FMDCoG7XLb/AKvTxOqSlCzXBqSO0y3ERBviNI6Po9bHSoK2iIOCgyUhAVJxCC10P9iQphBQ
	CpmeTWRZLat74eORq0XJvLIvvBYOC5cOibG0Dy6WBd/Oybvm+xbbqjytao1+HiqUTviky1vu
	gMtTQcdNZxbG5jq+kz61SfoPFv4yLV/rR5yrOnPr6bncDfXfHIk5IGf6AuP2e+uJu7x021hB
	yT/+D0L3HJv3OTTFWYQfZweBGPPVZ55HD/sqh/a9VjRSFam+J/H58tPaVv7nuUbPlLp6/592
	F0ePZuTc7apL+CNjj+1JQmiZvTR3F39sV80EWfEwav7YrMgaIVPQwoGS05bICJZ5J/WIoOfb
	3CvvNzF7xz8pDQwQ7hi6lt0U/UPGZJV2b1xYhaDEPN45/3hNwUXj2Q5f/ZW07TN5WDgv+miR
	tnHn0jYa5+JlEm9Mx8n+A67KA+eABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYQCG/XbOdk4r6zStPiyMVoFEmrfyy6K0Qo5FNyuK7OLIw7S2pWca
	Jmiat1w5DYtybbEpSA1daV5SU+cML5ho6pQssTRnlpfMJSkVNS3w38vzPP9eEhPcx53IcFkU
	w8pEEiGPj5fVC51dCwp7xO5fh7yQ1dhBoO7q2wRStyXjyFCZwkEW7X0cDTUMEMgyPYOh7DsA
	Xa/twNBAZhMPmavGMVRVdo9A7WVKLjLVDxOos1LNQ09axgGarh4l0I131Thq0K5E0y2jAGmL
	BgBKGZwiUNrMFxxZB808NNl4nUB5xm8EStIZcL/VdMnjNxy6QtVH0NriaLpYn86jtUqCnqgx
	82hliR7QU8XOR8jT/J2hjCT8CsNu2RXCD3vV/ABEZC6J+WRVEwlAw1eARSSkvGHJYAOmAHxS
	QJUD+GJCx50Xa+Dbx53/tgPsT37JnY+mALxVaCBsgke5wrKm30ABSNKRcoL95h22BqMsOEwu
	aAK2xoHyh+O55XMNTm2EE1aBDdtTu6GubRazYUithXnv4TxeDptzPuK2jf3FSaUPsCywVLVA
	qRYoLeDowQomQi4VSy9EeLjJRVJ5tEzsduGytBjMnbcp6DnIf/LLzQQ4JDABSGJCR/vM3B6x
	wD5UdDWWYS+fZ6MljNwEVpO4cJX9ekl6qIASi6KYSwwTwbD/LYdc5JTAKZXkr4mvOnrSL/eh
	v/7Rxlupbzf7pFpmW2My2/3zZz60xsSM0cf9QuKdfiZk+GzT+wYG9tnFmkcV3/Gzzjk9y4sO
	5wVEbvhxiLm2rOaZIkXc5lWn4QYKzZFW5JGdtur1CJOk2x5lGLXzzDpxLmVxf7LGd2bSC7jH
	5gzL1h0LTu9I1B++l/W59ia3K9xrK55UpHJkessDGmWempPe3l1hkaf2HazQyftGxFEuce8S
	NWfylKxDKWHYY0xIoxRKsSXuQHb3XTTG7v/NHnWRhu1VRQdR/hVay1rjxbGMM6Zg8ql6ktvc
	69iXjh9UFzWevzOeUVNXaRxZeqx2wrMl3k2Iy8NEHpswVi76AykiwOkrAwAA
X-CMS-MailID: 20250317050548epcas2p158c1bfcef5059e51afeab70680da5e5d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250317050548epcas2p158c1bfcef5059e51afeab70680da5e5d
References: <CGME20250317050548epcas2p158c1bfcef5059e51afeab70680da5e5d@epcas2p1.samsung.com>

From: Eric Dumazet <edumazet@google.com>

tcp_abort() has the same issue than the one fixed in the prior patch
in tcp_write_err().

commit 5ce4645c23cf5f048eb8e9ce49e514bababdee85 upstream.

To apply commit bac76cf89816bff06c4ec2f3df97dc34e150a1c4,
this patch must be applied first.

In order to get consistent results from tcp_poll(), we must call
sk_error_report() after tcp_done().

We can use tcp_done_with_error() to centralize this logic.

Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Link: https://lore.kernel.org/r/20240528125253.1966136-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Cc: <stable@vger.kernel.org>
[youngmin: Resolved minor conflict in net/ipv4/tcp.c]
Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
---
 net/ipv4/tcp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3c85ecab1445..c1e624ca6a25 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4514,13 +4514,9 @@ int tcp_abort(struct sock *sk, int err)
 	bh_lock_sock(sk);
 
 	if (!sock_flag(sk, SOCK_DEAD)) {
-		WRITE_ONCE(sk->sk_err, err);
-		/* This barrier is coupled with smp_rmb() in tcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
 		if (tcp_need_reset(sk->sk_state))
 			tcp_send_active_reset(sk, GFP_ATOMIC);
-		tcp_done(sk);
+		tcp_done_with_error(sk, err);
 	}
 
 	bh_unlock_sock(sk);
-- 
2.39.2


