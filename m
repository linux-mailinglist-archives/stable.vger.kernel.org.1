Return-Path: <stable+bounces-66428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8AE94E9C7
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1866C1F22E03
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 09:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E12D16CD19;
	Mon, 12 Aug 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VR9Qo1EO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070A20323
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454892; cv=none; b=t4b0i8j1lT3US8uUcxvZMVCfKlWiOhv20r8U80z5CjTOD6ts5avvsszQrYVX3V80039dZm4HlEq1xpMuohvEFSv8wTUEOAUMkCX/mX0ZWMmeI0ESq9EWbb4Ga9Ytq8H2tJXmFgwr5jkrnqAo/IwXYxabjBJTv1oR45bVUvlbRG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454892; c=relaxed/simple;
	bh=IMmcMtU5fk66IHIQRUmsvE6ldp2EaaakuHoo/HoFJrg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RtD6RM2zXQcd6YSEXHSDQ6WZU4ulNi4/2atKpzTqmkMHvKXElMsyMF4S7OGzYFh6loklBp2jrHe6edUTo6PrrhllthpHmUIa6V69bmdEouiaKYk9da+wr8UqbNkgpJuEWYmo6mNCOi9JG7lWD8zKdje+qLXZ9TSBLfwMLRUirvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VR9Qo1EO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46433C32782;
	Mon, 12 Aug 2024 09:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723454892;
	bh=IMmcMtU5fk66IHIQRUmsvE6ldp2EaaakuHoo/HoFJrg=;
	h=Subject:To:Cc:From:Date:From;
	b=VR9Qo1EOrrbEL/KRhqONwdQw6sVRI5NbW5A0d6CiLCxYSE1c4djslLzYPY3NxPTMb
	 Tt/HaNZhs8itPxmg9ejUYz9NzPCQ+J4iFROJEi3qweEVbH/1JS4mDE1fDxTrBMY98j
	 5Lyv3vN3Z9L12KPPaogbSvVMjg6Ok5RGy61L6eEA=
Subject: FAILED: patch "[PATCH] drm/xe: Fix NULL ptr dereference in devcoredump" failed to apply to 5.4-stable tree
To: matthew.brost@intel.com,jose.souza@intel.com,rodrigo.vivi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 11:27:55 +0200
Message-ID: <2024081255-oversight-parasail-1af6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x f2bf9e95989c0163650dbeaede658d0fcf929063
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081255-oversight-parasail-1af6@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


