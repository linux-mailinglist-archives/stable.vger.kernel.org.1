Return-Path: <stable+bounces-163547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EBDB0C1D3
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 12:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB16C18C328F
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 10:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865D327FB05;
	Mon, 21 Jul 2025 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FTV3RrwQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0221A457
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095277; cv=none; b=sUeRQR4BabL6Et8RCeFvMOFOxKqitnjXZpcHBZO4/ilVfuq/kwLC13sa0znvnaoiWW8HWdGg5L6FH8cXY9zby1ECeiQBU3PsvpDhgtLCABT0n7RUj/4Fs1UEUrJlZFHKXayWoSThWiWpWH0a8YYZ1T1+FCNh+FxjGeDktUDxw48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095277; c=relaxed/simple;
	bh=c90N5gSf/59ExX0LOYNx+FGXNjLXY2Yoi59ILa1xzVk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C9OcLl8t1aD4qpMWqwy3XZnq4mBPOAX8xKFG8c3rJvk9uBtRhm/LKlwpScezQSjvHt8qn1oiRGuwJS00ixzXLMFGAecJ3Rb1FRp+ArZb1OPkeZi287rrag7/mDaXgl+9J+d6WYpqJPj+LQkdLY80NhDaBkAewrM4KgX5hCgeBUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FTV3RrwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E14C4CEED;
	Mon, 21 Jul 2025 10:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753095276;
	bh=c90N5gSf/59ExX0LOYNx+FGXNjLXY2Yoi59ILa1xzVk=;
	h=Subject:To:Cc:From:Date:From;
	b=FTV3RrwQQKYiz//G6Wvd3WHeX4F94MMbz4QYm+HIn8f+ld4RtFhhy0sOUDYP1njYQ
	 5gNx6FHoU/Bne1ADHY7jUPa+VF55LNYf4DXytuXgVhVtruF9rzMPphxX4vfOzl2B71
	 0X2qVA3x33swTHF49rtJpLDC7O4pIIFyIhCEsFkY=
Subject: FAILED: patch "[PATCH] sched/ext: Prevent update_locked_rq() calls with NULL rq" failed to apply to 6.15-stable tree
To: leitao@debian.org,arighi@nvidia.com,peterz@infradead.org,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 12:54:33 +0200
Message-ID: <2025072133-babble-buddhist-9fbe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x e14fd98c6d66cb76694b12c05768e4f9e8c95664
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072133-babble-buddhist-9fbe@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e14fd98c6d66cb76694b12c05768e4f9e8c95664 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Wed, 16 Jul 2025 10:38:48 -0700
Subject: [PATCH] sched/ext: Prevent update_locked_rq() calls with NULL rq

Avoid invoking update_locked_rq() when the runqueue (rq) pointer is NULL
in the SCX_CALL_OP and SCX_CALL_OP_RET macros.

Previously, calling update_locked_rq(NULL) with preemption enabled could
trigger the following warning:

    BUG: using __this_cpu_write() in preemptible [00000000]

This happens because __this_cpu_write() is unsafe to use in preemptible
context.

rq is NULL when an ops invoked from an unlocked context. In such cases, we
don't need to store any rq, since the value should already be NULL
(unlocked). Ensure that update_locked_rq() is only called when rq is
non-NULL, preventing calling __this_cpu_write() on preemptible context.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Fixes: 18853ba782bef ("sched_ext: Track currently locked rq")
Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org # v6.15

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d867ba21..7dd5cbcb7a06 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1272,7 +1272,8 @@ static inline struct rq *scx_locked_rq(void)
 
 #define SCX_CALL_OP(sch, mask, op, rq, args...)					\
 do {										\
-	update_locked_rq(rq);							\
+	if (rq)									\
+		update_locked_rq(rq);						\
 	if (mask) {								\
 		scx_kf_allow(mask);						\
 		(sch)->ops.op(args);						\
@@ -1280,14 +1281,16 @@ do {										\
 	} else {								\
 		(sch)->ops.op(args);						\
 	}									\
-	update_locked_rq(NULL);							\
+	if (rq)									\
+		update_locked_rq(NULL);						\
 } while (0)
 
 #define SCX_CALL_OP_RET(sch, mask, op, rq, args...)				\
 ({										\
 	__typeof__((sch)->ops.op(args)) __ret;					\
 										\
-	update_locked_rq(rq);							\
+	if (rq)									\
+		update_locked_rq(rq);						\
 	if (mask) {								\
 		scx_kf_allow(mask);						\
 		__ret = (sch)->ops.op(args);					\
@@ -1295,7 +1298,8 @@ do {										\
 	} else {								\
 		__ret = (sch)->ops.op(args);					\
 	}									\
-	update_locked_rq(NULL);							\
+	if (rq)									\
+		update_locked_rq(NULL);						\
 	__ret;									\
 })
 


