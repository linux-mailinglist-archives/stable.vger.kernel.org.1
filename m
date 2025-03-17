Return-Path: <stable+bounces-124577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0483FA63F16
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 06:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E68B16CC8C
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 05:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB16217660;
	Mon, 17 Mar 2025 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mAnyiBPx"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5418217645
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 05:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742187837; cv=none; b=WSmhF0J1+eqpJU47q0Bx+G8WQDx7izByQjAN6yiq8RS8b5ERoe1qa6lg1NPtl9/PDKPqAIAEGxXLxM4y8E4xmGTOtCZsEgAGuGcXPUVN5G5xY9wEcJrGeXox6KeILbDY0ns95CZPHAlSOiRi2JEsxxdVVD8iHfv0VsBIOPG9D7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742187837; c=relaxed/simple;
	bh=7KtKbUBfRVsOM0YpzDH79MW3tYGWwRDfDO+qSC9dc9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Wj29X/9U0UsxqGUdXG5cC5gz0DHAIQHWzm2bmK3dWPDVBARBmGgrQ/rKBXjVvaH6wHSsgT+llZZkFftfdSmL2evFHhS8oXUaq+4A07WHTyHorFckfhzJK5KMG6zRhmTDMpB6zOmog05/x9EvRnUvWldb76dbsx4C1hEbJ7mQP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mAnyiBPx; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250317050347epoutp0153d8c7e3322b42244eb13f2f62d7d860~tfplX6L3w1168911689epoutp01Q
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 05:03:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250317050347epoutp0153d8c7e3322b42244eb13f2f62d7d860~tfplX6L3w1168911689epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742187827;
	bh=g3lhbddvt7BuVPUO8gjUzJrDreH9HIqkAq2uIjjyAqc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=mAnyiBPxqBebVCuxkiyZStbKdHVvxBORqgXgq8mFMuHqh0ux9NDM4okPa1hjg7H9P
	 dKPorktU6QYWwcEWZSRJ9VzhOLaKzOelRE67YTzaten7cTeKtHhPMC8ui5lP16OhIi
	 IcV7tpHqufd0/AlWPVdHbUqztaEyfmXHdWba4nqU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20250317050347epcas2p2ae6b870fffc8fedc9631cb866c84364f~tfpko6mVd1700117001epcas2p2d;
	Mon, 17 Mar 2025 05:03:47 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.70]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4ZGND233bXz4x9Pw; Mon, 17 Mar
	2025 05:03:46 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	24.79.22094.23DA7D76; Mon, 17 Mar 2025 14:03:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250317050345epcas2p4cc44d6e10bb9916fba56d633f505a7e5~tfpjbzg6k1034110341epcas2p4J;
	Mon, 17 Mar 2025 05:03:45 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250317050345epsmtrp1458ed71deaa687a563cdb11d04398c2a~tfpjZw-N_0187101871epsmtrp1P;
	Mon, 17 Mar 2025 05:03:45 +0000 (GMT)
