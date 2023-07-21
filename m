Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D7C75CE56
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjGUQUV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjGUQUA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:20:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA8C422C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A096C61D2A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C5DC433C8;
        Fri, 21 Jul 2023 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956325;
        bh=G3vJ3bjzoxsnq6dSG07XAiqaRd6eJXwgYCa+87FIYmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+mnNQErMyiUtFmOOb3YNquBh45bNErCBH3WzfwpXX/mXdBWxmfqfOfiyUBukEgaT
         iWV4QDZvzhjqyV7TofiZTsayTWWau1Tuku8vPCME5TXOLe5kQ0FD29ycK/2qmj6A7D
         r1Xjaov+bWK8oEsqV0FkiO4wFwcwprE4wh1GDFXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Woodhouse <dwmw@amazon.co.uk>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 6.4 159/292] mm/mmap: Fix error return in do_vmi_align_munmap()
Date:   Fri, 21 Jul 2023 18:04:28 +0200
Message-ID: <20230721160535.737377624@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

commit 6c26bd4384da24841bac4f067741bbca18b0fb74 upstream.

If mas_store_gfp() in the gather loop failed, the 'error' variable that
ultimately gets returned was not being set. In many cases, its original
value of -ENOMEM was still in place, and that was fine. But if VMAs had
been split at the start or end of the range, then 'error' could be zero.

Change to the 'error = foo(); if (error) goto …' idiom to fix the bug.

Also clean up a later case which avoided the same bug by *explicitly*
setting error = -ENOMEM right before calling the function that might
return -ENOMEM.

In a final cosmetic change, move the 'Point of no return' comment to
*after* the goto. That's been in the wrong place since the preallocation
was removed, and this new error path was added.

Fixes: 606c812eb1d5 ("mm/mmap: Fix error path in do_vmi_align_munmap()")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mmap.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2480,7 +2480,8 @@ do_vmi_align_munmap(struct vma_iterator
 		}
 		vma_start_write(next);
 		mas_set_range(&mas_detach, next->vm_start, next->vm_end - 1);
-		if (mas_store_gfp(&mas_detach, next, GFP_KERNEL))
+		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
+		if (error)
 			goto munmap_gather_failed;
 		vma_mark_detached(next, true);
 		if (next->vm_flags & VM_LOCKED)
@@ -2529,12 +2530,12 @@ do_vmi_align_munmap(struct vma_iterator
 		BUG_ON(count != test_count);
 	}
 #endif
-	/* Point of no return */
-	error = -ENOMEM;
 	vma_iter_set(vmi, start);
-	if (vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL))
+	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
+	if (error)
 		goto clear_tree_failed;
 
+	/* Point of no return */
 	mm->locked_vm -= locked_vm;
 	mm->map_count -= count;
 	/*


