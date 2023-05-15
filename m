Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7D5703AD3
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243765AbjEORzz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243682AbjEORz2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:55:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AAC1A3B3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3086D62F9B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218E8C433EF;
        Mon, 15 May 2023 17:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173128;
        bh=ctV1nE43M4kuOGjcstmWH9EETCvik2xA2JAUo6/AM3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zz0gdLiaFArE5+ZvYC7sDng+frATNZEmpBdI/HWAPYp8P/Hhk+SnINnFbGL03fqVt
         I8TTaQpIBfFt3r5bCSmWkjBWoi2JImdHmhl4cJZ7Wkc5H+pANZ/sc690WO6Cw7+lYF
         3gZHDGG8Exlkm75H3U53HorlNtsVeRRzkdfrj6IU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Rishabh Bhatnagar <risbhat@amazon.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.10 376/381] KVM: x86: do not report preemption if the steal time cache is stale
Date:   Mon, 15 May 2023 18:30:27 +0200
Message-Id: <20230515161753.938718905@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rishabh Bhatnagar <risbhat@amazon.com>

From: Paolo Bonzini <pbonzini@redhat.com>

commit c3c28d24d910a746b02f496d190e0e8c6560224b upstream.

Commit 7e2175ebd695 ("KVM: x86: Fix recording of guest steal time
/ preempted status", 2021-11-11) open coded the previous call to
kvm_map_gfn, but in doing so it dropped the comparison between the cached
guest physical address and the one in the MSR.  This cause an incorrect
cache hit if the guest modifies the steal time address while the memslots
remain the same.  This can happen with kexec, in which case the preempted
bit is written at the address used by the old kernel instead of
the old one.

Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: stable@vger.kernel.org
Fixes: 7e2175ebd695 ("KVM: x86: Fix recording of guest steal time / preempted status")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
Tested-by: Allen Pais <apais@linux.microsoft.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4096,6 +4096,7 @@ static void kvm_steal_time_set_preempted
 	struct kvm_steal_time __user *st;
 	struct kvm_memslots *slots;
 	static const u8 preempted = KVM_VCPU_PREEMPTED;
+	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
 
 	/*
 	 * The vCPU can be marked preempted if and only if the VM-Exit was on
@@ -4123,6 +4124,7 @@ static void kvm_steal_time_set_preempted
 	slots = kvm_memslots(vcpu->kvm);
 
 	if (unlikely(slots->generation != ghc->generation ||
+		     gpa != ghc->gpa ||
 		     kvm_is_error_hva(ghc->hva) || !ghc->memslot))
 		return;
 


