Return-Path: <stable+bounces-204648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A06AECF31DD
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 004A2310F89D
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3205832F750;
	Mon,  5 Jan 2026 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YByCe2eT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53BE32E6BF
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610568; cv=none; b=QjLz7QXHf1QXHV+hUqlVgdLy4pPbaNvhyRCbWMqrP/4A9FVjHg/abWs5reDM+/6BjLtR4EAxj5th5IvSSEPbH1p8qRetv+NBDQWY7OP1XeB7UP2H5JkJE3APNInSVpD3Ef6RQyD9sot6lD9G+6Yhzgz5WGycxFgl1GhaHF7f5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610568; c=relaxed/simple;
	bh=6nFv8Cm4AgZnRzhbVcOS7Rd9aiZLV8qGkw2c5CqnUVQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s5goh4RhRELbAdPjmArciO18DJy1tE5tt4N5tlZQLxXGAbIf/2X8lgfJXXXlZkJE4KVy73zvh+HsnmvMkr4qrdf2huoCUEB74GGiixIcdUIczBjYqo02gNTYCkM3L8F6IzlQIKI02l4nnNuc8MJjSpfvrj7Wn4aW4ojCLzxKx+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YByCe2eT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA218C116D0;
	Mon,  5 Jan 2026 10:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610567;
	bh=6nFv8Cm4AgZnRzhbVcOS7Rd9aiZLV8qGkw2c5CqnUVQ=;
	h=Subject:To:Cc:From:Date:From;
	b=YByCe2eTZffio8QZj62r+FUZ2NLDV1l7nP19MCCrpioQk6n4K61hifyJUddVGcj4w
	 rOlrIyfgtylC15xj4m9l0hunadH0QmuThZYg/qaouAj6mQxRpepBixohUt3b0X6TFw
	 W5wj/3ARRIRksBIR+4gmx1rh6YBEvrstRiJyGIOQ=
Subject: FAILED: patch "[PATCH] powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating" failed to apply to 5.15-stable tree
To: david@kernel.org,akpm@linux-foundation.org,christophe.leroy@csgroup.eu,david@redhat.com,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,ritesh.list@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:55:48 +0100
Message-ID: <2026010548-impulse-unspoken-ac63@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0da2ba35c0d532ca0fe7af698b17d74c4d084b9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010548-impulse-unspoken-ac63@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


