Return-Path: <stable+bounces-147221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCE5AC56BB
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A257F4A5EF5
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E8C27FD4C;
	Tue, 27 May 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cRjuEbmN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6167280034;
	Tue, 27 May 2025 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366661; cv=none; b=CWn/ySO9DfNbDuYAW/1Y48kJmGfI06PZm87qeSOTHqNP4FgufT9L1NkHxj4z4FwZ/XG/Jt7uAzXC6hy0D9K2nlJLkXvw34wneF450/MKFDvfZVBqUoU1Ujm4LothzCY+dx5FQS8YT9z2lnCYRyAomxkFOdVs5mBICB252pzNuKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366661; c=relaxed/simple;
	bh=+is5Wl+hiqkPGyndIgeDwxN4NmM+8V5zErpeASqvtvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfCKXqAkyl5ItZIkzGD1KXAFJ/62p7goKF3H+wtlEhjxygNUulqGCHZvq3+szZRKsC8F5g1ZI/H9BQigwhIIq8EgiIaRFU9M8HGCgYDUmxOHARgs18iorQevLwF0bl75LsnoFBx5mTwXPL4PqsxiGAWRH9Ll4Rv52YUvRhhwOm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cRjuEbmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530ACC4CEE9;
	Tue, 27 May 2025 17:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748366661;
	bh=+is5Wl+hiqkPGyndIgeDwxN4NmM+8V5zErpeASqvtvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRjuEbmNW0EPczxOSF6XA1L3dN7O85GByqEsZ4saPFLe/W6st1YQFLRTke2RjFupt
	 PyCp9o5uRqoXKCNLI0TNmjLkXRBSJaR0vGtZmr+zHP829gJHPlt6DHerwawljfq9un
	 3NCq0JiZC/3Q5wt9o8rcx6whJGWSb40+AJbVwbF0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wen Tao <wentao@uniontech.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 140/783] blk-cgroup: improve policy registration error handling
Date: Tue, 27 May 2025 18:18:57 +0200
Message-ID: <20250527162518.861794675@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Linxuan <chenlinxuan@uniontech.com>

[ Upstream commit e1a0202c6bfda24002a3ae2115154fa90104c649 ]

This patch improve the returned error code of blkcg_policy_register().

1. Move the validation check for cpd/pd_alloc_fn and cpd/pd_free_fn
   function pairs to the start of blkcg_policy_register(). This ensures
   we immediately return -EINVAL if the function pairs are not correctly
   provided, rather than returning -ENOSPC after locking and unlocking
   mutexes unnecessarily.

   Those locks should not contention any problems, as error of policy
   registration is a super cold path.

2. Return -ENOMEM when cpd_alloc_fn() failed.

Co-authored-by: Wen Tao <wentao@uniontech.com>
Signed-off-by: Wen Tao <wentao@uniontech.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/3E333A73B6B6DFC0+20250317022924.150907-1-chenlinxuan@uniontech.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c94efae5bcfaf..8b07015db819a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1727,27 +1727,27 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 	struct blkcg *blkcg;
 	int i, ret;
 
+	/*
+	 * Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs, and policy
+	 * without pd_alloc_fn/pd_free_fn can't be activated.
+	 */
+	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
+	    (!pol->pd_alloc_fn ^ !pol->pd_free_fn))
+		return -EINVAL;
+
 	mutex_lock(&blkcg_pol_register_mutex);
 	mutex_lock(&blkcg_pol_mutex);
 
 	/* find an empty slot */
-	ret = -ENOSPC;
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
 		if (!blkcg_policy[i])
 			break;
 	if (i >= BLKCG_MAX_POLS) {
 		pr_warn("blkcg_policy_register: BLKCG_MAX_POLS too small\n");
+		ret = -ENOSPC;
 		goto err_unlock;
 	}
 
-	/*
-	 * Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs, and policy
-	 * without pd_alloc_fn/pd_free_fn can't be activated.
-	 */
-	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
-	    (!pol->pd_alloc_fn ^ !pol->pd_free_fn))
-		goto err_unlock;
-
 	/* register @pol */
 	pol->plid = i;
 	blkcg_policy[pol->plid] = pol;
@@ -1758,8 +1758,10 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 			struct blkcg_policy_data *cpd;
 
 			cpd = pol->cpd_alloc_fn(GFP_KERNEL);
-			if (!cpd)
+			if (!cpd) {
+				ret = -ENOMEM;
 				goto err_free_cpds;
+			}
 
 			blkcg->cpd[pol->plid] = cpd;
 			cpd->blkcg = blkcg;
-- 
2.39.5




