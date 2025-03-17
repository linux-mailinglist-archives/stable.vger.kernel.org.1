Return-Path: <stable+bounces-124578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2267A63F17
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 06:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 172297A4DFB
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 05:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E749217663;
	Mon, 17 Mar 2025 05:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cvpsARB1"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036BB217657
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 05:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742187838; cv=none; b=e27vD6bUDbrxpO12nCQBA8tJcUP2kujCcRBACJgIgKpD6l9i9LESdiK+lbKZOjNw3yIlHS4/v585dS4JvLDOFohrsx3RJRnHyX+ZRktT2HFqi3yAdz0zqYy1SbzBZQCBb4DxLE0s3Filw7CKWQjn0EaV+nrTUkE4+zIw56x8GvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742187838; c=relaxed/simple;
	bh=zGYIv+Hhzn1MQVBX0XOcV0ByAZ23bMtfnEGSYKLgHCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=svCVrpOB2ZDzt39LcccBLvFu2JrjgcWn73F0UerUETn/j7qUir6DPhTqik/JwHrpLrBMHr8mnydx6+xLjDalgkSUAYgh6oNQhgJnYG6dMtg/V0dVS3By3UzS0MxV0Iu5LBxd1sgFSJDNqWS3zSpF82kMf8rhSejn661iQbRAUk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cvpsARB1; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250317050352epoutp031efa6e3b3bac7af5faebafe4557486cc~tfpqFYBII0611606116epoutp03s
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 05:03:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250317050352epoutp031efa6e3b3bac7af5faebafe4557486cc~tfpqFYBII0611606116epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742187833;
	bh=6EiAEIzNYgOkMx7TS9Hntt/nK3Y08tJUDiqot73jl60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvpsARB1wu6zFczPg+ATSFpu/LsRUMjqtWDJyR+4FufeA1eTBCj54vbqGG+kjiL38
	 g16M3cB/qJgCsKe9zR6uRKZtYqpy1n5wSqoeVMoCNSwPnqid0PP/VuITFn/BuY2PVN
	 eTQHXwsawJJPO2z/gI/QKzvL4Zk1H8tHUmhp1WxI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20250317050352epcas2p4849df5d98ddfe308092f083072c45435~tfppQxN382395723957epcas2p4H;
	Mon, 17 Mar 2025 05:03:52 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4ZGND73Nc1z4x9Q2; Mon, 17 Mar
	2025 05:03:51 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	28.B3.23368.73DA7D76; Mon, 17 Mar 2025 14:03:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250317050350epcas2p3612d0b2787f9e21ab4719b9bf8a70c54~tfpoGOaaj2573225732epcas2p3V;
	Mon, 17 Mar 2025 05:03:50 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250317050350epsmtrp1f2a32dd5e61666c56f2fecde1dc49eec~tfpoD1-u80199601996epsmtrp1E;
	Mon, 17 Mar 2025 05:03:50 +0000 (GMT)
