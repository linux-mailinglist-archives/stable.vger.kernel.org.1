Return-Path: <stable+bounces-242734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMSyBpQ892k2dwIAu9opvQ
	(envelope-from <stable+bounces-242734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:16:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3C94B59A6
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDA4F30057AC
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7CF2C08BC;
	Sun,  3 May 2026 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hA5oiFjN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F002176FB1
	for <stable@vger.kernel.org>; Sun,  3 May 2026 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810576; cv=none; b=rM8j+pOHFBFCwnakSYFlXGPEEImVDmTRG+J1zSa+BHpoD9zE9Zr5USg/CttSbXgIOmX6yRNMsYhzEj6llwtw4KpusgiAsxnwbdIcka1lUfTbcIVevDCyszbaIkuFJJmL4klzlXOqsdw/OCJChfwsS9YRmCb5RHV+KzPEXJEZ5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810576; c=relaxed/simple;
	bh=Ekw+ppjc7mmGOCtXG1OUzycYNBLiWFrTJeIRWMYJnjc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NsODhPfH2oIDujiwTTpUlHfVVKN5oceNz5rLOYmkpKOrF/KERTiwGLLtIeM2Nt5WSGvPEfk1BMcmZDsPO/KVSK6EAa9dghf6k+gUtJvpdlo3OMt1koggAb3GNHWskFwyssY9lS2P6679wjM6SZpAKVzj2VgbpbomMEDrXIAdmXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hA5oiFjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB604C2BCB4;
	Sun,  3 May 2026 12:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777810576;
	bh=Ekw+ppjc7mmGOCtXG1OUzycYNBLiWFrTJeIRWMYJnjc=;
	h=Subject:To:Cc:From:Date:From;
	b=hA5oiFjN80mKfXQ56TJ/+3clTrn+06ko9Vsw5507rj+23sDHCx7ew3rFeIp1CyibN
	 C20f5wy4zAlqMo8G5OjE9Ak6NQ+6W3LJEOc9lSFG9851YFAZdzfVG+BQbUFpTSeznZ
	 NtPjYTyU3xUzpoRPiNtCGT/Ht6RT7hqFny/MWz6c=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Refactor checking LBRV enablement in vmcb12 into a" failed to apply to 6.12-stable tree
To: yosry@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 14:16:13 +0200
Message-ID: <2026050313-thorn-escapade-d954@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C3C94B59A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242734-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,msgid.link:url]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 290c8d82023ab0e1d2782d37136541e017174d7c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050313-thorn-escapade-d954@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 290c8d82023ab0e1d2782d37136541e017174d7c Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 3 Mar 2026 00:34:00 +0000
Subject: [PATCH] KVM: nSVM: Refactor checking LBRV enablement in vmcb12 into a
 helper

Refactor the vCPU cap and vmcb12 flag checks into a helper. The
unlikely() annotation is dropped, it's unlikely (huh) to make a
difference and the CPU will probably predict it better on its own.

CC: stable@vger.kernel.org
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260303003421.2185681-7-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 7a472d7c6e98..d419fd516fa9 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -640,6 +640,12 @@ void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm)
 	svm->nested.vmcb02.ptr->save.g_pat = svm->vmcb01.ptr->save.g_pat;
 }
 
+static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
+{
+	return guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
+		(to_svm(vcpu)->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK);
+}
+
 static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12)
 {
 	bool new_vmcb12 = false;
@@ -704,8 +710,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
 		vmcb_mark_dirty(vmcb02, VMCB_DR);
 	}
 
-	if (unlikely(guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK))) {
+	if (nested_vmcb12_has_lbrv(vcpu)) {
 		/*
 		 * Reserved bits of DEBUGCTL are ignored.  Be consistent with
 		 * svm_set_msr's definition of reserved bits.
@@ -1233,8 +1238,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	if (!nested_exit_on_intr(svm))
 		kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 
-	if (unlikely(guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK))) {
+	if (nested_vmcb12_has_lbrv(vcpu)) {
 		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
 	} else {
 		svm_copy_lbrs(&vmcb01->save, &vmcb02->save);


