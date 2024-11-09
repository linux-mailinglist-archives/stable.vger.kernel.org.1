Return-Path: <stable+bounces-92001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5823F9C2C67
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 13:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0F91C21135
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C051465B1;
	Sat,  9 Nov 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W1SW0kPK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614013B192
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731153693; cv=none; b=tqLHwA08eUFCcVbafVNFw4+ds/5iqfhD8sQWVIHCdVf0O+0+7ov656LVYsO7kXfwCi7tehHVvTJTM99clzaUrjakuEkWX/Yo2DcqLxzgXcCzO7PovFXeJmpFzhROv+J8aGjREK+NE6Nng3UAlDO/libEnrynqCByQvYLzrohXLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731153693; c=relaxed/simple;
	bh=T10YmsHOj9ey8cKCwtF98jh24yxwzra0001TLdGKWJs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V45XI8Etls+bLAGSi3mXD72vHRt1NTDD+Sp1ZWwOzigC1U0BomDcgx9SsvAAotWEzUojO/Y8h9r6TwHSeSQoWe/+HJ5r4m9txZWF4b/08YImyQpRVswPkK/NO/ImBRhD8ZND2j/4oyarsL2HqH8rxY9MnQMH0Vo9/752GfRCsSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W1SW0kPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66169C4CECE;
	Sat,  9 Nov 2024 12:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731153692;
	bh=T10YmsHOj9ey8cKCwtF98jh24yxwzra0001TLdGKWJs=;
	h=Subject:To:Cc:From:Date:From;
	b=W1SW0kPK8mXyzGsOeco4fBQ3uu8epzmCgOAebp6yfvGiVk4CLknHTJPeTuIGoeqBo
	 ywP414k3lcZ9VXGrbhKCMcDljDng0ITwXMIahSnGXBzEU8fRWph+dR+U0isKb1315g
	 FCj2UxQmRFiTkmBwmnRK7yfsD/C9L8kf99WRJLnM=
Subject: FAILED: patch "[PATCH] drm/xe/guc/tlb: Flush g2h worker in case of tlb timeout" failed to apply to 6.11-stable tree
To: nirmoy.das@intel.com,John.C.Harrison@Intel.com,badal.nilawar@intel.com,himal.prasad.ghimiray@intel.com,lucas.demarchi@intel.com,matthew.auld@intel.com,matthew.brost@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Nov 2024 13:01:29 +0100
Message-ID: <2024110929-reveler-elevate-b941@gregkh>
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
git cherry-pick -x 1491efb39acee3848b61fcb3e5cc4be8de304352
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110929-reveler-elevate-b941@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1491efb39acee3848b61fcb3e5cc4be8de304352 Mon Sep 17 00:00:00 2001
From: Nirmoy Das <nirmoy.das@intel.com>
Date: Tue, 29 Oct 2024 13:01:17 +0100
Subject: [PATCH] drm/xe/guc/tlb: Flush g2h worker in case of tlb timeout

Flush the g2h worker explicitly if TLB timeout happens which is
observed on LNL and that points to the recent scheduling issue with
E-cores on LNL.

This is similar to the recent fix:
commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
response timeout") and should be removed once there is E core
scheduling fix.

v2: Add platform check(Himal)
v3: Remove gfx platform check as the issue related to cpu
    platform(John)
    Use the common WA macro(John) and print when the flush
    resolves timeout(Matt B)
v4: Remove the resolves log and do the flush before taking
    pending_lock(Matt A)

Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: stable@vger.kernel.org # v6.11+
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2687
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241029120117.449694-3-nirmoy.das@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit e1f6fa55664a0eeb0a641f497e1adfcf6672e995)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
index bbb9e411d21f..9d82ea30f4df 100644
--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
@@ -72,6 +72,8 @@ static void xe_gt_tlb_fence_timeout(struct work_struct *work)
 	struct xe_device *xe = gt_to_xe(gt);
 	struct xe_gt_tlb_invalidation_fence *fence, *next;
 
+	LNL_FLUSH_WORK(&gt->uc.guc.ct.g2h_worker);
+
 	spin_lock_irq(&gt->tlb_invalidation.pending_lock);
 	list_for_each_entry_safe(fence, next,
 				 &gt->tlb_invalidation.pending_fences, link) {


