Return-Path: <stable+bounces-83588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C6499B465
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3265BB241B7
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247D720606A;
	Sat, 12 Oct 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvv80uLL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6535205E37;
	Sat, 12 Oct 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732603; cv=none; b=fnjFSTHVJ0Hripvc0Pp+b3vPra1eubCy1V3lPFb1dIM8WxuBCu+m8FhsFdGyTPdJWmku8TsDTtTvFSM+PI09qCZQuHvjSi3rbaFWFlC0Oz+hlRjAOYNwtczjOIsXF9r/reBnZZwf7CJrpEmFWu4kJvSYvBlRMDZ9cum8lagK4fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732603; c=relaxed/simple;
	bh=s6a75ygW/XR1hPToCJ4pwziJfz1cgmCxHl4xM3zC+eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7BJWMnjDVuioPgWVUJqQ0pz+7dUTCQExuZxLFTg2dONvhJQ7jMROSgoPCK35UOCFR+BeivlG0/e516MYEqGj57juz6VzlyT6g1vBAytkE/C/gobKh322lSdOh+0Rg+zefRdr31/fcI25L4ma83Fpid19VplXkTI/zEoM2r0Kts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvv80uLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0840C4CED0;
	Sat, 12 Oct 2024 11:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732603;
	bh=s6a75ygW/XR1hPToCJ4pwziJfz1cgmCxHl4xM3zC+eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uvv80uLLEmi5k/bVnS4zRGzdHGFVyj388Al2emQGxAykf8s5ezfBtfv+gbvaC+cIL
	 CVjj994Nlssc6MB+i1PbgXDw8tDWr0DOX1h31nNdx9GeT7jE7Ero+7nDChV1GJkk1A
	 B6Q0SJ5h7LFBTaDWNK+yi9ua9SIGWZ9ao1AeWFpvbggc7FHplPnWXjnFAhoZyQey9Q
	 2iBF2BVJ9es2EzuIqZVEvAMGMoHyvQ0e1XsWZa2GzK9NyE5B0GwFTRu4jfoYT2w7zH
	 Rz27DkHK8IZTvubMTwVxALSB5u92T0i9LIbTiP/VgDnm7OZFjhtQNr0JOoSe34sdbI
	 xxh+ApTxrxayQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 7/7] lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()
Date: Sat, 12 Oct 2024 07:29:42 -0400
Message-ID: <20241012112948.1764454-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112948.1764454-1-sashal@kernel.org>
References: <20241012112948.1764454-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
Content-Transfer-Encoding: 8bit

From: Kent Overstreet <kent.overstreet@linux.dev>

[ Upstream commit b2f11c6f3e1fc60742673b8675c95b78447f3dae ]

If we need to increase the tree depth, allocate a new node, and then
race with another thread that increased the tree depth before us, we'll
still have a preallocated node that might be used later.

If we then use that node for a new non-root node, it'll still have a
pointer to the old root instead of being zeroed - fix this by zeroing it
in the cmpxchg failure path.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/generic-radix-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index f25eb111c0516..34d3ac52de894 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -131,6 +131,8 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 		if ((v = cmpxchg_release(&radix->root, r, new_root)) == r) {
 			v = new_root;
 			new_node = NULL;
+		} else {
+			new_node->children[0] = NULL;
 		}
 	}
 
-- 
2.43.0


