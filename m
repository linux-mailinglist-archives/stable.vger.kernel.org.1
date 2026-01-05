Return-Path: <stable+bounces-204644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 747E4CF31BF
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 726E43108FA7
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659E4330667;
	Mon,  5 Jan 2026 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yCwyfY8Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C4832D452
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610551; cv=none; b=M8MauCoNQeiltPvAfim0oPHDwzyuaVkzdnRLpYk1+ZBuZzySwjSROneBvsoJScb/uoOZNsokqsq7FnTk3eYAy0nqSmn4BehUUnZL6o4Ab5GH0LS75NzwBsILUrz95wpr4KQTLJet2O2l6NlIoC8JFPqQtvPpX+Zi7vRT86404Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610551; c=relaxed/simple;
	bh=+uOpXLXvpTJN196r10WoZa002JMpa83g/HUR+rBVTIc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=En6HvZ3MwWY0T/KvYg0E9XsYValH7J91Ylf7yDWN11R9KZSx0KrcWsR9piTP4SHPUCfsbv1wW/n4XXCx9T4bVv8Tg8psuTcYJHTIBJLmnsLJhzPK2PcMywPOqlDbk9VJWFWqcEXW6O5cdQ3t3Qsghn5ZHpX3JbX+/gt9qbXdghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yCwyfY8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4087EC116D0;
	Mon,  5 Jan 2026 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610550;
	bh=+uOpXLXvpTJN196r10WoZa002JMpa83g/HUR+rBVTIc=;
	h=Subject:To:Cc:From:Date:From;
	b=yCwyfY8QYEmWXPsVSXPHu89WcUcmArWaQrhxueUmeqi09SP0xHh6a5ZBQ/2shps5G
	 TxGIGTTSNO8KmDHEW1f1T542fk0HsUk21M/gF3b0etKVARaZzq6OPtWT7lykoIj8By
	 /Ey5cmadrKOj6G6TPGNk5bqj2X8nQExf9R9cGehE=
Subject: FAILED: patch "[PATCH] powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating" failed to apply to 6.12-stable tree
To: david@kernel.org,akpm@linux-foundation.org,christophe.leroy@csgroup.eu,david@redhat.com,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,ritesh.list@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:55:46 +0100
Message-ID: <2026010546-overcrowd-jarring-93b0@gregkh>
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
git cherry-pick -x 0da2ba35c0d532ca0fe7af698b17d74c4d084b9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010546-overcrowd-jarring-93b0@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0da2ba35c0d532ca0fe7af698b17d74c4d084b9a Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@kernel.org>
Date: Tue, 21 Oct 2025 12:06:06 +0200
Subject: [PATCH] powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating
 pages

Let's properly adjust BALLOON_MIGRATE like the other drivers.

Note that the INFLATE/DEFLATE events are triggered from the core when
enqueueing/dequeueing pages.

This was found by code inspection.

Link: https://lkml.kernel.org/r/20251021100606.148294-3-david@redhat.com
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
index 688f5fa1c724..310dab4bc867 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -532,6 +532,7 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	balloon_page_insert(b_dev_info, newpage);
+	__count_vm_event(BALLOON_MIGRATE);
 	b_dev_info->isolated_pages--;
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 


