Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4D870718D
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 21:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjEQTKd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjEQTKa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 15:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACBD903C
        for <stable@vger.kernel.org>; Wed, 17 May 2023 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684350565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0vLIGQ76sSG5EGgMh6kBM7wgWyPxuvXNfJPYChH6HQ=;
        b=DA+BjAMAeQNnwDFXUzHSxYc8t7ur7rUlG3VnueIAjwGOEWvI2l0PIbIcWrC3v0FQsW0vpO
        PNbvZnxynhHp5XzGcYXaWzRefVy9Y3vKGYoTENcfuKSTm1GOqUurhwKPo9k1n1Cn3cCsc9
        q1Ljx+AuozUg2Azk9IBwO0TNhPQNXwc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-cz-5H6qvNlSSFa7fwbz-dw-1; Wed, 17 May 2023 15:09:23 -0400
X-MC-Unique: cz-5H6qvNlSSFa7fwbz-dw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f39195e7e5so2360081cf.0
        for <stable@vger.kernel.org>; Wed, 17 May 2023 12:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350562; x=1686942562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0vLIGQ76sSG5EGgMh6kBM7wgWyPxuvXNfJPYChH6HQ=;
        b=DsEr8+Ch5v5iQTMww8QF1RZN1ZDgWLMl5FgsM+u06/SbgnGO4IxOMqHP2cp3K69An1
         M2kdr43+r3OqJfcm/6T9kimZoQFOO528qKg7wLqvRJX66uPTmzApMACaHg4WpzD6RS3C
         qqzbEBo1TKuE/m48r6QUTpfLxasSxADHFa0T/LlZvPqzQmv3SnT0fXAaoe0XddH9P8DL
         1pAUaNxXA+NS0btr4oOnZsRpwsDB+Bp/AYYxLfx6T9ZO3bENqDHVTyEYjhxy7EVXlcyG
         gpznnEB9YpNuPgDO2StJ4IWqe9PH36vwYXQByLHurC4aYiHIG4HgrQMnwKBo8hilNo3h
         +UgQ==
X-Gm-Message-State: AC+VfDwQ42AVG8WR9xYV4ajU3JvWSxl4kMUUmQZYMfES6DB6qemV8arr
        mz5m4Am4IXogIHQw3M4Xh29DJoUmlUmnur1zlwpmOJY0da7EEQKSRlrTBA4Py9+A36p4FVvR3zn
        6QOL/cW9w+TQ4d9kj
X-Received: by 2002:a05:622a:2cd:b0:3ef:4614:d0de with SMTP id a13-20020a05622a02cd00b003ef4614d0demr6995407qtx.4.1684350561791;
        Wed, 17 May 2023 12:09:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7J2wzPLNuWb2xStmEdoJDaUJKipyb+2I0xjiFg3N5ksFe4XH0shtqnXZrCduoJFkiMn/Bkjw==
X-Received: by 2002:a05:622a:2cd:b0:3ef:4614:d0de with SMTP id a13-20020a05622a02cd00b003ef4614d0demr6995376qtx.4.1684350561541;
        Wed, 17 May 2023 12:09:21 -0700 (PDT)
Received: from x1n.. (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id k21-20020a05620a143500b0075954005b46sm833464qkj.48.2023.05.17.12.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:09:20 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@kernel.org>, peterx@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-stable <stable@vger.kernel.org>
Subject: [PATCH v2 1/2] mm/uffd: Fix vma operation where start addr cuts part of vma
Date:   Wed, 17 May 2023 15:09:15 -0400
Message-Id: <20230517190916.3429499-2-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230517190916.3429499-1-peterx@redhat.com>
References: <20230517190916.3429499-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

It seems vma merging with uffd paths is broken with either
register/unregister, where right now we can feed wrong parameters to
vma_merge() and it's found by recent patch which moved asserts upwards in
vma_merge() by Lorenzo Stoakes:

https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/

It's possible that "start" is contained within vma but not clamped to its
start.  We need to convert this into either "cannot merge" case or "can
merge" case 4 which permits subdivision of prev by assigning vma to
prev. As we loop, each subsequent VMA will be clamped to the start.

This patch will eliminate the report and make sure vma_merge() calls will
become legal again.

One thing to mention is that the "Fixes: 29417d292bd0" below is there only
to help explain where the warning can start to trigger, the real commit to
fix should be 69dbe6daf104.  Commit 29417d292bd0 helps us to identify the
issue, but unfortunately we may want to keep it in Fixes too just to ease
kernel backporters for easier tracking.

Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Fixes: 29417d292bd0 ("mm/mmap/vma_merge: always check invariants")
Fixes: 69dbe6daf104 ("userfaultfd: use maple tree iterator to iterate VMAs")
Closes: https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0fd96d6e39ce..17c8c345dac4 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1459,6 +1459,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 
 	vma_iter_set(&vmi, start);
 	prev = vma_prev(&vmi);
+	if (vma->vm_start < start)
+		prev = vma;
 
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
@@ -1625,6 +1627,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 
 	vma_iter_set(&vmi, start);
 	prev = vma_prev(&vmi);
+	if (vma->vm_start < start)
+		prev = vma;
+
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
-- 
2.39.1

