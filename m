Return-Path: <stable+bounces-134551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D3AA935F5
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30A719E64C4
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B294270ECA;
	Fri, 18 Apr 2025 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tku+ybVG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A77270EAF;
	Fri, 18 Apr 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744971842; cv=none; b=RznFNOkRyGxXwMkLeFoJnXZBen+8ZW6QK9gp24D/babGU4n50s+PKaqKgEsWeoKAF6uglSsiP1s41lEPgTkB9ErTgycU3p3GX32VWPB3G/LQnwgUmDqlGG891zUH65LK4GG1cgeBRirOqQiNgrWzOmc0gH2txBehvUXZPCXfiMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744971842; c=relaxed/simple;
	bh=P97hqC6EW7vjXhtV3g/3x273eY7ZgHwtxbCdYWgBhH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXbDg7RnyOtl2IrIDj9QVQJlCzMb0K7OP0XC1LFJ7ShcVOK4qnzodMP1C4m9kljH1tNDMmkcVDs506EfMK4U+TbU1g3dHqKmd0F38DRNrQodgQupR8bKIm7RtYhI3FB2mtRnpvNwr4HG6YK60CvfiOnOAZ5cS6yzabyxonTNpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tku+ybVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B55C4CEE2;
	Fri, 18 Apr 2025 10:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744971842;
	bh=P97hqC6EW7vjXhtV3g/3x273eY7ZgHwtxbCdYWgBhH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tku+ybVG9+TqfhLscXoZqOnGP2F652zeysZ9Gc0wLbbFmXYEofgCv9oAnZiX69xF0
	 i5civvJqrbbYPwuNFo8PW822pcymOHLRfTwSl4vT9hTBM8AcmmtePD3b3LDUhQ69P6
	 H2CG6UXwx945vsSJr/+BnJ+SzaiecRxRQvGU9TM+9I9G01wXghEQq5sV1aR7o9dJ5t
	 2eM5OtAsM5tMphOy9OrZtoEMmmIwE1NHyyhNSFnduaowYKjuTx+pkGib83yqrpR+9Z
	 /CDu7r6/axELift2UTyCpnEibm6ORDYaMndX8j89+jXOjgcwyTEwurVK1DnDAaN/9h
	 p9d1ZSULdleUg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] mptcp: sockopt: fix getting IPV6_V6ONLY
Date: Fri, 18 Apr 2025 12:23:20 +0200
Message-ID: <20250418102319.3212564-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025041742-gurgle-parking-5fbb@gregkh>
References: <2025041742-gurgle-parking-5fbb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3043; i=matttbe@kernel.org; h=from:subject; bh=P97hqC6EW7vjXhtV3g/3x273eY7ZgHwtxbCdYWgBhH4=; b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBoAigXg1S3OR8LHBUTrRjD8iRy3CjgWQ/tusACW ExSI3VY+KaJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaAIoFwAKCRD2t4JPQmmg c5rPD/9e4K/HOnpN/8KEDnqhVoike8aDODTVrutJfXTLA4sbUNvGWZFLMkYQrUvTLPg6+Lv9YCl NIMu6iALtsFv2WMow8nho6yMdoaXRIH4fG5x77o3Towe2kpagM06PrKX6RSUwLLOuun01X3V7uD MQOR8ZjWlHuVmGAiU3bEqrDMd0eo/kg2siNNUa5QSkKcRZMSXYxKS8YPevTnLKl8UyYaZF+qvDO BHszJxPV0kiyQ7itZQdMa5nw1NHwKvqQM108NejDX9Vtb/VmILZDi38clHqirEWKUxmlXUT0Ow+ uthCHkr4dwDrlsNcBQwLy/e5omFZUJu3OCpLY1XI7ogEjhncURgtuUHdfuu4d68VRwUCyyd2tmo eklsW7DhkMhJpbV5WxXPP/MUDzY+3vYHSsz9W2kHDI0dkgCM4Ax4IYrhKaXP++wghRw1kKHgbjs TG600zcOEBU97nQXARQWAR6O/kazVj1YE6H8T39kWbyfi/9ThH9muI+FRNq76xeCq2jmLJqMd2W WCVrZ2Alxon3ZWEw/GL8kYHB5HH2YVxLWUgnAEgIIG3gH3QBOVmDFn5LwD6jvwhcv8OURwEWTCz Sgdj0/Zm5SXNOWQyKHbR8XswcCdcCxL6PMiz3nwTA5sgI3laNa9B23XBGP5YSaPR+Ss3/LYmInE F/2m/AbXw6mClGg==
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
[ Conflicts in sockopt.c in the context, because commit 3b1e21eb60e8
  ("mptcp: getsockopt: add support for IP_TOS") is not in this release.
  The conflicts are in the context, the new helper can be added without
  issue. It depends on mptcp_put_int_option() which has been added via
  another backport, see commit 874aae15fbef ("mptcp: fix full TCP
  keep-alive support"). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 93d2f028fa91..cd10f4a54de7 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -793,6 +793,20 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
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
 int mptcp_getsockopt(struct sock *sk, int level, int optname,
 		     char __user *optval, int __user *option)
 {
@@ -813,6 +827,8 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 	if (ssk)
 		return tcp_getsockopt(ssk, level, optname, optval, option);
 
+	if (level == SOL_IPV6)
+		return mptcp_getsockopt_v6(msk, optname, optval, option);
 	if (level == SOL_TCP)
 		return mptcp_getsockopt_sol_tcp(msk, optname, optval, option);
 	return -EOPNOTSUPP;
-- 
2.48.1


