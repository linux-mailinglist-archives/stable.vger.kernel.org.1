Return-Path: <stable+bounces-69987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A5195CED8
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6335228668B
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F30192B6B;
	Fri, 23 Aug 2024 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbkNfgj6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF91925BF;
	Fri, 23 Aug 2024 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421742; cv=none; b=lbJh8Ts9ve7Cpil5OKHY/u2Az9MLGod8SGzS07LAyYo/+FkBqYJ9ijTqnXKvrvwIMSlZnCpye3z3miHUNEtO5ZxldPe4nVNzKahwqHFGcVXPYZWlcLr/3/93DJ13gtekDal1AUoSCemyygvFwqOlpXk7sBGQRN4e/Q+fNKFtC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421742; c=relaxed/simple;
	bh=TFLmSaPNhWnKrG4/6pw8ok+rdhClUEi48vtIecip4Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmjWY0M8z0U+/YL5amsaSorRctHjIYNb+nwO790X5+rwxP48ER6OIxwU/ZBH72nH+m/ihvqR3AodiQ7lUfkdlaAwZeSIDC+7kzomQXe49BNlgP9ry/4ZhUsLyQ40Jsw1DdWlKc0Dtg4j7r/v0VN2Ymet2qEZgbNWW25qvV6d5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbkNfgj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932D9C4AF0F;
	Fri, 23 Aug 2024 14:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421742;
	bh=TFLmSaPNhWnKrG4/6pw8ok+rdhClUEi48vtIecip4Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AbkNfgj6qlwPfgetXs4nlVUmo/zBSKfai3wogqNEWdpaJNE2+R5AhNF9UYEatMkSh
	 0kFiXhYjs3CKtplml2329U6iGzfvifHh9hl8my93AYMkBI2+erwnSJvJ86X0R9v4zh
	 KMveJljaGLyPa1OYXQaauhQN1wg4q7kFtdkAAxgszvJWEl0ij4QVJXOYl87c6Y2Giv
	 wLA/PW4BT0yhMbadhtCVA8WDtGE/xTLecgTutGgcWsgVwBBZpyr1SlB3Z/d/ERTPLy
	 otBhkIrHWpTyhL1qQTF74UOQElI+C+I86Cm/ELMKJPINECZ/1QCuDvb5hVKPBWM4C1
	 JazEEdAmlTmNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.10 20/24] lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()
Date: Fri, 23 Aug 2024 10:00:42 -0400
Message-ID: <20240823140121.1974012-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
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
index aaefb9b678c8e..fa692c86f0696 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -121,6 +121,8 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 		if ((v = cmpxchg_release(&radix->root, r, new_root)) == r) {
 			v = new_root;
 			new_node = NULL;
+		} else {
+			new_node->children[0] = NULL;
 		}
 	}
 
-- 
2.43.0


