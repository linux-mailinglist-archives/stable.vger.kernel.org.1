Return-Path: <stable+bounces-66131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D78794CCF0
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 11:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C4C282E30
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 09:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73F518F2F2;
	Fri,  9 Aug 2024 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTgOZWvU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648474431;
	Fri,  9 Aug 2024 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194503; cv=none; b=L7OkGzJuzhVudVXnM3Ept15SPpm1u3MQn3ERjysA8ua5v9upe2YTA1tiHJs2Z6s2g8zIPy6F1SC/b/MSCOn2L8vzxMEYxq/o/xMz0YJxaaRLuVwVrxzVLddNvKxp3gEjqTJTkwCAReJT5TdG7+MPVXw7RSavl5nLUq0nmBDQtws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194503; c=relaxed/simple;
	bh=33CzOGIrA+23VwfTJJrkSVPN2f1A7HK3EiJOP5ec01I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SR4hDDa12Kjv4rYS8b/yj9Rba4zzXaD40WBZWb/FYwNqkFpVxNlH5DR7AzXdcQUez1ObYnhMXWDarqkt2kecAe//ap/iL6ycltHY+Y0V+9LRs09a46x2M/pr62fOCiskcxIPqqa7SeUlYRg1IcdEae8lF37DabuEonvZ0wAqFvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTgOZWvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8C7C32782;
	Fri,  9 Aug 2024 09:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723194502;
	bh=33CzOGIrA+23VwfTJJrkSVPN2f1A7HK3EiJOP5ec01I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTgOZWvUZv62vnK8ZWEM38yUJzhnWmoa99t2cIp4hmMy/lMQ2nFsYi7L2Uaar95b4
	 qbH5Ef45tl7336YWMJUecxXLouySLm1AOLMwybjvcPRhQkCV66Lc3FtiV2Uk/5ZPok
	 eNSfXFvQv7uChTeXQxZRaABlNiRew/wfKVx7kJJ/5fOR4peSIT/W5V+5f5p576Con+
	 BsQJtoafTSCxG218RS7uPv71YuIVvTRO0W+owtD223mBwwRQLotqo4rbAK1COPUi8h
	 i9JGz5SaZoSKodFexIytYzTyjAjA0xohwsHvICNFmzBwjuYz4DLs9LFePHLappTEjo
	 Ll6wDscdD+Gow==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 5.15.y] mptcp: fix bad RCVPRUNED mib accounting
Date: Fri,  9 Aug 2024 11:08:14 +0200
Message-ID: <20240809090813.2700287-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080738-providing-expiring-91d1@gregkh>
References: <2024080738-providing-expiring-91d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=matttbe@kernel.org; h=from:subject; bh=FS8mALVmet6EZrYV3F0dy7bL4krYZ50u0JCp73RBQc0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtdx9IZTYPLxoHVhctzT7BPVzlOQ8X5bXJAmlX vFA6X1UWw2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrXcfQAKCRD2t4JPQmmg cwZ+D/9SFr7sb3EXrjJRX67RWgQzyZ19wxnpXjfhnW97EfC+dhcjG9gL0FUq0Lm3ZOD07u9rXNw mSLzphAB+EAseMyJjfY3u+YpOsRcHasPCCcFKUD9K9kOebhHQUSRfTcB4/ffjcSn85v3BzaE4iu +nZoYkVofHm+Y36It0r7c/N37Otxa+XD8b51jpe7b2PGHuPJRdOv+8iXNqoICrAq8/HNS74hRvw o+1qCWBmqp1o1tMfLWhGjmnRiFNb/M7DHLhwPtM3E5mhLtVuJ69wKZNhou+jVYOGO6Qp4iliJuL WBGmfikNNcVHKc+1uLSFp+58qejSDQB9oXMabjiWjx9+swOsd4RqXT62SlIu964D79BWdNAdTwr pxY6yMvTWG+Qd6T1SI0sjzxTT5/lzUYZNkSERk5PU8bV5diZLUjbm8UF9fgZmDS0vddBk8T8ED1 p4nHWsYPNtDLVNP4lApDv9n6ArVrgzIKMq2cwb51FdS11no85lEq1VRR4i38PF55DofXs/hBW8g hGWhDtsoaOmge/T95+MH0aWzoVp4fRGedqZuGh4suH0M4EDEwyeO8DkRx/87dnsBne47Jhi9H0e I++RQuqfHnvUdAuI5Z/GdcpEjE/mWK2o/E4nAvG/MUxisi28AL/FmqfiufH48IS5vUkTKAg5WtA x988YjP15VgyfmA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 0a567c2a10033bf04ed618368d179bce6977984b upstream.

Since its introduction, the mentioned MIB accounted for the wrong
event: wake-up being skipped as not-needed on some edge condition
instead of incoming skb being dropped after landing in the (subflow)
receive queue.

Move the increment in the correct location.

Fixes: ce599c516386 ("mptcp: properly account bulk freed memory")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in protocol.c, because the commit 6511882cdd82 ("mptcp:
  allocate fwd memory separately on the rx and tx path") is not in this
  version. The fix can still be applied before the 'goto drop'. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b6b708dbfce9..9273316cdbde 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -288,8 +288,10 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
 		int amount = sk_mem_pages(skb->truesize) << SK_MEM_QUANTUM_SHIFT;
 
-		if (ssk->sk_forward_alloc < amount)
+		if (ssk->sk_forward_alloc < amount) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 			goto drop;
+		}
 
 		ssk->sk_forward_alloc -= amount;
 		sk->sk_forward_alloc += amount;
@@ -774,10 +776,8 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		sk_rbuf = ssk_rbuf;
 
 	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
-	if (__mptcp_rmem(sk) > sk_rbuf) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+	if (__mptcp_rmem(sk) > sk_rbuf)
 		return;
-	}
 
 	/* Wake-up the reader only for in-sequence data */
 	mptcp_data_lock(sk);
-- 
2.45.2


