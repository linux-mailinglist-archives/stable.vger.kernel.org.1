Return-Path: <stable+bounces-134623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FF0A93B3A
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 18:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C3B8A36DC
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C392153DA;
	Fri, 18 Apr 2025 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8ZxL9ee"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0992CCC0;
	Fri, 18 Apr 2025 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994773; cv=none; b=d6ou4rp/M0ulepJDlTZi31z9ol0mXOb3n6Ace20GBrtBJnNRqUgmflX4G/3cq/ZwuFsHlZHVQQR1yC7nYyHV18Tq0oBMnZPnl4dhnkbeP3XfFL18iTglKnat0FXxsQjh2ZB8r6nzCRfi47+Q09Zx3OXI/NjcEzckHltDiT1asp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994773; c=relaxed/simple;
	bh=6Evc0IWJ/vJ/0X/51M2poyLTeZoDAbUjdzxgXD7DUb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohEyCkFpwmxxBc5baegvBKnUNFkJtOjrIfEiMQ89ePm5RFjK90eG+8FaCNAcO4fvpBeCcvBc18acw8YTIAOjr1CvuRPAruo9Azm+alPCji8Vb/igOaeGBGUglAzWkGci0qyyVcUPhrrew8Ovpl9PR/3Kg2rAfKJtPHmPzoDIIiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8ZxL9ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5F4C4CEED;
	Fri, 18 Apr 2025 16:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744994773;
	bh=6Evc0IWJ/vJ/0X/51M2poyLTeZoDAbUjdzxgXD7DUb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C8ZxL9eeNe0REt+QcB7FhktjhtvLAwg7sNO5d0qkYTqLEGOWfZ29F2LX4YEcjx+z9
	 eO9kbzPHXrAAPOMMOPQOL7QNWK7I8zvDbK3U/5tURO5qR2y84ZAefmv+tjxPVeqXe0
	 9Vh/PN/xDEUfIt672afWi4hl3100tDCCDaDcoIaJd4L9Zyd33slZO8FHO3oLVPlfiP
	 4VQcv2ynGuY8px4EBPErZc6NQzn6OgvpJLxtq+zpDb50ubpnyCA6Wqg6l6N/yhWhIX
	 MFUptq/R5SbvQPmORxZdxjGDwiw7yilkCi8xW0q0cwl5QIedYvXyXPOBAGNPVuz8xH
	 8fZ5K49gNsFpQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y 3/3] mptcp: sockopt: fix getting IPV6_V6ONLY
Date: Fri, 18 Apr 2025 18:46:00 +0200
Message-ID: <20250418164556.3926588-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250418164556.3926588-5-matttbe@kernel.org>
References: <20250418164556.3926588-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3816; i=matttbe@kernel.org; h=from:subject; bh=6Evc0IWJ/vJ/0X/51M2poyLTeZoDAbUjdzxgXD7DUb4=; b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBoAoHFuRsWheK+lnVvPxOPIYylIEB/mI4tvq2dL 5FPeswxgW2JAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaAKBxQAKCRD2t4JPQmmg c1usEACrGHdaCffCpk+7uiPeDrdCsCig60Pk8Y6irRUI0TsUXWq+ck11clX4Y4NLc3YPaCHBSnR VX27SolCNk3espOiCRVV3PI/cidUy8nkzqHoRZt7GrPqkbBop9ORQUIw5Xm5Utbu5iZSjPDgcyO acmQBMmo1wCySCYPkiiIFhkwnaLfB1qzrbKUH0QhD324aPaZu/j9+mTgagpKVVkbyU4LdOM5h7A X4rKf+w8W6KBYAhC3wtPo+8CMDeuEGGPDBKt4Bs3l5xQvEehKW5otK1MK4yENLbL47ySEKAu0P3 boAbO0z3rLPCxKL7pKFM/lUJjekOXIofdnPVLAcApf9A0YUi/NgRAq701RO/N92p8CQELZuKMAz vllVlEg1pfXAXZlaJnLSfjLZQb4JN5pO7oDpduBFqW+B4+IfBU4D1Fd0JIgOBau6LXiFxtI64+l OkpDDNn0+W0lBMilO4TFyFkUoFbD54W7vrf8EsZJW3rwQFFt026H6hDXWjuibvaFvf7C92FinDS 1QeM9Mcx8Ds9IMz97p0BFZExoXaokXPsnDLihyFcGVIOvjBmWMuNylo2nEAXks9bdDXvc2HDYlC g5XUSyaXLN2fcgj96Oopo7wSH0LGbg4P3RsM/MulZ+mDbiloHBtbXcG13azWeOOYW5dqeoM9oiE vIGIJ21tPQhujwg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 8c39633759885b6ff85f6d96cf445560e74df5e8 upstream.

When adding a socket option support in MPTCP, both the get and set parts
are supposed to be implemented.

IPV6_V6ONLY support for the setsockopt part has been added a while ago,
but it looks like the get part got forgotten. It should have been
present as a way to verify a setting has been set as expected, and not
to act differently from TCP or any other socket types.

Not supporting this getsockopt(IPV6_V6ONLY) blocks some apps which want
to check the default value, before doing extra actions. On Linux, the
default value is 0, but this can be changed with the net.ipv6.bindv6only
sysctl knob. On Windows, it is set to 1 by default. So supporting the
get part, like for all other socket options, is important.

Everything was in place to expose it, just the last step was missing.
Only new code is added to cover this specific getsockopt(), that seems
safe.

Fixes: c9b95a135987 ("mptcp: support IPV6_V6ONLY setsockopt")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/550
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-2-122dbb249db3@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in sockopt.c in the context, because commit 0abdde82b163
  ("mptcp: move sockopt function into a new file") is not in this
  release. The modifications can still be done in protocol.c without
  difficulties. A particularity is that the mptcp_put_int_option()
  helper is required, and imported from newer versions without taking
  the extra features introduced with them in commit 2c9e77659a0c
  ("mptcp: add TCP_INQ cmsg support") and commit 3b1e21eb60e8 ("mptcp:
  getsockopt: add support for IP_TOS"). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 51b552fa392a..f33c3150e690 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2395,6 +2395,49 @@ static int mptcp_setsockopt(struct sock *sk, int level, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
+				int __user *optlen, int val)
+{
+	int len;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+	if (len < 0)
+		return -EINVAL;
+
+	if (len < sizeof(int) && len > 0 && val >= 0 && val <= 255) {
+		unsigned char ucval = (unsigned char)val;
+
+		len = 1;
+		if (put_user(len, optlen))
+			return -EFAULT;
+		if (copy_to_user(optval, &ucval, 1))
+			return -EFAULT;
+	} else {
+		len = min_t(unsigned int, len, sizeof(int));
+		if (put_user(len, optlen))
+			return -EFAULT;
+		if (copy_to_user(optval, &val, len))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
+			       char __user *optval, int __user *optlen)
+{
+	struct sock *sk = (void *)msk;
+
+	switch (optname) {
+	case IPV6_V6ONLY:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    sk->sk_ipv6only);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_getsockopt(struct sock *sk, int level, int optname,
 			    char __user *optval, int __user *option)
 {
@@ -2415,6 +2458,8 @@ static int mptcp_getsockopt(struct sock *sk, int level, int optname,
 	if (ssk)
 		return tcp_getsockopt(ssk, level, optname, optval, option);
 
+	if (level == SOL_IPV6)
+		return mptcp_getsockopt_v6(msk, optname, optval, option);
 	return -EOPNOTSUPP;
 }
 
-- 
2.48.1


