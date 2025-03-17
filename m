Return-Path: <stable+bounces-124581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0011A63F22
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 06:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B44D3AD5BB
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 05:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2952153EB;
	Mon, 17 Mar 2025 05:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GZsUuZBR"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FDB21517D
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 05:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742187957; cv=none; b=YoBHUkKAJSAxzjeRqRoSk4/+mJms1B7jwO5czV0e0JhegNPAx3EeMForVJ1XII2IjHBcdr/Wh7VWDBfemdEpXtibuEv1p5tCNRUQ8TNwx/bPIURe0dGBgMl9INyFqD13HmoEZiMIVIgxG2fDyTpqQINmUzdLSspApxaqIstLCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742187957; c=relaxed/simple;
	bh=ipv8rMVW3ERGH3eiCEl8IzeWf/gtBtntXWcsUqgJkrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=qANfGuwDCYMO3g/EJrbPmHw3fDbH1W3eu+Mo35ahjeFH1wkCddjzf/NsBoyRwsJ4TgXUMHNmyzwm97ONcaGuTxS2nRB+BlRrRxov+KE4864O72xn9Q8UzIziNu6r5iRlAges9vH/xxXBFg7M5K/czV3wMeMSAKTj5d8En29/Znc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GZsUuZBR; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250317050553epoutp01824491331321f3a95da0e8d14f05277a~tfradrubD1560915609epoutp01Z
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 05:05:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250317050553epoutp01824491331321f3a95da0e8d14f05277a~tfradrubD1560915609epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742187953;
	bh=Xb0t7aSJEf5G74tQ1qvnseCvuLAXjviEbbQuE6Y2ccw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZsUuZBROSukNufwjejYwderaezL4eGio3jn49XKfGqfeLzN3jN40iOL1hgU37THJ
	 vlB/UsA+kXTksOcE5X3+tqirLQszDhrPbJvdlpgFGDI/HmMun6D9uBy+zJCyyq0Y3o
	 cn2yisYHXLjoLhMiFbHFxzybKRWAmxPUdmkYuf44=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20250317050552epcas2p3b6c70fc5b3c4a44c1aa80f0fff279fc9~tfrZmhWND3174431744epcas2p3b;
	Mon, 17 Mar 2025 05:05:52 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4ZGNGS0tgsz4x9Q6; Mon, 17 Mar
	2025 05:05:52 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.DB.22105.FADA7D76; Mon, 17 Mar 2025 14:05:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250317050551epcas2p365f292c4cecce8c4d15960c4219a44c2~tfrYhlrhh0393203932epcas2p3b;
	Mon, 17 Mar 2025 05:05:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250317050551epsmtrp27b1cdc6aaf4399b50f2cd13358b4875f~tfrYgZD0O2082720827epsmtrp2g;
	Mon, 17 Mar 2025 05:05:51 +0000 (GMT)
