Return-Path: <stable+bounces-135497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC9AA98E6E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0689445708
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E65D266B4B;
	Wed, 23 Apr 2025 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qo6KGD1s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0883175BF;
	Wed, 23 Apr 2025 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420079; cv=none; b=iD/XCsWbsYSo1YMB4LAYYwk5W7F9ICl44yiZ3aHz0yATKZqmvqukTBc6LBIrR67XoUBXeh/YmN3CdHA/S6+jglwIhfVf5oTtxGqVe2tlSnPczbtHWog79d/Hn2qYsY0i0SXEC5oT+kilWcB3QTXXHnfOZjdQzRC/80Rizb2k9jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420079; c=relaxed/simple;
	bh=ch4wo6nbsY8c6GWk1tf4b1anDbkdFE8BJxLspoaqA74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMS826u/bWhCKDZjZLN6661UPYeLNAsa+W4sOmxUT1QAv4p5tBQiL7aFeWjBvmWOfKfeLGvb2ulawRPwTd4YVE8Poyw5fAfUr2taKFM8RbDv/11RNWQk8luTnIlHNMaRMbWIc2BbIwbvsDGJ3Z6FhKZbFbBvF4+YpfLfvexYPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qo6KGD1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C4BC4CEE2;
	Wed, 23 Apr 2025 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420078;
	bh=ch4wo6nbsY8c6GWk1tf4b1anDbkdFE8BJxLspoaqA74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qo6KGD1sGO6v36Qyrr4u+uIJ6WCjX+jXrpuDjIkStFzFI7MW51sDaibvBPliewmT1
	 GAbEbw5iDbe6/BmVzZ8awK4QdvahB+pi+2pdRLAeBE8bRCW3X2dcro65esroA3eX/B
	 fiscrTEC5Yy66jzTWYTJ9QTIWSsz1S7Gkhbd6QGc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 015/291] ipv6: Align behavior across nexthops during path selection
Date: Wed, 23 Apr 2025 16:40:04 +0200
Message-ID: <20250423142625.030448015@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
References: <20250423142624.409452181@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 6933cd4714861eea6848f18396a119d741f25fc3 ]

A nexthop is only chosen when the calculated multipath hash falls in the
nexthop's hash region (i.e., the hash is smaller than the nexthop's hash
threshold) and when the nexthop is assigned a non-negative score by
rt6_score_route().

Commit 4d0ab3a6885e ("ipv6: Start path selection from the first
nexthop") introduced an unintentional difference between the first
nexthop and the rest when the score is negative.

When the first nexthop matches, but has a negative score, the code will
currently evaluate subsequent nexthops until one is found with a
non-negative score. On the other hand, when a different nexthop matches,
but has a negative score, the code will fallback to the nexthop with
which the selection started ('match').

Align the behavior across all nexthops and fallback to 'match' when the
first nexthop matches, but has a negative score.

Fixes: 3d709f69a3e7 ("ipv6: Use hash-threshold instead of modulo-N")
Fixes: 4d0ab3a6885e ("ipv6: Start path selection from the first nexthop")
Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Closes: https://lore.kernel.org/netdev/67efef607bc41_1ddca82948c@willemb.c.googlers.com.notmuch/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250408084316.243559-1-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/route.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index d6de164720a05..4e6b833dc40bb 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -474,10 +474,10 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 		goto out;
 
 	hash = fl6->mp_hash;
-	if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
-	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
-			    strict) >= 0) {
-		match = first;
+	if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound)) {
+		if (rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
+				    strict) >= 0)
+			match = first;
 		goto out;
 	}
 
-- 
2.39.5




