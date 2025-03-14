Return-Path: <stable+bounces-124423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F41FA60D16
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 10:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2BC1893719
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37D51EF0B0;
	Fri, 14 Mar 2025 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iubXgSoZ"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF61EE7C0
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944097; cv=none; b=R2lbQMTdaUFlXf/gC/0AnkM/PQSwePQgbTyS36XzZA3kNTkBDrTb8NDhmASSlURxgnfHI0R7nC/NeKrgV9c+iCURfpCIZ+VI8dudvxhpqeQxc9KhfZ6/YGKCdcdnrsGwNxe31r1HOXfZVEdXIoSvYuZB0KFB4uPXWzT2oa+NCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944097; c=relaxed/simple;
	bh=BzrI+MQVbm/6jXqGUS8ON4OO4Uhb3M0vnil1W0SY4xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=pNN8d7Vxy17kukBwGa7vjQVdNuA50LLKh1DntECdM+4RG23JzWcPEIFGDau0qNHR24Tej05xzMCabvqce0wvIsqnMyKwkjbm0rM1FhagLajOtyxdFlR3nA5MGvf1UP57cHJR6Mg/DLHyGq4kFQWVBKoYWUFTTrCNE4TLDRhpfp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iubXgSoZ; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250314092132epoutp0318105639a6fb51bd16fa4ae8446e566a~soOxdmMBa2961829618epoutp03I
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 09:21:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250314092132epoutp0318105639a6fb51bd16fa4ae8446e566a~soOxdmMBa2961829618epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741944092;
	bh=jwFybI78FScw6EFw2tJIl/DO2vG2x0q+jbEpcWUDHSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iubXgSoZIgQcm2rgzOMy+uYqpZahF7j3HrP+WSD3Jwt2M022aTMakQLFpJpCmssJi
	 hCLEJS89et/yzw+jA2nZCabK0wWxu9GFophp4hxWgbvHrGJdO3SL6mMRGEcIUzw0SX
	 FLUi2dDOImBGhL042XdmioeFMO5bl5/1XQmYmt8k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20250314092131epcas2p13cc2885f7118460459b017cc64689920~soOwlZDa10480104801epcas2p15;
	Fri, 14 Mar 2025 09:21:31 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.69]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4ZDf4q2TyFz4x9Pr; Fri, 14 Mar
	2025 09:21:31 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	D9.AC.22938.B15F3D76; Fri, 14 Mar 2025 18:21:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250314092130epcas2p34e60b23ff983fe03195820a38fb376c5~soOvcsHce2154821548epcas2p3W;
	Fri, 14 Mar 2025 09:21:30 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250314092130epsmtrp1de9057981f4c9787b7a5af45f1a110cf~soOvazgVF0533405334epsmtrp1X;
	Fri, 14 Mar 2025 09:21:30 +0000 (GMT)
