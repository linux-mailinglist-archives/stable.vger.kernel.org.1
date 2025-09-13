Return-Path: <stable+bounces-179459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487AFB560C5
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75BA1896B61
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E388287248;
	Sat, 13 Sep 2025 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v/lWZvhB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7BBDDD2
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766362; cv=none; b=aUONbyoPOPztjS4dX97riJKvYVC282JnMg189LMWQkgNJ7Z3hiF/K9kYJ3UHhSU+GIVJK2prd6FLQE8ucJ448ux1WkfAf0EbN0SBZaOiMq85klLJBtPzS2gMzy2Y2jT8ss/FYzEwqfA56eDkGalQ5sCVQW6c/mxCUNV2jyC9kLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766362; c=relaxed/simple;
	bh=u13NF5J2k++Tf3tFZgfdf+bC6ZnGJP6ee2Tbs5aWZjc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cccFa6NjS5k9m+CMXuObnKSLpA5XxozuHZv3Pn479msT9MKRsThLtxAcPZMHyz5ipNIbCT2vmi/XeSQ4kh4Lb0n5n7id8d3MuiIdU8/rpIwYaYkZrKMdQ3w2rBSw3/CnsqTq5AX1JYylUrVclJDlZCWsfEmyxhRHkhd3jMjg5rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v/lWZvhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AEBC4CEEB;
	Sat, 13 Sep 2025 12:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766360;
	bh=u13NF5J2k++Tf3tFZgfdf+bC6ZnGJP6ee2Tbs5aWZjc=;
	h=Subject:To:Cc:From:Date:From;
	b=v/lWZvhBJbWNtAXKsT3Qf60hvF167SniUILbQr5NKV337aS4vGQ7otR34JARZDrxL
	 8MHu3dbRL/F6kOdZVj9pVTgPkM65msEX7wy2lewM5QoFLwXq7pZtzyhKoDY0iBQ2pO
	 8ubG3B/tK61EikPHZXgtMjxrHavaoJvTCXZ47G7U=
Subject: FAILED: patch "[PATCH] mm/damon/core: set quota->charged_from to jiffies at first" failed to apply to 5.15-stable tree
To: ekffu200098@gmail.com,akpm@linux-foundation.org,sj@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:25:57 +0200
Message-ID: <2025091357-stapling-walrus-d0f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ce652aac9c90a96c6536681d17518efb1f660fb8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091357-stapling-walrus-d0f7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ce652aac9c90a96c6536681d17518efb1f660fb8 Mon Sep 17 00:00:00 2001
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Fri, 22 Aug 2025 11:50:57 +0900
Subject: [PATCH] mm/damon/core: set quota->charged_from to jiffies at first
 charge window

Kernel initializes the "jiffies" timer as 5 minutes below zero, as shown
in include/linux/jiffies.h

 /*
 * Have the 32 bit jiffies value wrap 5 minutes after boot
 * so jiffies wrap bugs show up earlier.
 */
 #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

And jiffies comparison help functions cast unsigned value to signed to
cover wraparound

 #define time_after_eq(a,b) \
  (typecheck(unsigned long, a) && \
  typecheck(unsigned long, b) && \
  ((long)((a) - (b)) >= 0))

When quota->charged_from is initialized to 0, time_after_eq() can
incorrectly return FALSE even after reset_interval has elapsed.  This
occurs when (jiffies - reset_interval) produces a value with MSB=1, which
is interpreted as negative in signed arithmetic.

This issue primarily affects 32-bit systems because: On 64-bit systems:
MSB=1 values occur after ~292 million years from boot (assuming HZ=1000),
almost impossible.

On 32-bit systems: MSB=1 values occur during the first 5 minutes after
boot, and the second half of every jiffies wraparound cycle, starting from
day 25 (assuming HZ=1000)

When above unexpected FALSE return from time_after_eq() occurs, the
charging window will not reset.  The user impact depends on esz value at
that time.

If esz is 0, scheme ignores configured quotas and runs without any limits.

If esz is not 0, scheme stops working once the quota is exhausted.  It
remains until the charging window finally resets.

So, change quota->charged_from to jiffies at damos_adjust_quota() when it
is considered as the first charge window.  By this change, we can avoid
unexpected FALSE return from time_after_eq()

Link: https://lkml.kernel.org/r/20250822025057.1740854-1-ekffu200098@gmail.com
Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control") # 5.16
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 106ee8b0f2d5..c2e0b469fd43 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2111,6 +2111,10 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
 		return;
 
+	/* First charge window */
+	if (!quota->total_charged_sz && !quota->charged_from)
+		quota->charged_from = jiffies;
+
 	/* New charge window starts */
 	if (time_after_eq(jiffies, quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {


