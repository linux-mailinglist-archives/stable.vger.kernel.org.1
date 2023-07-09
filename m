Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDBA74C218
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjGILQr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGILQp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:16:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0537812A
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9775760BC9
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F44AC433C7;
        Sun,  9 Jul 2023 11:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901404;
        bh=eWUD0JCjdAlO6MgKHYvybEqDaVxmuzCvYvA/tzXVLE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uFKlqEWH468+ItmiJTExii2QuREd/5ZH3hsE5CEsFneGPbMd9NT5vKTxmMrbAOJzP
         HouBjKx8Qkeg7dpNiON6dD3x+U+yPZ/NhzEvEpaDfr5UGxzccQWpk805J3L12MFqHr
         GFnz9MCP41lsg2ZWhm+2tY11UH3mGrX6Re+C9CCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Collingbourne <pcc@google.com>,
        Qun-wei Lin <Qun-wei.Lin@mediatek.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.3 001/431] mm: call arch_swap_restore() from do_swap_page()
Date:   Sun,  9 Jul 2023 13:09:09 +0200
Message-ID: <20230709111451.140448187@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peter Collingbourne <pcc@google.com>

commit 6dca4ac6fc91fd41ea4d6c4511838d37f4e0eab2 upstream.

Commit c145e0b47c77 ("mm: streamline COW logic in do_swap_page()") moved
the call to swap_free() before the call to set_pte_at(), which meant that
the MTE tags could end up being freed before set_pte_at() had a chance to
restore them.  Fix it by adding a call to the arch_swap_restore() hook
before the call to swap_free().

Link: https://lkml.kernel.org/r/20230523004312.1807357-2-pcc@google.com
Link: https://linux-review.googlesource.com/id/I6470efa669e8bd2f841049b8c61020c510678965
Fixes: c145e0b47c77 ("mm: streamline COW logic in do_swap_page()")
Signed-off-by: Peter Collingbourne <pcc@google.com>
Reported-by: Qun-wei Lin <Qun-wei.Lin@mediatek.com>
Closes: https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com/
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: <stable@vger.kernel.org>	[6.1+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3915,6 +3915,13 @@ vm_fault_t do_swap_page(struct vm_fault
 	}
 
 	/*
+	 * Some architectures may have to restore extra metadata to the page
+	 * when reading from swap. This metadata may be indexed by swap entry
+	 * so this must be called before swap_free().
+	 */
+	arch_swap_restore(entry, folio);
+
+	/*
 	 * Remove the swap entry and conditionally try to free up the swapcache.
 	 * We're already holding a reference on the page but haven't mapped it
 	 * yet.


