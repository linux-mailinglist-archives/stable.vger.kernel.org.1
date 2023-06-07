Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71575726BD1
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjFGU2g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjFGU2e (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5DE1FDF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:28:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DA186449E
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848D6C433D2;
        Wed,  7 Jun 2023 20:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169692;
        bh=aPcXVjWq8mZxtSfdsthnBIg8pSYFUVdu8S9E/OiWq8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EvPR+OU12YeyA98uZ6FIXQsO/bQG928hUkemovEcALwwn1jqn6z8xzCMOVwmGYpLj
         NDJ7NGmsC7OjJIXUz7bWdgmJpTRWujK02k4MBVYoaSebMRXxhNwx9jW8FFyHXwRyFe
         D4TEoiRec4p7CPA+FzIxnNHSgeC+EhnwBZWdow7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quentin Perret <qperret@google.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 178/286] KVM: arm64: Prevent unconditional donation of unmapped regions from the host
Date:   Wed,  7 Jun 2023 22:14:37 +0200
Message-ID: <20230607200929.076394365@linuxfoundation.org>
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

From: Will Deacon <will@kernel.org>

[ Upstream commit 09cce60bddd6461a93a5bf434265a47827d1bc6f ]

Since host stage-2 mappings are created lazily, we cannot rely solely on
the pte in order to recover the target physical address when checking a
host-initiated memory transition as this permits donation of unmapped
regions corresponding to MMIO or "no-map" memory.

Instead of inspecting the pte, move the addr_is_allowed_memory() check
into the host callback function where it is passed the physical address
directly from the walker.

Cc: Quentin Perret <qperret@google.com>
Fixes: e82edcc75c4e ("KVM: arm64: Implement do_share() helper for sharing memory")
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230518095844.1178-1-will@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 552653fa18be3..dab14d3ca7bb6 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -568,7 +568,7 @@ struct pkvm_mem_donation {
 
 struct check_walk_data {
 	enum pkvm_page_state	desired;
-	enum pkvm_page_state	(*get_page_state)(kvm_pte_t pte);
+	enum pkvm_page_state	(*get_page_state)(kvm_pte_t pte, u64 addr);
 };
 
 static int __check_page_state_visitor(const struct kvm_pgtable_visit_ctx *ctx,
@@ -576,10 +576,7 @@ static int __check_page_state_visitor(const struct kvm_pgtable_visit_ctx *ctx,
 {
 	struct check_walk_data *d = ctx->arg;
 
-	if (kvm_pte_valid(ctx->old) && !addr_is_allowed_memory(kvm_pte_to_phys(ctx->old)))
-		return -EINVAL;
-
-	return d->get_page_state(ctx->old) == d->desired ? 0 : -EPERM;
+	return d->get_page_state(ctx->old, ctx->addr) == d->desired ? 0 : -EPERM;
 }
 
 static int check_page_state_range(struct kvm_pgtable *pgt, u64 addr, u64 size,
@@ -594,8 +591,11 @@ static int check_page_state_range(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	return kvm_pgtable_walk(pgt, addr, size, &walker);
 }
 
-static enum pkvm_page_state host_get_page_state(kvm_pte_t pte)
+static enum pkvm_page_state host_get_page_state(kvm_pte_t pte, u64 addr)
 {
+	if (!addr_is_allowed_memory(addr))
+		return PKVM_NOPAGE;
+
 	if (!kvm_pte_valid(pte) && pte)
 		return PKVM_NOPAGE;
 
@@ -702,7 +702,7 @@ static int host_complete_donation(u64 addr, const struct pkvm_mem_transition *tx
 	return host_stage2_set_owner_locked(addr, size, host_id);
 }
 
-static enum pkvm_page_state hyp_get_page_state(kvm_pte_t pte)
+static enum pkvm_page_state hyp_get_page_state(kvm_pte_t pte, u64 addr)
 {
 	if (!kvm_pte_valid(pte))
 		return PKVM_NOPAGE;
-- 
2.39.2



