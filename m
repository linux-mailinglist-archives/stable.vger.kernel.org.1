Return-Path: <stable+bounces-66427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5135794E9C6
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D041281A86
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B4D16D4D9;
	Mon, 12 Aug 2024 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pkqydhf7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F4220323
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454889; cv=none; b=IgXilU4ZX3UYVAK7X4E25khY4Icohw6IWOTJeG/oYZtwX0OyP/u45Rnp+w5Zj5ZN2dhPWVfWxTJv40ijgvqMJNUxIi9Q5ceZC0G4CLtCmOTRHeNhT7gCHZoZohOBdNPuKCcrFmwy8n/NDl4sxWK7feYo8NhzhzAEOAgkiMT/rIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454889; c=relaxed/simple;
	bh=xz8FFyAkY3RHo/VlIA6FV/tLUb+q5db+n/+CbzUYKqE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Yuf3/h2bwKHdNr9CLR5SbySip6eJv5I78fTek95ltERBVtf3ypR+g0D2O0qrnps671QxO7cQGotOWsmNNMOPYUVBLtIbu51zcbtQ0H24q7dGaR03GyJ6C1aGanjkwov+1bC5NpO345MPwocf/m0mNON4p5a6wvfoI+IsBmILoYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pkqydhf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C5EC32782;
	Mon, 12 Aug 2024 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723454889;
	bh=xz8FFyAkY3RHo/VlIA6FV/tLUb+q5db+n/+CbzUYKqE=;
	h=Subject:To:Cc:From:Date:From;
	b=Pkqydhf70MR+SZPLNVwROvFDMMskh20NKrJInLUDD4BKlDALmG0NwBUvJmE11+B/r
	 NxMjLMh+f5cPIpAUKOGBQ0aA/qvJ/8uQ5TDmMAJS6rSiedoJrLBNczr3T8E6aJJ+Q6
	 ta2XZwZzVte26C4e99lmHILhxItmI/J0KdbOQy1w=
Subject: FAILED: patch "[PATCH] drm/xe: Fix NULL ptr dereference in devcoredump" failed to apply to 5.15-stable tree
To: matthew.brost@intel.com,jose.souza@intel.com,rodrigo.vivi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 11:27:54 +0200
Message-ID: <2024081253-trombone-brim-cbae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f2bf9e95989c0163650dbeaede658d0fcf929063
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081253-trombone-brim-cbae@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

f2bf9e95989c ("drm/xe: Fix NULL ptr dereference in devcoredump")
b10d0c5e9df7 ("drm/xe: Add process name to devcoredump")
0eb2a18a8fad ("drm/xe: Implement VM snapshot support for BO's and userptr")
be7d51c5b468 ("drm/xe: Add batch buffer addresses to devcoredump")
4376cee62092 ("drm/xe: Print more device information in devcoredump")
98fefec8c381 ("drm/xe: Change devcoredump functions parameters to xe_sched_job")
eb9702ad2986 ("drm/xe: Allow num_batch_buffer / num_binds == 0 in IOCTLs")
53bf60f6d850 ("drm/xe: Use a flags field instead of bools for sync parse")
37d078e51b4c ("drm/xe/uapi: Split xe_sync types from flags")
fdb6a05383fa ("drm/xe: Internally change the compute_mode and no_dma_fence mode naming")
3ac4a7896d1c ("drm/xe/uapi: Add _FLAG to uAPI constants usable for flags")
d5dc73dbd148 ("drm/xe/uapi: Add missing DRM_ prefix in uAPI constants")
be13336e07b5 ("drm/xe/pmu: Drop interrupt pmu event")
60f3c7fc5c24 ("drm/xe/uapi: Remove unused QUERY_CONFIG_GT_COUNT")
4195e5e5e3d5 ("drm/xe/uapi: Remove unused QUERY_CONFIG_MEM_REGION_COUNT")
1a912c90a278 ("drm/xe/uapi: Remove GT_TYPE_REMOTE")
de84aa96e442 ("drm/xe/uapi: Remove useless XE_QUERY_CONFIG_NUM_PARAM")
44e694958b95 ("drm/xe/display: Implement display support")
571622740288 ("drm/xe: implement driver initiated function-reset")
b8d70702def2 ("drm/xe/xe_exec_queue: Add check for access counter granularity")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2bf9e95989c0163650dbeaede658d0fcf929063 Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Thu, 30 May 2024 13:33:41 -0700
Subject: [PATCH] drm/xe: Fix NULL ptr dereference in devcoredump
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Kernel VM do not have an Xe file. Include a check for Xe file in the VM
before trying to get pid from VM's Xe file when taking a devcoredump.

Fixes: b10d0c5e9df7 ("drm/xe: Add process name to devcoredump")
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: José Roberto de Souza <jose.souza@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240530203341.1795181-1-matthew.brost@intel.com

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 1973bfaece40..d7f2d19a77c1 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -176,7 +176,7 @@ static void devcoredump_snapshot(struct xe_devcoredump *coredump,
 	ss->snapshot_time = ktime_get_real();
 	ss->boot_time = ktime_get_boottime();
 
-	if (q->vm) {
+	if (q->vm && q->vm->xef) {
 		task = get_pid_task(q->vm->xef->drm->pid, PIDTYPE_PID);
 		if (task)
 			process_name = task->comm;