X-AuditID: b6c32a45-dc9f070000005b48-53-67d7ad3762ed
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	77.3B.18949.63DA7D76; Mon, 17 Mar 2025 14:03:50 +0900 (KST)
Received: from perf.dsn.sec.samsung.com (unknown [10.229.95.91]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250317050350epsmtip1a19fb8300f2c56734dbb06b648c66307~tfpnt-ySV2650226502epsmtip1B;
	Mon, 17 Mar 2025 05:03:50 +0000 (GMT)
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
Subject: [PATCH v2 stable 6.1 2/2] tcp: fix forever orphan socket caused by
 tcp_abort
Date: Mon, 17 Mar 2025 14:07:43 +0900
Message-Id: <20250317050743.2350136-2-youngmin.nam@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250317050743.2350136-1-youngmin.nam@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTVxjGOb3l3gJju1TEAzqpNfsAB7QI9ODsJJZJl7mMsQ8YarDCtRD6
	ld6yzBGQUT67BAScOmSuwhKw0SKsED7CdOCASbYRJjSIGwwGAgNhgGjHxLXcuvnf77znec55
	3vfkcDCuDffjpKl0lFYlU/Bxd3ZzV0BEkOiKVS6oM/iilesDBBrqKCNQ1c95bGRuy2ehKeM5
	NprsHifQ1KoNQxWnAcq9NoCh8dJeHA2238NQe/NZAvU3l7iizq67BPqlrQpH9X33AFrtmCNQ
	0Z0ONuo2+qDVvjmAjA3jAOVPLBOo0PYnG61MDOLor55cAtVcXyKQ/qKZHbVVark0zJK2Vv5K
	SI2NGdJGUzEuNZYQ0oVvB3FpicUEpMuN22M5iel7UylZCqXlUapkdUqaSi7mv/lukiQpPEIg
	DBJGIhGfp5IpKTE/+mBs0IE0hb1rPu8jmSLDXoqV0TQ/5LW9WnWGjuKlqmmdmE9pUhQakSaY
	linpDJU8WEXp9ggFgtBwu/BoeurYQC6h0W/9uKBkkZUDRn0MwI0DyTDYf/4K28FcsgXAW4/E
	DC8BWPvTcwbgbudVAA36IfDEYJ62YsxGB4CFvevOxX276tIky6HCySDY3Ltud3A43qQfHB18
	1aHByBts2Hd5nnBoNpHxsLjtU1cHs8kXYO+tJdzBnuQ+WLWct+GFpD+sGYOOshsZBR/WN7gy
	Ei/4wxd/bKTG7BJ90/mNDJD8zA0O5k+wmKTRsHa6HGd4E5ztsRAM+8GZ0gIn0zBn9LbTnAfg
	Tes0xmzshpVThRshMDIA1reFMHl2whu3nfc+C4u6HhFM2RMWFXAZ44vw79NXnbPaBttr6pwH
	SqGpwMJmRlUBYH95LTgFeJVPtVP5VDuV/19sBJgJ+FAaWimn6FCN8L/3TVYrG8HGHwh8vQVU
	zC8GdwIWB3QCyMH43p6l1VY51zNFduITSqtO0mYoKLoThNtnXYb5bU5W2z+RSpckDIsUhEVE
	CEWh4QIRf4tnZkuenEvKZToqnaI0lPaJj8Vx88thyYdHMkfvJh7Z7a3+x9Id7z8yc/gbl6wP
	T06OrTweZ02RCnPefLI1pvoAiNrRerXEw9s18HirzownnBoub0vQlq+/HIdtlmyz5vZ4ScJ2
	ZLr4f69LXHxoJnybbJzRt7oN+9OzTOZpvUE7+/UD7p0R//ALJ/TdKdnYSzlvlFn2ZL1Tpai2
	VasPHR4LMu3fJdacKytPvB9TKNEcf5yde2hmIVQS8/xR8Bv1ytD7B79778E+a1VTu2/9V6Ij
	AVu6LmqnPEJu9ke7fLld6RL4Nq84TVm3cy3rg8hjtmNJa/En1zw+j73gpZ0tpMX5Z+KKf5xb
	+P2ZGAm3Zdhdvyvhcnxc9rUGIc5n06kyYSCmpWX/AqphAkeMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRjHe3eO5xxHxmmKvakYDCIbZWoSr2WWXQcl5YfRjbKhhyW6ObY0
	FSlxs7zg7H7RVUuJctnUpcu5LXWKTYuyeUvMNC0tmlNTRkZFbRX07cfz+z//58NDYZx6PIBK
	lpxkZBJhKpdg44Y2bvDaDQ8HRGHFUyFovsVOon7LBRKpXypxpGvKZ6EJzXUcfegYI9GEawFD
	ly4DlNdsx9BYqY1AfSYnhkyGayTqNqi8kLVtkkQ9TWoC1TxzAuSyOEhU8MaCow6NP3I9cwCk
	qRsDKH98jkTnFj7jaH68j0CzT/NIVNnyhUSKOzp8ayC/vmqQxTeWDZN8jT6dr9cWEnyNiuRP
	P+kj+Kp6LeDP6YP3U4fZ0UlManIGI1sXc5x9YtSeR0oVgZlnVTOsXDDiXwS8KUhHQt3HAawI
	sCkObQKwSbFA/BFBcKiqx+sP+8IRZbuHOfQcgHWtkW4m6LXQYPsJigBF+dEBcKRvk7sHoydw
	qKy2AXfGlxbAQusL3M04vRLaer94+n3oLVA9p/TsQnoFrByF7rE3vRV+ran7e2oL7BhV/Y0v
	hZ033ntqsN9xRUM5dh7QZf+psv+UBrC0YDkjlYtFYnm4NELCnAqVC8XydIkoNDFNrAeex/J4
	jcCsnQm1AhYFrABSGNfPp7RiQMTxSRJmZTOytARZeiojt4JACucu83F9Lkni0CLhSSaFYaSM
	7J9lUd4BuSw9L4UXuP5ohCRx9oc2pbQ97WOHU1xUO/EayTrf+LIXFcRGFCzutVRnvo3y7Y1w
	Zp1/1BBZG1MOcjrX3L/7/Ea31+rDCa8Kb9qDD/VOCt4ZHyhzNm+D00fsIzWm2cSz5sfvutRf
	Hf57Q8gz5ijH4qvP44eKBZ+klXGuB9uDHupVigBW99GmKsGU2X7kdlB/Qqxx5hE7K/5Tbfu4
	yRBtb9Vn2jXqXOK0RXdq5pt51RB3+f7qcmdD6IHJ5Fu21cmodedFa37YhjvKbEP09xZg7Dpo
	xI/vmDo4vK8EELd2CZoHRWKOfvexihVx3HFdfRdcsme+8XLLjo0Zbfdi/aLPXeHi8hPCcB4m
	kwt/AfJgvLdHAwAA
X-CMS-MailID: 20250317050350epcas2p3612d0b2787f9e21ab4719b9bf8a70c54
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250317050350epcas2p3612d0b2787f9e21ab4719b9bf8a70c54
References: <20250317050743.2350136-1-youngmin.nam@samsung.com>
	<CGME20250317050350epcas2p3612d0b2787f9e21ab4719b9bf8a70c54@epcas2p3.samsung.com>

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
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/lkml/Z9OZS%2Fhc+v5og6%2FU@perf/
[youngmin: Resolved minor conflict in net/ipv4/tcp.c]
Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
---
 net/ipv4/tcp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1ad3a20eb9b7..b64d53590f25 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4745,6 +4745,12 @@ int tcp_abort(struct sock *sk, int err)
 	/* Don't race with userspace socket closes such as tcp_close. */
 	lock_sock(sk);
 
+	/* Avoid closing the same socket twice. */
+	if (sk->sk_state == TCP_CLOSE) {
+		release_sock(sk);
+		return -ENOENT;
+	}
+
 	if (sk->sk_state == TCP_LISTEN) {
 		tcp_set_state(sk, TCP_CLOSE);
 		inet_csk_listen_stop(sk);
@@ -4754,15 +4760,12 @@ int tcp_abort(struct sock *sk, int err)
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
 	release_sock(sk);
 	return 0;
 }
-- 
2.39.2


