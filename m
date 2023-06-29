Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4026B742C61
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjF2SsN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjF2SsI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:48:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4105E3582
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EE9161575
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF026C433C0;
        Thu, 29 Jun 2023 18:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064483;
        bh=D7KJx60x+QIR843AUu2dYTtKXW5BaTZlh6/dIjVYVf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YFJGRLfTzAPli1g1bMdT+2T4bq0HR0ZeIAUuZMmzQrfTdJ61n2tx4n4PKhRtKxsXo
         SHBsXtJ1KBGDmWYeugwcThQ3fg08XYYCZjQuAGPAQoiokV2Qzo0SkhLQBrV43BEdfU
         IfS/7to0FgmK4xsZSSEjyrnmf4CL4sZ0HwqoKESk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.4 18/28] powerpc/mm: convert coprocessor fault to lock_mm_and_find_vma()
Date:   Thu, 29 Jun 2023 20:44:06 +0200
Message-ID: <20230629184152.624917276@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.888604958@linuxfoundation.org>
References: <20230629184151.888604958@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 2cd76c50d0b41cec5c87abfcdf25b236a2793fb6 upstream.

This is one of the simple cases, except there's no pt_regs pointer.
Which is fine, as lock_mm_and_find_vma() is set up to work fine with a
NULL pt_regs.

Powerpc already enabled LOCK_MM_AND_FIND_VMA for the main CPU faulting,
so we can just use the helper without any extra work.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/copro_fault.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -33,19 +33,11 @@ int copro_handle_mm_fault(struct mm_stru
 	if (mm->pgd == NULL)
 		return -EFAULT;
 
-	mmap_read_lock(mm);
-	ret = -EFAULT;
-	vma = find_vma(mm, ea);
+	vma = lock_mm_and_find_vma(mm, ea, NULL);
 	if (!vma)
-		goto out_unlock;
-
-	if (ea < vma->vm_start) {
-		if (!(vma->vm_flags & VM_GROWSDOWN))
-			goto out_unlock;
-		if (expand_stack(vma, ea))
-			goto out_unlock;
-	}
+		return -EFAULT;
 
+	ret = -EFAULT;
 	is_write = dsisr & DSISR_ISSTORE;
 	if (is_write) {
 		if (!(vma->vm_flags & VM_WRITE))


