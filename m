Return-Path: <stable+bounces-163546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41096B0C139
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 12:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875BD3BF9B9
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 10:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2341F28F523;
	Mon, 21 Jul 2025 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uYBRpu/v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E6819DF62
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753093507; cv=none; b=MtTm/G2gQ7eLhvJfUDYRI6NqOS9dE7SAMRDctLCbqXLRO5b/KNL0AlIXiVxqxjoPIEXdhkViRBorH9gZf9BBalmhdKiMiZ7ffMBPEu11PgPsU94pUvJSERikNqaR7gqNj4NU0M7pF3/sJ+a2XCnzFkfFIqNo9Xixs1DQBmYnFr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753093507; c=relaxed/simple;
	bh=GeWpJdNeHYbQvbRH8lZLkC0hgz1jhS4WxqqdZXP64DY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jc/towiGsKPk8pVcE+EbjDLquNxWBG9j0gEkqQoYlIQxuxrxksdSujja3nvx7TWfd+WSr7XKuW0Y2E+TI03q4B7hddPle0O2RbR9aZWBmjUspuY6z7uoPRs2AK160y7+pQWG8dSwHKJMUzJo9lTYaVOIjF75LoRP0Vp+DL44yKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uYBRpu/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4952AC4CEED;
	Mon, 21 Jul 2025 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753093507;
	bh=GeWpJdNeHYbQvbRH8lZLkC0hgz1jhS4WxqqdZXP64DY=;
	h=Subject:To:Cc:From:Date:From;
	b=uYBRpu/vX1HEp2tmhVM81KI5Z4yWffqfsIc11msyIz5saXq8784gUco7zhJmXJ/N6
	 47lWI5ZMZ2rGMmrmZkF8WcmBiG1vVrFstGx+c38o9oFxOmwLqHeLy7sBqsUILWeCue
	 LoQrSJHiH8E6VbnBa124ypSizsvjXTum8q+i8Ixc=
Subject: FAILED: patch "[PATCH] drm/xe: Move page fault init after topology init" failed to apply to 6.12-stable tree
To: matthew.brost@intel.com,jonathan.cavitt@intel.com,lucas.demarchi@intel.com,stuart.summers@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 12:25:01 +0200
Message-ID: <2025072101-drastic-gentile-dc59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3155ac89251dcb5e35a3ec2f60a74a6ed22c56fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072101-drastic-gentile-dc59@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


