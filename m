Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589F4726C53
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjFGUce (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjFGUcc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:32:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9FE1FE6
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C55EE6450A
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D1CC433D2;
        Wed,  7 Jun 2023 20:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169945;
        bh=jCO4H3cR9wEWkB9Jbpu3LZA+lydgZ+2UOCFygH9YRNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kexoFA1ZRbHYhYpB75FsfCFxJTffz7o4gsNhD8srXXZGURzqbEa8jBaZt2hc7YBE6
         iXtAOIdEyF3wQKSpreXHcEgiIv6EYFnPz7CkDMw/UQW+oQKwy2g07p97rWHLtTeiDT
         gAIb4+K5+gNnCjBRZ8Kqr14PYPT3P7R9ApZt7HRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michal Luczaj <mhal@rbox.co>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.3 274/286] KVM: x86: Bail from kvm_recalculate_phys_map() if x2APIC ID is out-of-bounds
Date:   Wed,  7 Jun 2023 22:16:13 +0200
Message-ID: <20230607200932.246044719@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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

From: Sean Christopherson <seanjc@google.com>

commit 4364b287982bd05bfafa461c80650c732001974b upstream.

Bail from kvm_recalculate_phys_map() and disable the optimized map if the
target vCPU's x2APIC ID is out-of-bounds, i.e. if the vCPU was added
and/or enabled its local APIC after the map was allocated.  This fixes an
out-of-bounds access bug in the !x2apic_format path where KVM would write
beyond the end of phys_map.

Check the x2APIC ID regardless of whether or not x2APIC is enabled,
as KVM's hardcodes x2APIC ID to be the vCPU ID, i.e. it can't change, and
the map allocation in kvm_recalculate_apic_map() doesn't check for x2APIC
being enabled, i.e. the check won't get false postivies.

Note, this also affects the x2apic_format path, which previously just
ignored the "x2apic_id > new->max_apic_id" case.  That too is arguably a
bug fix, as ignoring the vCPU meant that KVM would not send interrupts to
the vCPU until the next map recalculation.  In practice, that "bug" is
likely benign as a newly present vCPU/APIC would immediately trigger a
recalc.  But, there's no functional downside to disabling the map, and
a future patch will gracefully handle the -E2BIG case by retrying instead
of simply disabling the optimized map.

Opportunistically add a sanity check on the xAPIC ID size, along with a
comment explaining why the xAPIC ID is guaranteed to be "good".

Reported-by: Michal Luczaj <mhal@rbox.co>
Fixes: 5b84b0291702 ("KVM: x86: Honor architectural behavior for aliased 8-bit APIC IDs")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230602233250.1014316-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/lapic.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -229,6 +229,23 @@ static int kvm_recalculate_phys_map(stru
 	u32 physical_id;
 
 	/*
+	 * For simplicity, KVM always allocates enough space for all possible
+	 * xAPIC IDs.  Yell, but don't kill the VM, as KVM can continue on
+	 * without the optimized map.
+	 */
+	if (WARN_ON_ONCE(xapic_id > new->max_apic_id))
+		return -EINVAL;
+
+	/*
+	 * Bail if a vCPU was added and/or enabled its APIC between allocating
+	 * the map and doing the actual calculations for the map.  Note, KVM
+	 * hardcodes the x2APIC ID to vcpu_id, i.e. there's no TOCTOU bug if
+	 * the compiler decides to reload x2apic_id after this check.
+	 */
+	if (x2apic_id > new->max_apic_id)
+		return -E2BIG;
+
+	/*
 	 * Deliberately truncate the vCPU ID when detecting a mismatched APIC
 	 * ID to avoid false positives if the vCPU ID, i.e. x2APIC ID, is a
 	 * 32-bit value.  Any unwanted aliasing due to truncation results will
@@ -253,8 +270,7 @@ static int kvm_recalculate_phys_map(stru
 	 */
 	if (vcpu->kvm->arch.x2apic_format) {
 		/* See also kvm_apic_match_physical_addr(). */
-		if ((apic_x2apic_mode(apic) || x2apic_id > 0xff) &&
-			x2apic_id <= new->max_apic_id)
+		if (apic_x2apic_mode(apic) || x2apic_id > 0xff)
 			new->phys_map[x2apic_id] = apic;
 
 		if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])


