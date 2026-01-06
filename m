Return-Path: <stable+bounces-205106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 53954CF9011
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84CB53008769
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37233890E;
	Tue,  6 Jan 2026 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ys85iGCk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE75338905
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712506; cv=none; b=caj2LyQlrJMOs5JqQcvsresCXqJw12VPXHhE0oOnHYr0uFjH4nJXtamTH9CyrmRM+BLaIM+gGrPRDaHub+6t5SCDr5TmdvClwHPAYa/d7eGPq36JWbNe5LN5ceu6mSE97kPJmylhmqfpZmzXaBuZZB7ydcnAOyPcXu6Z5ym3hxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712506; c=relaxed/simple;
	bh=QT1EZcdvG1OK72aeh5rUjY876hqk69SV9DGMDxV18YA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tqvXG8j1dP41uXRD6IEnDAuYnZ1Itb+xFDImdYELbTQXHeVMTfEtcuFOggQKdZPqflM1dLT9KNPBLDC44ikFmckqxrY/RSBHX0Z87vnitmJlOW4yzmfrJZq7+rxF6JTugh+ved2NOV0V7M+hR5CJ6GUdG5BMxZdH9xc7tfVnePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ys85iGCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657BFC116C6;
	Tue,  6 Jan 2026 15:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767712505;
	bh=QT1EZcdvG1OK72aeh5rUjY876hqk69SV9DGMDxV18YA=;
	h=Subject:To:Cc:From:Date:From;
	b=Ys85iGCkj9z30Y63sDqsAQKnkXXodm4QG9V+RK/WraHknMdvTJ7/LypBmx9Xz4iKv
	 dMPv8oW3S2RBMa8/SZ2vdB52e+yBP3EtBi4ZVyCBY3pT1X94tz2O93f9mO44UtUSyd
	 kYiEgWarPMX1Ey5Ug4lYKIk1yw80dO8sZpsiL5oU=
Subject: FAILED: patch "[PATCH] firmware: stratix10-svc: Add mutex in stratix10 memory" failed to apply to 5.15-stable tree
To: mahesh.rao@altera.com,dinguyen@kernel.org,matthew.gerlach@altera.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Jan 2026 16:14:54 +0100
Message-ID: <2026010654-kimono-starlight-7676@gregkh>
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
git cherry-pick -x 85f96cbbbc67b59652b2c1ec394b8ddc0ddf1b0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010654-kimono-starlight-7676@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85f96cbbbc67b59652b2c1ec394b8ddc0ddf1b0b Mon Sep 17 00:00:00 2001
From: Mahesh Rao <mahesh.rao@altera.com>
Date: Mon, 27 Oct 2025 22:54:40 +0800
Subject: [PATCH] firmware: stratix10-svc: Add mutex in stratix10 memory
 management

Add mutex lock to stratix10_svc_allocate_memory and
stratix10_svc_free_memory for thread safety. This prevents race
conditions and ensures proper synchronization during memory operations.
This is required for parallel communication with the Stratix10 service
channel.

Fixes: 7ca5ce896524f ("firmware: add Intel Stratix10 service layer driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 5a32c1054bee..9372a17d89b7 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017-2018, Intel Corporation
+ * Copyright (C) 2025, Altera Corporation
  */
 
 #include <linux/completion.h>
@@ -172,6 +173,12 @@ struct stratix10_svc_chan {
 static LIST_HEAD(svc_ctrl);
 static LIST_HEAD(svc_data_mem);
 
+/**
+ * svc_mem_lock protects access to the svc_data_mem list for
+ * concurrent multi-client operations
+ */
+static DEFINE_MUTEX(svc_mem_lock);
+
 /**
  * svc_pa_to_va() - translate physical address to virtual address
  * @addr: to be translated physical address
@@ -184,6 +191,7 @@ static void *svc_pa_to_va(unsigned long addr)
 	struct stratix10_svc_data_mem *pmem;
 
 	pr_debug("claim back P-addr=0x%016x\n", (unsigned int)addr);
+	guard(mutex)(&svc_mem_lock);
 	list_for_each_entry(pmem, &svc_data_mem, node)
 		if (pmem->paddr == addr)
 			return pmem->vaddr;
@@ -1002,6 +1010,7 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 			p_data->flag = ct->flags;
 		}
 	} else {
+		guard(mutex)(&svc_mem_lock);
 		list_for_each_entry(p_mem, &svc_data_mem, node)
 			if (p_mem->vaddr == p_msg->payload) {
 				p_data->paddr = p_mem->paddr;
@@ -1084,6 +1093,7 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 	if (!pmem)
 		return ERR_PTR(-ENOMEM);
 
+	guard(mutex)(&svc_mem_lock);
 	va = gen_pool_alloc(genpool, s);
 	if (!va)
 		return ERR_PTR(-ENOMEM);
@@ -1112,6 +1122,7 @@ EXPORT_SYMBOL_GPL(stratix10_svc_allocate_memory);
 void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 {
 	struct stratix10_svc_data_mem *pmem;
+	guard(mutex)(&svc_mem_lock);
 
 	list_for_each_entry(pmem, &svc_data_mem, node)
 		if (pmem->vaddr == kaddr) {


