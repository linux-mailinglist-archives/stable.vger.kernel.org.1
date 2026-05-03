Return-Path: <stable+bounces-242722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HKAF78792kddwIAu9opvQ
	(envelope-from <stable+bounces-242722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:12:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3724B58F0
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 380A43001459
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 12:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4225D3AEF4B;
	Sun,  3 May 2026 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VBFsqbPj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058F73AE6F7
	for <stable@vger.kernel.org>; Sun,  3 May 2026 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810365; cv=none; b=iuAh02Q086lEYbUjKKsLIyfTu5sWnHmP5QgyK6aXb3jOI7HlFbfbz6udhmVIotewQ9gdFufRI8PbFRY9whCFcCbfNcMaL5365oB7/J162DmwVO4PgzRgELWmK4dAStEGWYx9ERV4e8nbOeIZH+YWEYm757QvfaGj2KxH/QAQvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810365; c=relaxed/simple;
	bh=CjZwn21BUYeibRCcQugFW9ZLGuZMSHmaV0uU512vfvA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kgh/owQ4or+XOvuoqkDow0Vnaxx66cjmEeyKl45kcwmajAtNFu5/FJlT9Iz7DJkaGB/ivYNyjnbtr09PSAEcCwqbUvKrZX+38rlwxYUf+LZA3cqKDTuN9QKfcaXiGXroPZHk6N98108EAJ6HpXgrJa+VYWKRtPLY5/p7tNStGp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VBFsqbPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D68DC2BCB4;
	Sun,  3 May 2026 12:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777810364;
	bh=CjZwn21BUYeibRCcQugFW9ZLGuZMSHmaV0uU512vfvA=;
	h=Subject:To:Cc:From:Date:From;
	b=VBFsqbPjvR4ss7GdZXrGWUosN33xEzvv+WQB+bkty4LQcpT6jtLLSFzWxvceq0meR
	 ZFF5zdaiX/9aTKhYZqyQ5O3nGZgy63LqKSxso8mdEVrm3T+j6CrBsappispnsRjIKe
	 ExUEUw5gmqXzcfrJ0HFm/HnQ5SHHr5M2gPyvasaA=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Avoid clearing VMCB_LBR in vmcb12" failed to apply to 6.1-stable tree
To: yosry@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 14:12:32 +0200
Message-ID: <2026050332-overdrive-street-d372@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0B3724B58F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242722-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gregkh:email,msgid.link:url]


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b53ab5167a81537777ac780bbd93d32613aa3bda
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050332-overdrive-street-d372@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b53ab5167a81537777ac780bbd93d32613aa3bda Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 3 Mar 2026 00:33:55 +0000
Subject: [PATCH] KVM: nSVM: Avoid clearing VMCB_LBR in vmcb12

svm_copy_lbrs() always marks VMCB_LBR dirty in the destination VMCB.
However, nested_svm_vmexit() uses it to copy LBRs to vmcb12, and
clearing clean bits in vmcb12 is not architecturally defined.

Move vmcb_mark_dirty() to callers and drop it for vmcb12.

This also facilitates incoming refactoring that does not pass the entire
VMCB to svm_copy_lbrs().

Fixes: d20c796ca370 ("KVM: x86: nSVM: implement nested LBR virtualization")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260303003421.2185681-2-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 3e2841598a36..0a35c815f4d2 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -715,6 +715,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
 	} else {
 		svm_copy_lbrs(vmcb02, vmcb01);
 	}
+	vmcb_mark_dirty(vmcb02, VMCB_LBR);
 	svm_update_lbrv(&svm->vcpu);
 }
 
@@ -1231,10 +1232,12 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 		kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 
 	if (unlikely(guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK)))
+		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK))) {
 		svm_copy_lbrs(vmcb12, vmcb02);
-	else
+	} else {
 		svm_copy_lbrs(vmcb01, vmcb02);
+		vmcb_mark_dirty(vmcb01, VMCB_LBR);
+	}
 
 	svm_update_lbrv(vcpu);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 543f9f3f966e..9b4f5a46d550 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -848,8 +848,6 @@ void svm_copy_lbrs(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
 	to_vmcb->save.br_to		= from_vmcb->save.br_to;
 	to_vmcb->save.last_excp_from	= from_vmcb->save.last_excp_from;
 	to_vmcb->save.last_excp_to	= from_vmcb->save.last_excp_to;
-
-	vmcb_mark_dirty(to_vmcb, VMCB_LBR);
 }
 
 static void __svm_enable_lbrv(struct kvm_vcpu *vcpu)


