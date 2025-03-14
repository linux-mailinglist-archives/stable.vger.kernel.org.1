Return-Path: <stable+bounces-124424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853AEA60D15
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 10:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623D73B3C1D
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 09:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39661EF0B4;
	Fri, 14 Mar 2025 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oRR6xXed"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5741EEA36
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944097; cv=none; b=CS5Nnc0fRq4ROLcsSJni+RjBM5inuhrflTZ8yG5MaYWPFFJzXyuRBZggwNIstApmt4pCpxGzA2o4dngloDe1t6T0ONiDGLcSUKeXg06mEc8PebRKzBLADJXnP3khbYvEktQ7ErvbhglAPK57m53Zkwl2znnAqj/d7jD6JRT7J1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944097; c=relaxed/simple;
	bh=TvoOmyRV1P0CxMrsROtJHUSz7hWCQ459PFWfGmwMX1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=NAKMbaFmy7ACUKdk+/h233tENDPp5GShqOcGkXJAICwUuCw7enec7F7LYBfnmK55iz38L5YSmE7cXcJk5TiU7ttxq09pmYShYJYuk54sf3CGAC/g3vPVWl9pC4pn9o+/7dBbfoVU7u7+xvQ332KwKbwWQhXzI6tcExe9Kayo4PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oRR6xXed; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250314092127epoutp01f78cab226f32815ae846f991f8d48ebd~soOsl5Boa0908409084epoutp01L
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 09:21:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250314092127epoutp01f78cab226f32815ae846f991f8d48ebd~soOsl5Boa0908409084epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741944087;
	bh=s/FLtSsThZifg860YzHPdVeWeC6b46eBkekISgy9cFY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=oRR6xXedQC8RXQdaABEUO26wDbPvfb+RnulCfgG+s4toHrzSXyF+8gvHq03KOsP/Z
	 GZvf2K5mcAHHNdHX82hQAHid1QsF95yfpnaZooE66e9mj7aT7SASKKFb93enqnC+Cr
	 eRJJZRzqrlu1xWcINA591SXEq+Yo48BLr15SWSpk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20250314092126epcas2p374624cb3a109cbbc279471c369f67b56~soOrV_lMu1703717037epcas2p3k;
	Fri, 14 Mar 2025 09:21:26 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.101]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4ZDf4j5ZcFz4x9Q8; Fri, 14 Mar
	2025 09:21:25 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	54.9C.23368.515F3D76; Fri, 14 Mar 2025 18:21:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250314092125epcas2p418cd0caeffc32b05fba4fdd2e4ffb9fa~soOqFU9fN2558125581epcas2p4I;
	Fri, 14 Mar 2025 09:21:25 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250314092124epsmtrp1463cf08f860d8c8be3ea69139d07ab36~soOqDKPgY0533405334epsmtrp1K;
	Fri, 14 Mar 2025 09:21:24 +0000 (GMT)
