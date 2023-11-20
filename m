Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D305E7F174B
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 16:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjKTP33 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 10:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjKTP32 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 10:29:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7529FD8
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 07:29:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C4AC433C9;
        Mon, 20 Nov 2023 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700494164;
        bh=xo3Xfw1jrl+xQHdL1FqxkEacEmX9bppDTnuTYynM8xM=;
        h=Subject:To:Cc:From:Date:From;
        b=hgddhv01V/G2zzFkIFGefae08D1ywYqiLwzX3IA3arrw58JKnXx6OFOxI/RWVas9x
         wKC8zQTuPwraLJevA41Spncf+qr1ovR6WWkHT/jMPWnsHDQH6ZMDzG2scYlJLfAQMa
         LUlOiym+iwn1pGsrdZH7F6d58TzyLrlVVd4D6bDc=
Subject: FAILED: patch "[PATCH] KVM: x86: hyper-v: Don't auto-enable stimer on write from" failed to apply to 4.14-stable tree
To:     nsaenz@amazon.com, seanjc@google.com, vkuznets@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 20 Nov 2023 16:29:13 +0100
Message-ID: <2023112013-chemicals-trousers-113f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x d6800af51c76b6dae20e6023bbdc9b3da3ab5121
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112013-chemicals-trousers-113f@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

d6800af51c76 ("KVM: x86: hyper-v: Don't auto-enable stimer on write from user-space")
013cc6ebbf41 ("x86/kvm/hyper-v: avoid spurious pending stimer on vCPU init")
87a8d795b2f1 ("x86/hyper-v: Stop caring about EOI for direct stimers")
8644f771e07c ("x86/kvm/hyper-v: direct mode for synthetic timers")
6a058a1eadc3 ("x86/kvm/hyper-v: use stimer config definition from hyperv-tlfs.h")
0aa67255f54d ("x86/hyper-v: move synic/stimer control structures definitions to hyperv-tlfs.h")
7deec5e0df74 ("x86: kvm: hyperv: don't retry message delivery for periodic timers")
3a0e7731724f ("x86: kvm: hyperv: simplify SynIC message delivery")
f21dd494506a ("KVM: x86: hyperv: optimize sparse VP set processing")
e6b6c483ebe9 ("KVM: x86: hyperv: fix 'tlb_lush' typo")
214ff83d4473 ("KVM: x86: hyperv: implement PV IPI send hypercalls")
2cefc5feb80c ("KVM: x86: hyperv: optimize kvm_hv_flush_tlb() for vp_index == vcpu_idx case")
0b0a31badb2d ("KVM: x86: hyperv: valid_bank_mask should be 'u64'")
a812297c4fd9 ("KVM: x86: hyperv: optimize 'all cpus' case in kvm_hv_flush_tlb()")
aa069a996951 ("KVM: PPC: Book3S HV: Add a VM capability to enable nested virtualization")
9d67121a4fce ("Merge remote-tracking branch 'remotes/powerpc/topic/ppc-kvm' into kvm-ppc-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d6800af51c76b6dae20e6023bbdc9b3da3ab5121 Mon Sep 17 00:00:00 2001
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
Date: Tue, 17 Oct 2023 15:51:02 +0000
Subject: [PATCH] KVM: x86: hyper-v: Don't auto-enable stimer on write from
 user-space

Don't apply the stimer's counter side effects when modifying its
value from user-space, as this may trigger spurious interrupts.

For example:
 - The stimer is configured in auto-enable mode.
 - The stimer's count is set and the timer enabled.
 - The stimer expires, an interrupt is injected.
 - The VM is live migrated.
 - The stimer config and count are deserialized, auto-enable is ON, the
   stimer is re-enabled.
 - The stimer expires right away, and injects an unwarranted interrupt.

Cc: stable@vger.kernel.org
Fixes: 1f4b34f825e8 ("kvm/x86: Hyper-V SynIC timers")
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20231017155101.40677-1-nsaenz@amazon.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 7c2dac6824e2..238afd7335e4 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -727,10 +727,12 @@ static int stimer_set_count(struct kvm_vcpu_hv_stimer *stimer, u64 count,
 
 	stimer_cleanup(stimer);
 	stimer->count = count;
-	if (stimer->count == 0)
-		stimer->config.enable = 0;
-	else if (stimer->config.auto_enable)
-		stimer->config.enable = 1;
+	if (!host) {
+		if (stimer->count == 0)
+			stimer->config.enable = 0;
+		else if (stimer->config.auto_enable)
+			stimer->config.enable = 1;
+	}
 
 	if (stimer->config.enable)
 		stimer_mark_pending(stimer, false);

