Return-Path: <stable+bounces-83562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C060399B3F9
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DE91C20E76
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA2E1E7C27;
	Sat, 12 Oct 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CusW7wre"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA321E7675;
	Sat, 12 Oct 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732525; cv=none; b=bwzRBelAXkEyMIYGbcHuiguE8FnzdSCxICqxUFii2Qjss+7qONqQxtb3FwaGORppNENkMfoDuYeCvBtIeg4Acs7btyAtGtJGxac4BO7bagpOnGdcKHUNhGkeH82N4Xph1A+z+2QKSYpD6up6pEQJr5JU+3c9WadT5Fkhl1Kda3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732525; c=relaxed/simple;
	bh=UiqWGB4fidTn7hEicA8WF8H3Yu5kNYzn7AfdgvBKixA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWCnuHu6N7RerK+a2xbfMt3keO0KSMl30Ado8GA0Z1Fftt+0uHLiVD04ZEUQ6HigEVETUJhQahpsyAE+dwjg9mKHjgF1I9v1TBqjcw6Ty84IJKzgPblUKy78KqgL67ecC31Mq7UAm5qyrkoZiuqm9HFKVLzywPPiTn0cnSWT0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CusW7wre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919ECC4CECE;
	Sat, 12 Oct 2024 11:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732525;
	bh=UiqWGB4fidTn7hEicA8WF8H3Yu5kNYzn7AfdgvBKixA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CusW7wreVGmJYB5/NpCMSePbD0fC9Dib36HRvjkIn6p+VL4+pecm4kD9zQqG6J1qu
	 ntvdlSlXMz4sebHUDLRIY9JR0KBXkAiG60mTwY5Mpp5diDtYtZMM0KcoRqvYQ3OSzc
	 7dC05OOv67tvy+6c7WWAKjQAn6oP8MpWzHob5mbgzOl+cmQp4xKrkDDVw7Ro2zNMVk
	 IH9xzdCIPwFr3a96jg0fOsNrBgIeyBejmNaHNoQY192EQP8HKMyeOmJuYC9zz0yaLl
	 3oaQMp3JCm6QNeOynHpUtFV5Mt7ozTKkdrl1rFZvLKYTjRRsX6pspyAB9ZrouXDdYm
	 HwKioLmzbynXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 12/13] lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()
Date: Sat, 12 Oct 2024 07:28:01 -0400
Message-ID: <20241012112818.1763719-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112818.1763719-1-sashal@kernel.org>
References: <20241012112818.1763719-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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


