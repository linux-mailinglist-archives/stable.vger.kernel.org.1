Return-Path: <stable+bounces-17975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9638480DE
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2C71C24141
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390921A27E;
	Sat,  3 Feb 2024 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dx6BMv64"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4ADFC03;
	Sat,  3 Feb 2024 04:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933455; cv=none; b=nXsYHcEKEV+e+WH5fzOz9r5ZsjIU85qkoWfalQKG1DzOA7iWPKKpJFEFfiFnbh5/BguulMpqlmDklR44sNHNeCAN96nZfDrW9Dvd5SgEEni6qnPzv3xRu1VOdw7H8Nyi9N5rYBwec+LAx+UmogmCatZYzAv9p7TpYKQxYx8mrto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933455; c=relaxed/simple;
	bh=w7nzPg8fc3VQys1+YHOSRVjRNk/2TwU7+3blsQsQngg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqYiF9n06ZrzupeALKggovQAqbrJ+R2X8tjZg3Qw2ToR02IBVccAoQLnEgIMfXR6ZEaOQfU4+9Ye0tEyscSRfK8BmR1Qc2d66aF/fDD8CCjTqSqsaGXZpqudY7ZJW7qBxhTXb5Kl7z5FL4ayThgzuZjW39m4FxSe4lQkiEeb0As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dx6BMv64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C95C433F1;
	Sat,  3 Feb 2024 04:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933454;
	bh=w7nzPg8fc3VQys1+YHOSRVjRNk/2TwU7+3blsQsQngg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dx6BMv64CaryQiI2ZHAS77DHSC+rPsa8sy1wJWzMNNj//mzbGxiDyzzu6iPYba7cQ
	 yXR2ftyZSYklEQozjaqMB4jUsXeSz6CatEa4mB9E79IjrU90lwzlKyQ4+KErOg4y5O
	 a1MVyhn5a/c3tiUrKbtDovaoPGhTFuFth8E4zhPo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 191/219] ipv4: raw: add drop reasons
Date: Fri,  2 Feb 2024 20:06:04 -0800
Message-ID: <20240203035343.770665436@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>
References: <20240203035317.354186483@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 42186e6c00352ce9df9e3f12b1ff82e61978d40b ]

Use existing helpers and drop reason codes for RAW input path.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e622502c310f ("ipmr: fix kernel panic when forwarding mcast packets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/raw.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 639aa5abda9d..19936dc329d8 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -286,11 +286,13 @@ void raw_icmp_error(struct sk_buff *skb, int protocol, u32 info)
 
 static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
+	enum skb_drop_reason reason;
+
 	/* Charge it to the socket. */
 
 	ipv4_pktinfo_prepare(sk, skb);
-	if (sock_queue_rcv_skb(sk, skb) < 0) {
-		kfree_skb(skb);
+	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
+		kfree_skb_reason(skb, reason);
 		return NET_RX_DROP;
 	}
 
@@ -301,7 +303,7 @@ int raw_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_XFRM_POLICY);
 		return NET_RX_DROP;
 	}
 	nf_reset_ct(skb);
-- 
2.43.0