X-AuditID: b6c32a48-e7eec7000000564e-e0-67d7ad32b25f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F3.27.23488.13DA7D76; Mon, 17 Mar 2025 14:03:45 +0900 (KST)
Received: from perf.dsn.sec.samsung.com (unknown [10.229.95.91]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250317050345epsmtip1b127f254a5bcd3787aea173ded975727~tfpjDOBAE2572925729epsmtip1i;
	Mon, 17 Mar 2025 05:03:45 +0000 (GMT)
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
Subject: [PATCH v2 stable 6.1 1/2] tcp: fix races in tcp_abort()
Date: Mon, 17 Mar 2025 14:07:42 +0900
Message-Id: <20250317050743.2350136-1-youngmin.nam@samsung.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfVBUVRT37nu892CEeS4b3DZDZjUamQF3Nz6uJUggzmbUMONY2GDwBp7L
	xn7Nvt2mZCjiQwiK1STFhaYVaCI0kQ0YXKSINSBIMBEIikhQUD5EWEOxwnbZtfzvd8/5/c75
	nXPvpTD+LCGkFGo9q1MzShHhhTfbtqIQ6dfDcnHPtC+6236FRENtR0lU2Z+Po7PWAh6aMpfj
	6EbnBImmllcwdKwMoNzvrmBowthNoMHW2xhqbT5BosvNpR6owzZNogFrJYHqe28DtNw2R6Ki
	39pw1Gn2Q8u9cwCZGyYAKpi0k6hwZRZHdycHCbTYlUui6vYlEuWdOovHPCVr/GqEJztvGiNl
	ZotBZqn7kJCZS0nZwreDhKy0sQ7I7JaAROqNzB0ZLJPO6gJZdZomXaGWR4le3psSlxIeIZaE
	SLajSFGgmlGxUaJdCYkhuxVKx9SiwLcZpcERSmQ4TrQteodOY9CzgRkaTh8lYrXpSm2kNpRj
	VJxBLQ9Vs/rnJWKxNNxBTM3MaDs/6KE1rn9nsbwXzwGfeRUDTwrSYdB6pBMvBhTFp1sAXNhX
	DLwccAnA07UVHq7DMoBNHzQQjwS/2vLdiTYAx2ZMHs4En/4TwAt5Kicm6BDY3L0KnFUFtBCO
	D77g5GP0RRz2npknnRxfOgb2nOrjOTFOPwNH783hTuxN74RDi7+QTi2kN8HqP6ArvAH+ePL6
	GgVzhPOaKjBnTUjfoWBv2RjPZW4XHPl7hnRhXzjT1ejGQnjLeNiNOZgzPuoW5wPYM3wTcyWe
	g6apwjXTGL0V1lu3uTxshhdH3X19YJHtH7c1b1h0mO8SBsEHZeeAC2+ErdW17oIyaL+/hLu2
	cwA+rKzGj4BNpsemMT02jen/vmaA1QE/Vsup5Cwn1Yb9d6NpGpUFrL36YFkLqJi/E9oBeBTo
	AJDCRAJvY9WwnO+dzrx7iNVpUnQGJct1gHDHeo9iwifSNI5vo9anSMK2i8MiIiSR0nBxpMjf
	O6slX86n5YyezWRZLat7pONRnsIcXnGCVK0KXs27qph89tpi3yWvV4ZLxpIKu06bfB7WmFOL
	vhG+xu00xKfuyxO0Mw8KmNpiZcNAWe6F7D0H7BMv+o1X+Ht231s4+MlHx/uMQfvzYxOY5EM1
	qCQ5+fUGgXVLvCH4TFCgVOivmM+O+nlPv+CGD288q3Ex/GTodct79eJVScpwfaL92rEnh8CK
	wjrdGLKuv79qvaXqRPS6JPunr6qz98/eesun6/5LGwfif48W5B6MHFux+RH2mO+7A1I3FP50
	vHzk8ptZl6KT6wqJplgRyP1r7tzTnqov4hbiOvps/uWyvT9c3VIi/tKeQ30e+7H9/cm4pPSw
	dkNNbMDuzUU35VKeCOcyGEkwpuOYfwHYxFCMfgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRzGec85O+c4Uk7T9E1l1io0wctS6s1kSmacjKLUrhA69TBNXWtH
	uxLVnKgjZmUXs0UzP9SWJg4b5ZjXMMvIMtbFiobLSWWGKcbCblMCv/14fs/z//KncZGBCKYL
	lCWcWikvkpBCwtojEUdJm14pYnWvV6KpzkEKvbSfo5BhQEugO23lGHIbawk00jtMIfe0B0c1
	FwDSdAziaLi6j0QO2ziObNbLFHpm1QtQd88ohV60GUjU3D8O0LR9jEKV7+wE6jUGoun+MYCM
	LcMAlbsmKVTh+UKgKZeDRBMPNRRq6PxOobL6O0RyCNtqeoOx9+veU6zRUspazFUka9RT7Ld2
	B8nqW82AnbSIt9F7hYl5XFHBIU4dI8sW5tvvOwSq6gVHJmr7iVPgmlAHfGjIxMO3PVqBDghp
	EWMD0HBulJwTofCt6YVgjv3hB+2DWRYxkwA6b1JeJpkoaO37DXSApgOYYPjBsc57B2fcBNQ2
	9gFvx59Jho/rn2JeJpgVcOjHGOFlXyYJvpx4TXm3kAmDDU44Fy+Ej658nK3g/+Kyu1fxs8Cv
	bp6qm6eMADODxZyKL1YU50pVUiV3OJqXF/OlSkV07oFiC5h9YGTEPTA+rYnpBhgNugGkcUmA
	b/WNVwqRb5786DFOfSBLXVrE8d0ghCYkQb4m6W6FiFHIS7hCjlNx6v8Wo32CT2Hbn2QZ3Has
	azQox68kUd4YuqizCltGiAtTMhv2SZSmWtY/XU/+HDHLwvoX1Ck3JCX4nOaTNEzcqq0BJS12
	q2XoSOKS1Um2XX7Ps7RbVGIsvSBjSfoiOj5VmC9tDtDtOAFqvrmC0lTOSsblCdfUTrYzTrFs
	pBlFuApdy7gU19BMu0Nh35hx4ZL7+vpfgnjhD0PX45MxgTldPR0zsQMJfP3tke+3Igdm9tRs
	1qWZBg6uTgvNtM+0fg6PqbCFedYcipRVZo2WeS6ad659dkyX2lupTx2URW+K+iMuxFsuj2ef
	jzu+nOuKGkwvbW/C+Zavn84svVZm2rX/i/yK872E4PPl0khczcv/AvgPiZgvAwAA
X-CMS-MailID: 20250317050345epcas2p4cc44d6e10bb9916fba56d633f505a7e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250317050345epcas2p4cc44d6e10bb9916fba56d633f505a7e5
References: <CGME20250317050345epcas2p4cc44d6e10bb9916fba56d633f505a7e5@epcas2p4.samsung.com>

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
index 7d591a0cf0c7..1ad3a20eb9b7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4755,13 +4755,9 @@ int tcp_abort(struct sock *sk, int err)
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


