Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9F37D30DE
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjJWLDI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjJWLDI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:03:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184F3D7E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:03:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8F9C433C7;
        Mon, 23 Oct 2023 11:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058983;
        bh=u7mWjFZGZnU8N+72psBtc5lI9nvUCd24qtcu/3Gqa4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CU8GmDeP8SaKPBJQJuBIjUgjDRiukM2mVSNRbNWH4ZNg9HQlaEeqdmmuc16pY841g
         thHNnrrTdBV5kaiIr2JSbkvzC70U3HT5D2gJBJmII4LM+07/xiDDH4aOG54TfEK6Xr
         fysM8P7NCRix7suU7bjoGdkCRZNnauZQwUAq7ORc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.5 024/241] x86: KVM: SVM: refresh AVIC inhibition in svm_leave_nested()
Date:   Mon, 23 Oct 2023 12:53:30 +0200
Message-ID: <20231023104834.520751671@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxim Levitsky <mlevitsk@redhat.com>

commit 3fdc6087df3be73a212a81ce5dd6516638568806 upstream.

svm_leave_nested() similar to a nested VM exit, get the vCPU out of nested
mode and thus should end the local inhibition of AVIC on this vCPU.

Failure to do so, can lead to hangs on guest reboot.

Raise the KVM_REQ_APICV_UPDATE request to refresh the AVIC state of the
current vCPU in this case.

Fixes: f44509f849fe ("KVM: x86: SVM: allow AVIC to co-exist with a nested guest running")
Cc: stable@vger.kernel.org
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20230928173354.217464-4-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/nested.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1243,6 +1243,9 @@ void svm_leave_nested(struct kvm_vcpu *v
 
 		nested_svm_uninit_mmu_context(vcpu);
 		vmcb_mark_all_dirty(svm->vmcb);
+
+		if (kvm_apicv_activated(vcpu->kvm))
+			kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
 	}
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);


