Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241947BDEC9
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376424AbjJINXF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376434AbjJINXE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:23:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19469B6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:23:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC45C433C7;
        Mon,  9 Oct 2023 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857782;
        bh=/ieAj7VtzqQ+VkJrhQFVgX8TKXBsjywIAwxliITNe30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K9qZcbaUoH0tjVrWjMGHIMJZdtFwqanpusiMS9qSlnPfxvNCjUWMadDTjbs8eA3d1
         GKEcGcE6odxZC6SMgZg8CrgJWNQw6vkXRe9pBNozC1VHacgRSlz8g6mWr187RYB8I5
         JrVcF57xOZlhuaoMt+7Iyx0V+lomuKDJy7m6mppM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Lendacky <thomas.lendacky@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, stable@kernel.org
Subject: [PATCH 6.1 154/162] x86/sev: Use the GHCB protocol when available for SNP CPUID requests
Date:   Mon,  9 Oct 2023 15:02:15 +0200
Message-ID: <20231009130127.166773774@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>

commit 6bc6f7d9d7ac3cdbe9e8b0495538b4a0cc11f032 upstream.

SNP retrieves the majority of CPUID information from the SNP CPUID page.
But there are times when that information needs to be supplemented by the
hypervisor, for example, obtaining the initial APIC ID of the vCPU from
leaf 1.

The current implementation uses the MSR protocol to retrieve the data from
the hypervisor, even when a GHCB exists. The problem arises when an NMI
arrives on return from the VMGEXIT. The NMI will be immediately serviced
and may generate a #VC requiring communication with the hypervisor.

Since a GHCB exists in this case, it will be used. As part of using the
GHCB, the #VC handler will write the GHCB physical address into the GHCB
MSR and the #VC will be handled.

When the NMI completes, processing resumes at the site of the VMGEXIT
which is expecting to read the GHCB MSR and find a CPUID MSR protocol
response. Since the NMI handling overwrote the GHCB MSR response, the
guest will see an invalid reply from the hypervisor and self-terminate.

Fix this problem by using the GHCB when it is available. Any NMI
received is properly handled because the GHCB contents are copied into
a backup page and restored on NMI exit, thus preserving the active GHCB
request or result.

  [ bp: Touchups. ]

Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/a5856fa1ebe3879de91a8f6298b6bbd901c61881.1690578565.git.thomas.lendacky@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/sev-shared.c |   69 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 14 deletions(-)

--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -253,7 +253,7 @@ static int __sev_cpuid_hv(u32 fn, int re
 	return 0;
 }
 
-static int sev_cpuid_hv(struct cpuid_leaf *leaf)
+static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
 {
 	int ret;
 
@@ -276,6 +276,45 @@ static int sev_cpuid_hv(struct cpuid_lea
 	return ret;
 }
 
+static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+{
+	u32 cr4 = native_read_cr4();
+	int ret;
+
+	ghcb_set_rax(ghcb, leaf->fn);
+	ghcb_set_rcx(ghcb, leaf->subfn);
+
+	if (cr4 & X86_CR4_OSXSAVE)
+		/* Safe to read xcr0 */
+		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
+	else
+		/* xgetbv will cause #UD - use reset value for xcr0 */
+		ghcb_set_xcr0(ghcb, 1);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) &&
+	      ghcb_rbx_is_valid(ghcb) &&
+	      ghcb_rcx_is_valid(ghcb) &&
+	      ghcb_rdx_is_valid(ghcb)))
+		return ES_VMM_ERROR;
+
+	leaf->eax = ghcb->save.rax;
+	leaf->ebx = ghcb->save.rbx;
+	leaf->ecx = ghcb->save.rcx;
+	leaf->edx = ghcb->save.rdx;
+
+	return ES_OK;
+}
+
+static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+{
+	return ghcb ? __sev_cpuid_hv_ghcb(ghcb, ctxt, leaf)
+		    : __sev_cpuid_hv_msr(leaf);
+}
+
 /*
  * This may be called early while still running on the initial identity
  * mapping. Use RIP-relative addressing to obtain the correct address
@@ -385,19 +424,20 @@ snp_cpuid_get_validated_func(struct cpui
 	return false;
 }
 
-static void snp_cpuid_hv(struct cpuid_leaf *leaf)
+static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
-	if (sev_cpuid_hv(leaf))
+	if (sev_cpuid_hv(ghcb, ctxt, leaf))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
-static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
+static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+				 struct cpuid_leaf *leaf)
 {
 	struct cpuid_leaf leaf_hv = *leaf;
 
 	switch (leaf->fn) {
 	case 0x1:
-		snp_cpuid_hv(&leaf_hv);
+		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
 
 		/* initial APIC ID */
 		leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
@@ -416,7 +456,7 @@ static int snp_cpuid_postprocess(struct
 		break;
 	case 0xB:
 		leaf_hv.subfn = 0;
-		snp_cpuid_hv(&leaf_hv);
+		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->edx = leaf_hv.edx;
@@ -464,7 +504,7 @@ static int snp_cpuid_postprocess(struct
 		}
 		break;
 	case 0x8000001E:
-		snp_cpuid_hv(&leaf_hv);
+		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->eax = leaf_hv.eax;
@@ -485,7 +525,7 @@ static int snp_cpuid_postprocess(struct
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-static int snp_cpuid(struct cpuid_leaf *leaf)
+static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -519,7 +559,7 @@ static int snp_cpuid(struct cpuid_leaf *
 			return 0;
 	}
 
-	return snp_cpuid_postprocess(leaf);
+	return snp_cpuid_postprocess(ghcb, ctxt, leaf);
 }
 
 /*
@@ -541,14 +581,14 @@ void __init do_vc_no_ghcb(struct pt_regs
 	leaf.fn = fn;
 	leaf.subfn = subfn;
 
-	ret = snp_cpuid(&leaf);
+	ret = snp_cpuid(NULL, NULL, &leaf);
 	if (!ret)
 		goto cpuid_done;
 
 	if (ret != -EOPNOTSUPP)
 		goto fail;
 
-	if (sev_cpuid_hv(&leaf))
+	if (__sev_cpuid_hv_msr(&leaf))
 		goto fail;
 
 cpuid_done:
@@ -845,14 +885,15 @@ static enum es_result vc_handle_ioio(str
 	return ret;
 }
 
-static int vc_handle_cpuid_snp(struct pt_regs *regs)
+static int vc_handle_cpuid_snp(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
+	struct pt_regs *regs = ctxt->regs;
 	struct cpuid_leaf leaf;
 	int ret;
 
 	leaf.fn = regs->ax;
 	leaf.subfn = regs->cx;
-	ret = snp_cpuid(&leaf);
+	ret = snp_cpuid(ghcb, ctxt, &leaf);
 	if (!ret) {
 		regs->ax = leaf.eax;
 		regs->bx = leaf.ebx;
@@ -871,7 +912,7 @@ static enum es_result vc_handle_cpuid(st
 	enum es_result ret;
 	int snp_cpuid_ret;
 
-	snp_cpuid_ret = vc_handle_cpuid_snp(regs);
+	snp_cpuid_ret = vc_handle_cpuid_snp(ghcb, ctxt);
 	if (!snp_cpuid_ret)
 		return ES_OK;
 	if (snp_cpuid_ret != -EOPNOTSUPP)


