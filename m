Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181277A39EB
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240202AbjIQT4T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbjIQT4C (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:56:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08929F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:55:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED57C433C7;
        Sun, 17 Sep 2023 19:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980556;
        bh=deQrrf+xOBM3E4OjB7S/Xs4BBH3wEnyP5OtHoo93mSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDsNF3JkWtkpQ4gP1j99Scrvrx6qWpDK42fEhc1FmJCKZ/e2vmsisOapVONHDrqgv
         ZU9FvvBdD1vebWzM8BgUMAgsujd99zjpC1n2Dt9T8Lxm2LSwkh3D+TiHiHJPd+o8DO
         anSH2XbF9zE49lSSOtjR9JRPRkZmTT3+aJVBSgNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Gonda <pgonda@google.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.5 225/285] KVM: SVM: Get source vCPUs from source VM for SEV-ES intrahost migration
Date:   Sun, 17 Sep 2023 21:13:45 +0200
Message-ID: <20230917191059.266184112@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit f1187ef24eb8f36e8ad8106d22615ceddeea6097 upstream.

Fix a goof where KVM tries to grab source vCPUs from the destination VM
when doing intrahost migration.  Grabbing the wrong vCPU not only hoses
the guest, it also crashes the host due to the VMSA pointer being left
NULL.

  BUG: unable to handle page fault for address: ffffe38687000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP NOPTI
  CPU: 39 PID: 17143 Comm: sev_migrate_tes Tainted: GO       6.5.0-smp--fff2e47e6c3b-next #151
  Hardware name: Google, Inc. Arcadia_IT_80/Arcadia_IT_80, BIOS 34.28.0 07/10/2023
  RIP: 0010:__free_pages+0x15/0xd0
  RSP: 0018:ffff923fcf6e3c78 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffffe38687000000 RCX: 0000000000000100
  RDX: 0000000000000100 RSI: 0000000000000000 RDI: ffffe38687000000
  RBP: ffff923fcf6e3c88 R08: ffff923fcafb0000 R09: 0000000000000000
  R10: 0000000000000000 R11: ffffffff83619b90 R12: ffff923fa9540000
  R13: 0000000000080007 R14: ffff923f6d35d000 R15: 0000000000000000
  FS:  0000000000000000(0000) GS:ffff929d0d7c0000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffe38687000000 CR3: 0000005224c34005 CR4: 0000000000770ee0
  PKRU: 55555554
  Call Trace:
   <TASK>
   sev_free_vcpu+0xcb/0x110 [kvm_amd]
   svm_vcpu_free+0x75/0xf0 [kvm_amd]
   kvm_arch_vcpu_destroy+0x36/0x140 [kvm]
   kvm_destroy_vcpus+0x67/0x100 [kvm]
   kvm_arch_destroy_vm+0x161/0x1d0 [kvm]
   kvm_put_kvm+0x276/0x560 [kvm]
   kvm_vm_release+0x25/0x30 [kvm]
   __fput+0x106/0x280
   ____fput+0x12/0x20
   task_work_run+0x86/0xb0
   do_exit+0x2e3/0x9c0
   do_group_exit+0xb1/0xc0
   __x64_sys_exit_group+0x1b/0x20
   do_syscall_64+0x41/0x90
   entry_SYSCALL_64_after_hwframe+0x63/0xcd
   </TASK>
  CR2: ffffe38687000000

Fixes: 6defa24d3b12 ("KVM: SEV: Init target VMCBs in sev_migrate_from")
Cc: stable@vger.kernel.org
Cc: Peter Gonda <pgonda@google.com>
Reviewed-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Link: https://lore.kernel.org/r/20230825022357.2852133-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/sev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1725,7 +1725,7 @@ static void sev_migrate_from(struct kvm
 		 * Note, the source is not required to have the same number of
 		 * vCPUs as the destination when migrating a vanilla SEV VM.
 		 */
-		src_vcpu = kvm_get_vcpu(dst_kvm, i);
+		src_vcpu = kvm_get_vcpu(src_kvm, i);
 		src_svm = to_svm(src_vcpu);
 
 		/*


