Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C656B74BFE5
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 01:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGHXER (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 8 Jul 2023 19:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGHXEQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 8 Jul 2023 19:04:16 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21AEE5E
        for <stable@vger.kernel.org>; Sat,  8 Jul 2023 16:04:11 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-579e5d54e68so39342937b3.1
        for <stable@vger.kernel.org>; Sat, 08 Jul 2023 16:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688857451; x=1691449451;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O+qLESJCRFN7dcIsyw3NJtjwIsXtHYZLjT5v4tk5DvU=;
        b=mgCi5qSaZ0QN848AO4FEdlrrUOrB86sH23LbXPcpsn4qyESlzAQawFfOF04UBU4Kgv
         9/lqmDRKXg+cqWxZ2Jzz8dSkhhwyJvxS413AvX/bJBFnXjkhbSF26g90mSr+UkOXy8qt
         Lg0ffkvvfGuyQCAHGQNyalDtsOWJwlyjwicSAZnEWb8DRbiUVaPqcJE1hmf3pb5JbHCV
         F+aCGx7iX12vcDpSmC0d09+31EprSu+CfzDgy+pt2tM4zg6JDFCADKQwoJX7LmkAFVnW
         HfnY7DNlbwjqy3xmZ1ahFCq1H6iUoXJC9PL/ZtQyNPupEGpCxTeiUlFqcf0amr0w6t44
         ARKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688857451; x=1691449451;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+qLESJCRFN7dcIsyw3NJtjwIsXtHYZLjT5v4tk5DvU=;
        b=kQhuTdmiZdFhIuBrxV6P3mhRZk7xIroe+3mx1sqOHn2WH2g1JODVRWJfv39J91oEPD
         CkdOCDvgUhQG6UZh7pg7FgjNOnF3/3G1Ds1f+fRdHgfWWkO/faOW47lKNuAp/Ep4sr6D
         ug/VFXWDbTrfVl1lvW7frAB5gLjRSesAL9yqGtTvNH23W5Z46/6Bqk6M0qKrt5Tfkh9D
         sdnz5uXDLNBshuSrVFE8i0CwTB9XJf4sZeRibyiN+MsP0oIaGVUVQGh+UE5Uo14ux2FS
         2cV2wax2zK4YJYMNM0NXyduaCLiHzoEypZIrpMOFLOElh7/2qVtukFuwdWkTyuuIOcHC
         wPwQ==
X-Gm-Message-State: ABy/qLZCv4qp+9aYHr/sNExvvLxikzupnCdIl/uiyopJDKy6EUTmt25q
        YVjFlX0c9Aljogd6cosOjEonCw==
X-Google-Smtp-Source: APBJJlHxsUrb2PsB8Vr/SdiFDl5l/hnimxuzYl85A5so5Ag/YE5k+SY0YoZnZodNyJi7fr5g0LxUxA==
X-Received: by 2002:a81:4e87:0:b0:573:527b:747b with SMTP id c129-20020a814e87000000b00573527b747bmr8684830ywb.36.1688857450765;
        Sat, 08 Jul 2023 16:04:10 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d205-20020a8168d6000000b0056cd3e598d8sm2108255ywc.114.2023.07.08.16.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 16:04:10 -0700 (PDT)
Date:   Sat, 8 Jul 2023 16:04:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        regressions@leemhuis.info, bagasdotme@gmail.com,
        jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, stable@vger.kernel.org
Subject: [PATCH] mm: lock newly mapped VMA with corrected ordering
Message-ID: <b5a5626-2684-899d-874b-801e7974b17@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Lockdep is certainly right to complain about
(&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_write+0x2d/0x3f
               but task is already holding lock:
(&mapping->i_mmap_rwsem){+.+.}-{3:3}, at: mmap_region+0x4dc/0x6db
Invert those to the usual ordering.

Fixes: 33313a747e81 ("mm: lock newly mapped VMA which can be modified after it becomes visible")
Cc: stable@vger.kernel.org
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 84c71431a527..3eda23c9ebe7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2809,11 +2809,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (vma_iter_prealloc(&vmi))
 		goto close_and_free_vma;
 
+	/* Lock the VMA since it is modified after insertion into VMA tree */
+	vma_start_write(vma);
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
 
-	/* Lock the VMA since it is modified after insertion into VMA tree */
-	vma_start_write(vma);
 	vma_iter_store(&vmi, vma);
 	mm->map_count++;
 	if (vma->vm_file) {
-- 
2.35.3
