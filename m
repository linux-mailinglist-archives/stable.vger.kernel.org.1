Return-Path: <stable+bounces-70032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADEC95CF6F
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211431C20D5A
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6211A4AD7;
	Fri, 23 Aug 2024 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROXeMxbw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C91A3BD8;
	Fri, 23 Aug 2024 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421927; cv=none; b=icDnnuRgXPyQ7djCT+oXpk337pwtJ5oau564NJ4qmp8p1anIT8tTvm68eohmkPa2zVu7XzWOMrfmc3WHaZ2iYt3OTqYqUCO3oXivdTtdBSufJ8fw5JAkHOqGL21WpXp62d3ENff+Uw8DXkmi2J1UGql5e/yRiuaEaG9NI6YibcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421927; c=relaxed/simple;
	bh=s6a75ygW/XR1hPToCJ4pwziJfz1cgmCxHl4xM3zC+eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwypN2IfUtASqn662U5b0qZN10KqTw5HC/L/S/nfBjcMCky48JMIMhXkHxkebbEozzhSIFOh7GDLNoFlSPuX9oVY/3VeXVKnxaPLylRjaFrrZCAdivFdZBQZvC9N6jXanvqLy61/GnxIP1cOCOIzdRI/VSE2zwwnCG40GNI+xz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROXeMxbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B5BC4AF10;
	Fri, 23 Aug 2024 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421927;
	bh=s6a75ygW/XR1hPToCJ4pwziJfz1cgmCxHl4xM3zC+eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ROXeMxbwr+LguoVM9E7coNt+4GOsiRJBQGlaDkbAdP0uPwZTaL1pNsY9IU13RR7GK
	 XjNhnGjqKeuE3rh/D9GYHG1C9EoGxGW792rFF8qh/X+5a0vK2nLJlMxYGI/bbDG78o
	 nucYXP/buSPbS3n+yH/VBG9vO3iy+Sj/fYgez+PuikIhwlL6KPGCeXpYuI1KveWV65
	 riZ6xqu6x15L63Dq1qYPzh2wXRdfEduoCpTll7AcKkSC+85bNIy4bg3MvTMKxduJLf
	 bK5VfBgk7z4HiP6IzYzZR/DNIaLz8g07XWMAyV0atgLUhvHAbwo5htxfj8MjdADN5m
	 MHdR1r9C5x4ng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 8/9] lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()
Date: Fri, 23 Aug 2024 10:04:55 -0400
Message-ID: <20240823140507.1975524-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140507.1975524-1-sashal@kernel.org>
References: <20240823140507.1975524-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.165
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


