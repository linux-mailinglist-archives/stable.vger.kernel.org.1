Return-Path: <stable+bounces-134620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4ACA93B38
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 18:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5408C7AB5F6
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8147B214212;
	Fri, 18 Apr 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP6c0Kcy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1BC2CCC0;
	Fri, 18 Apr 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994769; cv=none; b=MH7ggcpGoCnrbquYBRQNBr9PllWqhfGaXc2Xom3VBdLNeFJAinVz6HYyuoK+6b8Hd6vv/3PQRlNop4+a716N1zXMKyWjv1pqlKGd4EhvU9gYveDCCskBFN7XXaQl0+Gy5ko5QFCZQqy6gFXdHkCirFU7faNklO4i9Jstz+HA0l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994769; c=relaxed/simple;
	bh=zvmUmQEZ3L3IPpPSxYc/GgRj1jb4khCovHnrM4YSWNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvdmraR68//IPrWivvl9yqwpXj6BtqZboayqg0lCLXocBbXmgYhs/V/I223li3rGndCInLqMg30EkwlM20Bi/NCggqmPbl46e+Xwda1YxSZl/HplopINNSUTOXKq5htI9/tN+Dc6IyAwQjrrKvCHNjqQ/c9+cYMHga9WXhD3rVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP6c0Kcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC64C4CEE2;
	Fri, 18 Apr 2025 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744994769;
	bh=zvmUmQEZ3L3IPpPSxYc/GgRj1jb4khCovHnrM4YSWNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FP6c0KcySxZnxtvcuQeVvekTMsVZ6mEwV8jldXFiGkMl+cKRHCtzxdkwKeWRc7sug
	 eyiKiOcO/7VJkYRnbwI9q1TNNok7HClYfUSPrzABiYG+9c6p1XUnI1JMOFbnnmhi5M
	 fEZ6UT5I8i0rRSJu/FsuiJYK42vD/iYoTbr0V6vSlpkbE66TrmZn2irI44RLS/wHE4
	 VEDE1sc2zt/kwKwvn3Rco1KO/im50Ei4ZZfWkZzPn7bPegdWV2/ShBgLLUlBhNCkY4
	 9qBXIbPLp1m+IHNPi3oxUlgPeYToyLv0V1c0gRZKx/2i5GFI6Fm+B6j4/ONiRT7Ij5
	 8YthwBzBgXR4w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Gang Yan <yangang@kylinos.cn>,
	sashal@kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y 1/3] mptcp: fix NULL pointer in can_accept_new_subflow
Date: Fri, 18 Apr 2025 18:45:58 +0200
Message-ID: <20250418164556.3926588-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250418164556.3926588-5-matttbe@kernel.org>
References: <20250418164556.3926588-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3691; i=matttbe@kernel.org; h=from:subject; bh=chgQEWyhe4KcXuZhJu0HD2Y7iXhgAlkLyZRoIrX2Wog=; b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBoAoHFcsSdzu8DpzjWPPLVlpeSV9ZwqvMVxbwUe pOSQuqkQZOJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaAKBxQAKCRD2t4JPQmmg c1RMD/oCjv7xIXemiRgEQgSSoNTFl5IYzbRiQUn4N1CdAdAx+qnSOgQPRRpk5G+9jHVwUkO1GAV FEH4qACFehxezn0rUOFwRNL87zRsC68/s75bgvb6PFDDpfYWB5Lw+4Lich+Y2/8bQuJWUYP86pq /D5o3e5jXmwRtWvqusbLy8wV7HkKsGneWnmajvk6keLLxcQGE/L7HMw49zSskglrPv9Q9qERn44 WAI8cTWC2g+5Lie7ZEs5nXqLrex0eKAHcuvHm8XOIhi6pR+TdjSXUvqXM7szIW6HUjM83JPPKxc zDkFpNSP8uUuAw/f4Th6rZekGSnLLpDrLGoYq8J/invKdNzoeaQHN8dSPmKhEnFnTifwewcTd6z yM5WmkTdfjbQPlUdIeUM/jpgFZFyzUYp8/cu6PInsVfBRNa+goSFEKPRDVrtIPg8bTffxeTkRzt l2CnI3/9lsP22MQbSbGIYYSL6/p3RUt9N5wA5ElEukldM7crTojoqSUlaayikEBkap7znPDKZeJ HT4qQZl9ye2oeP6BLGJZbCBXirxOezwWO/j/YfpEEkVUuCzg0FnWeJpy5FgzTdekRtbfB2/mPrR O3jGV+vEu40RG0V1D0d9Z163OCRI5x52HLDP8xn4Y9Dt/JlU721vyPLoZ/WyJyClqjQikgfaVPs 2qGZAWxUsZgJnxA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

commit 443041deb5ef6a1289a99ed95015ec7442f141dc upstream.

When testing valkey benchmark tool with MPTCP, the kernel panics in
'mptcp_can_accept_new_subflow' because subflow_req->msk is NULL.

Call trace:

  mptcp_can_accept_new_subflow (./net/mptcp/subflow.c:63 (discriminator 4)) (P)
  subflow_syn_recv_sock (./net/mptcp/subflow.c:854)
  tcp_check_req (./net/ipv4/tcp_minisocks.c:863)
  tcp_v4_rcv (./net/ipv4/tcp_ipv4.c:2268)
  ip_protocol_deliver_rcu (./net/ipv4/ip_input.c:207)
  ip_local_deliver_finish (./net/ipv4/ip_input.c:234)
  ip_local_deliver (./net/ipv4/ip_input.c:254)
  ip_rcv_finish (./net/ipv4/ip_input.c:449)
  ...

According to the debug log, the same req received two SYN-ACK in a very
short time, very likely because the client retransmits the syn ack due
to multiple reasons.

Even if the packets are transmitted with a relevant time interval, they
can be processed by the server on different CPUs concurrently). The
'subflow_req->msk' ownership is transferred to the subflow the first,
and there will be a risk of a null pointer dereference here.

This patch fixes this issue by moving the 'subflow_req->msk' under the
`own_req == true` conditional.

Note that the !msk check in subflow_hmac_valid() can be dropped, because
the same check already exists under the own_req mpj branch where the
code has been moved to.

Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in use")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250328-net-mptcp-misc-fixes-6-15-v1-1-34161a482a7f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflict in subflow.c because commit 74c7dfbee3e1 ("mptcp: consolidate
  in_opt sub-options fields in a bitmask") is not in this version. The
  conflict is in the context, and the modification can still be applied.
  Note that subflow_add_reset_reason() is not needed here, because the
  related feature is not supported in this version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c3434069fb0a..5403292d4473 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -454,8 +454,6 @@ static bool subflow_hmac_valid(const struct request_sock *req,
 
 	subflow_req = mptcp_subflow_rsk(req);
 	msk = subflow_req->msk;
-	if (!msk)
-		return false;
 
 	subflow_generate_hmac(msk->remote_key, msk->local_key,
 			      subflow_req->remote_nonce,
@@ -578,11 +576,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			fallback = true;
 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
-		if (!mp_opt.mp_join || !subflow_hmac_valid(req, &mp_opt) ||
-		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
-			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
+		if (!mp_opt.mp_join)
 			fallback = true;
-		}
 	}
 
 create_child:
@@ -636,6 +631,12 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			if (!owner)
 				goto dispose_child;
 
+			if (!subflow_hmac_valid(req, &mp_opt) ||
+			    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
+				goto dispose_child;
+			}
+
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;
 			ctx->conn = (struct sock *)owner;
-- 
2.48.1


