Return-Path: <stable+bounces-83548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F899B3D0
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062071F271CF
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03931C57B2;
	Sat, 12 Oct 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctPu+oud"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2DD1AB6FD;
	Sat, 12 Oct 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732477; cv=none; b=OM2RBWhnhCvSxqu2Anr+EbBoRi3X9LhiQeNCMQFQPJhfq6K0UQMgKdt++0PMi2NyXAfbQwQyd2LltAlcbJZIcAIIlZKmrnRDSAhRopuhMQhHZqnIE/0Pf6hzlBjl2r5Q+Js1uZ3utUqUS50ifLGYU/8LVET2msqisLrH8xN20oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732477; c=relaxed/simple;
	bh=UiqWGB4fidTn7hEicA8WF8H3Yu5kNYzn7AfdgvBKixA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbiNcy15AL0sC5Lf+CYYbvGp383QGuUNmggMiYw8gjdAWYcpd8OTV3wXgiPMnFmckZuP18LBOjgi7Ph5OTKwV3b5iEKukK/RpKGMarY7ysBf3gcoPI8S3FJC9tpu4vj3EbRxzvcVmaHdKb/q5JCNEXcRIMyWjBjjCZtJOEx2xvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctPu+oud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD934C4CECF;
	Sat, 12 Oct 2024 11:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732477;
	bh=UiqWGB4fidTn7hEicA8WF8H3Yu5kNYzn7AfdgvBKixA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctPu+oudbMjDPPeO15Mi9uoPM0QVNrRBL2BbTKEuBV5Gp/nKq+LSzeaH+Snsua4Ya
	 YrSn6Sa4ffESKIkwVw7k4CKZAIXjXihUdyHyWIBHehviOc6FoQ4ixrP9xZA911cIGR
	 Qo2jZRBZzTwIz+dAt7oGf8Dmm3Y34479TD4d3KsUbCrHTVx+D/mv5Khj8gpjK3Hexb
	 6Q1m9ADdj6KLP3F0tWn+wGZXCXHWwxdtsDoYtmPgBZ+duQItLIQjxUrzLIF8lj0Ayo
	 tlG7EmOSq0uMQgRpSscYKB5gmn6e3aVoC+KHCreWg+4LWU+wbgrZvNJzp7euB9sfvY
	 yzQnjqG25kOyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 18/20] lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()
Date: Sat, 12 Oct 2024 07:26:50 -0400
Message-ID: <20241012112715.1763241-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112715.1763241-1-sashal@kernel.org>
References: <20241012112715.1763241-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
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
index 7dfa88282b006..78f081d695d0b 100644
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


