Return-Path: <stable+bounces-124473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB119A61C25
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 21:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099DC189C9F6
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 20:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4272066C1;
	Fri, 14 Mar 2025 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhMQkduS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A42063CF;
	Fri, 14 Mar 2025 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983128; cv=none; b=b9TnjK8z1te58SoacEmQfBzwlPXIyaSZhGpRvP5oGntlYzEoiP4h6GEHHu1/NI2yAwDunSoSGHDPDQHTLke4WCe6BiRyPWUwTSqtwD8fDDloyUewnmbsd3v37anp0j9yV7SkbwM2OolosQhyWiJXcoKGHhw4NQgVui6wzwQJTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983128; c=relaxed/simple;
	bh=K+kt5H19r+zhcB2pGmIn5iHnIGeebwcfJ1/x5/chx9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXM5jh1OZTQ+YSJrUypFGwT9//BsfhHTNnTIBMxI+VOpO+GKCZWwYXw0fkzbplLTm0BOdSko1wzCJFUfvvQPNYI7MbcUcQJK7aoaKP7gW2YvZZ4MTdaDuAEijQwjTmIpeoGvNTGmTjfhixnrIZhVUucQAyg0Kp+LbcSLhkyeSLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhMQkduS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA99C4CEE3;
	Fri, 14 Mar 2025 20:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741983128;
	bh=K+kt5H19r+zhcB2pGmIn5iHnIGeebwcfJ1/x5/chx9E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BhMQkduSsgLhJGLaqIplnRle/4ogm1w9V7nmiTjXese4Ng/Ob9Bn61BfW28ED8g6h
	 sNZJGU2AMei2R/CfTUDQLYH7J3bL6sqA8nGlefd8eAaueWdWDpq3jK5ilxzuMO7G/v
	 xUto+17mh10OOamPQMliehzzEhYAL7TWi5GxbzQGpMpLrJYnsEP5EKkZsSqNoJ2kd7
	 T/u6POgmCVEZZyK5hcusNSSeGGDkyt36zmyg2nn3SB7PjCAjFpy8ZoMqMPoWBddDhU
	 +fkhP5U9si9xA6GLF/QvutRhYsR1WQW5N9p/HsfDWgbUpU5GoeCM2kwVt2bIYQxhuM
	 Y/JpHf6wCrf7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Mar 2025 21:11:32 +0100
Subject: [PATCH net 2/3] mptcp: sockopt: fix getting IPV6_V6ONLY
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-2-122dbb249db3@kernel.org>
References: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
In-Reply-To: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2424; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=K+kt5H19r+zhcB2pGmIn5iHnIGeebwcfJ1/x5/chx9E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn1I2HIYtQZj6uH9MxHhmTDaxDMB5TrLG0UCciS
 vrBtOqsaS2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9SNhwAKCRD2t4JPQmmg
 c/ZlEADgJY1x0h02GMK6jlnMq8Xp+hck8Vr1OO8rEB4OKxCzDbXhkbwhbBIbDwRUqTsPq82z41V
 llfbK2+qMwGzm9E2JFn4Dgmaca0Suht3Oyu040//hdSCtxokXvHj3wlUbSsI5NNsvgrx0EUFCpb
 8kIW6PAgFlAcepd8kodSn6GJL5I95XBvzKJZPvBA5/UrcBf2vWCVh4zCIH3w4cVjABGWg0CKh/4
 H1dmC8raWuw1SMcsJlPXAWjM5XMxjxUzXR2L1mMiXqBbDZ7uCLCNA8pxCdo1YikDtoeQIotkqqw
 JisSO6JgRdI4XqrgpZFX7iZZrMvsg+pd/8sg9CgGGujQ6/BOL+uGh5ZO2qPM/ntZxAaqcYYrNhr
 6vB2ybMwHQbJtllHDvAKNXSr5E7kI4nsPMgX84jtg5p9/DmXDJOi3+Lnqolc5ti9vqvne8r7lny
 LyRxbzB4Nj4pSj6GW7TIFs/hHlI9xAppAGrPfy2e3AQdkARVT9bArSSKqf0QWe2PZGPYk81jawl
 PQENXPb1juFwbuU0oZi+pWD6krDji4GvjVo3spTy0gzmlsBqt5zcFwey8+y9+Pr/ep6gMrogZj+
 e4a8Be7rmmEZnFo5g9vmHxeqpF9r9pplx8oj5wHtbTuHDdRSgsW2l0LbBEq35RfMMAZeBnXh11l
 ld63lBdB1xMYkug==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

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
---
 net/mptcp/sockopt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 505445a9598fafa1cde6d8f4a1a8635c3e778051..4b99eb796855e4578d14df90f9d1cc3f1cd5b8c7 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1430,6 +1430,20 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
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
 static int mptcp_getsockopt_sol_mptcp(struct mptcp_sock *msk, int optname,
 				      char __user *optval, int __user *optlen)
 {
@@ -1469,6 +1483,8 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 
 	if (level == SOL_IP)
 		return mptcp_getsockopt_v4(msk, optname, optval, option);
+	if (level == SOL_IPV6)
+		return mptcp_getsockopt_v6(msk, optname, optval, option);
 	if (level == SOL_TCP)
 		return mptcp_getsockopt_sol_tcp(msk, optname, optval, option);
 	if (level == SOL_MPTCP)

-- 
2.48.1