X-AuditID: b6c32a47-f91c170000005659-8d-67d7adafc3ba
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0B.7C.18729.FADA7D76; Mon, 17 Mar 2025 14:05:51 +0900 (KST)
Received: from perf.dsn.sec.samsung.com (unknown [10.229.95.91]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250317050551epsmtip126608e9b9edf00a488a87c8491b1cb36~tfrYMwPPZ2597525975epsmtip1k;
	Mon, 17 Mar 2025 05:05:51 +0000 (GMT)
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
Subject: [PATCH v2 stable 5.15 2/2] tcp: fix forever orphan socket caused by
 tcp_abort
Date: Mon, 17 Mar 2025 14:09:50 +0900
Message-Id: <20250317050950.2351143-2-youngmin.nam@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250317050950.2351143-1-youngmin.nam@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfVCTdRz3t+fxeTbO2dN46efAoqeo0IYbMvazRMmAdkVK2p3E6cEOHgcH
	e7ltcBC97BwEecUgXwaDrtkohBAQFg1wSOApwqWmh0ujI2e8JArEiKQLbWOz/O/z/fw+n+/b
	775sjHeP4LNzlDpGo5Tl0UQA3jkQKRG0nXTKhYsCtNB3hUTXHFUkqrtUgqOW7lIWmrBU42j8
	nItEE4tLGDp8BKCDZ65gyGUcJNBIzwyGejpNJLrcWbEa9Q9Mkuhqdx2BWodnAFp03CFR+agD
	R+csIWhx+A5AllMugEpvuUlUtjSNo4VbIwT64/xBEln75klkON6Cx4dKbY3XWdIu8y+k1NKe
	L21v+piQWipI6WzvCCGtsDUBqbv9yRR2Wu7WbEaWxWjCGWWmKitHKY+j39iT/mq6OFYoEoi2
	IAkdrpQpmDg6ITlFkJST5xmaDi+Q5eV7qBSZVktv2rZVo8rXMeHZKq0ujmbUWXlqiTpKK1No
	85XyKCWje0kkFEaLPcKM3Gz9D/UstSG00FR6YrUejIUcAhw2pGLgktMIDoEANo+yAzj8eas/
	mAfwJ9sFwhcsAtjr+Bl/aHFPTLF8Dw4A22rn/cGfAJrOdGBeFUEJYOfgfU8uNjuI4sOxkZe9
	Gow6i8Ph5rukVxNIpcLBmu8JL8apCHh6xrhSgUtth66Gv1heL6SegtZfoZfmUPFw6l6NX/I4
	vFDz2wrGPBLDt7WYrzkjBxp6433WBDg39LSPDoS3z9tIH+ZD94yD8GEt1I/dwLytQaoEwCHn
	lD/PZmieKFtpH6MiYWv3Jl/KZ+DZG/6qa2H5wDLpo7mw/COez/gc/PtIG/DhMNhjPeFPKIUm
	m9W/28MAVjdPg0oQbn5kGPMjw5j/L2wBWBMIYdRahZzRRqs3//e/mSpFO1g5gQ2v2UH13bmo
	fsBig34A2RgdxDV+6ZTzuFmyoncZjSpdk5/HaPuB2LPpKowfnKny3JBSly6K2SKMiY0VSaLF
	Qgn9BLfYXiLnUXKZjsllGDWjeehjsTl8PevNZXUTrl5zmx31KSE5PtHlUt2kf3QnZTjSYu1H
	bbDLKlxVJCoKLqQ/S+Qk2b9oUY2nGfpmeQvri+rWSycVgxcn3SczggrsYaed2wXZXwV3dLxS
	WOn6upgX+uJs5tyq0YSdawtcwqTdV3cpj/X/w20Yn04W2MfeiTzQXGbOnZoPNPXERewvMA9s
	rN+Hb1xTudek+K7WuXvnUGrEwNHqxh1j3Q/2rFte3ra32NQQXH6zaOEbXnNq4rq+x0T82X3P
	RlQFvOe4lh62Xyw21r5t+f3DMDp5/H3OqU+u13CndxQYjtUX6w88f0k1GmW9f5HA9E2vyzJG
	S3clqhsfzF+WvfDBW3NSGtdmy0QbMI1W9i9pB/s6iwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSnO76tdfTDbadlrT4cuASu8W1vRPZ
	Leacb2GxWLerlcni2YIZLBZPjz1it3j27SezxeQpjBZN+y8xWzzqP8FmcXX3O2aL3dums1tc
	2NbHanHo8HN2i8u75rBZrD/9jtHi29437BYdd/ayWBxbIGbx7fQbRosFGx8xWrQ+/sxu0f7z
	NYvFl8dX2Sw+Hm9it1h84BO7RfPCdSwO0h5bVt5k8tg56y67x4JNpR6bVnWyeSzoY/d4v+8q
	m0ffllWMHp83yQVwRHHZpKTmZJalFunbJXBlNJxdwlTQLF0xvXUFawPjfbEuRk4OCQETic/P
	XjCB2EICuxkl2o+GQMRlJG6vvMwKYQtL3G85wgpR85lRYstqXxCbTUBXYtuJf4xdjBwcIgJS
	EvevWncxcnEwCzxjkWhZc4IRpEZYIEyi4fxhZhCbRUBVYs+7fhYQm1fAXuLR8u9MIL0SAvIS
	ix9IgIQ5BRwkXvyYyQKxyl7i1udp7BDlghInZz4BizMDlTdvnc08gVFgFpLULCSpBYxMqxgl
	UwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxguNVS3MH4/ZVH/QOMTJxMB5ilOBgVhLh7V90
	PV2INyWxsiq1KD++qDQntfgQozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QDE5dWzqYr
	W1M9q31kTFY777BT2hlQI6Dg8sxy5oKXHyf6hzs13nd8XrJ4aiPfgm3uk78rB+5ZpJ1XHcDt
	Ot3LWo2lSjDv86V5eds1Lz6xczq40Wtn7fSUp8GPV/jPK00+p3g0wFfS9oDCCu0zM/a3aFz3
	s/ogVnzXgqnp4EzlxlSFUFfj6tCfXBq6FUXLZJiaXA/kv36syfTlzfvjlyOUjnGYdyZ9Cnya
	I5DoWnfXdZrY9LmTPyY375n4sU3wUP4ksXlHss4lNkmK61h3zJnQFsm8h1/VpTJ4XrJU/GK9
	jQrLXh9dMaFzEruIz+qAdRbNAlzsX7bvZxb+nXFjkiHv281L1fPXxdieqX4qm8uvxFKckWio
	xVxUnAgAxCtET0YDAAA=
X-CMS-MailID: 20250317050551epcas2p365f292c4cecce8c4d15960c4219a44c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250317050551epcas2p365f292c4cecce8c4d15960c4219a44c2
References: <20250317050950.2351143-1-youngmin.nam@samsung.com>
	<CGME20250317050551epcas2p365f292c4cecce8c4d15960c4219a44c2@epcas2p3.samsung.com>

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
index c1e624ca6a25..7ff0ecb59579 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4504,6 +4504,12 @@ int tcp_abort(struct sock *sk, int err)
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
@@ -4513,15 +4519,12 @@ int tcp_abort(struct sock *sk, int err)
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


