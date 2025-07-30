Return-Path: <stable+bounces-165175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5377EB1574C
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 03:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE8F560F83
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 01:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D181DACA7;
	Wed, 30 Jul 2025 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zfaKZB/n"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1DD1EB5F8
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 01:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840461; cv=none; b=ihL3psG2rfQ9Bnml7stzB11LmaVdCZFDlC3D2uxKdOS4DkorXhNGC2K1Uhozj9/gX3svTEj5JHylGFai15JNVmYvUoocda150ly64dzyTDQRNsiVeb/oN0Nso+WDBJr0/np3YBefVSth2ih4hkH6OkDs94eldbZ6thTTnBo1Mwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840461; c=relaxed/simple;
	bh=mqgw4zMDQqw7T+X2sib4x4x/Vj8W0pCtkYcXF+7y1XU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kMB8lREbh8XINjnHPSpQgyVfqW9r3UjzOAu2aGz6zDsJgRINbcnRGSOjUH5NsALKHSaKCdCo1JXrMXfHXQUD40FpJ6HP/V3+z80Na8F2sP2lOwmem5rK03Pze7dF+9FCEk1c61epxTSYCkru+M34W7nEa2FyH84ad4fOITDwWZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zfaKZB/n; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3f33295703so8167895a12.1
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840458; x=1754445258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VXg5VQlsYRDQOn4qX1CEGd3+KGbAxIhXk1wybEg/0Gs=;
        b=zfaKZB/npVGp09xn9o/GuVXFZ8AjS/K2suQvGNpF3iQ2/N7Ub3YQpbCOWWvO+GIdVO
         87IxLWeZOs7PFsv82xvUWciGtxKpwW4MFLIW6sCmRUi+Lg3IlqASBJH7MyiG6oOq4kK5
         WOx5V3x8WJ82UgglcvYGmCTzY3yqCuq486eu+0ttVKa4eJScQmuZPyAfbGxaIOdYhP9v
         ebAYsDI2bdXRO4i3ylq8KNDUE7/zfsF+YAMbyrdRcfquTCBZr/LbKdD7UgWHs+Vyc1Xo
         MtHXafZiB0kJveVgDQt0HhbwSDRX2GSCGT+QxZrSaBT3sUK4p0kf0j7o8fZIIenb+A6b
         Ekbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840458; x=1754445258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXg5VQlsYRDQOn4qX1CEGd3+KGbAxIhXk1wybEg/0Gs=;
        b=He5gImzdseuWFy4Y/aENj2fW4eCjmCNY0HE7PQUhrwhyWWKYIIy2RhfnKJ5u36A4HZ
         eYe9+GIdi2NIuihzJEFg/6ziW0Mo2hoEBQZCy/E630JfhLkr+UmgrFxS1T2wmwScRgjQ
         9NWOJNFvcDEbWnAl/bOoJaf05YBGmNvWPTkNIHG9j/yy3awl4EwFBFre21j7100Q5PHj
         ldbTXl0nqI1SSSvixQXjYZsrDHhaNmVuRL77RIahnC/L5AXmH6UOoBPOnYCHhwSqWzu3
         UgwwkjEq7KXKwlk+iIh7n1imOrjOb7yox9VrG61bIU7LWu/zCVLPHJivSeWq36YK/KSo
         NdQA==
X-Forwarded-Encrypted: i=1; AJvYcCX6/EI1+0v7w+WUJKjOPYnnccefDjp9954COvUvLuWOWMoUBIdF5AMos1qHdLq22w5vUrVjIYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAuQty5JhL4y8Vbmy93yqMl3F7GqEmvSdCUQ654nZ2RyJwCunA
	rKOLdrwpHsQgZ0ROe9AM0P5XTNZvDvngGLglIMajfjWakMlc1YLJ80QykwpYj4XiSgrdpll11wi
	CLg0fpOdOFTCQ2p4HWdfH6EDbiCztfOrUV8I6YQ==
X-Google-Smtp-Source: AGHT+IFNWTjX24exOZOPvPnWYCkq5geMIPulZn3Ba9ouy0INNk3MDuxRkhn6Gb1zf4XS83ACMv3zIQsDLx8mU8pDfF2f+w==
X-Received: from pluo8.prod.google.com ([2002:a17:903:4b08:b0:240:3f51:abcf])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d2cd:b0:240:92f9:7b75 with SMTP id d9443c01a7336-24096a4f806mr21813325ad.2.1753840457907;
 Tue, 29 Jul 2025 18:54:17 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:54:00 -0700
In-Reply-To: <20250730015406.32569-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730015406.32569-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015406.32569-3-isaacmanjarres@google.com>
Subject: [PATCH 5.10.y 2/4] mm: update memfd seal write check to include F_SEAL_WRITE
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
index bf3cda498962..6e97a54ffda1 100644
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
index 2bedc9940c47..130d53f0bd66 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3201,25 +3201,26 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
 extern int sysctl_nr_trim_pages;
 
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
index 6666114ed53b..5f8d8899bd0e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2263,7 +2263,7 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	struct shmem_inode_info *info = SHMEM_I(file_inode(file));
 	int ret;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
-- 
2.50.1.552.g942d659e1b-goog


