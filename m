Return-Path: <stable+bounces-230498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB59Cr1hxWkJ+AQAu9opvQ
	(envelope-from <stable+bounces-230498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:41:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D316633897F
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9629330FD092
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840A41162F;
	Thu, 26 Mar 2026 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="n3moEIvy"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4458410D27
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542381; cv=none; b=J8iT+93lb+r1TbrOQBAUHDyX/dFa7wY+VsFUeFQFTdHviizRWj7tv3AUVNGnSgZa+jUgShUpCRpzcCnqWw6QedQRoCH4owVCDWkkddfZHRCu8AYmAHfq6Kd0ADZRUPRWQP85iAKpiXtV19I3OBAnGjqkQedPnKooCP+Eo9kHTU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542381; c=relaxed/simple;
	bh=/rCQ5RHjpOdrFxQs6E/BFz7et49J70l7+uo/Tv9Uzv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QlguEuYExJ+PuSKi7v4xTGf529LM1gN67DSci/640vs01gcxxJc5+SgoLtRRVOCq25dYzz0JMq1syBeLFuOBitXB+ZQB8GHSozYmDRHb9xP9MGrvGs1XUDBvvZ/851M2gfPmzlhUvari0sNX+sWVwf2SpG5SVsukGZX36FXveHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=n3moEIvy; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cfc497a604so171434685a.3
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774542379; x=1775147179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/cqQrfIeVRKhirbOTonOVGcajNoS4JNy4y1RyCuZwpE=;
        b=n3moEIvyloI/44YLDfg4zEBPuXV199v5SLZQP0fNl5BuE8hRyMrSo4gLGAbmUNshXQ
         qdniRO5VWhBzXKeMEr49k5mu2jkAZTR0cLtpvYVZbxbos9fZoSlru1p9zJoye35LnUrL
         b/JGyxN6AXoitvul7TYSPdo1kXQV7sDPwaUIsvax1dKVjcbCcw6Ls6YItmRxgaaa9JDY
         5/nbSLNc8qWuteJzTOKvp4wEphnCNkgc54SGi2L8qDYelK/GSe9zZ6aOx4GmXbduQipB
         kPojj6GsVX9sJlayeNpU83T1pP88YCBRF4brjCNmJFKCZYKHGKCAs+2B4rmEkUuDYUtI
         p67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542379; x=1775147179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cqQrfIeVRKhirbOTonOVGcajNoS4JNy4y1RyCuZwpE=;
        b=Y/5EVrlqv0En3FatXLCtIB8wSS+XK8EctqR2A2iNVv/rvc0WPIe2dQK72HrelFBDVX
         QSdX1d3BA/rizNWHZbPdd5Yr0PzPJgHRSfn0AYYlJXpyPj6aQUEdhp27dDl4NkRpO7l2
         kLOJj2nUCb/g3+2Gco2y62nodIb3bc8OzKgrIQXJNbdj+c75yY++4zXpfCFCT1uO4q1R
         Ps0/IbouPwPP8OAzEXeTAmEfXY2U3djBA4n7pRbAbIsL/a/LkP5475YWSs3+4eOPRcTi
         RdNcfIrnVgorES0w/UuvHpuIusEQn9J26QDtIp03uL7U/ieroSt1lCRMdb7amccitBGr
         q7tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtiODmmeiytUFkQG/rU6kMNiphlqNo7nRTRlVwMnqN8dSoTfkgWhOipzED9KZgLZNtK/DTBPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEjDf+eSPhmaTZpG33bIAENNDYH49GjxLGN4B4adcLAY7QnsDZ
	nKXHJVT3W4157+QqbEadMgaxNrY698JUrIoppWK3oQe4kzMWyH4Wlq+A/fM+ANGfnz4=
X-Gm-Gg: ATEYQzywIDACl406DrOrC46x1Jf80HYHDJZUqAcgYVH7HAs2AJ88jOdj3AqkaB11dIz
	jMtrDtXDUuMC6xTmqE8wmih7PuNd7ohnBiEa6AskqGTeKp0UhY4Ddo2DkiS7QMRX1fUGr+GMC91
	5LJ/gRZ1lxCQU29UNXilhVea4GjenR6poXsi8sldzoHWdLvgwTnLqA10oXENSiN36jcC9VIoQYo
	Sk/Kxq2ncp+hgtuQd9NcoN6gYR5MHF7ClLpD03LoKyI3qfaqAIXAPK0LMO5UVTwxVaEWVQGYglw
	1/CTcDlgqoqqc3KksosJyvbkrBJPpA1cHDNvjk+oHD/I7mxom3HDD2S9Bt+Q48nfd9DzUkSBFKv
	0GW3LVewnqObG2hxnwcZ0pBG9iqE864McQky8Ci3jY0HM+2DVcVLGQGm4gD/bjg8RllY/zr+qiY
	j4yB6ebgqxufHwON29Dmx45Ec+ZcXZ1601/Dx9cCKXtQ==
X-Received: by 2002:a05:620a:700b:b0:8cf:da76:58ea with SMTP id af79cd13be357-8d001003c8amr1290364085a.25.1774542378652;
        Thu, 26 Mar 2026 09:26:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.thefacebook.com ([2620:10d:c091:500::2:e5e8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e3c3a18sm297378885a.12.2026.03.26.09.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:26:18 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	hughd@google.com
Cc: david@kernel.org,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: [PATCH] mm/shmem: use invalidate_lock to fix hole-punch race
Date: Thu, 26 Mar 2026 11:26:11 -0500
Message-ID: <20260326162611.693539-1-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-230498-lists,stable=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gourry.net:dkim,gourry.net:email,gourry.net:mid]
X-Rspamd-Queue-Id: D316633897F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Inflating a VM's balloon while vhost-user-net fork+exec's a helper
triggers "still mapped when deleted" on the memfd backing guest RAM:

  BUG: Bad page cache in process __balloon  pfn:6520704
  page dumped because: still mapped when deleted
  ...
  shmem_undo_range+0x3fa/0x570
  shmem_fallocate+0x366/0x4d0
  vfs_fallocate+0x13c/0x310

This BUG also resulted in guests seeing stale mappings backed by a
zeroed page, causing guest kernel panics.  I was unable to trace that
specific interaction, but it appears to be related to THP splitting.

Two races allow PTEs to be re-installed for a folio that fallocate
is about to remove from page cache:

Race 1 — fault-around (filemap_map_pages):

  fallocate              fault-around           fork
  --------               ------------           ----
  set i_private
  unmap_mapping_range()
  # zaps PTEs
                       filemap_map_pages()
                        # re-maps folio!
                                              dup_mmap()
                                              # child VMA
                                              # in tree
  shmem_undo_range()
    lock folio
    unmap_mapping_folio()
    # child VMA:
    #   no PTE, skip
                                            copy_page_range()
                                              # copies PTE
    # parent VMA:
    #   zaps PTE
  filemap_remove_folio()
    # mapcount=1, BUG!

filemap_map_pages() is called directly as .map_pages, bypassing
shmem_fault()'s i_private synchronization.

Race 2 — shmem_fault TOCTOU:

  fallocate                   shmem_fault
  --------                    -----------
                            check i_private → NULL
  set i_private
  unmap_mapping_range()
  # zaps PTEs
                            shmem_get_folio_gfp()
                              # finds folio in cache
                            finish_fault()
                              # installs PTE
  shmem_undo_range()
    truncate_inode_folio()
      # mapcount=1, BUG!

Fix both races with invalidate_lock.

This matches the existing pattern used by secretmem_fault(),
udf_page_mkwrite(), and zonefs_filemap_page_mkwrite(), all of
which take invalidate_lock shared under mmap_lock in their
fault handlers.

This also requires removing the rcu_read_lock() from
do_fault_around() so that .map_pages may use sleeping locks.

The outer rcu_read_lock is redundant for all in-tree .map_pages
implementations: every one either IS filemap_map_pages (which
takes rcu_read_lock) or is a thin wrapper around it.

Fixes: d7c1755179b8 ("mm: implement ->map_pages for shmem/tmpfs")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memory.c |  2 --
 mm/shmem.c  | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index e44469f9cf65..838583591fdf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5900,11 +5900,9 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 			return VM_FAULT_OOM;
 	}
 
-	rcu_read_lock();
 	ret = vmf->vma->vm_ops->map_pages(vmf,
 			vmf->pgoff + from_pte - pte_off,
 			vmf->pgoff + to_pte - pte_off);
-	rcu_read_unlock();
 
 	return ret;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 4ecefe02881d..5c654b86f3cf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2731,7 +2731,8 @@ static vm_fault_t shmem_falloc_wait(struct vm_fault *vmf, struct inode *inode)
 static vm_fault_t shmem_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
+	struct address_space *mapping = inode->i_mapping;
+	gfp_t gfp = mapping_gfp_mask(mapping);
 	struct folio *folio = NULL;
 	vm_fault_t ret = 0;
 	int err;
@@ -2747,8 +2748,15 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 	}
 
 	WARN_ON_ONCE(vmf->page != NULL);
