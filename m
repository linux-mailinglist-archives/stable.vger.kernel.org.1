Return-Path: <stable+bounces-70023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0D495CF54
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E81C1F2A6DD
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38261A08A3;
	Fri, 23 Aug 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFKQivak"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEC21A0737;
	Fri, 23 Aug 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421894; cv=none; b=p5onMTUAqJ4gOu1L64HQP7v2rnQhFFyyyrXwnPeS7tBBnAClNeTltU509GlGNrhZvbjv+pT9j9xp7H1ueSA5aHOL3nHGkYAh/C4315LFLb7yfOUJ05QN6yQUbUZVWaTuK/50XUU7zUmq3B0I9aiJ0kKTw6TIA7bdypV62/w0lPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421894; c=relaxed/simple;
	bh=UiqWGB4fidTn7hEicA8WF8H3Yu5kNYzn7AfdgvBKixA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpyBze0Ky7KbxrSJpEsdzyUcNriZKD+PzB9IoX27bLGlESJb0+dVbXg+0Jqhk8WsNAAzyfIfe4hUWZLaC8JhGfvOdCaJ54SqEVy5/qg8OdTOnrs5w/5Ml8o7PoQ5BdwfpvEzgvFGG3aC2a5M+vhLJo+HHEWlWZs4iycLkRVHedM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFKQivak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE00C4AF0E;
	Fri, 23 Aug 2024 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421894;
	bh=UiqWGB4fidTn7hEicA8WF8H3Yu5kNYzn7AfdgvBKixA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFKQivak/Gf6MzMYItyeTs2Bj2kEJfQa7Nras21oN0K1Hrv+XwmRObxH4TeKpTfyX
	 hHB0w/e21g2VW10yApZSPVAASwzzyz+FnGEAhTB+6ePqNYW+Tz76FQAHQig2naaQop
	 bHb8kp94b7DtRn2IBnmSRIMQmWyKk0NKB2kP8ky4ZLtKytOGCLju9Cb6NIL5E/l+c/
	 96P5j6YtTtIypdENri2OL0KKJJypEShx26gNIl8OhooNW0Yp3m4awZBYPkFqkNFYKG
	 NCdRhUPkiRlBhjtFk9R37h1tEYncWBZICOFfXM0PTbhcxmpIo03rVvi6v7fRgJ524K
	 Juduilv7zTZFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 12/13] lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()
Date: Fri, 23 Aug 2024 10:04:01 -0400
Message-ID: <20240823140425.1975208-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140425.1975208-1-sashal@kernel.org>
References: <20240823140425.1975208-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.106
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


