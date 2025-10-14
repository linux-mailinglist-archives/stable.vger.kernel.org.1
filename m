Return-Path: <stable+bounces-185557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E832BD6DB7
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 02:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387CF404E73
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627552C3768;
	Tue, 14 Oct 2025 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnxiU2wh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171EF34BA5B;
	Tue, 14 Oct 2025 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760401132; cv=none; b=qLTzUl9EMm2IjLGdDhU3ldfj+3r/OWH2+g2OOz5VL5Zm/srOP2M2Q2M6zm+QZL4GMZdRUo7JdAuHkOF1ioZqs/hiupxWC0t9MogHJdICZXM9GWhAN1Kg4YIusuA0c5SYE4hbUukpIPLObOD8TKqbESZzBpEHe0sF+l9dSLBAJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760401132; c=relaxed/simple;
	bh=Wj7cSLcyT0p0yvwLU7VLNGP20MDD+s64RMgH2Oq8gVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DoP66gMqGPjFl4TCUoWC9eG6Z9d+d0e+2uO3jJKuoGHpO2q0hGscYxRiRHD0vmk4azVhx55jULtMDlVd1pmIuYZlxfCm4b7aKCOS0B+whbENSeAClIuM0//OQ1OI0HWeKuJNKe8p4o/zuA23damxQPT+AVIv0QH9kCvdrNM9pj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnxiU2wh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76584C4CEE7;
	Tue, 14 Oct 2025 00:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760401130;
	bh=Wj7cSLcyT0p0yvwLU7VLNGP20MDD+s64RMgH2Oq8gVw=;
	h=From:To:Cc:Subject:Date:From;
	b=EnxiU2whCnZHUhG3hop0501oo0Znua44eztBcxHHpcDKvqctxqoBaaULm3oZuJ6Fq
	 QcuWIJMf0g3JJAMsAZ9xXnMUfpDF/VhkkcxRRTYnveOqNgcEELdDWjXZIQ1yAtWS6X
	 x8clovOVioShD79aGcl4Maj896DiLcjFhyoIMacQPCdENh/f1D8CdU7cj5LyhiNlqk
	 FqK4eOZ4zXYS3fFpYaVDta7X4FIME/JnjpKYx12Ap+up5OwKQq4M+3wUMMXkKx3CSs
	 nUHCtwjKNsZpvXt61K1whz0slG3bN7VEZCiBlPZBRyVgTjURPedUxR0HGTnEeS3yt8
	 gUPSTBavfE3DA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/core: use damos_commit_quota_goal() for new goal commit
Date: Mon, 13 Oct 2025 17:18:44 -0700
Message-ID: <20251014001846.279282-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a damos_commit_quota_goals() is called for adding new DAMOS quota
goals of DAMOS_QUOTA_USER_INPUT metric, current_value fields of the new
goals should be also set as requested.

However, damos_commit_quota_goals() is not updating the field for the
case, since it is setting only metrics and target values using
damos_new_quota_goal(), and metric-optional union fields using
damos_commit_quota_goal_union().  As a result, users could see the first
current_value parameter that committed online with a new quota goal is
ignored.  Users are assumed to commit the current_value for
DAMOS_QUOTA_USER_INPUT quota goals, since it is being used as a
feedback.  Hence the real impact would be subtle.  That said, this is
obviously not intended behavior.

Fix the issue by using damos_commit_quota_goal() which sets all quota
goal parameters, instead of damos_commit_quota_goal_union(), which sets
only the union fields.

Fixes: 1aef9df0ee90 ("mm/damon/core: commit damos_quota_goal->nid")
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 93848b4c6944..e72dc49d501c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -832,7 +832,7 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
 				src_goal->metric, src_goal->target_value);
 		if (!new_goal)
 			return -ENOMEM;
-		damos_commit_quota_goal_union(new_goal, src_goal);
+		damos_commit_quota_goal(new_goal, src_goal);
 		damos_add_quota_goal(dst, new_goal);
 	}
 	return 0;

base-commit: ccb48f0d949e274d388e66c8f80f7d1ff234ce46
-- 
2.47.3

