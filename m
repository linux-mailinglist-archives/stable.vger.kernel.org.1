Return-Path: <stable+bounces-134538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87368A934BF
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 10:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3604C19E23C8
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 08:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A31326E154;
	Fri, 18 Apr 2025 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKZzpvwW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160A01DFFD;
	Fri, 18 Apr 2025 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965669; cv=none; b=U0FKecPvOBiMsJ50JExRX04POfhPBU6EDiphJlpxjT1KRzXYwuJv+9X1Zg7+yRVkysjt3NH8Z8YQz1fBB2fRaVlLZ/lFkDf9qq02ETh3ZfQMREC1NhMN1N3/Fsb78tVeO0XfyZBPe5JMp9+35/YmzKldwSjLnFE9yM9rqRfB/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965669; c=relaxed/simple;
	bh=BO020wlfUv/7CUlGZVr8kU7dwOzJcrNv1k+2TQtc/yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2LF74jLocjGsjTV7+QyybFedgGMxhOw0PJnwpz3t/bQ9xzQJ+mN/ojxKIzm/gY5Er3blEf1ySXsumbha3S8Oc108r4pO/kUCvdaWABUY0+l0V0HFs1h22tmwhaVRpDJJpmbDs14rMfTXnw7GWwyFU8XZ+m03O7ML2VDodo5P2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKZzpvwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18316C4CEE2;
	Fri, 18 Apr 2025 08:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744965668;
	bh=BO020wlfUv/7CUlGZVr8kU7dwOzJcrNv1k+2TQtc/yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bKZzpvwWUSkWYYhsfbnvutJZiBAJvtSkfM87J35Rc/oOlgwrlJhx+iyJ7T4uc2vUH
	 o+4zxnHhLzCP0H6ffxJ3jPvKew/tJsPdmsj9Egpfwp3dLQ8VdjLVo8sJpNq1X6VjkG
	 bbeL05NSicxL3riI1giKDGmeXPLApbcH7VxK2bHH4oF67DuMbBv/b1SVtLBFFd+5QT
	 6u4kqMnBfA4v9MpUtXXfgoYdQIZhe8uPJi2gY8qVKgdsop8AlPks9dtRGzBi2+sVek
	 G7t+8QB3HdQbqU+Z9tK7zB43bs8tGVAceXMemnQ2kEzzhhmsR00xuOo1ph5dSPsiuo
	 KCyzZxdaad5rg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] mptcp: sockopt: fix getting freebind & transparent
Date: Fri, 18 Apr 2025 10:39:56 +0200
Message-ID: <20250418083955.2844365-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025041757-treble-debatable-db2c@gregkh>
References: <2025041757-treble-debatable-db2c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2597; i=matttbe@kernel.org; h=from:subject; bh=BO020wlfUv/7CUlGZVr8kU7dwOzJcrNv1k+2TQtc/yc=; b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBoAg/biTeZh82Rjjs/wSoOLRrP3q9hR5734UkJo PlV8V3zo0eJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaAIP2wAKCRD2t4JPQmmg c4wxEACcfDKCbB9/zlidMOIHddx64uSXgcbIwRzTXRpht1jr9uRFIxF2AG3XhtZGe0ysDo2NY0+ G5EoVRX5mgX79E8O41M/LWqOzGO8/8xgQj3W+kUjbu7u9Gc5dbvYc4YxMZpmHYTUKMn1lDAL8+a XpLB5ck5EbsUN75R2u4mHH17K4HQ1Sz14ZqbqAMI+Q6nO/xMcJQyas6nzXdkDs8zoyNsE0UHvoU DBipVfC7+8GgICY84e2DKnte/4jLLlyDBquEN//XHgMBocbKC/vded4LgVV05b4X0nWPidr3hIx G300NwWP2vouEF2h8qvjORZGA8hT2Tt4QH06WMv0JJ3dJp3Tgc1/1KRTiAnLdLlq333hvywpe4m SsS2czgjN3NiWEUJFToDBJQYanU4Qu9Ed9Zszachtk8R0BOZbxq09O5Ad0CoKLZIhvyPIxGt4e5 ubgYgb2l+d3hhtI3ptWSV6lQwS++ZoA8M0kYZlKA90BwzmljAwQ66Z7Yejb3OAJOE/GyFKpGTg/ hqUomLwDrXVKjpR+pVSXIW7Z3NlP7CH0U5EMt91pv/CTc7GwcWlVMEiOKhIMu6fmF2EGidXDLIX YGbVC2+qe8TRQP+bte1VDcJQfEy8iLhljSbyj82lpB9XHfTLQo6UlkfLCXNlLtCshDAL2IFvwOx nwuKDBVhUiCdYLQ==
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
  mptcp_getsockopt_v4() after the IP_TOS case.
  Also, get the values without 'inet_test_bit()' like it was done in
  this version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 362ef7c9b940..129c9e9ee396 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1266,6 +1266,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case IP_TOS:
 		return mptcp_put_int_option(msk, optval, optlen, inet_sk(sk)->tos);
+	case IP_FREEBIND:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_sk(sk)->freebind);
+	case IP_TRANSPARENT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_sk(sk)->transparent);
 	}
 
 	return -EOPNOTSUPP;
@@ -1280,6 +1286,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_V6ONLY:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    sk->sk_ipv6only);
+	case IPV6_TRANSPARENT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_sk(sk)->transparent);
+	case IPV6_FREEBIND:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_sk(sk)->freebind);
 	}
 
 	return -EOPNOTSUPP;
-- 
2.48.1


