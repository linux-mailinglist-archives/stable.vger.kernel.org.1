Return-Path: <stable+bounces-163440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5034CB0B147
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 20:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7FB1AA1A05
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E78223DCB;
	Sat, 19 Jul 2025 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgsiqDsA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEEB2AE7F;
	Sat, 19 Jul 2025 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949178; cv=none; b=u+6KbCaCbdVFbfiRGpk5pVXfd1wNQpI8gyeGkTbHbW5EMcp92dFECJTeEL/u3PVvTWi28FUZ3i3F4RNkmY7jIJPwEDAMZWm32tj4OYjgQ0ZXiS+JDm7jdzdQU+Nsh/bAtBXTWLeTb3jn2NrI+IFVjBu36xe1dOEi4B4pt8GdTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949178; c=relaxed/simple;
	bh=UT44bjgcgNEzmE3niHBCySJwkb/IEGsOxx/0/fOEM0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NUW6hTpu0oodpXjIzlmC6f052burbLx8wFLJm0zVuMFLJ0Vp9nTzBwV41EvQQR6kqf8S72WXnr+DWQwG2v2hE2NMfQnwmylPhYx4pfUY4KdBItJV7ZjKoNb7fPSn2e6DohNckvg6SFBy55ShdAov2kORV6+8o/f4FxD+qWGI3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgsiqDsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1743CC4CEE3;
	Sat, 19 Jul 2025 18:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752949175;
	bh=UT44bjgcgNEzmE3niHBCySJwkb/IEGsOxx/0/fOEM0A=;
	h=From:To:Cc:Subject:Date:From;
	b=sgsiqDsAWgDB2f/86RmWgWg/MfpsuzSilW3zHhfN3YS7aCJUpJXp9fciRHErMQfqH
	 kDg4b+jA/y9TaVKbVEG8MJW66qlsw4/8cjvBoahgF1TGKypL4XfEHQ3T883CH0j4Lc
	 Cf2l6EFuqYSVl+MJAMSnE+jBgn/w3bu1e5F1k9Sgy+OJ66AJ2txKDzKDeblcjMkXJX
	 ESPvp5Km5l971cSnykqQZw/3L0HpP5kP4IgFS+ka3Ss62HgUprZW0bK7xXTRNZSNgt
	 bWx2HiWrqmJzQk81C21oePRNbxlMJQTcX470meUI1prI4fbLRAmDifgB2JK1SDi67c
	 xoQ4iCSYbSp7g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: commit damos_quota_goal->nid
Date: Sat, 19 Jul 2025 11:19:32 -0700
Message-Id: <20250719181932.72944-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS quota goal uses 'nid' field when the metric is
DAMOS_QUOTA_NODE_MEM_{USED,FREE}_BP.  But the goal commit function is
not updating the goal's nid field.  Fix it.

Fixes: 0e1c773b501f ("mm/damon/core: introduce damos quota goal metrics for memory node utilization") # 6.16.x
Cc: stable@vger.kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f3ec3bd736ec..52a48c9316bc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -756,6 +756,19 @@ static struct damos_quota_goal *damos_nth_quota_goal(
 	return NULL;
 }
 
+static void damos_commit_quota_goal_union(
+		struct damos_quota_goal *dst, struct damos_quota_goal *src)
+{
+	switch (dst->metric) {
+	case DAMOS_QUOTA_NODE_MEM_USED_BP:
+	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
+		dst->nid = src->nid;
+		break;
+	default:
+		break;
+	}
+}
+
 static void damos_commit_quota_goal(
 		struct damos_quota_goal *dst, struct damos_quota_goal *src)
 {
@@ -764,6 +777,7 @@ static void damos_commit_quota_goal(
 	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
 		dst->current_value = src->current_value;
 	/* keep last_psi_total as is, since it will be updated in next cycle */
+	damos_commit_quota_goal_union(dst, src);
 }
 
 /**
@@ -797,6 +811,7 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
 				src_goal->metric, src_goal->target_value);
 		if (!new_goal)
 			return -ENOMEM;
+		damos_commit_quota_goal_union(new_goal, src_goal);
 		damos_add_quota_goal(dst, new_goal);
 	}
 	return 0;

base-commit: 5d6176edfeb848b1039a1a2c9c1c36dd7f83150f
-- 
2.39.5

