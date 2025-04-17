Return-Path: <stable+bounces-133221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F19A923F9
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 19:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5FF44308A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2468255238;
	Thu, 17 Apr 2025 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCfdgiuQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F73254847;
	Thu, 17 Apr 2025 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910879; cv=none; b=MukKQWp/wRjVr0kFsgs0V/E3CpVeoQ+wFdbGGwYApCyG+UMIZjN2U0O/tzEH/tYgx3VaE39wenbNhYVvBvpcM2TyySbf6YGwCgourb5jwnajo6PCkOVX20mMx/TezkLz1eHHr0dNGFtk0rkJFlJF3xG2sZ16DhpAsAZxL2Z9wV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910879; c=relaxed/simple;
	bh=bozUT5/oYSVExPvcUhz0rxy2hH8hcx4ml0cfxxy4j80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXzW12SpIUgPBAmKTwrc0WO/Fj8QJ0YjldgHrtYsqssivR6IwQigZbHNjqgAYpdfrx0FvX7HuCvkBjtnktgjGd00FcEvwLr/QJSPaNN30y5p2mEGPn+IMGAgx0/8aPVKNFokmW++AIGMUb2GT4RjboL6BGfWOyyiT9lF/rq6CTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCfdgiuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760FCC4CEEA;
	Thu, 17 Apr 2025 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744910878;
	bh=bozUT5/oYSVExPvcUhz0rxy2hH8hcx4ml0cfxxy4j80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCfdgiuQGHnycFu/0O9jA7xCJdt7HaPumUKr9fwuoDfJBeDwogN2lI4VEoTHUSWu7
	 EVx6tj9RGtawlBgXkJwwYFTmjPPxMCE9sS8/uPYpGHwHC4y/TdahBIP+G8VxMrF+b8
	 Km0KUJaXsVaM4phStJTaEf6j5lHLGRwHDXYYa386KqhqCoWJpxc3SUpMGCTyf7tOnO
	 e/ULcn8fnq515kZwmMDesCYDG9udUuAxYOS8szg/4MivjgPjnGzceUq0J1Hhfabtgt
	 mGVsUMjZyw0D5JvPJSY/o9QnHHDshmtD8FAl2BSu+lVeoN+YotMnmD1w806t0b4bbW
	 5MMc4/GLjbd2w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y 1/2] mptcp: sockopt: fix getting freebind & transparent
Date: Thu, 17 Apr 2025 19:27:51 +0200
Message-ID: <20250417172749.2446163-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025041756-ovary-sandfish-4a21@gregkh>
References: <2025041756-ovary-sandfish-4a21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2524; i=matttbe@kernel.org; h=from:subject; bh=bozUT5/oYSVExPvcUhz0rxy2hH8hcx4ml0cfxxy4j80=; b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBoAToWKuqh40qyemrqHYzrCze/rIsATbLmgdinZ 7oGSkN0d9GJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaAE6FgAKCRD2t4JPQmmg c+sxEACvKOiWN1ZvQQMBTcoZ77a9zKpYBGB9nP/OLxDwaRe/0f0be3XIcfbA4YN5WmONWaZnkO2 EdtvAAhm1Rfa0X7TVuLwoDXMZjDe0k/zWNYPhXeK4NecS/F4WRqYYG10Us9sXvx5c+qdw3JRJmw Ig5dXTowynKedm0J0BQDQc/rpKgx7jHboFQTVvXseyXt92m/IRlhs8rdcL0CiM7c3rlwIZNm+0J HP8wYOzLV3V1f3FHtqr+cqvtQ7BhrNMV4zGtW9vF0V0uxxJi/Y7rg1z9mpbFOWsiuZJLJIHUG1Z F9wCA/iCVN9yVLx7nKmkZk4JdfAeQyjmG3QYLTS/4dKRyasOd6jd4flm+0eD/zKpRTVG8He4fWJ SmfeslVMtyZaKnUKCnb93/AP8K4nglvm6+cQ0Wkx07eRVT3zOMYG3/6yoyZKwrFUTV0FqxDhpN3 2J/YZHvNiyZCHKlN1P+ysyGwh78ok/VmzbxYx4Pnaedw4KozMwYhkAnigCOxrDOqZ5I3+JCUHIE SOY8vWbvoPR4cbwgQW7iHXOaBupjoEJD0xcGlVAg4Kj0zo3xgzUrMTKYq3lZMSLFxlDoCLEJz9U K97Z/yzHYrmE41tiR3FcZK03KASgBYNJuXHN5P45i5J7jScz9ZZAPiyLKyl7tFQAHlApUQQu9f4 eHpaMunUI/PhbaQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit e2f4ac7bab2205d3c4dd9464e6ffd82502177c51 upstream.

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
[ Conflict in sockopt.c due to commit e08d0b3d1723 ("inet: implement
  lockless IP_TOS") not being in this version. The conflict is in the
  context and the modification can still be applied in
  mptcp_getsockopt_v4() after the IP_TOS case. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8c9fd9c1dbce..31f6899ef71a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1388,6 +1388,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case IP_TOS:
 		return mptcp_put_int_option(msk, optval, optlen, inet_sk(sk)->tos);
+	case IP_FREEBIND:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(FREEBIND, sk));
+	case IP_TRANSPARENT:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(TRANSPARENT, sk));
 	}
 
 	return -EOPNOTSUPP;
@@ -1402,6 +1408,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
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
-- 
2.48.1


