Return-Path: <stable+bounces-203368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B836CDC06C
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 11:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3DAD30090AE
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 10:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587BF3191BE;
	Wed, 24 Dec 2025 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QTmAy/0l"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98690314B8F
	for <stable@vger.kernel.org>; Wed, 24 Dec 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766573014; cv=none; b=UCYpg0H45oz7VgNKyAA7wCZgGTgjoJtv/QXe4o+S1ntjpdipq7IhmYVqlloB2pW6zuDigHeZBT0vbO9Whg0UnxW9e2dcMG7tsVzVZRkLM8lrGBfKAtxgk+/4iBXgyz7o9ErpcgGl4DjFLdFZThMO4eAtJ3vE/xPVxUhxKco2/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766573014; c=relaxed/simple;
	bh=gtSHTc5KLEm2c3/Ii/6Ssf3DLdh0gefU1D1AZRjUdVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRC9xH5x0RfmAXO2aYAqqgEwbJT5fR0cSn8Mink4zdPEdpcSYm3G5sEPshAUQjeMrvttJwZkH0BvWx16zs3weh/56hYXIFYgZkyOHBzaPbyM5nSfeyAl+wSlUMVzSrcIi/gcClPWEhnIfRyHGFeam16I21XaJPfU2g7lD+YkHcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QTmAy/0l; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a0bb2f093aso60227265ad.3
        for <stable@vger.kernel.org>; Wed, 24 Dec 2025 02:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766573011; x=1767177811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1xHU9mQPsJeek2O22o16AKV8gYUfyitTbWLfmUirCg=;
        b=DkIj5Kipy/q3wGs0d7ybt1BqzKyW99Rs/I2bgj2OPP4FFf88SrxV3/KkYu1KYvONfm
         GAzdFce/LnBukh6G7ZRIVAALiZ8TtPV9dyZH7QB1hVBUfh3TjuOJl2T8t/tWIh+WrX8+
         N/qxrUYBY+ahJ7vFfExQgT9fz7OHG38nPBR6bYk3WvMrUAj0m7oLeTY+9mxwWJ3hXn5f
         Msd/8dASNYwV6qXAX7l3BHiHbuxsLjR8+Y8RUAxVK0dxZWnIc+Ue8kzGaa/qfc5a31lS
         wqYERVdig7bmo2UdKBzCFfRGPmq8sjOUIYnA+gltYw8IxHJKuiZ1/SGn3bmAIAbJxh/7
         A9pg==
X-Gm-Message-State: AOJu0YyZUdrbroX6KMeEslWX7l53NpUdGqMo9mZBdpCJ8EGrspO22Bpy
	yQcAvB4abcoufnn9GaZFQWxPM2x2179Yt9XWQv+8et9jrGmG6hjfEC7X67Pq9dcNWPajLEwTX7v
	+gBbFsjQVU4TLDM50FZgm+fTzgnuP3HI9a8ezPyLwD/aAfNOqSv/2AJoXhSUVSel3a8egde00fY
	JnB/yj+0SD1xB2g4lwgk72pEyc7MFW/LzZbDJYd7WMcStXxprui0eg4dqXHgdkzixIJv6JdkcTX
	ins3qXqELE=
X-Gm-Gg: AY/fxX5x0kJLQTWBK/RWAnOXv/4Dxq80k/NiAQRBGfamu1Ty+6GF1KJszRyg+EiXSaI
	P10Us5giAZQM8dESCnHKr8nR0eL91kKp4JtM52h02Me80wJXJCchJndEez/giYRTmcX6oh2v/Nn
	nQ1xNkQDhSpWT+pkYrerc943G1pdVxP31jF5OEFEMnuQneDCjq2rKe0QrtnRr57AYCc74CA2pAe
	sj+/BadDe5AOKDhp/5LnZr+w71onpaxqImNZ9itmBL6Y/5gmTOKqVfTzrwcBqywknfidADt0GZi
	Tz59S+GfhmveumN4EgAvXvVlE+Ij5IqpeunRgFLIcKaxOi6m+JqDSne9HSiKXgeRAJGIIXHqPrd
	9C4oBWco8h59CGXf9qz+foPF54wa9xCtepz55WfIOP9DnNz5w5/BSVCDQDYvOMU8I2TToG/zUJh
	yJ7h4TtDMpkwK17JALjtTMDPBzjJdcIMZ8vF7W4I8N5Q==
X-Google-Smtp-Source: AGHT+IFya6L2/rcLnYVucA9EnZUDX9B3kXhoS4s6cq+VFGu4iBQoR2VLVEM1ARZJs5K3aX/WF1+5us4QVZJu
X-Received: by 2002:a17:903:b83:b0:295:5972:4363 with SMTP id d9443c01a7336-2a2f1f6bcb9mr184683185ad.0.1766573010860;
        Wed, 24 Dec 2025 02:43:30 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-10.dlp.protect.broadcom.com. [144.49.247.10])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a2f3d1c1f5sm18378585ad.49.2025.12.24.02.43.30
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Dec 2025 02:43:30 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-bddf9ce4935so5484227a12.1
        for <stable@vger.kernel.org>; Wed, 24 Dec 2025 02:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766573009; x=1767177809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1xHU9mQPsJeek2O22o16AKV8gYUfyitTbWLfmUirCg=;
        b=QTmAy/0lhBwTUuXiJ1YMYwi50qJYtNKPJpcxWB7x2ryvpR9tTAOozIjhOn9XgxGJJq
         AGPLXbA8uzA5VgWTXpbgIVFdsovq+sCFMijuP9tai6Pq2zON7lTHn9pBdQk+en+qgklm
         3Yo8lril5Tnx6gxBGRIMDBfhu4vXAy9E8hGpU=
