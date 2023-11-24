Return-Path: <stable+bounces-1684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BBE7F80E1
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53AAF1C2158A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E4833CD1;
	Fri, 24 Nov 2023 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2WhjDZio"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47728DBB;
	Fri, 24 Nov 2023 18:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B079EC433C8;
	Fri, 24 Nov 2023 18:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852017;
	bh=896H0XAGbSfRAUjYaJtyQMorXgJs7j7IuMN/s5c2b1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2WhjDZioUmn4V0vejZ1GpluSL6/dWnMyeNsLgHlRdgpu620jRO/iaoDdvHNYHOIZr
	 7nL/2rObKIGOFTxsYQIcD24GiyXAkDxEeHIqHKqXKt2LmCr1autTmwodKEj4fOhPWh
	 DW00B4sJKfV3ubE3YyWAS4E7b66pNqXKCYAf/wJ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 186/372] mm/damon/sysfs: remove requested targets when online-commit inputs
Date: Fri, 24 Nov 2023 17:49:33 +0000
Message-ID: <20231124172016.665199381@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: SeongJae Park <sj@kernel.org>

commit 19467a950b49432a84bf6dbadbbb17bdf89418b7 upstream.

damon_sysfs_set_targets(), which updates the targets of the context for
online commitment, do not remove targets that removed from the
corresponding sysfs files.  As a result, more than intended targets of the
context can exist and hence consume memory and monitoring CPU resource
more than expected.

Fix it by removing all targets of the context and fill up again using the
user input.  This could cause unnecessary memory dealloc and realloc
operations, but this is not a hot code path.  Also, note that damon_target
is stateless, and hence no data is lost.

[sj@kernel.org: fix unnecessary monitoring results removal]
  Link: https://lkml.kernel.org/r/20231028213353.45397-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20231022210735.46409-2-sj@kernel.org
Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: <stable@vger.kernel.org>	[5.19.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/sysfs.c |   68 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2188,58 +2188,60 @@ destroy_targets_out:
 	return err;
 }
 
-/*
- * Search a target in a context that corresponds to the sysfs target input.
- *
- * Return: pointer to the target if found, NULL if not found, or negative
- * error code if the search failed.
- */
-static struct damon_target *damon_sysfs_existing_target(
-		struct damon_sysfs_target *sys_target, struct damon_ctx *ctx)
+static int damon_sysfs_update_target(struct damon_target *target,
+		struct damon_ctx *ctx,
+		struct damon_sysfs_target *sys_target)
 {
 	struct pid *pid;
-	struct damon_target *t;
+	struct damon_region *r, *next;
 
-	if (!damon_target_has_pid(ctx)) {
-		/* Up to only one target for paddr could exist */
-		damon_for_each_target(t, ctx)
-			return t;
-		return NULL;
-	}
+	if (!damon_target_has_pid(ctx))
+		return 0;
 
-	/* ops.id should be DAMON_OPS_VADDR or DAMON_OPS_FVADDR */
 	pid = find_get_pid(sys_target->pid);
 	if (!pid)
-		return ERR_PTR(-EINVAL);
-	damon_for_each_target(t, ctx) {
-		if (t->pid == pid) {
-			put_pid(pid);
-			return t;
-		}
+		return -EINVAL;
+
+	/* no change to the target */
+	if (pid == target->pid) {
+		put_pid(pid);
+		return 0;
 	}
-	put_pid(pid);
-	return NULL;
+
+	/* remove old monitoring results and update the target's pid */
+	damon_for_each_region_safe(r, next, target)
+		damon_destroy_region(r, target);
+	put_pid(target->pid);
+	target->pid = pid;
+	return 0;
 }
 
 static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 		struct damon_sysfs_targets *sysfs_targets)
 {
-	int i, err;
+	struct damon_target *t, *next;
+	int i = 0, err;
 
 	/* Multiple physical address space monitoring targets makes no sense */
 	if (ctx->ops.id == DAMON_OPS_PADDR && sysfs_targets->nr > 1)
 		return -EINVAL;
 
-	for (i = 0; i < sysfs_targets->nr; i++) {
+	damon_for_each_target_safe(t, next, ctx) {
+		if (i < sysfs_targets->nr) {
+			damon_sysfs_update_target(t, ctx,
+					sysfs_targets->targets_arr[i]);
+		} else {
+			if (damon_target_has_pid(ctx))
+				put_pid(t->pid);
+			damon_destroy_target(t);
+		}
+		i++;
+	}
+
+	for (; i < sysfs_targets->nr; i++) {
 		struct damon_sysfs_target *st = sysfs_targets->targets_arr[i];
-		struct damon_target *t = damon_sysfs_existing_target(st, ctx);
 
-		if (IS_ERR(t))
-			return PTR_ERR(t);
-		if (!t)
-			err = damon_sysfs_add_target(st, ctx);
-		else
-			err = damon_sysfs_set_regions(t, st->regions);
+		err = damon_sysfs_add_target(st, ctx);
 		if (err)
 			return err;
 	}



