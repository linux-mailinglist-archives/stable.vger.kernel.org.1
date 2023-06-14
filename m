Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EFC713E76
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjE1Tfo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjE1Tfn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:35:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A126BB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:35:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C84F461E22
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6305C433D2;
        Sun, 28 May 2023 19:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302541;
        bh=0QGY+ixbiJ53s+lznGc6OpLn45DcgcDT3aIoof9SGfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uawK4oW13YtqgeuMDcqPPlpE/MNwSK/5i4zk+Se0v62R9Z55oNCORv9fnxiqcgCjI
         aJnkNH9vzHG47Rc45hv0b8Hv0BC7rzVW4eCOwimrIGkNPuyd55G1YgVUhgEkyNVyRw
         OMEbCKLBdp/Bl05biAWQkwITLdlS75iJiORriH3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 6.1 016/119] arm64: Also reset KASAN tag if page is not PG_mte_tagged
Date:   Sun, 28 May 2023 20:10:16 +0100
Message-Id: <20230528190835.869117178@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peter Collingbourne <pcc@google.com>

commit 2efbafb91e12ff5a16cbafb0085e4c10c3fca493 upstream.

Consider the following sequence of events:

1) A page in a PROT_READ|PROT_WRITE VMA is faulted.
2) Page migration allocates a page with the KASAN allocator,
   causing it to receive a non-match-all tag, and uses it
   to replace the page faulted in 1.
3) The program uses mprotect() to enable PROT_MTE on the page faulted in 1.

As a result of step 3, we are left with a non-match-all tag for a page
with tags accessible to userspace, which can lead to the same kind of
tag check faults that commit e74a68468062 ("arm64: Reset KASAN tag in
copy_highpage with HW tags only") intended to fix.

The general invariant that we have for pages in a VMA with VM_MTE_ALLOWED
is that they cannot have a non-match-all tag. As a result of step 2, the
invariant is broken. This means that the fix in the referenced commit
was incomplete and we also need to reset the tag for pages without
PG_mte_tagged.

Fixes: e5b8d9218951 ("arm64: mte: reset the page tag in page->flags")
Cc: <stable@vger.kernel.org> # 5.15
Link: https://linux-review.googlesource.com/id/I7409cdd41acbcb215c2a7417c1e50d37b875beff
Signed-off-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20230420210945.2313627-1-pcc@google.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/copypage.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -21,9 +21,10 @@ void copy_highpage(struct page *to, stru
 
 	copy_page(kto, kfrom);
 
+	if (kasan_hw_tags_enabled())
+		page_kasan_tag_reset(to);
+
 	if (system_supports_mte() && page_mte_tagged(from)) {
-		if (kasan_hw_tags_enabled())
-			page_kasan_tag_reset(to);
 		mte_copy_page_tags(kto, kfrom);
 		set_page_mte_tagged(to);
 	}


