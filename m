Return-Path: <stable+bounces-106598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2516E9FEC49
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 03:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D2F18832F2
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 02:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393BC17BA1;
	Tue, 31 Dec 2024 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="x0pj4xjq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C6513B5B6;
	Tue, 31 Dec 2024 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735610413; cv=none; b=RwUst8RDfSWiv1JRNdtHUmd4RqN7B/y8GeSsW1NRotndb1JLo6ytHBkoQjaeojeBCTT4W9nTTLfdA5crofkQc9unkaCBHZKpxIKzVSCIGVH055D2bUK29enwtSTSbuBR505SNGJ+jLA+dbFFGj5aEveoBPpluiS/JH2wEMiXMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735610413; c=relaxed/simple;
	bh=z6SOhrbQbGQZCQn58VrV9LuW4tiTAZ2wwWsSA6FGcEU=;
	h=Date:To:From:Subject:Message-Id; b=k8jgEt5/NyP8/70wpVFnsAHU+Cuw+62rlarBfj0wutVdBnGCZUieMS0W0bDoU3uyor21Yu1WdR9b2+vxXLp+tGGh3ubRGE+HyZF6gDGTCIsmKWjWM+PDLbbrpxKPA8U9gdDCnZM1Q+0rzeRR6l2mk19OdGatrwZqdvhK2Jfjn/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=x0pj4xjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8A0C4CED2;
	Tue, 31 Dec 2024 02:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1735610412;
	bh=z6SOhrbQbGQZCQn58VrV9LuW4tiTAZ2wwWsSA6FGcEU=;
	h=Date:To:From:Subject:From;
	b=x0pj4xjqh0mk6rk7wOPldgNReOYcZYohfgBZaGrlpb82Ti60TWCJ0GypH9jw57Hvr
	 Ap/0p/eIbND4J19k9fK47R09Ljup+1jiTDtcCsu86bmsP3opC8z6gaNtSQK5MBg+I2
	 V7iEt/ja2nJitYdx9z4+2SfvzC+H90QEm3+qocrs=
Date: Mon, 30 Dec 2024 18:00:11 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,hughd@google.com,david@redhat.com,baolin.wang@linux.alibaba.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-shmem-fix-the-update-of-shmem_falloc-nr_unswapped.patch removed from -mm tree
Message-Id: <20241231020012.6E8A0C4CED2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm: shmem: fix the update of 'shmem_falloc->nr_unswapped'
has been removed from the -mm tree.  Its filename was
     mm-shmem-fix-the-update-of-shmem_falloc-nr_unswapped.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: mm: shmem: fix the update of 'shmem_falloc->nr_unswapped'
Date: Thu, 19 Dec 2024 15:30:09 +0800

The 'shmem_falloc->nr_unswapped' is used to record how many writepage
refused to swap out because fallocate() is allocating, but after shmem
supports large folio swap out, the update of 'shmem_falloc->nr_unswapped'
does not use the correct number of pages in the large folio, which may
lead to fallocate() not exiting as soon as possible.

Anyway, this is found through code inspection, and I am not sure whether
it would actually cause serious issues.

Link: https://lkml.kernel.org/r/f66a0119d0564c2c37c84f045835b870d1b2196f.1734593154.git.baolin.wang@linux.alibaba.com
Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/shmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/shmem.c~mm-shmem-fix-the-update-of-shmem_falloc-nr_unswapped
+++ a/mm/shmem.c
@@ -1535,7 +1535,7 @@ try_split:
 			    !shmem_falloc->waitq &&
 			    index >= shmem_falloc->start &&
 			    index < shmem_falloc->next)
-				shmem_falloc->nr_unswapped++;
+				shmem_falloc->nr_unswapped += nr_pages;
 			else
 				shmem_falloc = NULL;
 			spin_unlock(&inode->i_lock);
_

Patches currently in -mm which might be from baolin.wang@linux.alibaba.com are

mm-factor-out-the-order-calculation-into-a-new-helper.patch
mm-shmem-change-shmem_huge_global_enabled-to-return-huge-order-bitmap.patch
mm-shmem-add-large-folio-support-for-tmpfs.patch
mm-shmem-add-a-kernel-command-line-to-change-the-default-huge-policy-for-tmpfs.patch
docs-tmpfs-drop-fadvise-from-the-documentation.patch


