Return-Path: <stable+bounces-92000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672B99C2C5E
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 13:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8A5282E8E
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 12:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B1E13DDA7;
	Sat,  9 Nov 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XqgTMRgD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D673B192
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731153635; cv=none; b=rrV/Sk9vdKHo9f5SMkcsYeFZisp+rWZQrGwE1NdsWEC1bjEZ1lYJJqmLRU45JQXgLFOQcNA3vBo927kOYTpg7UFafBth+mxo9Ue8gmO5UaUzl1hOHmPsQhAUGwfaLj71cRLzcVNMlbuYQDn3tUJyCS7s9ofvP1imqcHy+hrGwyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731153635; c=relaxed/simple;
	bh=9SZqjUSgvfsTnMkIRM2lys7TjGlO6KJ4HrFHefsEDNg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R2OgCMGbTvSzhDOAwBzX5OJyjXGBAT80q3GHa3M68VNTz1ZmS+5NTyq2ynYNAR00qJUi/aNJf5mPCOzf55lwjT28KzJleODZvSUzSQdm8g8RV9bufyN6+t9Ih/jeQWqkrf+LO2DE5ArFCaQyr6VeLFOhywl6C58mzq9d0J4ROy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XqgTMRgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80680C4CECE;
	Sat,  9 Nov 2024 12:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731153634;
	bh=9SZqjUSgvfsTnMkIRM2lys7TjGlO6KJ4HrFHefsEDNg=;
	h=Subject:To:Cc:From:Date:From;
	b=XqgTMRgD1Sx7twNWhYWBTW3rlKhUBRVaDJkUnSxPcCkf2WV+1LlNN0cOyhRz2W796
	 2BZmO+nOGPeLMLw3Ie+Ww7KLPvLDGoH8lsLxR+ftbA72X3NNmZQX1YGq7g6doNz3j5
	 2gpLcZicNrndeyLejOzcvNz9gEFqLHEb54xHWEG4=
Subject: FAILED: patch "[PATCH] drm/xe/ufence: Flush xe ordered_wq in case of ufence timeout" failed to apply to 6.11-stable tree
To: nirmoy.das@intel.com,John.C.Harrison@Intel.com,badal.nilawar@intel.com,himal.prasad.ghimiray@intel.com,lucas.demarchi@intel.com,matthew.auld@intel.com,matthew.brost@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Nov 2024 13:00:30 +0100
Message-ID: <2024110930-partition-dislike-9711@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 7d1e2580ed166f36949b468373b468d188880cd3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110930-partition-dislike-9711@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7d1e2580ed166f36949b468373b468d188880cd3 Mon Sep 17 00:00:00 2001
From: Nirmoy Das <nirmoy.das@intel.com>
Date: Tue, 29 Oct 2024 13:01:16 +0100
Subject: [PATCH] drm/xe/ufence: Flush xe ordered_wq in case of ufence timeout

Flush xe ordered_wq in case of ufence timeout which is observed
on LNL and that points to recent scheduling issue with E-cores.

This is similar to the recent fix:
commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
response timeout") and should be removed once there is a E-core
scheduling fix for LNL.

v2: Add platform check(Himal)
    s/__flush_workqueue/flush_workqueue(Jani)
v3: Remove gfx platform check as the issue related to cpu
    platform(John)
v4: Use the Common macro(John) and print when the flush resolves
    timeout(Matt B)

Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: stable@vger.kernel.org # v6.11+
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241029120117.449694-2-nirmoy.das@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 38c4c8722bd74452280951edc44c23de47612001)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
index f5deb81eba01..5b4264ea38bd 100644
--- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
+++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
@@ -155,6 +155,13 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
 		}
 
 		if (!timeout) {
+			LNL_FLUSH_WORKQUEUE(xe->ordered_wq);
+			err = do_compare(addr, args->value, args->mask,
+					 args->op);
+			if (err <= 0) {
+				drm_dbg(&xe->drm, "LNL_FLUSH_WORKQUEUE resolved ufence timeout\n");
+				break;
+			}
 			err = -ETIME;
 			break;
 		}


