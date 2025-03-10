Return-Path: <stable+bounces-122453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462CBA59FAC
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6BA27A20BD
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CACA2236FB;
	Mon, 10 Mar 2025 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eDzq0Oe7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4CF81E;
	Mon, 10 Mar 2025 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628535; cv=none; b=bLh19Nb9P5bvWrpMEJ4D1nwdptNr0BLpGdaAHvf912445FcAPvZ9f1XEK4Q/dMi78Le3mYCkSuB8SusIsUb6OcpIme4HpvhwATIq2AvW4ppoBZSrbSl+jdjeAztKQZxlzovgDRz+q3kt9eE17gqBoUQENjhfenvOjscJBbgAz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628535; c=relaxed/simple;
	bh=fEBnFKoMLJBx99TmTGvLwqW9vLd1ymqK2vIHotP01mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eM0kUHXy/MWHez2dFCnEb0OXbdge9ohx6MW1QADqE4YzZWYpQ65seuoa7ED+XTy22+7mV3S6lD656u1KAKuxAKnV6ZrQY902yjj6sE4sPTO8Hr4Wqy0bWD4ebF3CgqjXaEmqCTVqk8m0VEL7BhFHKXbt1FJrJBAki5OrmvSszu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eDzq0Oe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74467C4CEE5;
	Mon, 10 Mar 2025 17:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628534;
	bh=fEBnFKoMLJBx99TmTGvLwqW9vLd1ymqK2vIHotP01mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDzq0Oe7YSRdwIcrVYcul2+ybJinQSpGRm275+JDPh9SVhpYc80SPPWYllYeCeHpX
	 oL4MV8C+DS6cIVgv3FjpyHMdgk2ICk5rbicoDcDhTqQF1qyWiuBdvXZ6WXq2gC2xiy
	 ayTzSkD3XboVQmEm1Ld1aW5RJIrVAJqso9BuiGjs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zecheng Li <zecheng@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 6.1 059/109] sched/fair: Fix potential memory corruption in child_cfs_rq_on_list
Date: Mon, 10 Mar 2025 18:06:43 +0100
Message-ID: <20250310170429.919497036@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170427.529761261@linuxfoundation.org>
References: <20250310170427.529761261@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zecheng Li <zecheng@google.com>

[ Upstream commit 3b4035ddbfc8e4521f85569998a7569668cccf51 ]

child_cfs_rq_on_list attempts to convert a 'prev' pointer to a cfs_rq.
This 'prev' pointer can originate from struct rq's leaf_cfs_rq_list,
making the conversion invalid and potentially leading to memory
corruption. Depending on the relative positions of leaf_cfs_rq_list and
the task group (tg) pointer within the struct, this can cause a memory
fault or access garbage data.

The issue arises in list_add_leaf_cfs_rq, where both
cfs_rq->leaf_cfs_rq_list and rq->leaf_cfs_rq_list are added to the same
leaf list. Also, rq->tmp_alone_branch can be set to rq->leaf_cfs_rq_list.

This adds a check `if (prev == &rq->leaf_cfs_rq_list)` after the main
conditional in child_cfs_rq_on_list. This ensures that the container_of
operation will convert a correct cfs_rq struct.

This check is sufficient because only cfs_rqs on the same CPU are added
to the list, so verifying the 'prev' pointer against the current rq's list
head is enough.

Fixes a potential memory corruption issue that due to current struct
layout might not be manifesting as a crash but could lead to unpredictable
behavior when the layout changes.

Fixes: fdaba61ef8a2 ("sched/fair: Ensure that the CFS parent is added after unthrottling")
Signed-off-by: Zecheng Li <zecheng@google.com>
Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250304214031.2882646-1-zecheng@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eedbe66e05273..d30e0936cfecc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3550,15 +3550,17 @@ static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
 {
 	struct cfs_rq *prev_cfs_rq;
 	struct list_head *prev;
+	struct rq *rq = rq_of(cfs_rq);
 
 	if (cfs_rq->on_list) {
 		prev = cfs_rq->leaf_cfs_rq_list.prev;
 	} else {
-		struct rq *rq = rq_of(cfs_rq);
-
 		prev = rq->tmp_alone_branch;
 	}
 
+	if (prev == &rq->leaf_cfs_rq_list)
+		return false;
+
 	prev_cfs_rq = container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
 
 	return (prev_cfs_rq->tg->parent == cfs_rq->tg);
-- 
2.39.5




