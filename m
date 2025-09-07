Return-Path: <stable+bounces-178015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 325E6B478A8
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 03:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAEC3C7751
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 01:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF3819F48D;
	Sun,  7 Sep 2025 01:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHQWrlyh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E434419CC28
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 01:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757210338; cv=none; b=U2k/H456KpUZtJt0TLhvr+Cn8YLZPrkSm3BivYyCeMScKQ+9en4Qi+PWy2kOd7VH/+Uj1Uqns77hdTXKZ5jLbwyFR+dtnjIyGllw4lZSUTd/QcHsGQyXQ9IODaOwSlyRlo6FvEA0VTmobH3qxynJEBVlrrWZ2tnzzSh/ZQFwLEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757210338; c=relaxed/simple;
	bh=q4/yEhIcDZAOLmALzD1m5DNAZOkt6MoPC343J22Gws8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0uVwZfv/xdS+kJlr+rVkULcsBaPjLL8soU5NA+8ady98+kqDA5F4UryfLGlwUhL6Ivoc3KFtw20pljrjpZh0zuKtTSLL7AV2Nu7ZBsbB3/RDb7eObkRl2ZJx8GxPC6kQqQldI3n1331eQ7LbmsghwVyPYQ/S9vMAGSapfQXrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHQWrlyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D73C4CEE7;
	Sun,  7 Sep 2025 01:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757210337;
	bh=q4/yEhIcDZAOLmALzD1m5DNAZOkt6MoPC343J22Gws8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHQWrlyhEE1bUB1l1fsC7DUSdr9h7wKIERLvekDJQuO0Zg3mS0O4YX7Ih+xSDY0Bc
	 KF6i7s9lL+13jgdA+mS2hXAThUIeSlYgXCV1aeMWK1BqH9caKErWJttZAXZUxQ19pI
	 cNOgXnyNkSskxFOgyYjIeM3d5BzFOvLj+ew+keAC5NWVitI/nKEdzKk/LEQ9W9Itzs
	 I7p+NBdLMkjVPT49H8BJ7oJr/006avY01McDAy5EAJzFAHW3pAgeQd6wlrT7Kt/wxq
	 3q657dWlEirf+2EK7WLgfT7kkMH/+n8MZcew1OP1715NZI9wzj4pTkV7fpBqzHnmKD
	 nT34OZN6weqPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Qiong <liqiong@nfschina.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/slub: avoid accessing metadata when pointer is invalid in object_err()
Date: Sat,  6 Sep 2025 21:58:55 -0400
Message-ID: <20250907015855.398489-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090620-plaza-trench-7364@gregkh>
References: <2025090620-plaza-trench-7364@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Qiong <liqiong@nfschina.com>

[ Upstream commit b4efccec8d06ceb10a7d34d7b1c449c569d53770 ]

object_err() reports details of an object for further debugging, such as
the freelist pointer, redzone, etc. However, if the pointer is invalid,
attempting to access object metadata can lead to a crash since it does
not point to a valid object.

One known path to the crash is when alloc_consistency_checks()
determines the pointer to the allocated object is invalid because of a
freelist corruption, and calls object_err() to report it. The debug code
should report and handle the corruption gracefully and not crash in the
process.

In case the pointer is NULL or check_valid_pointer() returns false for
the pointer, only print the pointer value and skip accessing metadata.

Fixes: 81819f0fc828 ("SLUB core")
Cc: <stable@vger.kernel.org>
Signed-off-by: Li Qiong <liqiong@nfschina.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
[ struct page instead of slab ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index f95ae136a0698..97ac0c7da0f0b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -864,7 +864,12 @@ void object_err(struct kmem_cache *s, struct page *page,
 		return;
 
 	slab_bug(s, "%s", reason);
-	print_trailer(s, page, object);
+	if (!object || !check_valid_pointer(s, page, object)) {
+		print_page_info(page);
+		pr_err("Invalid pointer 0x%p\n", object);
+	} else {
+		print_trailer(s, page, object);
+	}
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
 
-- 
2.51.0


