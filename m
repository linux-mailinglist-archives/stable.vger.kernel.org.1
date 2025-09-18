Return-Path: <stable+bounces-180495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B920B83989
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 10:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDFC7211D3
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 08:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EF32FF159;
	Thu, 18 Sep 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrWsTO03"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9CD2FE594;
	Thu, 18 Sep 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185490; cv=none; b=Hjwvzgw6y8winIqgNtoBFEUf6xYLeWtmt8SC6XkkpHIPTFz4wc+jqCwX0OXeobys6Y19ihDzRwSP/iFEP3gX9b4kG/Ksv6jQkB8DnHlHzP+ymMtd6G0nocYligOZfLMtGvnpHZtc1hNbh4C6yA9O9WqX5iSQs7m2VXNsmaSeqgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185490; c=relaxed/simple;
	bh=EOhcyQviMMRhx2W39PIzcaMVrFvf9rRwgBG7ZlEa5Qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=niAkxSFmXvPA00pic9rjsnVSPtdUvh5W9NLJgwYlECWOcQCWgMKX7DsDorqTzB9yzk5ZMEyeWqwm9Pmm32YmnRoBBeWgIv4A542FFLiTr3su3yDaexf160dW3Ds8XZJ9+ut+NyZczFlLTHVkJdbwTpT28b0/iMnT8wwsROUKUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrWsTO03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF19C4CEF7;
	Thu, 18 Sep 2025 08:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758185490;
	bh=EOhcyQviMMRhx2W39PIzcaMVrFvf9rRwgBG7ZlEa5Qk=;
	h=From:Date:Subject:To:Cc:From;
	b=rrWsTO03uNLR2OpUo2Y+lCxaOienaLS0y3f5lE2pdbvNZrvJ9gXyEgyx6CNIHoCn/
	 CeNwxbahgBoqvIm/FxvphGRWISHEdb8kzeOvArQLXBzZNZ4tZS9WCNn5yuifS75F/h
	 G6vg04mIcgPZ9DHskv7HAl30TAzDvSdWpKAvAfwTH3rEPmVVAG1sb6902PZMszKkeL
	 Mh9A9WvXDPFlxRHoLckAeMl143/a1IM8Gend6hpFpgK2va6LsQ57pYlbIM6a57UWR9
	 b6Yd615bm8+ygtDJvLSccESMHjHv3SZ4kUk+5sZA0oN5QHvMwrFK/7uVhAgyKZkJI+
	 CrwSaTPPanSQg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Sep 2025 10:50:18 +0200
Subject: [PATCH net-next] mptcp: reset blackhole on success with
 non-loopback ifaces
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMnHy2gC/zWNwQqDMBBEf0X23IUkVIj+SulB46qLaRKSUATx3
 10ED3N4M/DmgEKZqUDfHJDpz4VjENCvBtw6hIWQJ2EwyrSq0xYDVcle8ZeqSzj6wW1r9ISZikw
 +xjRKhZM1rtWW3qqbQWwp08z7/fSBRwLf87wAanYj6IMAAAA=
X-Change-ID: 20250918-net-next-mptcp-blackhole-reset-loopback-d82c518e409f
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2035; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EOhcyQviMMRhx2W39PIzcaMVrFvf9rRwgBG7ZlEa5Qk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJOn+Cbx3R/a6HmPg7hL8vc48p7vu/ViJORv6Q589HC0
 xPiOWuyOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZyPJaR4YRHFLd78r/U1cmt
 927t4DXVYLR7+e7qhQ0rWKsjZ4XaVjEyXM8u37p/S6S0h+qvmCq9N/+FW9TvpCoXMAjVLmLJff2
 fFwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When a first MPTCP connection gets successfully established after a
blackhole period, 'active_disable_times' was supposed to be reset when
this connection was done via any non-loopback interfaces.

Unfortunately, the opposite condition was checked: only reset when the
connection was established via a loopback interface. Fixing this by
simply looking at the opposite.

This is similar to what is done with TCP FastOpen, see
tcp_fastopen_active_disable_ofo_check().

This patch is a follow-up of a previous discussion linked to commit
893c49a78d9f ("mptcp: Use __sk_dst_get() and dst_dev_rcu() in
mptcp_active_enable()."), see [1].

Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/4209a283-8822-47bd-95b7-87e96d9b7ea3@kernel.org [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Note: sending this fix to net-next, similar to commits 108a86c71c93
("mptcp: Call dst_release() in mptcp_active_enable().") and 893c49a78d9f
("mptcp: Use __sk_dst_get() and dst_dev_rcu() in mptcp_active_enable().").
Also to avoid conflicts, and because we are close to the merge windows.
---
 net/mptcp/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index e8ffa62ec183f3cd8156e3969ac4a7d0213a990b..d96130e49942e2fb878cd1897ad43c1d420fb233 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -507,7 +507,7 @@ void mptcp_active_enable(struct sock *sk)
 		rcu_read_lock();
 		dst = __sk_dst_get(sk);
 		dev = dst ? dst_dev_rcu(dst) : NULL;
-		if (dev && (dev->flags & IFF_LOOPBACK))
+		if (!(dev && (dev->flags & IFF_LOOPBACK)))
 			atomic_set(&pernet->active_disable_times, 0);
 		rcu_read_unlock();
 	}

---
base-commit: b127e355f1af1e4a635ed8f78cb0d11c916613cf
change-id: 20250918-net-next-mptcp-blackhole-reset-loopback-d82c518e409f

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


