Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324A3706C34
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 17:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjEQPHZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 11:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjEQPHL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 11:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA02DC49
        for <stable@vger.kernel.org>; Wed, 17 May 2023 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684335931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5R80nbUZwWFiHdR78rMDNlvBGteEPIxCifWqkv+jAN8=;
        b=cXCnBerYyBuztBZKPgcnZRocb3bw/Nt7ekfOkIWZZnmEFg+mC6aHP6qslkQcDgJca+p5+I
        a7Xt0KmrJc49IuLTSZpZjQb3dGud7NDwKH29+BdrK1vNCYlOGKgzCqaD8COYcNzQdUzNdl
        ryTUWqKCPQnCxwYLDzxY1F0KnVe6EmY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-KiuX7KALNsOUYPgKTGCfFg-1; Wed, 17 May 2023 11:04:14 -0400
X-MC-Unique: KiuX7KALNsOUYPgKTGCfFg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-61b6f717b6eso1822376d6.0
        for <stable@vger.kernel.org>; Wed, 17 May 2023 08:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335853; x=1686927853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5R80nbUZwWFiHdR78rMDNlvBGteEPIxCifWqkv+jAN8=;
        b=a/t83fC9Z9FWUk3U36gNRG5PGfCwj0IUtHIC18DPOzg+sRlhRtW9wVnFFalhiO4C1R
         5fSZnxbWswm50knsCTXgNSJEECnGs8X+F2V0+MaOgFIZHdNW2PSXOXLC+SXX/76hMdOf
         cZtI51UFKOgSl726NwUdJ1h9968G0ob9Tr9kirrvelVsZYz6TzcmQA/moTR6kffYAfm0
         5Ao8BbMQd+09wp0GP7zYeWzVHbQzzx23/PDED1Df30FW4fc4g38FaFgjKixkYS1pkYpc
         kf19UOyO0wWOIm8JuSh3WHN2DrCQ4U4mH0MkAGfN/1MkSXAILl8YBA9MZyb8vQtOtwz1
         BdwQ==
X-Gm-Message-State: AC+VfDydHyvR/mO6FQbR3QpNyG6pJC5IzOIC/5hiEnZdWk3hJcvOf0jW
        bRJoZqNiMFHchldjKXN2K/+XTXb40fTV8SArwtTCWsPecnYrNI8qus2N5PgCpZoLgiUWLPilQpD
        ykRfeZiPY0uNBR5IB
X-Received: by 2002:a05:6214:cc8:b0:623:5678:1285 with SMTP id 8-20020a0562140cc800b0062356781285mr5664665qvx.2.1684335852781;
        Wed, 17 May 2023 08:04:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4A7kugtT7Bx+EHF80tM99neHimNnRwy8AYQ2bdr/AsAi1MAhOSAI8qAPppaefRrYgb8kIRbA==
X-Received: by 2002:a05:6214:cc8:b0:623:5678:1285 with SMTP id 8-20020a0562140cc800b0062356781285mr5664630qvx.2.1684335852517;
        Wed, 17 May 2023 08:04:12 -0700 (PDT)
Received: from x1n.. (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a120a00b0074d4cf8f9fcsm661141qkj.107.2023.05.17.08.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:04:11 -0700 (PDT)
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
Subject: [PATCH 1/2] mm/uffd: Fix vma operation where start addr cuts part of vma
Date:   Wed, 17 May 2023 11:04:07 -0400
Message-Id: <20230517150408.3411044-2-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230517150408.3411044-1-peterx@redhat.com>
References: <20230517150408.3411044-1-peterx@redhat.com>
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

The problem is in the current code base we didn't fixup "prev" for the case
where "start" address can be within the "prev" vma section.  In that case
we should have "prev" points to the current vma rather than the previous
one when feeding to vma_merge().

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

