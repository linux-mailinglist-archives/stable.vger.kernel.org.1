Return-Path: <stable+bounces-248097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLpiNglHB2p6wAIAu9opvQ
	(envelope-from <stable+bounces-248097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:17:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E8673552F14
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 828F53086D0C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3973BB116;
	Fri, 15 May 2026 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FxX3G3Yz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4663B1029;
	Fri, 15 May 2026 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860864; cv=none; b=OhRFMxH9pi/V0kJ2dvJMbQIlCzbAPO1HfDY/cDmmwZA0XROUWCXVMY56oZG9yhaNxrACv1xILVy9mhciPH5dpBRsXGO4zDpses2Q5d89ZBtx4Qh/tJKOcIOzL/yM8ZespTBW4DRkHzk7nvGyxw6s/BnszgRJfC+4mVd4FIzzZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860864; c=relaxed/simple;
	bh=tnwqU62UB5OeEhkWlNLUOUv4yUYH3wyzlsK6XfhaWgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxH3SRP+L8qZr7qnxiOsbbw2Te4+Ld3uJk9R70+YnrWeC1sZhXt6w0x8541SwNR8IhKcbw9zRLfDvcidgkJNzgEvWQ3ypSt2WK/OwJATjm1ZUbPcrQcAkXkLnRvXlpIZnfjUfi333CkyXx+lpuOtSJ/FjGKkH3nqpZXme7ilIVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FxX3G3Yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4713FC2BCC9;
	Fri, 15 May 2026 16:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860864;
	bh=tnwqU62UB5OeEhkWlNLUOUv4yUYH3wyzlsK6XfhaWgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FxX3G3Yz/dCJ/FYJFxpl/gj43T/APaNZMCDeWtGK6vgJlM9tvOIG/TN5/hljnWjbR
	 6Zy6iE+yms7030Hsz1tob6UkdMzIoWK7t4/m8M6lpgubghIC/iDX7AWBqnLuq4GKJR
	 q9PQvs3a+qnSC3fo4A2+ms7QNcVpD+ughN+FjmRg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yosry Ahmed <yosry@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.6 106/474] KVM: nSVM: Add missing consistency check for EFER, CR0, CR4, and CS
Date: Fri, 15 May 2026 17:43:35 +0200
Message-ID: <20260515154717.330040123@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E8673552F14
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248097-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yosry Ahmed <yosry@kernel.org>

commit 96bd3e76a171a8e21a6387e54e4c420a81968492 upstream.

According to the APM Volume #2, 15.5, Canonicalization and Consistency
Checks (24593—Rev. 3.42—March 2024), the following condition (among
others) results in a #VMEXIT with VMEXIT_INVALID (aka SVM_EXIT_ERR):

  EFER.LME, CR0.PG, CR4.PAE, CS.L, and CS.D are all non-zero.

In the list of consistency checks done when EFER.LME and CR0.PG are set,
add a check that CS.L and CS.D are not both set, after the existing
check that CR4.PAE is set.

This is functionally a nop because the nested VMRUN results in
SVM_EXIT_ERR in HW, which is forwarded to L1, but KVM makes all
consistency checks before a VMRUN is actually attempted.

Fixes: 3d6368ef580a ("KVM: SVM: Add VMRUN handler")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260303003421.2185681-17-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/nested.c |    6 ++++++
 arch/x86/kvm/svm/svm.h    |    1 +
 2 files changed, 7 insertions(+)

--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -304,6 +304,10 @@ static bool __nested_vmcb_check_save(str
 		    CC(!(save->cr0 & X86_CR0_PE)) ||
 		    CC(kvm_vcpu_is_illegal_gpa(vcpu, save->cr3)))
 			return false;
+
+		if (CC((save->cs.attrib & SVM_SELECTOR_L_MASK) &&
+		       (save->cs.attrib & SVM_SELECTOR_DB_MASK)))
+			return false;
 	}
 
 	/* Note, SVM doesn't have any additional restrictions on CR4. */
@@ -390,6 +394,8 @@ static void __nested_copy_vmcb_save_to_c
 	 * Copy only fields that are validated, as we need them
 	 * to avoid TOC/TOU races.
 	 */
+	to->cs = from->cs;
+
 	to->efer = from->efer;
 	to->cr0 = from->cr0;
 	to->cr3 = from->cr3;
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -115,6 +115,7 @@ struct kvm_vmcb_info {
 };
 
 struct vmcb_save_area_cached {
+	struct vmcb_seg cs;
 	u64 efer;
 	u64 cr4;
 	u64 cr3;



