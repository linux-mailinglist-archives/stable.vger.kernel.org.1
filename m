Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B497A3B68
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbjIQURK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240761AbjIQURD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:17:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0AE101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:16:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C04C433C7;
        Sun, 17 Sep 2023 20:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981818;
        bh=4JsY7IPnLqarNEYvlGBdpA2mhmxQqHs8ps85jbhos84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmWNlrAa394Vh4qgVI61s1vQOA7iPllZkxlcs/UcHIDsSNCvRCJW1G+bMiw1UxI2c
         SVB/9RLXRgfuZ17GgPRXo4V0AZwp3fjS0Vkhnhrh5MS4Mad6pUbtufhXV3TewdxgWt
         qx4oyE+OMn6qUcgp4lRcrCoEXPxiOmZ+lpyPBqog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Gonda <pgonda@google.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.1 176/219] KVM: SVM: Skip VMSA init in sev_es_init_vmcb() if pointer is NULL
Date:   Sun, 17 Sep 2023 21:15:03 +0200
Message-ID: <20230917191047.338434419@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2951,9 +2951,12 @@ static void sev_es_init_vmcb(struct vcpu
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


