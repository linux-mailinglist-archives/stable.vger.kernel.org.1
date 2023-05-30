Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1573A716DCA
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 21:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjE3Tmy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 15:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjE3Tmw (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 15:42:52 -0400
X-Greylist: delayed 596 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 12:42:33 PDT
Received: from out-37.mta1.migadu.com (out-37.mta1.migadu.com [95.215.58.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4553180
        for <stable@vger.kernel.org>; Tue, 30 May 2023 12:42:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685475155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JVMjAcGuC6Xgi+ZFZsup7ky2vHzlpmovl5JmDiIW5nc=;
        b=kDWUwBDegAAuCx6HvZFIsr+TVKEhenp67RnujftDpVCLsUuQpeDe2r+ghL9J98aTT0Kmuc
        thvj8xz3lzjgRmaZlV+pWyMltur71y+cXaeyImJndnYHGHcstvVMuLveGVw8PPbyrDjIpR
        s8m8bH953j0ZPcZX6ywLEPh4D6DTa3k=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     kvmarm@lists.linux.dev
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Fuad Tabba <tabba@google.com>, Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>, stable@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH] KVM: arm64: Drop last page ref in kvm_pgtable_stage2_free_removed()
Date:   Tue, 30 May 2023 19:32:13 +0000
Message-ID: <20230530193213.1663411-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The reference count on page table allocations is increased for every
'counted' PTE (valid or donated) in the table in addition to the initial
reference from ->zalloc_page(). kvm_pgtable_stage2_free_removed() fails
to drop the last reference on the root of the table walk, meaning we
leak memory.

Fix it by dropping the last reference after the free walker returns,
at which point all references for 'counted' PTEs have been released.

Cc: stable@vger.kernel.org
Fixes: 5c359cca1faf ("KVM: arm64: Tear down unlinked stage-2 subtree after break-before-make")
Reported-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/hyp/pgtable.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index e1eacffbc41f..95dae02ccc2e 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1332,4 +1332,7 @@ void kvm_pgtable_stage2_free_removed(struct kvm_pgtable_mm_ops *mm_ops, void *pg
 	};
 
 	WARN_ON(__kvm_pgtable_walk(&data, mm_ops, ptep, level + 1));
+
+	WARN_ON(mm_ops->page_count(pgtable) != 1);
+	mm_ops->put_page(pgtable);
 }

base-commit: 811154e234db72f0a11557a84ba9640f8b3bc823
-- 
2.41.0.rc0.172.g3f132b7071-goog

