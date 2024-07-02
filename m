Return-Path: <stable+bounces-56312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E344A91EDE5
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 06:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91966285EC7
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 04:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7379B2D02E;
	Tue,  2 Jul 2024 04:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoFgC81S"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF9372
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 04:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719894599; cv=none; b=hNI9HLEBmTZgMMfXaHjt/lIJWxJWemO0PY6uExmY0LvPogq07hcy04serfjoPilQnaXVB7/ak86iS1qy2c857pdUwha8i3m707ucro2Bti+pvw2HS0FYrrHecc/dvEFMIIfYkiuSRovyaUczHgmEJ+benOFWCT1/VgziFwed7gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719894599; c=relaxed/simple;
	bh=zcixEUS6XsMOCRxjX6d6tG5bte/K0SaEark3niy57Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uildWr25hTBscYOI1NdlteV0WnwKftI1cxgFRVsEZ5sngOh3kyJpR07K3O5LbWAWCIKFBdk7r7Xj41Y06FrvuaJhLEqmbdUIO9JgKUqfkA9d1OHeVV/t6yzQv6m2a4IsSSLAn1th1mUKsuad4FZhMjsmUr9qlIPblhgckYZuM2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoFgC81S; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d84546a05bso571225b6e.1
        for <stable@vger.kernel.org>; Mon, 01 Jul 2024 21:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719894596; x=1720499396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/9ENtMAL2XpXCc3oQNvYhDVvO8Mw3hYfch7UFPZuHw=;
        b=RoFgC81S75nwm35bcN21ReDfGrTqeVkrwMmopOz8DaSdS//Th+g+DMibGQilWKwTmn
         Mv8VSC95QiJulhiB4br6LkycRT1mytLZe7+3+Fdmx146d7KE4sJukipY9fYQYgDHitmr
         B7SgdIWrYkfLIlYBkjMt3ucTqInZyco+8uO5nhJXbdZTGvq+ZpjlcznFJ9SqKWQ+Pdja
         ew1vOIJxSNhXMs8Vp1F/9S/SZcPNw5sf7cx0WIoFV/VfarR36+Qq3on/dYfM2dDSeUlR
         8DKD3TRDjFNlrQ3twgmmmH7h+7x1Eu4Cen7/S0x2FoTVJJnyNRcJmNG5t+OjfAwM6uEe
         SePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719894596; x=1720499396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/9ENtMAL2XpXCc3oQNvYhDVvO8Mw3hYfch7UFPZuHw=;
        b=EQ1Zp1Vz6OjEnaePpyh7dKpyaJdkSPvRfWrXituxBelhdJgeLIUBVRUO8eiS0WKhl+
         Rt8gAr3Wt99Vfn51N9vSzMcJSCTE/YFZZE9NS/gD1sMwYeQjJ7+xbupwCFRCi4G08zaZ
         4XlQAKb3mFTAZqGFU3293WNJwKJpSOFKDluys40J3dh5V5q6FauX25jS6vVIWKmdgLNl
         UpntZgxi6182WX3VYYSMnv53OG7axpyLhAS2f0LnqYt7Ti6TZAqOdzzQj1tQH0CRW2Ym
         erSyGcyElCMtlsCR6+lmbyrqKE8sgvCx0KkJogiShV6NAK5KuJf7ZhyKq3YzoPTbpvlz
         DeTQ==
X-Gm-Message-State: AOJu0Yw8fsxMgSaxjo5I14h24zc0YG7ShtUWLXVJi9P2oZ/0a6XmLp3e
	LCEd+HNu0qQ7YIFOsiF1UVFrt9iAO2R35Mvn9u0kM46gu6j+sFLM31EQ5dlI
X-Google-Smtp-Source: AGHT+IGO0UAZT5LW/Lp/IIwiZEThnWjumZUWITpOSy7S4lKPnuoMHiUl/3krYvVBVnZA167s8xDxmw==
X-Received: by 2002:a05:6808:1408:b0:3d5:5e73:1645 with SMTP id 5614622812f47-3d6afdb4752mr11463793b6e.0.1719894596452;
        Mon, 01 Jul 2024 21:29:56 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2a3:200:9e40:1748:c1c9:5ced])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a95fc4sm7378268b3a.215.2024.07.01.21.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 21:29:56 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	Thorvald Natvig <thorvald@google.com>,
	Jane Chu <jane.chu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.6] fork: defer linking file vma until vma is fully initialized
Date: Mon,  1 Jul 2024 21:29:48 -0700
Message-ID: <20240702042948.2629267-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miaohe Lin <linmiaohe@huawei.com>

