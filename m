Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C0C726C51
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjFGUc0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbjFGUcY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0A91BFF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CC9D6450A
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBDBC433D2;
        Wed,  7 Jun 2023 20:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169939;
        bh=X8NZ36pjb97E0h5JKRWfZ/GtFlU5FSSmzmUDlLFRTHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VnrDL+292eaFIRJywJEYNM+dzjf1uPAWgqEG9W5a+osiVYuU9jdrgKadsuutCzo4/
         tAvC5aB+9N6yFEm4qH6924D278n1558V4NzfTSQnM8Vj4FNwqKWNRl6HZVJKpZFCZ+
         ajDJ9c66KnkJJaXZweuOwrNhNtWHla74XKNe1E3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fabio Coatti <fabio.coatti@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.3 272/286] KVM: x86/mmu: Grab memslot for correct address space in NX recovery worker
Date:   Wed,  7 Jun 2023 22:16:11 +0200
Message-ID: <20230607200932.185264623@linuxfoundation.org>
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

commit 817fa998362d6ea9fabd5e97af8e9e2eb5f0e6f2 upstream.

Factor in the address space (non-SMM vs. SMM) of the target shadow page
when recovering potential NX huge pages, otherwise KVM will retrieve the
wrong memslot when zapping shadow pages that were created for SMM.  The
bug most visibly manifests as a WARN on the memslot being non-NULL, but
the worst case scenario is that KVM could unaccount the shadow page
without ensuring KVM won't install a huge page, i.e. if the non-SMM slot
is being dirty logged, but the SMM slot is not.

 ------------[ cut here ]------------
 WARNING: CPU: 1 PID: 3911 at arch/x86/kvm/mmu/mmu.c:7015
 kvm_nx_huge_page_recovery_worker+0x38c/0x3d0 [kvm]
 CPU: 1 PID: 3911 Comm: kvm-nx-lpage-re
 RIP: 0010:kvm_nx_huge_page_recovery_worker+0x38c/0x3d0 [kvm]
 RSP: 0018:ffff99b284f0be68 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff99b284edd000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: ffff9271397024e0 R08: 0000000000000000 R09: ffff927139702450
 R10: 0000000000000000 R11: 0000000000000001 R12: ffff99b284f0be98
 R13: 0000000000000000 R14: ffff9270991fcd80 R15: 0000000000000003
 FS:  0000000000000000(0000) GS:ffff927f9f640000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f0aacad3ae0 CR3: 000000088fc2c005 CR4: 00000000003726e0
 Call Trace:
  <TASK>
__pfx_kvm_nx_huge_page_recovery_worker+0x10/0x10 [kvm]
  kvm_vm_worker_thread+0x106/0x1c0 [kvm]
  kthread+0xd9/0x100
  ret_from_fork+0x2c/0x50
  </TASK>
 ---[ end trace 0000000000000000 ]---

This bug was exposed by commit edbdb43fc96b ("KVM: x86: Preserve TDP MMU
roots until they are explicitly invalidated"), which allowed KVM to retain
SMM TDP MMU roots effectively indefinitely.  Before commit edbdb43fc96b,
KVM would zap all SMM TDP MMU roots and thus all SMM TDP MMU shadow pages
once all vCPUs exited SMM, which made the window where this bug (recovering
an SMM NX huge page) could be encountered quite tiny.  To hit the bug, the
NX recovery thread would have to run while at least one vCPU was in SMM.
Most VMs typically only use SMM during boot, and so the problematic shadow
pages were gone by the time the NX recovery thread ran.

Now that KVM preserves TDP MMU roots until they are explicitly invalidated
(e.g. by a memslot deletion), the window to trigger the bug is effectively
never closed because most VMMs don't delete memslots after boot (except
for a handful of special scenarios).

Fixes: eb298605705a ("KVM: x86/mmu: Do not recover dirty-tracked NX Huge Pages")
Reported-by: Fabio Coatti <fabio.coatti@gmail.com>
Closes: https://lore.kernel.org/all/CADpTngX9LESCdHVu_2mQkNGena_Ng2CphWNwsRGSMxzDsTjU2A@mail.gmail.com
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230602010137.784664-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/mmu/mmu.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7011,7 +7011,10 @@ static void kvm_recover_nx_huge_pages(st
 		 */
 		slot = NULL;
 		if (atomic_read(&kvm->nr_memslots_dirty_logging)) {
-			slot = gfn_to_memslot(kvm, sp->gfn);
+			struct kvm_memslots *slots;
+
+			slots = kvm_memslots_for_spte_role(kvm, sp->role);
+			slot = __gfn_to_memslot(slots, sp->gfn);
 			WARN_ON_ONCE(!slot);
 		}
 