X-Received: by 2002:a05:7022:670b:b0:11a:fec5:d005 with SMTP id a92af1059eb24-121721aab84mr18748477c88.10.1766573008950;
        Wed, 24 Dec 2025 02:43:28 -0800 (PST)
X-Received: by 2002:a05:7022:670b:b0:11a:fec5:d005 with SMTP id a92af1059eb24-121721aab84mr18748454c88.10.1766573008224;
        Wed, 24 Dec 2025 02:43:28 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm68746919c88.13.2025.12.24.02.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:43:27 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Ma Wupeng <mawupeng1@huawei.com>,
	syzbot+5f488e922d047d8f00cc@syzkaller.appspotmail.com,
	Alexander Ofitserov <oficerovas@altlinux.org>
Subject: [PATCH v6.1 1/2] x86/mm/pat: clear VM_PAT if copy_p4d_range failed
Date: Wed, 24 Dec 2025 10:24:31 +0000
Message-Id: <20251224102432.923410-2-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251224102432.923410-1-ajay.kaher@broadcom.com>
References: <20251224102432.923410-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Ma Wupeng <mawupeng1@huawei.com>

[ Upstream commit d155df53f31068c3340733d586eb9b3ddfd70fc5 ]

Syzbot reports a warning in untrack_pfn().  Digging into the root we found
that this is due to memory allocation failure in pmd_alloc_one.  And this
failure is produced due to failslab.

In copy_page_range(), memory alloaction for pmd failed.  During the error
handling process in copy_page_range(), mmput() is called to remove all
vmas.  While untrack_pfn this empty pfn, warning happens.

Here's a simplified flow:

dup_mm
  dup_mmap
    copy_page_range
      copy_p4d_range
        copy_pud_range
          copy_pmd_range
            pmd_alloc
              __pmd_alloc
                pmd_alloc_one
                  page = alloc_pages(gfp, 0);
                    if (!page)
                      return NULL;
    mmput
        exit_mmap
          unmap_vmas
            unmap_single_vma
              untrack_pfn
                follow_phys
                  WARN_ON_ONCE(1);

Since this vma is not generate successfully, we can clear flag VM_PAT.  In
this case, untrack_pfn() will not be called while cleaning this vma.

Function untrack_pfn_moved() has also been renamed to fit the new logic.

Link: https://lkml.kernel.org/r/20230217025615.1595558-1-mawupeng1@huawei.com
Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
Reported-by: <syzbot+5f488e922d047d8f00cc@syzkaller.appspotmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
Cc: stable@vger.kernel.org
[ Ajay: Modified to apply on v6.1 ]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 arch/x86/mm/pat/memtype.c | 12 ++++++++----
 include/linux/pgtable.h   |  7 ++++---
 mm/memory.c               |  1 +
 mm/mremap.c               |  2 +-
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index d6fe9093e..1ad881017 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -1137,11 +1137,15 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 }
 
 /*
- * untrack_pfn_moved is called, while mremapping a pfnmap for a new region,
- * with the old vma after its pfnmap page table has been removed.  The new
- * vma has a new pfnmap to the same pfn & cache type with VM_PAT set.
+ * untrack_pfn_clear is called if the following situation fits:
+ *
+ * 1) while mremapping a pfnmap for a new region,  with the old vma after
+ * its pfnmap page table has been removed.  The new vma has a new pfnmap
+ * to the same pfn & cache type with VM_PAT set.
+ * 2) while duplicating vm area, the new vma fails to copy the pgtable from
+ * old vma.
  */
-void untrack_pfn_moved(struct vm_area_struct *vma)
+void untrack_pfn_clear(struct vm_area_struct *vma)
 {
 	vma->vm_flags &= ~VM_PAT;
 }
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 82d78cba7..500a612ff 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1214,9 +1214,10 @@ static inline void untrack_pfn(struct vm_area_struct *vma,
 }
 
 /*
- * untrack_pfn_moved is called while mremapping a pfnmap for a new region.
+ * untrack_pfn_clear is called while mremapping a pfnmap for a new region
+ * or fails to copy pgtable during duplicate vm area.
  */
-static inline void untrack_pfn_moved(struct vm_area_struct *vma)
+static inline void untrack_pfn_clear(struct vm_area_struct *vma)
 {
 }
 #else
@@ -1228,7 +1229,7 @@ extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 extern int track_pfn_copy(struct vm_area_struct *vma);
 extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 			unsigned long size);
-extern void untrack_pfn_moved(struct vm_area_struct *vma);
+extern void untrack_pfn_clear(struct vm_area_struct *vma);
 #endif
 
 #ifdef CONFIG_MMU
diff --git a/mm/memory.c b/mm/memory.c
index 454d91844..41a03adcf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1335,6 +1335,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 			continue;
 		if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
 					    addr, next))) {
+			untrack_pfn_clear(dst_vma);
 			ret = -ENOMEM;
 			break;
 		}
diff --git a/mm/mremap.c b/mm/mremap.c
index 930f65c31..6ed28eeae 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -682,7 +682,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 
 	/* Tell pfnmap has moved from this vma */
 	if (unlikely(vma->vm_flags & VM_PFNMAP))
-		untrack_pfn_moved(vma);
+		untrack_pfn_clear(vma);
 
 	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
 		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
-- 
2.40.4


