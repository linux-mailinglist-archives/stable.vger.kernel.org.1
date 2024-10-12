Return-Path: <stable+bounces-83580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9001B99B433
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09785B20EB5
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926B91FCC44;
	Sat, 12 Oct 2024 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdHGK88a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF6B1FBCBA;
	Sat, 12 Oct 2024 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732581; cv=none; b=NcqC5aKDeke//J7Q8vuCDs/9wdDnqFuHKh6sLCRoBt8nlVRjxLaFtaXc6se+5N7A3SAVe3CTm/B8N4othhjpkuZp1U6qgX5F72OJ1Hyg0bwd/M2+juyk3TuNIMC4UdctT8iAazZfItHzPnWFQbylFlsO5CbfAuw9NnRYA5gA6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732581; c=relaxed/simple;
	bh=s6a75ygW/XR1hPToCJ4pwziJfz1cgmCxHl4xM3zC+eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3PO3KODuCbLl9D8UjdUuxxFRYWy3BNKilmpmVBCe1WT1yAI+PMm/54UiiyYVcFxQvAvQZK3zRnDj0UTO+fYfDTA6Mzh/2stkQSl4Y80I+nPi7WOu8SOQWoFlR5kdshpJsfRWAYzDxNUltfmtc/0Z3CyahDUtgGBTEzFQH9tryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdHGK88a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F23C4CECE;
	Sat, 12 Oct 2024 11:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732580;
	bh=s6a75ygW/XR1hPToCJ4pwziJfz1cgmCxHl4xM3zC+eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rdHGK88aDUvmUvj6zIR36ELlhzDZ4tVVuy7fDo8RMzzkoFpktX0Dt7Bm+mPc57TyD
	 i4ejEbVxaVWPx8N2YrxWXthPWl2tVC1HXyzlzgbq14lQJqHq3pfPBiG0jxNCxXCGop
	 WcEBnBgbW9xCGa8bQZp/LH/4EDKFa75D1AIkWUByxWyjfiRPc8ma39L0FYiyfWkSJk
	 1i3EgH47NJSfBnyqPa/jKDzQPtUdtN9EGGqrol0gpSR9I68eDQkBKco4/aF3AS9zOA
	 UUZpE2aMymo50hudBtJidJQyalBS5p/8PoamGh4p+wyfCTM4uagIhd5oBQTPX/G6b1
	 04FpZq/yeHznw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 8/9] lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()
Date: Sat, 12 Oct 2024 07:29:13 -0400
Message-ID: <20241012112922.1764240-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112922.1764240-1-sashal@kernel.org>
References: <20241012112922.1764240-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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


