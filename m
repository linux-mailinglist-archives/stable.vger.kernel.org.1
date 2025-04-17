Return-Path: <stable+bounces-132984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F7BA91967
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7428C446295
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D1222E400;
	Thu, 17 Apr 2025 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IAYoJyUm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC82722DFBE
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885928; cv=none; b=l1fcOCBzCBvYHLXF0QId+6fINxyQjMT9bAt6+m3hI1fwT/2WsBGuEbXdzoUPqI++r/erZoZT+koDX/zlyxHpFWbe/flwuGN2+8gTrGx55g7cuVtib6uHNDHU6yOXgnunJfIUyN+atpT4KAJTs8DB7BGuIdyzRqcIAVYGV7WHRcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885928; c=relaxed/simple;
	bh=6m7O+PUuYXzv+a4wpqjZ+CXhqFhMJQHL1xt8zLnzwVc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=vC/uCOXLVcRl1eDu/lC2FH84hLmtZ5yq4RG+DY9yojEI/vYK79jVhW07Pjb0BGvO2GGPlzYcArxXmPVSaclo0ylbjBhCz6vmKoZLZ92x3EVPEK3t7nH4tQ5GIjVnAF30qlLjcfRizs7GmyXbaW5gVI2h1QjxH99BGKngJTVmOXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IAYoJyUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F7BC4CEE4;
	Thu, 17 Apr 2025 10:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744885928;
	bh=6m7O+PUuYXzv+a4wpqjZ+CXhqFhMJQHL1xt8zLnzwVc=;
	h=Subject:To:Cc:From:Date:From;
	b=IAYoJyUmqlyO2NWnmbL2NzZzcWcf+Izc4+G4LDUKlKul9ZE+J2qo+qmTAXbcZ7dM0
	 obC1t9oQ7C99ice5LvHphwv7KSiLrhS0x4HZtEEpHS7t4NNylzQcLFhTKpbVl3AscS
	 VbpwI9hxA0s+9xKpbiCnNWdO6cY+2D90/AdyzxdI=
Subject: FAILED: patch "[PATCH] mptcp: sockopt: fix getting freebind & transparent" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,horms@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:31:57 +0200
Message-ID: <2025041757-treble-debatable-db2c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e2f4ac7bab2205d3c4dd9464e6ffd82502177c51
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041757-treble-debatable-db2c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e2f4ac7bab2205d3c4dd9464e6ffd82502177c51 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Mar 2025 21:11:33 +0100
Subject: [PATCH] mptcp: sockopt: fix getting freebind & transparent

When adding a socket option support in MPTCP, both the get and set parts
are supposed to be implemented.

IP(V6)_FREEBIND and IP(V6)_TRANSPARENT support for the setsockopt part
has been added a while ago, but it looks like the get part got
forgotten. It should have been present as a way to verify a setting has
been set as expected, and not to act differently from TCP or any other
socket types.

Everything was in place to expose it, just the last step was missing.
Only new code is added to cover these specific getsockopt(), that seems
safe.

Fixes: c9406a23c116 ("mptcp: sockopt: add SOL_IP freebind & transparent options")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-3-122dbb249db3@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 4b99eb796855..3caa0a9d3b38 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1419,6 +1419,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case IP_TOS:
 		return mptcp_put_int_option(msk, optval, optlen, READ_ONCE(inet_sk(sk)->tos));
+	case IP_FREEBIND:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(FREEBIND, sk));
+	case IP_TRANSPARENT:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(TRANSPARENT, sk));
 	case IP_BIND_ADDRESS_NO_PORT:
 		return mptcp_put_int_option(msk, optval, optlen,
 				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
@@ -1439,6 +1445,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_V6ONLY:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    sk->sk_ipv6only);
+	case IPV6_TRANSPARENT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_test_bit(TRANSPARENT, sk));
+	case IPV6_FREEBIND:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_test_bit(FREEBIND, sk));
 	}
 
 	return -EOPNOTSUPP;


