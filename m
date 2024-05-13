Return-Path: <stable+bounces-43660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9358C4274
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EC31C20F3D
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F252153572;
	Mon, 13 May 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="onIK9uRC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E629153511
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607985; cv=none; b=Y5kqTIb4vG7bYsfVcKgeHarxcZAoztfkElH64q42E41K+tpIwoqGrPMAbIlTG2ONci8dc5IuP7b00x3ZLv+rM3zJniNWuj3SU4PvN7B+kMuqFvtsC+qQsWxupM6ITNxLL3BjFWiAz3JpZi3IWSENJeRcs6eaPrWki+bx1+Sz9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607985; c=relaxed/simple;
	bh=QgGzJ/yRa6x5VWFqEG75Fke+VJBulfzwMLhiiq13OGU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FyTVtWyjkZ0tAJkhITGLr5MjCnYGn6Yw+/dHaTdMLDCM/hmHrMFqfVey/fN8bOgtSmD+uHYn8U4TKG9hicUIuB56/+cuNorSEaTkHnRvJylHLf9+9uKf5ozD+qceGZ+LZT9ooyecStmAXktE2eiAcK5ALI0IYRxS18/jnatiswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=onIK9uRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E61C4AF07;
	Mon, 13 May 2024 13:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715607984;
	bh=QgGzJ/yRa6x5VWFqEG75Fke+VJBulfzwMLhiiq13OGU=;
	h=Subject:To:Cc:From:Date:From;
	b=onIK9uRCtxe3gkZ2Y+Dkkj5VtXWqig0VUOcPVE72HjeCW4HTwoa5vSjYWNQsmkWVA
	 STRsVfWyKXomqDze8ytGDhn9NgcDtp/7MjQbRxPQsaVs/3Q/khHAid7kOjcJtNlMKM
	 DYpDQ6CvCGcfUhN77EwRW5+Mk7pnGrEDBwPLA2L4=
Subject: FAILED: patch "[PATCH] drm/xe/vm: prevent UAF in rebind_work_func()" failed to apply to 6.8-stable tree
To: matthew.auld@intel.com,lucas.demarchi@intel.com,matthew.brost@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:46:21 +0200
Message-ID: <2024051321-bonehead-slang-4a7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x 98957360563e7ffdc0c2b3a314655eff8bc1cb5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051321-bonehead-slang-4a7c@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

98957360563e ("drm/xe/vm: prevent UAF in rebind_work_func()")
0eb2a18a8fad ("drm/xe: Implement VM snapshot support for BO's and userptr")
be7d51c5b468 ("drm/xe: Add batch buffer addresses to devcoredump")
4376cee62092 ("drm/xe: Print more device information in devcoredump")
98fefec8c381 ("drm/xe: Change devcoredump functions parameters to xe_sched_job")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 98957360563e7ffdc0c2b3a314655eff8bc1cb5a Mon Sep 17 00:00:00 2001
From: Matthew Auld <matthew.auld@intel.com>
Date: Tue, 23 Apr 2024 08:47:23 +0100
Subject: [PATCH] drm/xe/vm: prevent UAF in rebind_work_func()

We flush the rebind worker during the vm close phase, however in places
like preempt_fence_work_func() we seem to queue the rebind worker
without first checking if the vm has already been closed.  The concern
here is the vm being closed with the worker flushed, but then being
rearmed later, which looks like potential uaf, since there is no actual
refcounting to track the queued worker. We can't take the vm->lock here
in preempt_rebind_work_func() to first check if the vm is closed since
that will deadlock, so instead flush the worker again when the vm
refcount reaches zero.

v2:
 - Grabbing vm->lock in the preempt worker creates a deadlock, so
   checking the closed state is tricky. Instead flush the worker when
   the refcount reaches zero. It should be impossible to queue the
   preempt worker without already holding vm ref.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1676
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1591
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1364
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1304
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1249
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240423074721.119633-4-matthew.auld@intel.com
(cherry picked from commit 3d44d67c441a9fe6f81a1d705f7de009a32a5b35)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 3d4c8f342e21..32cd0c978aa2 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1606,6 +1606,9 @@ static void vm_destroy_work_func(struct work_struct *w)
 	/* xe_vm_close_and_put was not called? */
 	xe_assert(xe, !vm->size);
 
+	if (xe_vm_in_preempt_fence_mode(vm))
+		flush_work(&vm->preempt.rebind_work);
+
 	mutex_destroy(&vm->snap_mutex);
 
 	if (!(vm->flags & XE_VM_FLAG_MIGRATION))