X-AuditID: b6c32a45-dc9f070000005b48-23-67d3f515a493
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1D.63.23488.415F3D76; Fri, 14 Mar 2025 18:21:24 +0900 (KST)
Received: from perf.dsn.sec.samsung.com (unknown [10.229.95.91]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250314092124epsmtip1957bb83b732a1cb6af5f3fc2cd153959~soOpxvXQz0106001060epsmtip1t;
	Fri, 14 Mar 2025 09:21:24 +0000 (GMT)
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
	gregkh@google.com
Subject: [PATCH 1/2] tcp: fix races in tcp_abort()
Date: Fri, 14 Mar 2025 18:24:45 +0900
Message-Id: <20250314092446.852230-1-youngmin.nam@samsung.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxze6b30Vra6a0E5wibNNbiAKbQM6FGBkE1dA2YhOjZ1M9DRmxaB
	tvaW4V4J8h5RHkMnQqNVWJC6McawvOTNKDgZ01oQZiyBwsDhNsDiZG5Zaevmf9/vO993ft/v
	PDgY7x7bl5Oi1NIapTSNYnvixr5AJNhoN8uF5u8C0MPuWwQa7SgjkG4kF0f1bXksNKuvwNHM
	wBSBZlceY6j8NEDZXbcwNFUyyEaW9t8w9JOx2AP19v1CIHObjo1WOhYIVHi3A0cD+k1o5YcF
	gPTfTgGUN71MoILHv+Lo4bSFjRZN2QSq7l4iUM7Fejxms6Spbpwl0TdmSBoNn7El+mJC8nun
	hS0pbjIAyXLjlnjicGqkgpbKaA2fViarZClKeRQVdyDx9cTwCKFIINqBxBRfKU2no6jd++IF
	e1PSHGNS/A+kaRkOKl7KMFRIdKRGlaGl+QoVo42iaLUsTS1WBzPSdCZDKQ9W0tqdIqEwNNwh
	TEpVlI/tUle8cHyo4QKeBWo8i8A6DiTD4M3GSY8i4MnhkS0AThhuY65iCcBV2xPCVawAaMmz
	sZ5a5m92uVUdAM6X1QJXYQfw/LINW1OxSQE0Dv7jWOBwvElfaLXsWtNg5Bkc1s3r8DWNFxkK
	zbYq9hrGyQDY0mp1duCS0fDRiRzWmheS/rB6ErroDXDonM1pxRx0ztUqZwhITnJgbXsB7kq3
	G57sO4O5sBe8b2oiXNgXzpfkuzEDs6wTbnMugNfH5tyGV2HlbIEzNEYGwm/aQlwZtsL+CXff
	9bCw72/CRXNhYT7PZdwGV083ABd+CbZXX3ZvKIFLA31OzCOPwK6zdqIU+Fc+M03lM9NU/t9X
	DzAD2ESrmXQ5zYSqRf/dabIqvRE4H3rQnhZQ/uCP4F7A4oBeADkY5c1FZrOcx5VJP/yI1qgS
	NRlpNNMLwh3HW4b5bkxWOX6KUpsoCtshDIuIEIlDw4Viyof7cUuunEfKpVo6labVtOapj8VZ
	55vFSqn2qDJeajJu83mTPDZuOigYm35rbvT6ltjWzIJPdQlXI56reDKCTJv9Q4dfTm76Pm7w
	2v5PYu0i2bshq5oTMr/ld3R/3fDT1w1XLDaztnYp3vh5BL+9XtBQ9KftTpj9eL/85NEN3OhT
	1KMDsUbLvmuTQ2H9d2urd3qXGi7ssQYvT86ILxk7KYEpOOVFcU1O/MxiYM/MawmfH7GU+0j5
	w/dXx58/xMkM0MW8fdTafEUiSBrLvhHDt3tRSQkema8cPhgZ3uPXrWzVedwzCb7wYXpi8y2n
	agcuvz968UuZIs7Utr9O9sB6Z+7sezX1DUFfdx8rLflqe+eV7u3Nas/mBXam4cdDFM4opKIg
	TMNI/wW8glIjcQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTlfk6+V0g99njC2+HLjEbnFt70R2
	iznnW1gs1u1qZbJ4tmAGi8XTY4/YLZ59+8lsMXkKo0XT/kvMFo/6T7BZXN39jtniwrY+VotD
	h5+zW1zeNYfN4tveN+wWHXf2slgcWyBm8e30G0aLBRsfMVq0Pv7MbtH+8zWLxZfHV9ksPh5v
	YrdYfOATu0XzwnUsDpIeW1beZPJYsKnUY9OqTjaPBX3sHu/3XWXz6NuyitHj8ya5APYoLpuU
	1JzMstQifbsErozJ160LZvBUnNwwn6WBcQlXFyMnh4SAicTLi/uZuxi5OIQEdjNKtEyYygiR
	kJG4vfIyK4QtLHG/5QgrRNFnRol9/yeAFbEJ6EpsO/EPyObgEBGQkrh/1RqkhllgM4vEm8NP
	wWqEBYwkLj+ZzQZiswioSuzYeZ8JxOYVsJP43tjMBNIrISAvsfiBBERYUOLkzCcsIDYzULh5
	62zmCYx8s5CkZiFJLWBkWsUomVpQnJuem2xYYJiXWq5XnJhbXJqXrpecn7uJERxjWho7GN99
	a9I/xMjEwXiIUYKDWUmE1+Ly5XQh3pTEyqrUovz4otKc1OJDjNIcLErivCsNI9KFBNITS1Kz
	U1MLUotgskwcnFINTN4nz8+9nTsx9OM9tYUTQ6/9OJ7S86zk34rDust0jK5U8a5WVmrQzr6l
	phjjUczweqKC9Un/wi8z10e+1tz6+PLnA+/eHFy6gGt3ZEBS4YpfKQ/5HPJPNP+fk5OmZDs7
	+s6WSRf4/iRcLftx/ua8W137JwanzDgQ77bQXDBi727djy9nfjqRF5m2rWyxBLcOm7ZX3SKn
	I6v/O16USm95uC9/UvLN7akZpsLdlfULvmmvFoxuniXLxhlje2+V+c0u+WWO25UPrNx7M2ya
	Zo5xt8eRNo39i7JCD0Xyz31tm/FOhs98Pbe7bHC62qI03W79vnN7WV+FPeG+Guq+3Wop/8Kf
	R5f3HilXrZ1XJ39JRUmJpTgj0VCLuag4EQC0qmpmIAMAAA==
X-CMS-MailID: 20250314092125epcas2p418cd0caeffc32b05fba4fdd2e4ffb9fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250314092125epcas2p418cd0caeffc32b05fba4fdd2e4ffb9fa
References: <CGME20250314092125epcas2p418cd0caeffc32b05fba4fdd2e4ffb9fa@epcas2p4.samsung.com>

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
Cc: <stable@vger.kernel.org> # v5.10+
[youngmin: Resolved minor conflict in net/ipv4/tcp.c]
Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
---
 net/ipv4/tcp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7ad82be40f34..9fe164aa185c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4630,13 +4630,9 @@ int tcp_abort(struct sock *sk, int err)
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


