Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878B1703AB7
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244844AbjEORyk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241631AbjEORyK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:54:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F2C15253
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8412D62FA0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762EDC433D2;
        Mon, 15 May 2023 17:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173134;
        bh=tp/0cWuUERJ12V2jc6o9JHb12llyta2euiwz+DHhDsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSRNKTZSGOp3ngIV6udev5iS5x0SgHEK+7LxSbjPngNLQ77hMHrH8MKGf+U1Sk3ul
         FeIlnHRxHQ8HQBoSwXCWWRs1YM0EUp7JLpxdA4G5+J0zoaFhjDV6PYASm8xGN8jUPe
         K3ojiuBf2Dj6FpeIELMkN7Cejy0343m+VyhBhsqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephen Rothwell <sfr@canb.auug.org.au>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Rishabh Bhatnagar <risbhat@amazon.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.10 377/381] KVM: x86: move guest_pv_has out of user_access section
Date:   Mon, 15 May 2023 18:30:28 +0200
Message-Id: <20230515161753.987849668@linuxfoundation.org>
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

commit 3e067fd8503d6205aa0c1c8f48f6b209c592d19c upstream.

When UBSAN is enabled, the code emitted for the call to guest_pv_has
includes a call to __ubsan_handle_load_invalid_value.  objtool
complains that this call happens with UACCESS enabled; to avoid
the warning, pull the calls to user_access_begin into both arms
of the "if" statement, after the check for guest_pv_has.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
Tested-by: Allen Pais <apais@linux.microsoft.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3049,9 +3049,6 @@ static void record_steal_time(struct kvm
 	}
 
 	st = (struct kvm_steal_time __user *)ghc->hva;
-	if (!user_access_begin(st, sizeof(*st)))
-		return;
-
 	/*
 	 * Doing a TLB flush here, on the guest's behalf, can avoid
 	 * expensive IPIs.
@@ -3060,6 +3057,9 @@ static void record_steal_time(struct kvm
 		u8 st_preempted = 0;
 		int err = -EFAULT;
 
+		if (!user_access_begin(st, sizeof(*st)))
+			return;
+
 		asm volatile("1: xchgb %0, %2\n"
 			     "xor %1, %1\n"
 			     "2:\n"
@@ -3082,6 +3082,9 @@ static void record_steal_time(struct kvm
 		if (!user_access_begin(st, sizeof(*st)))
 			goto dirty;
 	} else {
+		if (!user_access_begin(st, sizeof(*st)))
+			return;
+
 		unsafe_put_user(0, &st->preempted, out);
 		vcpu->arch.st.preempted = 0;
 	}


