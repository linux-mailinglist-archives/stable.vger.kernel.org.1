Return-Path: <stable+bounces-165160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CBDB15729
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 03:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92077B1E22
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 01:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89651B394F;
	Wed, 30 Jul 2025 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tOqBCS+O"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C541ACEDE
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 01:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840344; cv=none; b=ihoAkM+FMp00UBgBTfohVg5Hi15UBtuGdWB3DseXsPrU5eg39tLCPtoOfKi/CgJdEN9wWcZT7JTjmvnGtNRacumr+iL7htaedsKMg+HooCDlkFVq9coRdIyNVqsjvfHd/UpG8hd5GwxVVsGRCHyj97EP3wikmG4yl7IQphX7YaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840344; c=relaxed/simple;
	bh=Im+RIZaPA97mCJ1p993zhCOeOvGk7nERXgnH32EytNg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yfa1J4dIs9k49nR8GNtNhcI6gFT8IZOkKNbNhEJ8reEIYz4oitgjTqDrF3JvNe2sHiYJjFPAqF//wvkPMR34TAXDDxX6VSm1hl5C7h3c0OKnHstDdzTPDdGqXjqfivXex+eGK5Rf0MgYhs6BJjootFYCeZ1hSroGq1rIsh7oSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tOqBCS+O; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-764072aca31so6533166b3a.2
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840342; x=1754445142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0RGgZf0fn2tvYj09uOIiJChmIaihN770HRGuhK7cEA=;
        b=tOqBCS+OUZzW+qp0OEcRgfcCew6ZKeq+J4TBmQl3KuwHPiZZ6aGPseMel4q1VvpSDH
         k0YHtJHIvaQjSaU1WXpGSB/8m7wajO9Ya4xB1saNAphOvmY3Vl4xckg3zypItfSlXpxD
         wFV64z1TW1avFRQWrnRy1JI3+I+bZFvegIV0fSGk6cVAQib5BnZvo8I6HKu5BZkgUDSg
         mfPI8cQrX+l4pw040pkCGvWy6k9vmqIboSyBlcEAMh8vspha3a+CoHhpsEV9cGFamHUH
         r+KfqKwDfUzrwAgq6CuUiC9SUhmQQUtwmSYt14rSjuv5ptulGgbeKB/Q3l2z8VxC9R/c
         kTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840342; x=1754445142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0RGgZf0fn2tvYj09uOIiJChmIaihN770HRGuhK7cEA=;
        b=AbPnbeR0cthPKS3uMd6cC6pwbPkV5XR+VnEE9qyTZQDqvAPiKfFvtrFn40AIOLWQ4H
         XzrHhfZKMRiZxthazFQymYU4UwT0rWjZUZkQAWFBXbMqsBdTm0y4Rd7GgoNZ69HdWM+H
         gjgIEc3MLYbM36pbATry204Dshxz12FETxuPTfg1011+b8HW5OYNrqotbMsJGED8kGti
         D9kuO5xutV1qRZkz97tMAYLAr+FN3pGqY+YsSa/nhEkjfvb6twZBJ90OHQMEL3UCxlAb
         l29J/cXkem+O3tRghstfAtVyuBKKret+QSS6z6QWwDpU5m5wwdPyEhUr4D7hqrF4UtW2
         cXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ75e47+EOyx67cKocrpDt0gX259PYpFeHEu3UEPSBQJOk4F6bylHA2g5OwtQ/SCb+Wd6FzUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+MiI6HA4kTG513sewxIWeNGm3z3c8Wyp5rzYaSLXe8byoZj53
	0uaX37ldh3yExhKenLSvknlEGNdsw9reT84UGO3ZxVrd8zolQIA3AUoP3ojrLlvZRYUc6qbi6uV
	I4mdSt1TGpK7n77QJAYk41vy2tf6cIGnD0IsdzA==
X-Google-Smtp-Source: AGHT+IHzNEJ/jzYX0FtMn2+7BiG5mL108A3i2Ajr65TeHR5WLUWsP/dCyaoBLvXvu+kvbEDU8meaCfPSHxSvCaZY6Ind0A==
X-Received: from pffy13.prod.google.com ([2002:aa7:93cd:0:b0:769:ee8f:9dd0])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3a1e:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-76ab092f862mr2694402b3a.3.1753840342087;
 Tue, 29 Jul 2025 18:52:22 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:51:46 -0700
In-Reply-To: <20250730015152.29758-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730015152.29758-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015152.29758-3-isaacmanjarres@google.com>
Subject: [PATCH 6.6.y 2/4] mm: update memfd seal write check to include F_SEAL_WRITE
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
index ac519515ef6c..ab951fd47531 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -136,7 +136,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
 	vma->vm_ops = &hugetlb_vm_ops;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 036be4a87e3d..05b970a6cd28 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4023,25 +4023,26 @@ static inline void mem_dump_obj(void *object) {}
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
index 283fb62084d4..ecf1011cc3e2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2396,7 +2396,7 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	int ret;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
-- 
2.50.1.552.g942d659e1b-goog


