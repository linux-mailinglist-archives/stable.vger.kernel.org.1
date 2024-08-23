Return-Path: <stable+bounces-70041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC4C95CF88
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3901C22998
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC0D188596;
	Fri, 23 Aug 2024 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICuAlE4E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D71ABEA6;
	Fri, 23 Aug 2024 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421961; cv=none; b=ekIkXzzXGdRh0DjrgBZf8ynYXTP38ykHei5l5VoTc+l1QI1OHQy+rJQr75PAa1YdkKDzN2cKa9rL2lTCTABjZ0qEyEUfN+XV3sPyrnpWTdkvA/0wF2ENKHJvpajCoZlLQGgfG26RlA+qc9SBxaQhNfnu2kZxCzN5b1Vv+elzhr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421961; c=relaxed/simple;
	bh=s6a75ygW/XR1hPToCJ4pwziJfz1cgmCxHl4xM3zC+eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owB8KgQS6WNO/pGpbSX6+k2ZTLEwBgxIpP1J8yT0xaOxuuEr5mIgJILolqdOh1POQQAWi+Ab0aXhuQh2vW4V03Wvxz9suJURiK6cJPv750cHxaVyyilHy5cXKbHUEall+ZtQY6/meBAsCpxLZlYP01n0TVvHwwwB7k4y+4RCfLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICuAlE4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8623EC4AF10;
	Fri, 23 Aug 2024 14:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421961;
	bh=s6a75ygW/XR1hPToCJ4pwziJfz1cgmCxHl4xM3zC+eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICuAlE4E8FAgECX77ahSMcHbNbcB73fUk058x0ksUBH1CsCCWPZF7v1uFRLDyLyqT
	 zBq10mCuGY/prBjflsgtjbTD6i9/Tl7h8V2lAZbOJlOye9tDQxfTnr0DGJ4vukI5dg
	 l7Z2tGnbKRDtAe7LuvaJLx8Mw7WqaAvLuHp2BOTTU7KuEOWHLlP1PIfrSEfCs8Jlsa
	 Qf0jn2Y+eOUP6acoGl5iWcxlNZXtz8NZDw3GvssibOvhJXQuXftVubhALqWsU9qV29
	 tUEyPWPDVn5pFFJtBzWCtimJdhnOplST8TBzp0ULl4TZqKyVFU4QCyC8sywbQ5/V06
	 Vjd6TJR55Z+Sg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 8/9] lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()
Date: Fri, 23 Aug 2024 10:05:28 -0400
Message-ID: <20240823140541.1975737-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140541.1975737-1-sashal@kernel.org>
References: <20240823140541.1975737-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.224
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


