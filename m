Return-Path: <stable+bounces-163545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7628EB0C138
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 12:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F22189D6E8
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 10:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D5128F50F;
	Mon, 21 Jul 2025 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jp7vGwDd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646A519DF62
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753093504; cv=none; b=hDWR7lz4bZ9e00eyUBDNeE2uaRowEl/AyYXEdHAAPpCuiLNxefbOHI/nro+td4nGc+xL7MWVkGPEh9UCBBEvYOV7xPPs2IWiRlxi4EcQT2pVVoGwiltjjpBN8WI8Zd8AUpfbv1JrJZijRXRfkx87USMBIO/W25F1aRk8x9CHTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753093504; c=relaxed/simple;
	bh=GpCf6vLC/SrQAPnZzHk88zywAa32kIDZSeaRbU7tu9U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mjgWkbWzWwSohjEDRRwKaqEDSxwY/K0h2FJ5r4jDFjHcOgth/eOJvkg4R83bt//Ef2hOknIpAu9P7WdCPx6hZOs3uFXg+/LO6RMIi79pXR2hFaAzyz/BbMm1e+cj/gyIainkDst7LYTEBDSCLY38sXJdSZqIkAWoPDLYFBMEygo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jp7vGwDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7512C4CEED;
	Mon, 21 Jul 2025 10:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753093504;
	bh=GpCf6vLC/SrQAPnZzHk88zywAa32kIDZSeaRbU7tu9U=;
	h=Subject:To:Cc:From:Date:From;
	b=jp7vGwDdKgrlAfj30F/iN2DowL/wrqlkH+K8TfsF0XfU1mVtKGdsnjgr2/mZkG+3c
	 hm1GQ6UBDUuJVP5kH1DUpvfIGTk3YVSOFMWVXGHch7dz/hAe79W2fzcaxL0VXAoXLW
	 MNcEVF+tGZA32e9Cwe2tTPJ1cvQa2wiy4cTkOJDw=
Subject: FAILED: patch "[PATCH] drm/xe: Move page fault init after topology init" failed to apply to 6.15-stable tree
To: matthew.brost@intel.com,jonathan.cavitt@intel.com,lucas.demarchi@intel.com,stuart.summers@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 12:25:01 +0200
Message-ID: <2025072101-canola-aspect-c5c7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3155ac89251dcb5e35a3ec2f60a74a6ed22c56fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072101-canola-aspect-c5c7@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3155ac89251dcb5e35a3ec2f60a74a6ed22c56fd Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Thu, 10 Jul 2025 12:12:08 -0700
Subject: [PATCH] drm/xe: Move page fault init after topology init

We need the topology to determine GT page fault queue size, move page
fault init after topology init.

Cc: stable@vger.kernel.org
Fixes: 3338e4f90c14 ("drm/xe: Use topology to determine page fault queue size")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Reviewed-by: Stuart Summers <stuart.summers@intel.com>
Link: https://lore.kernel.org/r/20250710191208.1040215-1-matthew.brost@intel.com
(cherry picked from commit beb72acb5b38dbe670d8eb752d1ad7a32f9c4119)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 9752a38c0162..d554a8cc565c 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -632,10 +632,6 @@ int xe_gt_init(struct xe_gt *gt)
 	if (err)
 		return err;
 
-	err = xe_gt_pagefault_init(gt);
-	if (err)
-		return err;
-
 	err = xe_gt_sysfs_init(gt);
 	if (err)
 		return err;
@@ -644,6 +640,10 @@ int xe_gt_init(struct xe_gt *gt)
 	if (err)
 		return err;
 
+	err = xe_gt_pagefault_init(gt);
+	if (err)
+		return err;
+
 	err = xe_gt_idle_init(&gt->gtidle);
 	if (err)
 		return err;


