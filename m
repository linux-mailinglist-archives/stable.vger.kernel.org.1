Return-Path: <stable+bounces-66491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE30694EC4E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F3B282E52
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019EE14B95B;
	Mon, 12 Aug 2024 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2fX3t4mp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44361366
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464283; cv=none; b=XjLRAhEUG9Od/0lkMHqhLv1nSADQ6dicU1/WFJ5bO3Fer/hXXZ52AD1WZRvslJjfGnmUpok4KzzFzOSwdevCMpv0MXmlmN/5RwRXITZymCLszUH+FHTWoyX0wXSWgv6mMiQ9SsdQyoIw9t0WopofkzcruEoX5wxSoFHGbykwP0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464283; c=relaxed/simple;
	bh=/WXuaObBNSRGzjruQutCmJJ5RsnylfgXiuZAuydl8B0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RFu6xHGpyXibkJf+iMNo2X4hLeTSIgbcw4qT8KX0NTp/v2gfEgvRlzkDuzzS2qkQ33zfhkfZKft30JryMd0/lK6U5lnriI++8qJB578GarU0scsW2v8BP+PtyUH5qYSxq69BjQ4RBUxGL7wSipJbT45kLet1toOLBDtbOU3S1yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2fX3t4mp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F3CC32782;
	Mon, 12 Aug 2024 12:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723464283;
	bh=/WXuaObBNSRGzjruQutCmJJ5RsnylfgXiuZAuydl8B0=;
	h=Subject:To:Cc:From:Date:From;
	b=2fX3t4mpNzQBq83Rq6S57/owe+msAqTqXVWx7gDrZ+7BN1YqFQnmrGRjs1dfnLaXL
	 C8gn1ofMloBVO8goABKQKgxFpd23aK2CTmug1AXdA7zsM7WsTvjiHYqOwhuJ7MWEX+
	 e6cikh15xs7gzp5wNLEhdgZYEmGIu0K0znrHJQUE=
Subject: FAILED: patch "[PATCH] drm/xe/vm: prevent UAF in rebind_work_func()" failed to apply to 6.10-stable tree
To: matthew.auld@intel.com,matthew.brost@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:04:40 +0200
Message-ID: <2024081239-constant-defrost-6ddf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3d44d67c441a9fe6f81a1d705f7de009a32a5b35
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081239-constant-defrost-6ddf@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

3d44d67c441a ("drm/xe/vm: prevent UAF in rebind_work_func()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3d44d67c441a9fe6f81a1d705f7de009a32a5b35 Mon Sep 17 00:00:00 2001
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

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 633485c8c62b..dc685bf45857 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1504,6 +1504,9 @@ static void vm_destroy_work_func(struct work_struct *w)
 	/* xe_vm_close_and_put was not called? */
 	xe_assert(xe, !vm->size);
 
+	if (xe_vm_in_preempt_fence_mode(vm))
+		flush_work(&vm->preempt.rebind_work);
+
 	mutex_destroy(&vm->snap_mutex);
 
 	if (!(vm->flags & XE_VM_FLAG_MIGRATION))


