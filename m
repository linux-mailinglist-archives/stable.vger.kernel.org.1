Return-Path: <stable+bounces-165170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8098B15742
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 03:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6049518A7919
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 01:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EE21D799D;
	Wed, 30 Jul 2025 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKexWNxl"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389A1C6FFD
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840430; cv=none; b=vFI0AO4mGZ97EmylbKYnldecVVmqMkQXjatcbNKCgoC2YDO3BEfW8AQqY5/E13QjPghkFt7km/SrGk4cIpRiEoYx303eUtwrHK9aE7u7xJ5hQjAr0ZtpgSB7iMdgQTfzwUaO+nPCSmh7Ky/rTeHlqeCnQi80Ydn6awMm9KHd1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840430; c=relaxed/simple;
	bh=yb5AchvzprDt6k5TvIEB28CA26wR5+Hnp1aXu/ymoG8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dVxsRw7RKeivaGidwUAloJu4bVrZUBuA+AOnLchMsVy/yXNa4Sq+rozkTK7434ZCqaqKXMjWDohtuZ5LmYtL1Nl/kqxtlc58ZAoMuQ4uiKKBsxtnL03x/zM5UJ9JnyhpMAb3OvWNv9rxamlCYA2/eYfWmx/4v5vpzFoshlXNFyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bKexWNxl; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-70e4269de4fso90354957b3.0
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840428; x=1754445228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=39x+FWPwzH2SKG6lIOzneDjaUlY8W/uoBQrpnBZb02Q=;
        b=bKexWNxlWLjRKemHPQhsq2LNEQiLlCjJjGKN4PExF80PZk8JQvoGdjRabIisQZBhNB
         GN3pEZnbnPaYI0mZ40+NA9iAh0FARjw2ZfESRBDG2KAJBfVsNyjm5UacZFAQ9GS+3qL3
         bksWeTwS4N/tXAm30NVA8WXU/01hWU76eOINLmQ4eDiF8GjNIGHmcj10mlR4G7g7GlJ3
         ioaLiNX0aLVkOearZzNWe7R4+nFHy7OzpaVdAqjJxx+kjtfxOvcP35oPNaxxHRIP/FAc
         EHk18zhXXRjHlbyMmFEvTE3j4B881+GlWLtLWcxUpHr6NSUSSXzUysa+RggzjAbrFtF6
         sXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840428; x=1754445228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39x+FWPwzH2SKG6lIOzneDjaUlY8W/uoBQrpnBZb02Q=;
        b=Qby6QPRl8EYPl8bdG4UR29za262Fbw4kcw9g3zbyXZWtr7ChRtfZ/n88Ya2sJFexzm
         QCghBcvFX1CoyzW3wtDyGT0X4055GvdlngvIG4t+ligSii3/bheXTsx5ZU6uGqcNka/c
         0KvE4/deD4SETC/xJz5kh36Gq9Tn7+Ri/LDstdB56XH0PkrBLKoU7vNT15xVwGq6Sd+y
         odR2HtCi1/Muo/MT1qc2VW5defvySgem03g6AHLxgJ2B6nOeYt+H0YtYQpmrihTC/P6Z
         Wj+UanD7/fmmcSqOFnD4rNWEIHBdRliav/YVnVCKrrzP/RAFYcGQADw4BO0iGuWFbH5t
         KKtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhaIjtp9AYkbHeT6lUDPMvwqufL7iySCRpQaidbLrQYae9KClCPxwuNqvJAj26qwVemEiLg2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7oFeVBnUau8E1zuh1ue16yWAZs3rCcw8zZoXPK6yhdyeb3u7A
	mO7wYT9tus4jRet2m0+C7rcCd350j+WgIebJDuxe71+FXsUpu/TIJeI/0WNslg3Xe5HNfzsCIzq
	MHrT4503OgOtwLHDhJZ2vYnzL505PKVQkfr7s6w==
X-Google-Smtp-Source: AGHT+IGjCf5KwJgx9XGkjXLwUnllofZO1a2HLuupENahyAxK5jK5Et3l4fLbuwgKvSEACA7+q44be6tAId7B5VpbYdPrmQ==
X-Received: from ybdo28.prod.google.com ([2002:a05:6902:6c1c:b0:e8e:157e:e705])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a5b:ed1:0:b0:e8e:13f1:f174 with SMTP id 3f1490d57ef6-e8e315f2dddmr1583968276.37.1753840427764;
 Tue, 29 Jul 2025 18:53:47 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:53:31 -0700
In-Reply-To: <20250730015337.31730-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730015337.31730-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015337.31730-3-isaacmanjarres@google.com>
Subject: [PATCH 5.15.y 2/4] mm: update memfd seal write check to include F_SEAL_WRITE
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: aliceryhl@google.com, stable@vger.kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Lorenzo Stoakes <lstoakes@gmail.com>

[ Upstream commit 28464bbb2ddc199433383994bcb9600c8034afa1 ]

The seal_check_future_write() function is called by shmem_mmap() or
hugetlbfs_file_mmap() to disallow any future writable mappings of an memfd
sealed this way.

The F_SEAL_WRITE flag is not checked here, as that is handled via the
mapping->i_mmap_writable mechanism and so any attempt at a mapping would
fail before this could be run.

However we intend to change this, meaning this check can be performed for
F_SEAL_WRITE mappings also.

The logic here is equally applicable to both flags, so update this
function to accommodate both and rename it accordingly.

Link: https://lkml.kernel.org/r/913628168ce6cce77df7d13a63970bae06a526e0.1697116581.git.lstoakes@gmail.com
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 fs/hugetlbfs/inode.c |  2 +-
 include/linux/mm.h   | 15 ++++++++-------
 mm/shmem.c           |  2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9b6004bc96de..c8a5d94561ff 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -148,7 +148,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_flags |= VM_HUGETLB | VM_DONTEXPAND;
 	vma->vm_ops = &hugetlb_vm_ops;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ec171c6557a..61874611d0e4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3287,25 +3287,26 @@ static inline void mem_dump_obj(void *object) {}
 #endif
 
 /**
- * seal_check_future_write - Check for F_SEAL_FUTURE_WRITE flag and handle it
+ * seal_check_write - Check for F_SEAL_WRITE or F_SEAL_FUTURE_WRITE flags and
+ *                    handle them.
  * @seals: the seals to check
  * @vma: the vma to operate on
  *
- * Check whether F_SEAL_FUTURE_WRITE is set; if so, do proper check/handling on
- * the vma flags.  Return 0 if check pass, or <0 for errors.
+ * Check whether F_SEAL_WRITE or F_SEAL_FUTURE_WRITE are set; if so, do proper
+ * check/handling on the vma flags.  Return 0 if check pass, or <0 for errors.
  */
-static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
+static inline int seal_check_write(int seals, struct vm_area_struct *vma)
 {
-	if (seals & F_SEAL_FUTURE_WRITE) {
+	if (seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
 		/*
 		 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
-		 * "future write" seal active.
+		 * write seals are active.
 		 */
 		if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
 			return -EPERM;
 
 		/*
-		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
+		 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
 		 * MAP_SHARED and read-only, take care to not allow mprotect to
 		 * revert protections on such mappings. Do this only for shared
 		 * mappings. For private mappings, don't need to mask
diff --git a/mm/shmem.c b/mm/shmem.c
index 431a48e1b90c..06ed84ebdf3b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2262,7 +2262,7 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	struct shmem_inode_info *info = SHMEM_I(file_inode(file));
 	int ret;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
-- 
2.50.1.552.g942d659e1b-goog


