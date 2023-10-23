Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32B87D30DC
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjJWLDE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjJWLDC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:03:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DEAD6E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:03:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4BFC433C8;
        Mon, 23 Oct 2023 11:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058980;
        bh=cHamRBfA1TZ1jqBhIm2GuwDFKBNN8+6gEOpVHGUsB6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kAAkHZ6A8rahHcIkr9UmTNwkmA42Cc3dMaccqnhmHMw5DS/5ETSYysd7mjXT1wzQP
         fBIpZXLOkhW0oLxMuH+PLN92dnHQDfcDutL+BK0uRYk4xWmlpDKfX3ukmDVIEpginG
         pCEb26k9M/zOfMUBiExkdorPSNP9P68GFnomjHjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.5 023/241] x86: KVM: SVM: add support for Invalid IPI Vector interception
Date:   Mon, 23 Oct 2023 12:53:29 +0200
Message-ID: <20231023104834.498063284@linuxfoundation.org>
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

commit 2dcf37abf9d3aab7f975002d29fc7c17272def38 upstream.

In later revisions of AMD's APM, there is a new 'incomplete IPI' exit code:

"Invalid IPI Vector - The vector for the specified IPI was set to an
illegal value (VEC < 16)"

Note that tests on Zen2 machine show that this VM exit doesn't happen and
instead AVIC just does nothing.

Add support for this exit code by doing nothing, instead of filling
the kernel log with errors.

Also replace an unthrottled 'pr_err()' if another unknown incomplete
IPI exit happens with vcpu_unimpl()

(e.g in case AMD adds yet another 'Invalid IPI' exit reason)

Cc: <stable@vger.kernel.org>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20230928173354.217464-3-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/svm.h |    1 +
 arch/x86/kvm/svm/avic.c    |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -268,6 +268,7 @@ enum avic_ipi_failure_cause {
 	AVIC_IPI_FAILURE_TARGET_NOT_RUNNING,
 	AVIC_IPI_FAILURE_INVALID_TARGET,
 	AVIC_IPI_FAILURE_INVALID_BACKING_PAGE,
+	AVIC_IPI_FAILURE_INVALID_IPI_VECTOR,
 };
 
 #define AVIC_PHYSICAL_MAX_INDEX_MASK	GENMASK_ULL(8, 0)
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -529,8 +529,11 @@ int avic_incomplete_ipi_interception(str
 	case AVIC_IPI_FAILURE_INVALID_BACKING_PAGE:
 		WARN_ONCE(1, "Invalid backing page\n");
 		break;
+	case AVIC_IPI_FAILURE_INVALID_IPI_VECTOR:
+		/* Invalid IPI with vector < 16 */
+		break;
 	default:
-		pr_err("Unknown IPI interception\n");
+		vcpu_unimpl(vcpu, "Unknown avic incomplete IPI interception\n");
 	}
 
 	return 1;


