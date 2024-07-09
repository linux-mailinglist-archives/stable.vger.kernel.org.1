Return-Path: <stable+bounces-58736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDC892B8A3
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055F4283C26
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F17915FA6B;
	Tue,  9 Jul 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUOHX/qD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cFxapXFO"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4429A15B552;
	Tue,  9 Jul 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525323; cv=none; b=MRbzWAADX2iYDQoUnbzsNUo4cjk0N+rAYz61Vy2PjM8XjyPKrUyfHXv03LDIlVvIM74nObBNJHahaHFXycdMTSLGIo3RSKbT01au7gaNgCKQd8BDLywsnAitdX2Opu7jf8SzKqfmghtEL4Uz+sttFLJAGdybj1+aXwLgjtUR4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525323; c=relaxed/simple;
	bh=rmnzK0csXWcu3533RtbCgWfiZOR/YeSFGUjBdPOcPlA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r3y2CjVHwJ89zwBJZAg7pV1WRwm+rqch5olgfm78IhhOq7bpsOrseFdQmgP6C1MEN9FF+/emoygFuxuBDfd6r5CuHTu/EQSzvYaEiXFBNdPyfhqsGwVTAvsCxtunos+jL6Yv9CIV13eI3ad0sy7Qscbp8ltEOP+I4LXOL1NQdO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUOHX/qD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFxapXFO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Jul 2024 11:42:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720525321;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwcZRyTOkADrXOilHmW/ybtQNSdElzRh/GVMhIPCRj8=;
	b=bUOHX/qDQB65g9SCmoTiofPrQcDJWgYwp27CaMxVHSJ6itF6LBRtLOuyPjsKGrH/QzcTLB
	YXCCyBGAJNmA+HYWTzcesugQznHj0cr4fGX28P55mbEh/saCG+3czgccMdcMxMCZAKjv3s
	4ozGhavdfHzTwvhhr+ua7P+/hrSBEYSJlcQlwe/Rg2DHt4qcmnN/P54cUsg3C3MHmh3dWF
	U64llKnLT1KU9Vv5lNWy4luNiS9Xt0bHUdnKa7GXcoR02pLHqV6lSjJ5aVdVpTF1coR66p
	i0iD7dEqAp4XIYNnXjBIqNP67u5TqGIgSVvOfZBjMAvWVed3bFR+aEb+DgnZ+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720525321;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwcZRyTOkADrXOilHmW/ybtQNSdElzRh/GVMhIPCRj8=;
	b=cFxapXFOLjYTPQeDY9AkvlKRjLMNUGjbgm1QnJpElQ9v3/KC28MhE5Q64Ku214bYZFhhNd
	f4ZmhR90fDFHPwDQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] task_work: Introduce task_work_cancel() again
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240621091601.18227-3-frederic@kernel.org>
References: <20240621091601.18227-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172052532057.2215.9290238042382588762.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f409530e4db9dd11b88cb7703c97c8f326ff6566
Gitweb:        https://git.kernel.org/tip/f409530e4db9dd11b88cb7703c97c8f326ff6566
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 21 Jun 2024 11:15:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Jul 2024 13:26:32 +02:00

task_work: Introduce task_work_cancel() again

Re-introduce task_work_cancel(), this time to cancel an actual callback
and not *any* callback pointing to a given function. This is going to be
needed for perf events event freeing.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240621091601.18227-3-frederic@kernel.org
---
 include/linux/task_work.h |  1 +
 kernel/task_work.c        | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 23ab01a..26b8a47 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -31,6 +31,7 @@ int task_work_add(struct task_struct *task, struct callback_head *twork,
 struct callback_head *task_work_cancel_match(struct task_struct *task,
 	bool (*match)(struct callback_head *, void *data), void *data);
 struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
+bool task_work_cancel(struct task_struct *task, struct callback_head *cb);
 void task_work_run(void);
 
 static inline void exit_task_work(struct task_struct *task)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 54ac240..2134ac8 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -136,6 +136,30 @@ task_work_cancel_func(struct task_struct *task, task_work_func_t func)
 	return task_work_cancel_match(task, task_work_func_match, func);
 }
 
+static bool task_work_match(struct callback_head *cb, void *data)
+{
+	return cb == data;
+}
+
+/**
+ * task_work_cancel - cancel a pending work added by task_work_add()
+ * @task: the task which should execute the work
+ * @cb: the callback to remove if queued
+ *
+ * Remove a callback from a task's queue if queued.
+ *
+ * RETURNS:
+ * True if the callback was queued and got cancelled, false otherwise.
+ */
+bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
+{
+	struct callback_head *ret;
+
+	ret = task_work_cancel_match(task, task_work_match, cb);
+
+	return ret == cb;
+}
+
 /**
  * task_work_run - execute the works added by task_work_add()
  *

