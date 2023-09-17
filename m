Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2FC7A39F8
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240222AbjIQT4u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240275AbjIQT4g (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:56:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ABB101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:56:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467F1C433C8;
        Sun, 17 Sep 2023 19:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980590;
        bh=7HPwspJXkMXx4qSiri/iKKhuVjQ3UPFC0fU3gwFcAdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZE/quHjbmh2Qg8Iblu3NkEc759QrwMLd1ZFDu4bt403QcS7uoFnBnXzeZ2FJRJOo
         dM5Hxp2mf0+kG+x04oPHs4A39uRP8+nh0i4l31xZhs34AxSnaWr2AUr41BK5h1lC1K
         TkNHt7NOnnXVi89H5zrHdBROOUcBmHWMLLlqFZ2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Gonda <pgonda@google.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.5 229/285] KVM: SVM: Skip VMSA init in sev_es_init_vmcb() if pointer is NULL
Date:   Sun, 17 Sep 2023 21:13:49 +0200
Message-ID: <20230917191059.376715796@linuxfoundation.org>
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

commit 1952e74da96fb3e48b72a2d0ece78c688a5848c1 upstream.

Skip initializing the VMSA physical address in the VMCB if the VMSA is
NULL, which occurs during intrahost migration as KVM initializes the VMCB
before copying over state from the source to the destination (including
the VMSA and its physical address).

In normal builds, __pa() is just math, so the bug isn't fatal, but with
CONFIG_DEBUG_VIRTUAL=y, the validity of the virtual address is verified
and passing in NULL will make the kernel unhappy.

Fixes: 6defa24d3b12 ("KVM: SEV: Init target VMCBs in sev_migrate_from")
Cc: stable@vger.kernel.org
Cc: Peter Gonda <pgonda@google.com>
Reviewed-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Link: https://lore.kernel.org/r/20230825022357.2852133-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/sev.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2955,9 +2955,12 @@ static void sev_es_init_vmcb(struct vcpu
 	/*
 	 * An SEV-ES guest requires a VMSA area that is a separate from the
 	 * VMCB page. Do not include the encryption mask on the VMSA physical
-	 * address since hardware will access it using the guest key.
+	 * address since hardware will access it using the guest key.  Note,
+	 * the VMSA will be NULL if this vCPU is the destination for intrahost
+	 * migration, and will be copied later.
 	 */
-	svm->vmcb->control.vmsa_pa = __pa(svm->sev_es.vmsa);
+	if (svm->sev_es.vmsa)
+		svm->vmcb->control.vmsa_pa = __pa(svm->sev_es.vmsa);
 
 	/* Can't intercept CR register access, HV can't modify CR registers */
 	svm_clr_intercept(svm, INTERCEPT_CR0_READ);


