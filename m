Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9977726BD4
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjFGU2m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjFGU2m (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:28:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C126AF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2452644B3
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69B6C433EF;
        Wed,  7 Jun 2023 20:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169703;
        bh=0gFxFoHtkdrmjhcXIRRKAnG5kD0xcvAyvWlq8GOE8XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sRwairu0s+1taxK9VPFycT7lr6b4XWdk6pjZbOZzbgeDpGcDH+wE1dwMICpxrYow/
         CywzNRbKO3NZHoGiacQcnCUWhVwBG6wmszRWyP0YxH1m4s6dt43ub4HYWJLM25N8BI
         ARBe+WQ7M5ncY/60FbY9m8mGEMS/hH7T0hFNwCeQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oliver Upton <oliver.upton@linux.dev>,
        Fuad Tabba <tabba@google.com>, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 181/286] KVM: arm64: Reload PTE after invoking walker callback on preorder traversal
Date:   Wed,  7 Jun 2023 22:14:40 +0200
Message-ID: <20230607200929.180721549@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fuad Tabba <tabba@google.com>

[ Upstream commit a9f0e3d5a089d0844abb679a5e99f15010d53e25 ]

The preorder callback on the kvm_pgtable_stage2_map() path can replace
a table with a block, then recursively free the detached table. The
higher-level walking logic stashes the old page table entry and
then walks the freed table, invoking the leaf callback and
potentially freeing pgtable pages prematurely.

In normal operation, the call to tear down the detached stage-2
is indirected and uses an RCU callback to trigger the freeing.
RCU is not available to pKVM, which is where this bug is
triggered.

Change the behavior of the walker to reload the page table entry
after invoking the walker callback on preorder traversal, as it
does for leaf entries.

Tested on Pixel 6.

Fixes: 5c359cca1faf ("KVM: arm64: Tear down unlinked stage-2 subtree after break-before-make")
Suggested-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230522103258.402272-1-tabba@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/kvm_pgtable.h |  6 +++---
 arch/arm64/kvm/hyp/pgtable.c         | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index dc3c072e862f1..93bd0975b15f5 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -632,9 +632,9 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size);
  *
  * The walker will walk the page-table entries corresponding to the input
  * address range specified, visiting entries according to the walker flags.
- * Invalid entries are treated as leaf entries. Leaf entries are reloaded
- * after invoking the walker callback, allowing the walker to descend into
- * a newly installed table.
+ * Invalid entries are treated as leaf entries. The visited page table entry is
+ * reloaded after invoking the walker callback, allowing the walker to descend
+ * into a newly installed table.
  *
  * Returning a negative error code from the walker callback function will
  * terminate the walk immediately with the same error code.
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 140f82300db5a..faddf1e71c8de 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -209,14 +209,26 @@ static inline int __kvm_pgtable_visit(struct kvm_pgtable_walk_data *data,
 		.flags	= flags,
 	};
 	int ret = 0;
+	bool reload = false;
 	kvm_pteref_t childp;
 	bool table = kvm_pte_table(ctx.old, level);
 
-	if (table && (ctx.flags & KVM_PGTABLE_WALK_TABLE_PRE))
+	if (table && (ctx.flags & KVM_PGTABLE_WALK_TABLE_PRE)) {
 		ret = kvm_pgtable_visitor_cb(data, &ctx, KVM_PGTABLE_WALK_TABLE_PRE);
+		reload = true;
+	}
 
 	if (!table && (ctx.flags & KVM_PGTABLE_WALK_LEAF)) {
 		ret = kvm_pgtable_visitor_cb(data, &ctx, KVM_PGTABLE_WALK_LEAF);
+		reload = true;
+	}
+
+	/*
+	 * Reload the page table after invoking the walker callback for leaf
+	 * entries or after pre-order traversal, to allow the walker to descend
+	 * into a newly installed or replaced table.
+	 */
+	if (reload) {
 		ctx.old = READ_ONCE(*ptep);
 		table = kvm_pte_table(ctx.old, level);
 	}
-- 
2.39.2



