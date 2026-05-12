Return-Path: <stable+bounces-246289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGxnM25tA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:11:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 826EB526FF0
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2E753164BAD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A634633DEF7;
	Tue, 12 May 2026 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iaWkI4bi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C9133B6CC;
	Tue, 12 May 2026 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608843; cv=none; b=qg+yRiS+/M2ral6RG64vjl0iWBzpxXHYcFI3FAQifm+dJtJMNyrCuf2N1wEJdKheI2vopGelGNOa/ixYSaFA4vDTBmSXjd5tI7/UteV7FLA0fJSaOCFOebJpwTEBcxx925Abwacb4zlKgLiAd+FEaEuA5HMvSH97tNdjBWpSLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608843; c=relaxed/simple;
	bh=JgVcc5/jROLQ1hbcnMYDvV/EmRiXl5UYIjX8H4sFqiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bU7/NPJ5/M+4QwgBTGyWKUjvhJ0OMTbd5v7wjfkq3GkXNh14qt2GkSUZ18afhtFjDc5bMJenlHfjubGKGeiP9qF0Hp1sYH2w/Ufq7/dmIGSBe7f/GrxLaVVz6ho1FRo5X/1Xns91+PQwPos40J/ArypGFYbU3U+9fxqMcUScl2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iaWkI4bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46D8C2BCB0;
	Tue, 12 May 2026 18:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608843;
	bh=JgVcc5/jROLQ1hbcnMYDvV/EmRiXl5UYIjX8H4sFqiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iaWkI4biRE0KUoLytZxatxlbSgLr3xX0dyTCao3qSL+pa0t0x6PI73fwLU3wJdJE7
	 H25y7c1OY9UQAuQ4sMFOq7CSkC0qA9kK2yRUDZ0XRX64UeZeBOi7d/+uloTkB3EXNw
	 4iBJuTopZUh+542/5f74Vf/AJWTIbjHap3iOHD9I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fuad Tabba <tabba@google.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.18 236/270] KVM: arm64: Fix FEAT_SPE_FnE to use PMSIDR_EL1.FnE, not PMSVer
Date: Tue, 12 May 2026 19:40:37 +0200
Message-ID: <20260512173943.411321550@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 826EB526FF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246289-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fuad Tabba <tabba@google.com>

commit 08d715338287a1affb4c7ad5733decef4558a5c8 upstream.

FEAT_SPE_FnE is architecturally detected via PMSIDR_EL1.FnE [6], not
ID_AA64DFR0_EL1.PMSVer. The FEAT_X macro form (register, field, value)
cannot encode a PMSIDR_EL1-based feature, so FEAT_SPE_FnE was defined
identically to FEAT_SPEv1p2 (ID_AA64DFR0_EL1, PMSVer, V1P2), producing
a duplicate that used PMSVer >= V1P2 as a proxy.

Replace the macro with feat_spe_fne(), following the same pattern as
the sibling feat_spe_fds(): guard on FEAT_SPEv1p2 and read
PMSIDR_EL1.FnE [6] directly. Wire the two NEEDS_FEAT consumers to use
the new function.

Remove the now-unused FEAT_SPE_FnE macro.

Fixes: 63d423a7635b ("KVM: arm64: Switch to table-driven FGU configuration")
Signed-off-by: Fuad Tabba <tabba@google.com>
Link: https://patch.msgid.link/20260424084908.370776-4-tabba@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/config.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -127,7 +127,6 @@ struct reg_feat_map_desc {
 	}
 
 #define FEAT_SPE		ID_AA64DFR0_EL1, PMSVer, IMP
-#define FEAT_SPE_FnE		ID_AA64DFR0_EL1, PMSVer, V1P2
 #define FEAT_BRBE		ID_AA64DFR0_EL1, BRBE, IMP
 #define FEAT_TRC_SR		ID_AA64DFR0_EL1, TraceVer, IMP
 #define FEAT_PMUv3		ID_AA64DFR0_EL1, PMUVer, IMP
@@ -294,6 +293,16 @@ static bool feat_spe_fds(struct kvm *kvm
 		(read_sysreg_s(SYS_PMSIDR_EL1) & PMSIDR_EL1_FDS));
 }
 
+static bool feat_spe_fne(struct kvm *kvm)
+{
+	/*
+	 * Revisit this if KVM ever supports SPE -- this really should
+	 * look at the guest's view of PMSIDR_EL1.
+	 */
+	return (kvm_has_feat(kvm, FEAT_SPEv1p2) &&
+		(read_sysreg_s(SYS_PMSIDR_EL1) & PMSIDR_EL1_FnE));
+}
+
 static bool feat_trbe_mpam(struct kvm *kvm)
 {
 	/*
@@ -547,7 +556,7 @@ static const struct reg_bits_to_feat_map
 		   HDFGRTR_EL2_PMBPTR_EL1	|
 		   HDFGRTR_EL2_PMBLIMITR_EL1,
 		   FEAT_SPE),
-	NEEDS_FEAT(HDFGRTR_EL2_nPMSNEVFR_EL1, FEAT_SPE_FnE),
+	NEEDS_FEAT(HDFGRTR_EL2_nPMSNEVFR_EL1, feat_spe_fne),
 	NEEDS_FEAT(HDFGRTR_EL2_nBRBDATA		|
 		   HDFGRTR_EL2_nBRBCTL		|
 		   HDFGRTR_EL2_nBRBIDR,
@@ -615,7 +624,7 @@ static const struct reg_bits_to_feat_map
 		   HDFGWTR_EL2_PMBPTR_EL1	|
 		   HDFGWTR_EL2_PMBLIMITR_EL1,
 		   FEAT_SPE),
-	NEEDS_FEAT(HDFGWTR_EL2_nPMSNEVFR_EL1, FEAT_SPE_FnE),
+	NEEDS_FEAT(HDFGWTR_EL2_nPMSNEVFR_EL1, feat_spe_fne),
 	NEEDS_FEAT(HDFGWTR_EL2_nBRBDATA		|
 		   HDFGWTR_EL2_nBRBCTL,
 		   FEAT_BRBE),



