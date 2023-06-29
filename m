Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE0742C67
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjF2SsZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjF2SsY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:48:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF452D69
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7B01615F7
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01747C433C8;
        Thu, 29 Jun 2023 18:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064501;
        bh=Rqn+tf1KvsjMspe8JE1sSAvChCRRPOEzwcoTKygBHLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOUD97hhWaMkBuSoDxv9gKeXlXzAQiyLOKmlOwwWJpU4nxU2k3ks4TMn1EuxNM2RH
         u4Lnqh9DE4ADWOvo8CWC9tQ95Uht78ZJOfaYcZ7fVMIF6yQkBPta3hrnSpVFm5mIo6
         +IdNxiXPqNg5madydrapWU6f7nFQW+7SkNI/PnL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.4 23/28] gup: add warning if some caller would seem to want stack expansion
Date:   Thu, 29 Jun 2023 20:44:11 +0200
Message-ID: <20230629184152.797695288@linuxfoundation.org>
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

commit a425ac5365f6cb3cc47bf83e6bff0213c10445f7 upstream.

It feels very unlikely that anybody would want to do a GUP in an
unmapped area under the stack pointer, but real users sometimes do some
really strange things.  So add a (temporary) warning for the case where
a GUP fails and expanding the stack might have made it work.

It's trivial to do the expansion in the caller as part of getting the mm
lock in the first place - see __access_remote_vm() for ptrace, for
example - it's just that it's unnecessarily painful to do it deep in the
guts of the GUP lookup when we might have to drop and re-take the lock.

I doubt anybody actually does anything quite this strange, but let's be
proactive: adding these warnings is simple, and will make debugging it
much easier if they trigger.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/gup.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1096,7 +1096,11 @@ static long __get_user_pages(struct mm_s
 
 		/* first iteration or cross vma bound */
 		if (!vma || start >= vma->vm_end) {
-			vma = vma_lookup(mm, start);
+			vma = find_vma(mm, start);
+			if (vma && (start < vma->vm_start)) {
+				WARN_ON_ONCE(vma->vm_flags & VM_GROWSDOWN);
+				vma = NULL;
+			}
 			if (!vma && in_gate_area(mm, start)) {
 				ret = get_gate_page(mm, start & PAGE_MASK,
 						gup_flags, &vma,
@@ -1265,9 +1269,13 @@ int fixup_user_fault(struct mm_struct *m
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 retry:
-	vma = vma_lookup(mm, address);
+	vma = find_vma(mm, address);
 	if (!vma)
 		return -EFAULT;
+	if (address < vma->vm_start ) {
+		WARN_ON_ONCE(vma->vm_flags & VM_GROWSDOWN);
+		return -EFAULT;
+	}
 
 	if (!vma_permits_fault(vma, fault_flags))
 		return -EFAULT;


