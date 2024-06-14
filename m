Return-Path: <stable+bounces-52159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34660908695
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 10:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD45528ED13
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 08:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CFA188CBC;
	Fri, 14 Jun 2024 08:41:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A547190073
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354469; cv=none; b=GyXb9uzxIMOgOjQZreb9HTX/eT7WLuN3UM5ph+CgjhTebj9K97xwze6LY9J+ak7uVQGsatN1hGPUNZ6OMinmKydcjROSfjMhJOscqMcRIQQG1wmvQmoXnBuLuxk7vqqvgYnWAFt4yhgEK5F5fTU1QWIy11qxgSTKQejQyKpAl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354469; c=relaxed/simple;
	bh=O5nwfX69vpYw/U53P3eVhJwVdMRerLrzLVRqUhtzOVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZlKl8LgC3WWLkHyeAvtWtflshffaJD8t471wXSvMHTjDxg7XpQq9Gqop22ncYofCRpl7soGnOA93t+mcmYHYofkBPQ7YuLTDlKdA8hKuk3kTbiDPbjNcCZTehCpivzQ2KVgRyKzagFjMRzIMBeMOdoks9+UleYD5/2FpEmXp6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	leah.rumancik@gmail.com,
	Miaohe Lin <linmiaohe@huawei.com>,
	Sam James <sam@gentoo.org>
Subject: [PATCH 6.1] Revert "fork: defer linking file vma until vma is fully initialized"
Date: Fri, 14 Jun 2024 09:40:28 +0100
Message-ID: <20240614084038.3133260-1-sam@gentoo.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 0c42f7e039aba3de6d7dbf92da708e2b2ecba557.

The backport is incomplete and causes xfstests failures. The consequences
of the incomplete backport seem worse than the original issue, so pick
the lesser evil and revert until a full backport is ready.

Link: https://lore.kernel.org/stable/20240604004751.3883227-1-leah.rumancik@gmail.com/
Reported-by: Leah Rumancik <leah.rumancik@gmail.com>
Signed-off-by: Sam James <sam@gentoo.org>
---
 kernel/fork.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 7e9a5919299b4..85617928041cf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -662,15 +662,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
 		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
-		/*
-		 * Copy/update hugetlb private vma information.
-		 */
-		if (is_vm_hugetlb_page(tmp))
-			hugetlb_dup_vma_private(tmp);
-
-		if (tmp->vm_ops && tmp->vm_ops->open)
-			tmp->vm_ops->open(tmp);
-
 		file = tmp->vm_file;
 		if (file) {
 			struct address_space *mapping = file->f_mapping;
@@ -687,6 +678,12 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			i_mmap_unlock_write(mapping);
 		}
 
+		/*
+		 * Copy/update hugetlb private vma information.
+		 */
+		if (is_vm_hugetlb_page(tmp))
+			hugetlb_dup_vma_private(tmp);
+
 		/* Link the vma into the MT */
 		mas.index = tmp->vm_start;
 		mas.last = tmp->vm_end - 1;
@@ -698,6 +695,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval = copy_page_range(tmp, mpnt);
 
+		if (tmp->vm_ops && tmp->vm_ops->open)
+			tmp->vm_ops->open(tmp);
+
 		if (retval)
 			goto loop_out;
 	}
-- 
2.45.2


