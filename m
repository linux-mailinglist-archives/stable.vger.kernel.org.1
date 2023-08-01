Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB8A76C016
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 00:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjHAWHr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 18:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjHAWHq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 18:07:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A1F212A
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 15:07:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d3563cb3748so1926380276.0
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 15:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690927663; x=1691532463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4DFBzP3PjGN+0KSVb5wBxy1Zq6atXukCZSiVwP2lCA4=;
        b=yfrnQPSjeIcEe1QiQGFJbsVHjwcAuLH5y1rpwsS9p+vhZ0UwR6PwXsX+lyRO8LZqne
         i0Gs4sb/UQu9JzPwvqM6DFSny+pA/wf1YWY/9cDzKMMSVuqNYknBZN4RDzqEJ+3tgA1o
         9xqYOQ9YfNuN7rSMd/QL10WuKbuUb09YlooNQnxevr0KyYMiTseErJlZMTiswhp4rbGs
         2EwfGVOHZ8kOe74pKMJDxDRfvODcH40dPPxzmE/4CBhsbsPSTt0MJcXPagBusQWf3TL+
         2RYrhvVai3uiHNprCu8Jx7kGArbzCMBXdmuc0K6o1xx5D3e1kBTjmNATzd4hCjxzlGtv
         8JyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690927663; x=1691532463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DFBzP3PjGN+0KSVb5wBxy1Zq6atXukCZSiVwP2lCA4=;
        b=beVlaaWuO28wsI48+1c0zRg7w0btx5c8nWVVM9JV/A7KJKG4EE7GWogQXU1oF7NarB
         OLQXrt1BGYxd4dR4m6kIv7tNqpZ0H1WkvRMbtIT/KrAEKffnLU/HhACIs/0sGJPqaWw8
         BiG/gq3uHdiM2k9n8XOJYAmtUC7Jhmde/2SRVKM8EVb+xujn4MFMFTfODysYlkoa8aHN
         HIj2HYuxp34aukUaYHjHkmGm6SJg7E/+AMYkT8jlP52EaTo0dQiPL7K/Sg9fK4XWUxvy
         FbBafcL5rABuHJmYBk4ond3URZgcDe3w7B2pukLh1BLH2acUQRuiY9bV4s1ETvyQsr1m
         wskw==
X-Gm-Message-State: ABy/qLaCZ/zelhgjOK87PvfHWR/mbTt2r0K6Q0cynT/Be6ohTXmdqp5f
        Swgi9+sIraS9U85Sw6SjGICxBn7xGRc=
X-Google-Smtp-Source: APBJJlFt7bPUCzTOSC2YtD5VNpVA2kL+fFs0SLmjXp2yCsxE/K0tlsB3vCbnSPBXi96wBKaf36lZ9Vrga8w=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:211c:a2ff:f17b:c5e9])
 (user=surenb job=sendgmr) by 2002:a25:d246:0:b0:c61:7151:6727 with SMTP id
 j67-20020a25d246000000b00c6171516727mr103919ybg.10.1690927663525; Tue, 01 Aug
 2023 15:07:43 -0700 (PDT)
Date:   Tue,  1 Aug 2023 15:07:29 -0700
In-Reply-To: <20230801220733.1987762-1-surenb@google.com>
Mime-Version: 1.0
References: <20230801220733.1987762-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801220733.1987762-4-surenb@google.com>
Subject: [PATCH v2 3/6] mm: replace mmap with vma write lock assertions when
 operating on a vma
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Vma write lock assertion always includes mmap write lock assertion and
additional vma lock checks when per-VMA locks are enabled. Replace
weaker mmap_assert_write_locked() assertions with stronger
vma_assert_write_locked() ones when we are operating on a vma which
is expected to be locked.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/hugetlb.c    | 2 +-
 mm/khugepaged.c | 5 +++--
 mm/memory.c     | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 64a3239b6407..1d871a1167d8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5028,7 +5028,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					src_vma->vm_start,
 					src_vma->vm_end);
 		mmu_notifier_invalidate_range_start(&range);
-		mmap_assert_write_locked(src);
+		vma_assert_write_locked(src_vma);
 		raw_write_seqcount_begin(&src->write_protect_seq);
 	} else {
 		/*
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 78c8d5d8b628..1e43a56fba31 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1495,7 +1495,7 @@ static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
 	};
 
 	VM_BUG_ON(!PageTransHuge(hpage));
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_assert_write_locked(vma);
 
 	if (do_set_pmd(&vmf, hpage))
 		return SCAN_FAIL;
@@ -1525,7 +1525,7 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
 	pmd_t pmd;
 	struct mmu_notifier_range range;
 
-	mmap_assert_write_locked(mm);
+	vma_assert_write_locked(vma);
 	if (vma->vm_file)
 		lockdep_assert_held_write(&vma->vm_file->f_mapping->i_mmap_rwsem);
 	/*
@@ -1570,6 +1570,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	int count = 0, result = SCAN_FAIL;
 	int i;
 
+	/* Ensure vma can't change, it will be locked below after checks */
 	mmap_assert_write_locked(mm);
 
 	/* Fast check before locking page if already PMD-mapped */
diff --git a/mm/memory.c b/mm/memory.c
index 603b2f419948..652d99b9858a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1312,7 +1312,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		 * Use the raw variant of the seqcount_t write API to avoid
 		 * lockdep complaining about preemptibility.
 		 */
-		mmap_assert_write_locked(src_mm);
+		vma_assert_write_locked(src_vma);
 		raw_write_seqcount_begin(&src_mm->write_protect_seq);
 	}
 
-- 
2.41.0.585.gd2178a4bd4-goog