+	/*
+	 * shmem_fallocate(PUNCH_HOLE) holds invalidate_lock exclusive across
+	 * unmap+truncate.  Take it shared here so shmem_fault cannot obtain
+	 * a folio in the process of being punched.
+	 */
+	filemap_invalidate_lock_shared(mapping);
 	err = shmem_get_folio_gfp(inode, vmf->pgoff, 0, &folio, SGP_CACHE,
 				  gfp, vmf, &ret);
+	filemap_invalidate_unlock_shared(mapping);
 	if (err)
 		return vmf_error(err);
 	if (folio) {
@@ -3683,11 +3691,13 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 		inode->i_private = &shmem_falloc;
 		spin_unlock(&inode->i_lock);
 
+		filemap_invalidate_lock(mapping);
 		if ((u64)unmap_end > (u64)unmap_start)
 			unmap_mapping_range(mapping, unmap_start,
 					    1 + unmap_end - unmap_start, 0);
 		shmem_truncate_range(inode, offset, offset + len - 1);
 		/* No need to unmap again: hole-punching leaves COWed pages */
+		filemap_invalidate_unlock(mapping);
 
 		spin_lock(&inode->i_lock);
 		inode->i_private = NULL;
@@ -5268,9 +5278,26 @@ static const struct super_operations shmem_ops = {
 #endif
 };
 
+/*
+ * shmem_fallocate(PUNCH_HOLE) holds invalidate_lock for write across
+ * unmap+truncate.  Take it for read here so fault-around cannot re-map
+ * pages being punched.
+ */
+static vm_fault_t shmem_map_pages(struct vm_fault *vmf,
+				  pgoff_t start_pgoff, pgoff_t end_pgoff)
+{
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	vm_fault_t ret;
+
+	filemap_invalidate_lock_shared(mapping);
+	ret = filemap_map_pages(vmf, start_pgoff, end_pgoff);
+	filemap_invalidate_unlock_shared(mapping);
+	return ret;
+}
+
 static const struct vm_operations_struct shmem_vm_ops = {
 	.fault		= shmem_fault,
-	.map_pages	= filemap_map_pages,
+	.map_pages	= shmem_map_pages,
 #ifdef CONFIG_NUMA
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
@@ -5282,7 +5309,7 @@ static const struct vm_operations_struct shmem_vm_ops = {
 
 static const struct vm_operations_struct shmem_anon_vm_ops = {
 	.fault		= shmem_fault,
-	.map_pages	= filemap_map_pages,
+	.map_pages	= shmem_map_pages,
 #ifdef CONFIG_NUMA
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
-- 
2.53.0


