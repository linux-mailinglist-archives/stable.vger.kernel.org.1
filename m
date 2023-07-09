Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F51874C208
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjGILOl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjGILOk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:14:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87888131
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:14:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26C9360BC6
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B8AC433C7;
        Sun,  9 Jul 2023 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901278;
        bh=JZk0yN1cG4O5ARik7AJnsNBIkCv+udHoqBWNdnRb4tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B4Zhre8c7JMkUYakh08ltQQcEUH0LB2ZRJ1SEZpKPaiTIDqA2kjzmR0cwYh5xBwzv
         s3oXE1ropjeU+l/YyokAb0YDYdsFPwidRHFJCVD+E1l/J2IK/RBunz9zhWkwZ5yzfM
         +j9Xa5EQ/b5spMuHgO/Q75Lqqm2VPUmzTywVpvj4=
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
Subject: [PATCH 6.4 5/8] mm: call arch_swap_restore() from do_swap_page()
Date:   Sun,  9 Jul 2023 13:14:11 +0200
Message-ID: <20230709111345.460811210@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111345.297026264@linuxfoundation.org>
References: <20230709111345.297026264@linuxfoundation.org>
User-Agent: quilt/0.67
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
@@ -3933,6 +3933,13 @@ vm_fault_t do_swap_page(struct vm_fault
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


