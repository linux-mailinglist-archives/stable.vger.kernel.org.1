Return-Path: <stable+bounces-204645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AB2CF3161
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 11:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4AB3300874E
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B033067F;
	Mon,  5 Jan 2026 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s5mkZb2Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3901532E14F
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610558; cv=none; b=qu8PEdWR/5GZt+x14m+/AphcbyJw+5380YB+ymrXR5chnzNEuBJ0wJon32+BQLv+pnHIsEBLcB/gPoBZHrUXQziwm3SE81LgITp2Yi0ll0obQKostalJuHPawM85QuNGaGF0N5gZfqCmzIVS1plML/ekG1k+ZEV5NYnR0rhxOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610558; c=relaxed/simple;
	bh=/Byx82j2zLZgmYrPAtu7nl+OVeofU7Zwi1DsVgn/FS4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EreVdb6uQ1msD+mtB6WEuk4lSuqfYp8UBL/zae3OVvcYGFnR3pkLlALCLpRl/0ltmghaUFgZLOCsErm8UX6/9TyrH73E3yH65C8OOEgHeEytuJABmjl9qKJhTzcvwzarCcxC92r7V/CV7pbm+wL1/Wn36PRaGG33AjTARO76uN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s5mkZb2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B634FC116D0;
	Mon,  5 Jan 2026 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610558;
	bh=/Byx82j2zLZgmYrPAtu7nl+OVeofU7Zwi1DsVgn/FS4=;
	h=Subject:To:Cc:From:Date:From;
	b=s5mkZb2Y3/grrJQU9twVLRFHuWWlewvRSwpgDpzSFb43CzZezHvxczYAulJcML5tF
	 UpYUra7msV8jKb7CqFrgnwyh75OYolT4h7ZgdDx0x6sqL5qupAXMWy0H7IfKfHT1qN
	 mWJzA/ItAbfOjLlwgBFwIitAEsojea1EVs52GvTY=
Subject: FAILED: patch "[PATCH] powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating" failed to apply to 6.1-stable tree
To: david@kernel.org,akpm@linux-foundation.org,christophe.leroy@csgroup.eu,david@redhat.com,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,ritesh.list@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:55:47 +0100
Message-ID: <2026010547-partly-speller-54fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0da2ba35c0d532ca0fe7af698b17d74c4d084b9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010547-partly-speller-54fa@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