X-AuditID: b6c32a43-0d1e67000000599a-cc-67d3f51b3aee
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	50.73.23488.A15F3D76; Fri, 14 Mar 2025 18:21:30 +0900 (KST)
Received: from perf.dsn.sec.samsung.com (unknown [10.229.95.91]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250314092130epsmtip1f5c58ffeaf0f71b70bea83097dc7db2a~soOvK0vle0080200802epsmtip1K;
	Fri, 14 Mar 2025 09:21:30 +0000 (GMT)
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
	gregkh@google.com, Lorenzo Colitti <lorenzo@google.com>, Jason Xing
	<kerneljasonxing@gmail.com>
Subject: [PATCH 2/2] tcp: fix forever orphan socket caused by tcp_abort
Date: Fri, 14 Mar 2025 18:24:46 +0900
Message-Id: <20250314092446.852230-2-youngmin.nam@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250314092446.852230-1-youngmin.nam@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxT3673cW4iMu8rgGxipZeB0obRI6QcKvojUbMnY1GVTIzZw0zL6
	Wh8G2eYIlMdQ6XCwKY/Zpfhim9SO18BOUgiwEXSjdAYcD0GBKeILEExko9xu87/f+X2/c87v
	nC+HjXHmiSB2ukpPa1VSBY/wwRva1osigmedMoFtyA/NtPaS6A97CYkqrxtxdKk5j4XGzadw
	dKdjlETjcwsY+rIUoJyrvRgaNXURyNUyjaGWhq9J9FtDsRdytE2QyNlcSaDa7mmA5uxTJCr8
	046jDnMAmuueAsh8eRSgvLEnJCpYuIejmTEXgR515pDI0vqYRLnfXsK3BkvqLvazJD+VD5IS
	s80gsdV8TkjMxaTkwc8uQlJcVwMkT2xrktn7MjbLaWkareXSqlR1WrpKFs97c3fKjhRRjEAY
	IYxFYh5XJVXS8bzEt5IjdqYrlqbmcQ9LFYYlKlmq0/EiEzZr1QY9zZWrdfp4Hq1JU2jEGr5O
	qtQZVDK+itbHCQWCKNGS8FCGvKa/kaXpCc7suibOBpWBRYDNhlQ0/D1XWAR82ByqCUDLcxvG
	BI8BHM2ZZzHBHIDmiSG8CHgvZ9xrz/eo7AD2uY57glkAa3snvdwqgoqADV2LwN3DnwqCw65N
	bhqj7uDwZm6mG6+ikuCVGyPAjXEqDC4s9rHc2JdKgDfPVuKMvRBoGYFu2pvaAstsA4CRvAx/
	OX0bZ0qGwNz6imULkDrmDQfLzgHGaCK8X1zqxeBV8G5nHcngIPiXKd+DdTB7eMCTbATw1xuT
	GPOwEZaPFyz7x6j1sLY5kvETCtsHPH1fgoVtz0mG9oWF+RwmMRw+K7V6HKyGLZYLnoISaJ9a
	8GI2dRLAYZMZ+wJwy18Yp/yFccr/b2wGWA0IoDU6pYxOjdII//veVLXSBpZPYMOOJtB3ZpHv
	ACw2cADIxnj+vsjplHF806RHsmitOkVrUNA6BxAt7boEC3olVb10Qyp9ijA6VhAdEyMUR4kE
	Yl6g78dNRhmHkkn1dAZNa2jtv3kstndQNkt9MiSOn7535zzH7ies/0y7dW3FlXe3HBU+qPpI
	8SNltPasORT3gaU29NjQ4HeOjW8ok8SShJQV+151HCgo3B4sOvKJYZthV7j8fkmBIsNu3W4Q
	qsNn/Vp7BM7uKjzSxJ99e/+pzEznN8NzuxvyQtRjwwcC9zQ+2m+USKzELWvspyMV3g/Pv3O3
	+wSRZ5kh+h8e9vdrRE8nz8ovmp4SAfkz7yWVCcP42861dlVdXxmantG9+nxfh9cJ6Hpt1jxR
	U38LGLnHq0NYnZt00nVZK394/9qz6b/b66qN37dws26ve51zdCJ0RdjVXVnKxK9OHyyLW6zM
	qz7oNEVf6NvrY4378PKeMzxcJ5cKN2BanfQfKG9d9IsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTYRiH+3aO5xyHxnFafs20WBcvpXNl9XVRgyKPFGFQUFbk0sO6OB27
	dLFC8a7BKsqa03IiBgotXLYyW8Wxi2llc62lJs1L2cUsUwdDkJwS9N/D7/m9Ly+8FCa4gwup
	oxlqVpkhTRcRfNzcIgqJFE7YZNHnq0PR+JNOEr23XCJRZUc+jowPCnjoi0GHo8/P+0n0xeXG
	0OUrAOU+7sRQ/4VWAtmbRzDUbL5GordmrRfiWoZIZHtQSaDb7SMAuSzDJCr+aMHRc8N85Gof
	BsjQ0A9QwcAYiYrcP3A0PmAn0OiLXBLVPPlDorxqI745iGms6+IxTfpekjGYNIypvoRgDFqS
	+fXITjDaxnrAjJlCkqhk/qY0Nv3oCVYpjkvhH6nvusdTvA461fpmXQ6oDCwF3hSkY+CPp4WY
	hwV0M4Cjv/mz+ULYU2fzmmV/+Cn/6TTzpztjAFqd+TOCoCOhuXUKlAKKCqCF8JN9o6eD0QVe
	sK8iZ2apP50AHzqcwMM4vQy6p97xPOxLx8Ge2krcMwvpRbDGCT2xNx0Py0zdYPaeOFg1pMNm
	637wZfkg7mFsup53twK7CGj9f0r/nzIAXj1YwCpUcpk8VaKQZLAno1RSuUqTIYtKzZSbwMxf
	I8LugxFXrpgDPApwAFKYKMAX2WwygW+a9HQWq8w8pNSksyoOBFG4KNC3TrJXJqBlUjV7nGUV
	rPKf5VHewhxe8dZxxty2Ilg8xvpEVHHVuhNrJy5jKdutXF7gyWD1n5FjwysVzuRtU9URjQLm
	WFTSpLFzVLHnKzF/V2z8wJbV3rFDMtYYtHqhY2lNglxcou67aosd7zPtFpBOn6uZTS2HB2N2
	cY/DlndnPZrU+w3FZ6k7yr7f4BznSrb1gfOJjim9xsfr/fbC2p6wsxM3DmbffrVCbgTClvAa
	ftd+E0lw8msrddbQEHveFUH2h6pbvanusgSN+EyiVoOvsiRGW9bx3c/E1pi5HbGlbeXWl6d2
	lHdtyXfNK3rhiP55c/D0nInWijU7C75Jrg+k7Fu8PzwkYMM5v8kDDeuDl2jrdCoRrjoilURg
	SpX0L7wOt81GAwAA
X-CMS-MailID: 20250314092130epcas2p34e60b23ff983fe03195820a38fb376c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250314092130epcas2p34e60b23ff983fe03195820a38fb376c5
References: <20250314092446.852230-1-youngmin.nam@samsung.com>
	<CGME20250314092130epcas2p34e60b23ff983fe03195820a38fb376c5@epcas2p3.samsung.com>

From: Xueming Feng <kuro@kuroa.me>

commit bac76cf89816bff06c4ec2f3df97dc34e150a1c4 upstream.

We have some problem closing zero-window fin-wait-1 tcp sockets in our
environment. This patch come from the investigation.

Previously tcp_abort only sends out reset and calls tcp_done when the
socket is not SOCK_DEAD, aka orphan. For orphan socket, it will only
purging the write queue, but not close the socket and left it to the
timer.

While purging the write queue, tp->packets_out and sk->sk_write_queue
is cleared along the way. However tcp_retransmit_timer have early
return based on !tp->packets_out and tcp_probe_timer have early
return based on !sk->sk_write_queue.

This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched
and socket not being killed by the timers, converting a zero-windowed
orphan into a forever orphan.

This patch removes the SOCK_DEAD check in tcp_abort, making it send
reset to peer and close the socket accordingly. Preventing the
timer-less orphan from happening.

According to Lorenzo's email in the v1 thread, the check was there to
prevent force-closing the same socket twice. That situation is handled
by testing for TCP_CLOSE inside lock, and returning -ENOENT if it is
already closed.

The -ENOENT code comes from the associate patch Lorenzo made for
iproute2-ss; link attached below, which also conform to RFC 9293.

At the end of the patch, tcp_write_queue_purge(sk) is removed because it
was already called in tcp_done_with_error().

p.s. This is the same patch with v2. Resent due to mis-labeled "changes
requested" on patchwork.kernel.org.

Link: https://patchwork.ozlabs.org/project/netdev/patch/1450773094-7978-3-git-send-email-lorenzo@google.com/
Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
Signed-off-by: Xueming Feng <kuro@kuroa.me>
Tested-by: Lorenzo Colitti <lorenzo@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20240826102327.1461482-1-kuro@kuroa.me
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Cc: <stable@vger.kernel.org> # v5.10+
Link: https://lore.kernel.org/lkml/Z9OZS%2Fhc+v5og6%2FU@perf/
[youngmin: Resolved minor conflict in net/ipv4/tcp.c]
Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
---
 net/ipv4/tcp.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9fe164aa185c..ff22060f9145 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4620,6 +4620,13 @@ int tcp_abort(struct sock *sk, int err)
 		/* Don't race with userspace socket closes such as tcp_close. */
 		lock_sock(sk);
 
+	/* Avoid closing the same socket twice. */
+	if (sk->sk_state == TCP_CLOSE) {
+		if (!has_current_bpf_ctx())
+			release_sock(sk);
+		return -ENOENT;
+	}
+
 	if (sk->sk_state == TCP_LISTEN) {
 		tcp_set_state(sk, TCP_CLOSE);
 		inet_csk_listen_stop(sk);
@@ -4629,15 +4636,12 @@ int tcp_abort(struct sock *sk, int err)
 	local_bh_disable();
 	bh_lock_sock(sk);
 
-	if (!sock_flag(sk, SOCK_DEAD)) {
-		if (tcp_need_reset(sk->sk_state))
-			tcp_send_active_reset(sk, GFP_ATOMIC);
-		tcp_done_with_error(sk, err);
-	}
+	if (tcp_need_reset(sk->sk_state))
+		tcp_send_active_reset(sk, GFP_ATOMIC);
+	tcp_done_with_error(sk, err);
 
 	bh_unlock_sock(sk);
 	local_bh_enable();
-	tcp_write_queue_purge(sk);
 	if (!has_current_bpf_ctx())
 		release_sock(sk);
 	return 0;
-- 
2.39.2


