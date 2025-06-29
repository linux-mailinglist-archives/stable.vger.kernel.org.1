Return-Path: <stable+bounces-158855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74420AED10A
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 22:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7442B7A6829
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 20:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02F3239E60;
	Sun, 29 Jun 2025 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcizsm76"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9392823370A;
	Sun, 29 Jun 2025 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751230158; cv=none; b=bqilxHi78R2olBRBOO5AHXuhCBcSRz6AudPWif+svMT97umnlv4Yjus5Q2cm4yAUIjyw7qLoUb4+mYRx4GeXYA9+FkeYMEZ27FiWLEAPpLYVhsugVt+BFG7+wfGIhYs19RnTpDQs5wKujoM3t70Z1DKWx8hri7ddriBf7EPnavA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751230158; c=relaxed/simple;
	bh=XUP8lKIddKhAygDomeQIMUIjsYMoEKXPeWmno3HafKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b4HG9m3pEpQQ9iia1eiY3Jy6RmdaAnRMtGxyGQpCFxkkLNFG+AqZbrFPvGxzUTXtf0pbJYkpwnPYYn9P7Y8zk3D3RCORX88Dsf5vdX8MjQmHNMEdpjrYL+0VMT5qhyt0xbTIODbphDJTaIA139k1/IrbHLEDiLzpHBTrpU8xEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcizsm76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01386C4CEEB;
	Sun, 29 Jun 2025 20:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751230157;
	bh=XUP8lKIddKhAygDomeQIMUIjsYMoEKXPeWmno3HafKE=;
	h=From:To:Cc:Subject:Date:From;
	b=bcizsm76+XFW+2WXfnx4wgPXGwPvmvZRg0HKUj/aIbI6oh2PYfuRoZiWdBR0temqu
	 Ll51Lw7VzehYKidIL19nhQVMwY0Py66m+6TQ0HpdXOnOiUegArrdTn/Z2DY5UVHe7Q
	 wYjCn0eKQWvy9uM/pyukXLANGuTvwZuMKDlP57o1GE5T0s/5cHGfQ3qAi+MKnsszLS
	 5AlKfBHriydEIsRnH5czP52qqg1VBMxzdE9sQ7m2NFZg9yK2fKiGcUFhAL1nfE4F84
	 iZHzPK37hob/Pjnn6EUz6rSYcASW5S7ymn+gNHaLz3geOt6YFlUmdj0eXTGX9Wy6mI
	 ZWu6jznJ8kYeg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org, #@web.codeaurora.org,
	6.14.x@web.codeaurora.org
Subject: [PATCH] mm/damon/core: handle damon_call_control as normal under kdmond deactivation
Date: Sun, 29 Jun 2025 13:49:14 -0700
Message-Id: <20250629204914.54114-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface internally uses damon_call() to update DAMON
parameters as users requested, online.  However, DAMON core cancels any
damon_call() requests when it is deactivated by DAMOS watermarks.

As a result, users cannot change DAMON parameters online while DAMON is
deactivated.  Note that users can turn DAMON off and on with different
watermarks to work around.  Since deactivated DAMON is nearly same to
stopped DAMON, the work around should have no big problem.  Anyway, a
bug is a bug.

There is no real good reason to cancel the damon_call() request under
DAMOS deactivation.  Fix it by simply handling the request as normal,
rather than cancelling under the situation.

Fixes: 42b7491af14c ("mm/damon/core: introduce damon_call()")
Cc: stable@vger.kernel.org	# 6.14.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b217e0120e09..bc2e58c1222d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2355,9 +2355,8 @@ static void kdamond_usleep(unsigned long usecs)
  *
  * If there is a &struct damon_call_control request that registered via
  * &damon_call() on @ctx, do or cancel the invocation of the function depending
- * on @cancel.  @cancel is set when the kdamond is deactivated by DAMOS
- * watermarks, or the kdamond is already out of the main loop and therefore
- * will be terminated.
+ * on @cancel.  @cancel is set when the kdamond is already out of the main loop
+ * and therefore will be terminated.
  */
 static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 {
@@ -2405,7 +2404,7 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 		if (ctx->callback.after_wmarks_check &&
 				ctx->callback.after_wmarks_check(ctx))
 			break;
-		kdamond_call(ctx, true);
+		kdamond_call(ctx, false);
 		damos_walk_cancel(ctx);
 	}
 	return -EBUSY;

base-commit: 8f6082b6e60e05f9bcd5c39b19ede995a8975283
-- 
2.39.5

