Return-Path: <stable+bounces-83571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F36AB99B414
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B9E1F21E30
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86781F8924;
	Sat, 12 Oct 2024 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLfo2+ub"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B6D1F708E;
	Sat, 12 Oct 2024 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732553; cv=none; b=Zt410fEUpuS2UNcEL85O9eJ15S9ntK0LlassvBPVggqxjlVQxYyeBu4gOeYVEG0HkrO8joOWnTVQFmYveVXYtVEhjpJ1dPfZ0Dy6y3unS3hGBpixRHHmH8I8ERqVFivLcCYhbnSX0VDM40gCVjOHiVR3JNYXnH6EQgXdeTRRLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732553; c=relaxed/simple;
	bh=s6a75ygW/XR1hPToCJ4pwziJfz1cgmCxHl4xM3zC+eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvlY2k9JVpk4thSqfFST8teHZrB0LfFGKKA3hd6srIvyGs0QfQd5d/gfdYh2Xqn4EATM7naGmHMNK1p5gYyORjLEMAsQRhorzVPZONgfUB0pW0NCbdq0Mab7Zl1RPlIE67hDzWBl5Qf1E5pmKgDxgVi0Jll1vvsbQDMFsVKIyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLfo2+ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86513C4CEC6;
	Sat, 12 Oct 2024 11:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732553;
	bh=s6a75ygW/XR1hPToCJ4pwziJfz1cgmCxHl4xM3zC+eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLfo2+ubUl45lWEwGekV6UZIzta99EO6btaDUDojEijTZHgfWeWRaGUE2jYgxW/x+
	 F5j9aXIaux00rZ255vgZhrgbNh6vzOB/eSanCIAKfl0DvW+PggLM6ndmF9szVlrNdf
	 hdTi0JaoEbPBtn+1fW2gPurGVG5pTiHCZSYbf4rm7jyOwAqOSUzvnZVQLv1nnjKbsj
	 S7Kckid1tiAZEITAlPnwAPdTVJH+qTeEbrT/kxRwo43ozzcc0GXM0qutINIZ0v1QUQ
	 CcXCybqXXPdmgjC1LQh5NuatDEWtdX91UmBnS1nHhKEWQJ38KKuxxHdg2x3IpzZTjo
	 Wp/N1SPJJCLIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 8/9] lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()
Date: Sat, 12 Oct 2024 07:28:46 -0400
Message-ID: <20241012112855.1764028-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112855.1764028-1-sashal@kernel.org>
References: <20241012112855.1764028-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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


