Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC36F1693
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbjD1L2Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240307AbjD1L2X (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709F92728
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:28:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E30FD638BD
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A07C433EF;
        Fri, 28 Apr 2023 11:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682681301;
        bh=by/1dlldZF+tEZOPpYdKb2cW6x/lxYc9g3u5HfYzVL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cb3gu7/J2ssoqfiZmuYQaDRTyJLrRWDu2Ix8OCg+5GUAckt97shby+4htRWNtbrx8
         /6vmZGIOzLH+okQhtlhS6DOegYJ3k3uz+fANQK4JJy7PY2VfYLEvIW2R1jaINsz37r
         Fau4WXGBXJsg7376T/NB5DC2gcc393wQKoYpiJk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Fabian Vogt <fvogt@suse.com>
Subject: [PATCH 6.3 09/11] mm/mremap: fix vm_pgoff in vma_merge() case 3
Date:   Fri, 28 Apr 2023 13:27:44 +0200
Message-Id: <20230428112040.202040068@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230428112039.886496777@linuxfoundation.org>
References: <20230428112039.886496777@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vlastimil Babka <vbabka@suse.cz>

commit 7e7757876f258d99266e7b3c559639289a2a45fe upstream.

After upgrading build guests to v6.3, rpm started segfaulting for
specific packages, which was bisected to commit 0503ea8f5ba7 ("mm/mmap:
remove __vma_adjust()"). rpm is doing many mremap() operations with file
mappings of its db. The problem is that in vma_merge() case 3 (we merge
with the next vma, expanding it downwards) vm_pgoff is not adjusted as
it should when vm_start changes. As a result the rpm process most likely
sees data from the wrong offset of the file. Fix the vm_pgoff
calculation.

For case 8 this is a non-functional change as the resulting vm_pgoff is
the same.

Reported-and-bisected-by: Jiri Slaby <jirislaby@kernel.org>
Reported-and-tested-by: Fabian Vogt <fvogt@suse.com>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1210903
Fixes: 0503ea8f5ba7 ("mm/mmap: remove __vma_adjust()")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -978,7 +978,7 @@ struct vm_area_struct *vma_merge(struct
 			vma = next;			/* case 3 */
 			vma_start = addr;
 			vma_end = next->vm_end;
-			vma_pgoff = mid->vm_pgoff;
+			vma_pgoff = next->vm_pgoff - pglen;
 			err = 0;
 			if (mid != next) {		/* case 8 */
 				remove = mid;


