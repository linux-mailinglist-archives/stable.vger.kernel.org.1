Return-Path: <stable+bounces-204650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA05CCF3167
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 11:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0279E3008CB1
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE532E126;
	Mon,  5 Jan 2026 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ORPFY6dv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A305032E14F
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610574; cv=none; b=a9sFvKIiPP+OYPO4vPRPmqtKE4x7CVb4xKIvZqQe8O/hv6VUaLIz7PKaqrVovOJ6a/zEWAs8Rx08Ouw9Ld5VunrBmleZa3TIt+BO+ubn1v5UWrnujLv3JdKzw6FT+9swRdaRAMj0eRA/6SFUrCK/jJB08CZRDULKfnWDYreTTMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610574; c=relaxed/simple;
	bh=WkFoCVZQsTBtI/AQToyWtw9ACiL1uebpYgxtpBAmSrY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FNMza7prUOuqqke9lNgS/TyazL+r4oJKlfLEfZkpE25hFRJ5/L7YdZphFrrLshQdsCXe6rgAnwiSWSRBcETZywfN/zmdDDD/woALBSGOvbhVsNgZBcDswjppmQmWxOEGS0bardmZ1TylRAidg7dUFWoFm0MZaOPCP6NoFx2dcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ORPFY6dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AB0C116D0;
	Mon,  5 Jan 2026 10:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610574;
	bh=WkFoCVZQsTBtI/AQToyWtw9ACiL1uebpYgxtpBAmSrY=;
	h=Subject:To:Cc:From:Date:From;
	b=ORPFY6dvqunY5cFLmjjfoJS8RAZwen8W1yfQotj/gjnrmmaiZK0ENOT8xrMpF16bC
	 +1lSwcPRHhRehVTskXlCh+eVmmAmA5gWGt9DA1zXlW+TdTHGBfzx0goXtNBhZUdyQY
	 SYbAEH3t8U/P1NQNVUftszxjeSxNtn49RCPX2C94=
Subject: FAILED: patch "[PATCH] powerpc/pseries/cmm: call balloon_devinfo_init() also without" failed to apply to 5.10-stable tree
To: david@kernel.org,akpm@linux-foundation.org,christophe.leroy@csgroup.eu,david@redhat.com,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,ritesh.list@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:56:00 +0100
Message-ID: <2026010500-antirust-bacterium-2d22@gregkh>
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
git cherry-pick -x fc6bcf9ac4de76f5e7bcd020b3c0a86faff3f2d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010500-antirust-bacterium-2d22@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc6bcf9ac4de76f5e7bcd020b3c0a86faff3f2d5 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@kernel.org>
Date: Tue, 21 Oct 2025 12:06:05 +0200
Subject: [PATCH] powerpc/pseries/cmm: call balloon_devinfo_init() also without
 CONFIG_BALLOON_COMPACTION

Patch series "powerpc/pseries/cmm: two smaller fixes".

Two smaller fixes identified while doing a bigger rework.


This patch (of 2):

We always have to initialize the balloon_dev_info, even when compaction is
not configured in: otherwise the containing list and the lock are left
uninitialized.

Likely not many such configs exist in practice, but let's CC stable to
be sure.

This was found by code inspection.

Link: https://lkml.kernel.org/r/20251021100606.148294-1-david@redhat.com
Link: https://lkml.kernel.org/r/20251021100606.148294-2-david@redhat.com
Fixes: fe030c9b85e6 ("powerpc/pseries/cmm: Implement balloon compaction")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 0823fa2da151..688f5fa1c724 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -550,7 +550,6 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 
 static void cmm_balloon_compaction_init(void)
 {
-	balloon_devinfo_init(&b_dev_info);
 	b_dev_info.migratepage = cmm_migratepage;
 }
 #else /* CONFIG_BALLOON_COMPACTION */
@@ -572,6 +571,7 @@ static int cmm_init(void)
 	if (!firmware_has_feature(FW_FEATURE_CMO) && !simulate)
 		return -EOPNOTSUPP;
 
+	balloon_devinfo_init(&b_dev_info);
 	cmm_balloon_compaction_init();
 
 	rc = register_oom_notifier(&cmm_oom_nb);


