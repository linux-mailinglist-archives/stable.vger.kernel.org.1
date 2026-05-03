Return-Path: <stable+bounces-242755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EmQIAE992k2dwIAu9opvQ
	(envelope-from <stable+bounces-242755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:18:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9DB4B5A3F
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8724D3006141
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 12:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578672C08BC;
	Sun,  3 May 2026 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bK9x0wST"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C201176FB1
	for <stable@vger.kernel.org>; Sun,  3 May 2026 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810686; cv=none; b=E/f0TOyjTLdVukNN4J4IRUtccFTLfRE2FsYKfxK1hVPlBDWak8ubebOpYd70HZyyu8Vdjx2+jYTpf+2vBZyESbsQyxaONfO+TQZj7oswIXCsel4Cx6rsE0Mh/7QxdZVyMFXzpffp6TiOgoi3hmlwjQSxd/kaK8/Np+wZ0LKOt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810686; c=relaxed/simple;
	bh=klvd7muz8FbQzfOCgbO9zpMYAkKLsTj+DXpdOUDMQK8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U0BpdLwGXLKVaU9cB5nGRn9349RxyiESwLFitR5f/FHTspFSxpsrTmrbh3z0puseJRac84EhQLPT2l2hKGzX4keRA0hTMCcFjCgvfa6Og/pG6WItF8/XWSjGE8T/1MyNPmji8GPlgXSXxb+CvSEr6E1R4OaXnt4DIwKUZLG+BRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bK9x0wST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D82C2BCB4;
	Sun,  3 May 2026 12:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777810686;
	bh=klvd7muz8FbQzfOCgbO9zpMYAkKLsTj+DXpdOUDMQK8=;
	h=Subject:To:Cc:From:Date:From;
	b=bK9x0wSTbmDPUJx2mBFYaArI7ymU21MtADTUFAE4Of2S2+8uFhIfdMkgtaGP2ZMnm
	 TPcTonQhGy0c2I4ETvbMqt+84ohufOcWvegaRLYrRTN4Vftf0R7QeXurG6G3g4S3fh
	 IN5K9EJlmZEaa08IjxxoHNQ5R6DPhSahVGjdJuio=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Clear EVENTINJ fields in vmcb12 on nested #VMEXIT" failed to apply to 6.1-stable tree
To: yosry@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 14:18:03 +0200
Message-ID: <2026050303-overbid-vocalist-6efe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DD9DB4B5A3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242755-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,msgid.link:url]


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 69b721a86d0dcb026f6db7d111dcde7550442d2e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050303-overbid-vocalist-6efe@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 69b721a86d0dcb026f6db7d111dcde7550442d2e Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 3 Mar 2026 00:34:05 +0000
Subject: [PATCH] KVM: nSVM: Clear EVENTINJ fields in vmcb12 on nested #VMEXIT

According to the APM, from the reference of the VMRUN instruction:

  Upon #VMEXIT, the processor performs the following actions in order to
  return to the host execution context:

  ...

  clear EVENTINJ field in VMCB

KVM already syncs EVENTINJ fields from vmcb02 to cached vmcb12 on every
L2->L0  #VMEXIT. Since these fields are zeroed by the CPU on #VMEXIT, they
will mostly be zeroed in vmcb12 on nested #VMEXIT by nested_svm_vmexit().

However, this is not the case when:

  1. Consistency checks fail, as nested_svm_vmexit() is not called.
  2. Entering guest mode fails before L2 runs (e.g. due to failed load of
     CR3).

(2) was broken by commit 2d8a42be0e2b ("KVM: nSVM: synchronize VMCB
controls updated by the processor on every vmexit"), as prior to that
nested_svm_vmexit() always zeroed EVENTINJ fields.

Explicitly clear the fields in all nested #VMEXIT code paths.

Fixes: 3d6368ef580a ("KVM: SVM: Add VMRUN handler")
Fixes: 2d8a42be0e2b ("KVM: nSVM: synchronize VMCB controls updated by the processor on every vmexit")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260303003421.2185681-12-yosry@kernel.org
[sean: massage changelog formatting]
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index ac7d7f82c82b..90c8bc641bf3 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1035,6 +1035,8 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 		vmcb12->control.exit_code    = SVM_EXIT_ERR;
 		vmcb12->control.exit_info_1  = 0;
 		vmcb12->control.exit_info_2  = 0;
+		vmcb12->control.event_inj = 0;
+		vmcb12->control.event_inj_err = 0;
 		svm_set_gif(svm, false);
 		goto out;
 	}
@@ -1178,9 +1180,9 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	if (nested_vmcb12_has_lbrv(vcpu))
 		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
 
+	vmcb12->control.event_inj	  = 0;
+	vmcb12->control.event_inj_err	  = 0;
 	vmcb12->control.int_ctl           = svm->nested.ctl.int_ctl;
-	vmcb12->control.event_inj         = svm->nested.ctl.event_inj;
-	vmcb12->control.event_inj_err     = svm->nested.ctl.event_inj_err;
 
 	trace_kvm_nested_vmexit_inject(vmcb12->control.exit_code,
 				       vmcb12->control.exit_info_1,


