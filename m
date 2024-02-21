Return-Path: <stable+bounces-22038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554D585D9D2
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F711F236D9
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAD979DBF;
	Wed, 21 Feb 2024 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xDcSA8sp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689CD53816;
	Wed, 21 Feb 2024 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521764; cv=none; b=mNdOYhNDz7yxZcwTkORazSy1poqOd0q+GV4TSTWkBI3zeD7L4O4zF+aYbgOzZL7Zm8uSxXo0Vjh++vpPLfnZMeA7CgncHZxflL0jfiuOG4eeo2FDSGdxRkjNF3ZfIXFWrIJDm2Xd4LhVR0ks16QrFgZyfdXXRw0kjKwgbza6kTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521764; c=relaxed/simple;
	bh=UekCm42itF3nhu4rOr3znNG0KnI+RyAFbyzxDPIRHbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+gtthlyJ8IZrhVdOMc/hClwA4NLI++mrBlB8P9Mbc8r0+YqogEusLZB9G4rnwXkzUNo0W6krm3jr7axvWExY9YPxEWX3qo6PxST1DLNmKXvwItsGbVgHpeBzNbI+ruLWW7mAl5EcI/u/gA9Q8iEaFnEeAFAvOGL2AWUeGrhHkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xDcSA8sp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2920C433F1;
	Wed, 21 Feb 2024 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708521764;
	bh=UekCm42itF3nhu4rOr3znNG0KnI+RyAFbyzxDPIRHbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xDcSA8spxwxqv+MOgzKtNc5fyTQ+Cseaw3LWuQ2TUkvr+R83gVlmyvJonbWnC1Uc+
	 7gpbeGeeXt5tqbiolZ5zKQFw53e7ob2iSBX4lZQpY3mjKMWbM1TNrIxX6bhMgVDcJg
	 YQvkPF5jJORtaZQXSjKJyhjOQoGHGC3Kvrp+zQok=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 4.19 198/202] sched/membarrier: reduce the ability to hammer on sys_membarrier
Date: Wed, 21 Feb 2024 14:08:19 +0100
Message-ID: <20240221125938.189914810@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125931.742034354@linuxfoundation.org>
References: <20240221125931.742034354@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linuxfoundation.org>

commit 944d5fe50f3f03daacfea16300e656a1691c4a23 upstream.

On some systems, sys_membarrier can be very expensive, causing overall
slowdowns for everything.  So put a lock on the path in order to
serialize the accesses to prevent the ability for this to be called at
too high of a frequency and saturate the machine.

Reviewed-and-tested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Borislav Petkov <bp@alien8.de>
Fixes: 22e4ebb97582 ("membarrier: Provide expedited private command")
Fixes: c5f58bd58f43 ("membarrier: Provide GLOBAL_EXPEDITED command")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[ converted to explicit mutex_*() calls - cleanup.h is not in this stable
  branch - gregkh ]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/membarrier.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -34,6 +34,8 @@
 	| MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED			\
 	| MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK)
 
+static DEFINE_MUTEX(membarrier_ipi_mutex);
+
 static void ipi_mb(void *info)
 {
 	smp_mb();	/* IPIs should be serializing but paranoid. */
@@ -64,6 +66,7 @@ static int membarrier_global_expedited(v
 		fallback = true;
 	}
 
+	mutex_lock(&membarrier_ipi_mutex);
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		struct task_struct *p;
@@ -104,6 +107,7 @@ static int membarrier_global_expedited(v
 	 * rq->curr modification in scheduler.
 	 */
 	smp_mb();	/* exit from system call is not a mb */
+	mutex_unlock(&membarrier_ipi_mutex);
 	return 0;
 }
 
@@ -144,6 +148,7 @@ static int membarrier_private_expedited(
 		fallback = true;
 	}
 
+	mutex_lock(&membarrier_ipi_mutex);
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		struct task_struct *p;
@@ -182,6 +187,7 @@ static int membarrier_private_expedited(
 	 * rq->curr modification in scheduler.
 	 */
 	smp_mb();	/* exit from system call is not a mb */
+	mutex_unlock(&membarrier_ipi_mutex);
 
 	return 0;
 }



