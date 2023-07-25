Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9FD76114C
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjGYKtl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGYKtk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:49:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157F11990
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:49:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A74A16167E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DB0C433C7;
        Tue, 25 Jul 2023 10:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282177;
        bh=/WSUJ4MZNBXEQFat0hm3g+FgNhjj2koOuWzKQ0ebEsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZeFrHeRDI7T+5UwUitYb0vZy+ZZHmFM1ilLlORImQVPAfhqISTiNQh75jZS07Hh/1
         qqdvwKvqvOARtkIxIEnNVnVdev3rWR2oqBYPIMfrdrcsfSliyrCpdiod+LVfJXMstT
         BIaHTmk5G6Rqq9VSlG8g1do7wGrm1Etie7gkg37E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 007/227] mm/mlock: fix vma iterator conversion of apply_vma_lock_flags()
Date:   Tue, 25 Jul 2023 12:42:54 +0200
Message-ID: <20230725104515.107130597@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Liam R. Howlett <Liam.Howlett@oracle.com>

commit 2658f94d679243209889cdfa8de3743cde1abea9 upstream.

apply_vma_lock_flags() calls mlock_fixup(), which could merge the VMA
after where the vma iterator is located.  Although this is not an issue,
the next iteration of the loop will check the start of the vma to be equal
to the locally saved 'tmp' variable and cause an incorrect failure
scenario.  Fix the error by setting tmp to the end of the vma iterator
value before restarting the loop.

There is also a potential of the error code being overwritten when the
loop terminates early.  Fix the return issue by directly returning when an
error is encountered since there is nothing to undo after the loop.

Link: https://lkml.kernel.org/r/20230711175020.4091336-1-Liam.Howlett@oracle.com
Fixes: 37598f5a9d8b ("mlock: convert mlock to vma iterator")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Ryan Roberts <ryan.roberts@arm.com>
  Link: https://lore.kernel.org/linux-mm/50341ca1-d582-b33a-e3d0-acb08a65166f@arm.com/
Tested-by: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mlock.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -471,7 +471,6 @@ static int apply_vma_lock_flags(unsigned
 {
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
-	int error;
 	VMA_ITERATOR(vmi, current->mm, start);
 
 	VM_BUG_ON(offset_in_page(start));
@@ -492,6 +491,7 @@ static int apply_vma_lock_flags(unsigned
 	nstart = start;
 	tmp = vma->vm_start;
 	for_each_vma_range(vmi, vma, end) {
+		int error;
 		vm_flags_t newflags;
 
 		if (vma->vm_start != tmp)
@@ -505,14 +505,15 @@ static int apply_vma_lock_flags(unsigned
 			tmp = end;
 		error = mlock_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
 		if (error)
-			break;
+			return error;
+		tmp = vma_iter_end(&vmi);
 		nstart = tmp;
 	}
 
-	if (vma_iter_end(&vmi) < end)
+	if (tmp < end)
 		return -ENOMEM;
 
-	return error;
+	return 0;
 }
 
 /*


