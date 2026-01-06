Return-Path: <stable+bounces-205105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04030CF9030
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88A5D300CA08
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D259832D0F9;
	Tue,  6 Jan 2026 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TNYKwqGb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B70230274
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712497; cv=none; b=qvNp1000j60v1WJn38/XiFVmdErwRh7kZSqsR4BOjx/7CZNY/wLq4qyhvQlZoTBm7luzYbnqxNhfvxWSSpS3L/AfAm2eiuyulLDl996EF6gKk7CYpuoP5mzje/7AEPeiC2WxiK1USisLaMNf+GX2UOQAuwEqT7fjZpF1Q61Pacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712497; c=relaxed/simple;
	bh=agIoE6KxS2Z/1NDofuHZ1CPuIN73HC3YjV1lqzs4ZDc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C/6GKEKbQD3m5dAI3nZqtsPFeLNq3b5+wmhXg2P7wgA50ovz5RQx8YKjW3hICRdYQWYO6XQ8uoSWdATjwytarfJp2aFC3cgZS7gL+6PcybXXTSCrCC2Gy1T7Cvv4/glXE2kTfuBU42+aFLmRBL/Ra9E9fASpSBEzIu21tbLAnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TNYKwqGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E284EC16AAE;
	Tue,  6 Jan 2026 15:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767712497;
	bh=agIoE6KxS2Z/1NDofuHZ1CPuIN73HC3YjV1lqzs4ZDc=;
	h=Subject:To:Cc:From:Date:From;
	b=TNYKwqGb4l2yd7Sx4qNj/JRlDEgdwwptW5u8l4aNYzmZ4PMKQya8uCJXh2N3zqTkx
	 dya/KCdqGRmDSgRry97ZqB3nw9CNyAU10TDe3tATaV2J8nled/iFUcTtJB3+PHLLbB
	 jbevxBQnEbPWiWvdLu64/WTNKvz+wzpllY2bDMgs=
Subject: FAILED: patch "[PATCH] firmware: stratix10-svc: Add mutex in stratix10 memory" failed to apply to 5.10-stable tree
To: mahesh.rao@altera.com,dinguyen@kernel.org,matthew.gerlach@altera.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Jan 2026 16:14:54 +0100
Message-ID: <2026010654-universe-wrongly-32af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 85f96cbbbc67b59652b2c1ec394b8ddc0ddf1b0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010654-universe-wrongly-32af@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