commit 35e351780fa9d8240dd6f7e4f245f9ea37e96c19 upstream.

Thorvald reported a WARNING [1]. And the root cause is below race:

 CPU 1					CPU 2
 fork					hugetlbfs_fallocate
  dup_mmap				 hugetlbfs_punch_hole
   i_mmap_lock_write(mapping);
   vma_interval_tree_insert_after -- Child vma is visible through i_mmap tree.
   i_mmap_unlock_write(mapping);
   hugetlb_dup_vma_private -- Clear vma_lock outside i_mmap_rwsem!
					 i_mmap_lock_write(mapping);
   					 hugetlb_vmdelete_list
					  vma_interval_tree_foreach
					   hugetlb_vma_trylock_write -- Vma_lock is cleared.
   tmp->vm_ops->open -- Alloc new vma_lock outside i_mmap_rwsem!
					   hugetlb_vma_unlock_write -- Vma_lock is assigned!!!
					 i_mmap_unlock_write(mapping);

hugetlb_dup_vma_private() and hugetlb_vm_op_open() are called outside
i_mmap_rwsem lock while vma lock can be used in the same time.  Fix this
by deferring linking file vma until vma is fully initialized.  Those vmas
should be initialized first before they can be used.

Backport notes:

The first backport attempt (cec11fa2e) was reverted (dd782da4707). This is
the new backport of the original fix (35e351780fa9).

35e351780f ("fork: defer linking file vma until vma is fully initialized")
fixed a hugetlb locking race by moving a bunch of intialization code to earlier
in the function. The call to open() was included in the move but the call to
copy_page_range was not, effectively inverting their relative ordering. This
created an issue for the vfio code which assumes copy_page_range happens before
the call to open() - vfio's open zaps the vma so that the fault handler is
invoked later, but when we inverted the ordering, copy_page_range can set up
mappings post-zap which would prevent the fault handler from being invoked
later. This patch moves the call to copy_page_range to earlier than the call to
open() to restore the original ordering of the two functions while keeping the
fix for hugetlb intact.

Commit aac6db75a9 made several changes to vfio_pci_core.c, including
removing the vfio-pci custom open function. This resolves the issue on
the main branch and so we only need to apply these changes when
backporting to stable branches.

35e351780f ("fork: defer linking file vma until vma is fully initialized")-> v6.9-rc5
aac6db75a9 ("vfio/pci: Use unmap_mapping_range()") -> v6.10-rc4

Link: https://lkml.kernel.org/r/20240410091441.3539905-1-linmiaohe@huawei.com
Fixes: 8d9bfb260814 ("hugetlb: add vma based lock for pmd sharing")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reported-by: Thorvald Natvig <thorvald@google.com>
Closes: https://lore.kernel.org/linux-mm/20240129161735.6gmjsswx62o4pbja@revolver/T/ [1]
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: Tycho Andersen <tandersen@netflix.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 kernel/fork.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 177ce7438db6..122d2cd124d5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -727,6 +727,19 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
 		vm_flags_clear(tmp, VM_LOCKED_MASK);
+		/*
+		 * Copy/update hugetlb private vma information.
+		 */
+		if (is_vm_hugetlb_page(tmp))
+			hugetlb_dup_vma_private(tmp);
+
+		if (!(tmp->vm_flags & VM_WIPEONFORK) &&
+				copy_page_range(tmp, mpnt))
+			goto fail_nomem_vmi_store;
+
+		if (tmp->vm_ops && tmp->vm_ops->open)
+			tmp->vm_ops->open(tmp);
+
 		file = tmp->vm_file;
 		if (file) {
 			struct address_space *mapping = file->f_mapping;
@@ -743,25 +756,11 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			i_mmap_unlock_write(mapping);
 		}
 
-		/*
-		 * Copy/update hugetlb private vma information.
-		 */
-		if (is_vm_hugetlb_page(tmp))
-			hugetlb_dup_vma_private(tmp);
-
 		/* Link the vma into the MT */
 		if (vma_iter_bulk_store(&vmi, tmp))
 			goto fail_nomem_vmi_store;
 
 		mm->map_count++;
-		if (!(tmp->vm_flags & VM_WIPEONFORK))
-			retval = copy_page_range(tmp, mpnt);
-
-		if (tmp->vm_ops && tmp->vm_ops->open)
-			tmp->vm_ops->open(tmp);
-
-		if (retval)
-			goto loop_out;
 	}
 	/* a new mm has just been created */
 	retval = arch_dup_mmap(oldmm, mm);
-- 
2.45.2.803.g4e1b14247a-goog


