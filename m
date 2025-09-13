Return-Path: <stable+bounces-179462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C39CB560C8
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151CC16B569
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C8F2EC546;
	Sat, 13 Sep 2025 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ynSgutuf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9300BDDD2
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766392; cv=none; b=lyLpzEFVgP+Z6v9LSnsDQMoLuekd4sFV/ceSs6TF25YcbjU3QLxwrEGCwbVlYyZ2aNfEd7qapkU1QbtIKdrP6yHjXNS/qma/f8CfqX+itS4iDrqhO8rd8VVr7m9A7+kRfb6Mv3N//cfYvnrA7aEHCDwyLPDDMto5xLYESN7CVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766392; c=relaxed/simple;
	bh=r2KKelfE/hxYOLtwK/iYWkh7Rx83PoV/lnFcAeNdaw0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uoGvd7gE+cgX3bSjoB9phtrN9wh3igkiEzhTa3+bdzE1Dg58OIGR3dwQCoT3s3wJ7FHRl1LEFZNDihmTTVjTpI8sC8wFz6dIN2rSBnOkl07/fdB6Rmy340ESE8KlGJZne89Nyrl2lIVMPAbhJp76FcFXtPqJMMrHF0YFw1RnE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ynSgutuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A02C4CEEB;
	Sat, 13 Sep 2025 12:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766392;
	bh=r2KKelfE/hxYOLtwK/iYWkh7Rx83PoV/lnFcAeNdaw0=;
	h=Subject:To:Cc:From:Date:From;
	b=ynSgutufV904X08TEjbY+S1jn+hS9SrUzvHv7XPsWQYgjb5vA2gVB7j6ayPn/8dtR
	 bYp9qHWDVAiCVppLBgzWiyhr2LvBKEY4KMZWwj6gfuLiLE+dFkKWCQLcQ+0PD9rZlQ
	 rqpV7rmtJ8pYwSYWoE+f454Dg32L7ocsPv2ViwpE=
Subject: FAILED: patch "[PATCH] mm/damon/sysfs: fix use-after-free in state_show()" failed to apply to 6.6-stable tree
To: stanislav.fort@aisle.com,akpm@linux-foundation.org,disclosure@aisle.com,sj@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:26:18 +0200
Message-ID: <2025091318-trombone-graduate-3828@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3260a3f0828e06f5f13fac69fb1999a6d60d9cff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091318-trombone-graduate-3828@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3260a3f0828e06f5f13fac69fb1999a6d60d9cff Mon Sep 17 00:00:00 2001
From: Stanislav Fort <stanislav.fort@aisle.com>
Date: Fri, 5 Sep 2025 13:10:46 +0300
Subject: [PATCH] mm/damon/sysfs: fix use-after-free in state_show()

state_show() reads kdamond->damon_ctx without holding damon_sysfs_lock.
This allows a use-after-free race:

CPU 0                         CPU 1
-----                         -----
state_show()                  damon_sysfs_turn_damon_on()
ctx = kdamond->damon_ctx;     mutex_lock(&damon_sysfs_lock);
                              damon_destroy_ctx(kdamond->damon_ctx);
                              kdamond->damon_ctx = NULL;
                              mutex_unlock(&damon_sysfs_lock);
damon_is_running(ctx);        /* ctx is freed */
mutex_lock(&ctx->kdamond_lock); /* UAF */

(The race can also occur with damon_sysfs_kdamonds_rm_dirs() and
damon_sysfs_kdamond_release(), which free or replace the context under
damon_sysfs_lock.)

Fix by taking damon_sysfs_lock before dereferencing the context, mirroring
the locking used in pid_show().

The bug has existed since state_show() first accessed kdamond->damon_ctx.

Link: https://lkml.kernel.org/r/20250905101046.2288-1-disclosure@aisle.com
Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spaces monitoring")
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
Reported-by: Stanislav Fort <disclosure@aisle.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6d2b0dab50cb..7b9254cadd5f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1260,14 +1260,18 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
 			struct damon_sysfs_kdamond, kobj);
-	struct damon_ctx *ctx = kdamond->damon_ctx;
-	bool running;
+	struct damon_ctx *ctx;
+	bool running = false;
 
-	if (!ctx)
-		running = false;
-	else
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+
+	ctx = kdamond->damon_ctx;
+	if (ctx)
 		running = damon_is_running(ctx);
 
+	mutex_unlock(&damon_sysfs_lock);
+
 	return sysfs_emit(buf, "%s\n", running ?
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_ON] :
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_OFF]);


