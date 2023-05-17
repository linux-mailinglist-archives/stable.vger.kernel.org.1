Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4D1706C28
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 17:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjEQPGk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 11:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjEQPG0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 11:06:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F69AA5D1
        for <stable@vger.kernel.org>; Wed, 17 May 2023 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684335884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ms+Yw6xLDbHeWgltH2GeZ/mYx1EXxuQy0fD+zKwpp0k=;
        b=i4DtzBATErjbTK0ebW6E3IVdQ3T9ODteE5deU8VFZT5X8NFnSBTxUr9j+iic8cDAuU+Jzt
        lgVUJUCm3smSlLV9N7QwkxlrQtFF5vN0/+xF8QImCJ4DM9mqkVlTATG8umkWKDS2HoSMQ4
        OB4MDIPK87cp0D3JzBFPy/PSZJhnqKI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-AAHihqafOpuOwTeGUQGULA-1; Wed, 17 May 2023 11:04:15 -0400
X-MC-Unique: AAHihqafOpuOwTeGUQGULA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f5099edb1cso1489601cf.0
        for <stable@vger.kernel.org>; Wed, 17 May 2023 08:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335855; x=1686927855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ms+Yw6xLDbHeWgltH2GeZ/mYx1EXxuQy0fD+zKwpp0k=;
        b=YM9veV0C4M4YAAg2L7e4diwyBFexNoh9cvNLcMT1nA6S8WyCuM2rEqCgBnwW5jEdsa
         k5MYuhNRon9MFmIFU5pvOIvR2WE/Dz7OCtCg4js8A6a0pKpv2LqkGhxvB2f5GFMwo2BM
         L/ZkO3GryqFnoUuRD2mzwueQ4IPUDM/5ZdUHRGe25YFpbdffdO87ETooTsspqiSAa3MI
         7Pdyr6wkdr9tJDu+STMMh8Qi0hNX22g3wqKKlD3VTkxkrb25+vPUJXtlDnor8C/Nb8Ua
         UCH/XccKhrZ94TtvhezzRdhdC36L1C6BlWQ73SbAMtfJrkTEzdQYGFhyMz5O1KkVz2pP
         jJqA==
X-Gm-Message-State: AC+VfDzy8JiROCpIGN767BRno2P5j8F2f1G/344qpIcSwgeMr4V+fAHV
        sSqjp3HlH35W9k0q21Dh3cjGxK0lryNGIjUe0RQx/gvWkjXF9GtnFVQz4WwRe5XVG0EycAnsFVx
        nMxHST5MqNNY2RaNc
X-Received: by 2002:a05:622a:1a9e:b0:3f4:e9bc:22e with SMTP id s30-20020a05622a1a9e00b003f4e9bc022emr5674300qtc.6.1684335854895;
        Wed, 17 May 2023 08:04:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6hB1PyGgcmxyQUgGB/Eq0H7OvCFFhm3wB8MI1WHZGGvhbCG9ZQuuvRPeeeoIz0SVcyOGZnxg==
X-Received: by 2002:a05:622a:1a9e:b0:3f4:e9bc:22e with SMTP id s30-20020a05622a1a9e00b003f4e9bc022emr5674272qtc.6.1684335854592;
        Wed, 17 May 2023 08:04:14 -0700 (PDT)
Received: from x1n.. (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a120a00b0074d4cf8f9fcsm661141qkj.107.2023.05.17.08.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:04:13 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>, peterx@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-stable <stable@vger.kernel.org>
Subject: [PATCH 2/2] mm/uffd: Allow vma to merge as much as possible
Date:   Wed, 17 May 2023 11:04:08 -0400
Message-Id: <20230517150408.3411044-3-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230517150408.3411044-1-peterx@redhat.com>
References: <20230517150408.3411044-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

We used to not pass in the pgoff correctly when register/unregister uffd
regions, it caused incorrect behavior on vma merging and can cause
mergeable vmas being separate after ioctls return.

For example, when we have:

  vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)

Then someone unregisters uffd on range (5-9), it should logically become:

  vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)

But with current code we'll have:

  vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)

This patch allows such merge to happen correctly before ioctl returns.

This behavior seems to have existed since the 1st day of uffd.  Since pgoff
for vma_merge() is only used to identify the possibility of vma merging,
meanwhile here what we did was always passing in a pgoff smaller than what
we should, so there should have no other side effect besides not merging
it.  Let's still tentatively copy stable for this, even though I don't see
anything will go wrong besides vma being split (which is mostly not user
visible).

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: linux-stable <stable@vger.kernel.org>
Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 17c8c345dac4..4e800bb7d2ab 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1332,6 +1332,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
 	struct vma_iterator vmi;
+	pgoff_t pgoff;
 
 	user_uffdio_register = (struct uffdio_register __user *) arg;
 
@@ -1484,8 +1485,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma_end = min(end, vma->vm_end);
 
 		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
+		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
-				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
+				 vma->anon_vma, vma->vm_file, pgoff,
 				 vma_policy(vma),
 				 ((struct vm_userfaultfd_ctx){ ctx }),
 				 anon_vma_name(vma));
@@ -1565,6 +1567,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	unsigned long start, end, vma_end;
 	const void __user *buf = (void __user *)arg;
 	struct vma_iterator vmi;
+	pgoff_t pgoff;
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1667,8 +1670,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			uffd_wp_range(vma, start, vma_end - start, false);
 
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
+		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
-				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
+				 vma->anon_vma, vma->vm_file, pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
 		if (prev) {
-- 
2.39.1

