Return-Path: <stable+bounces-238778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBcIA/In5mnesgEAu9opvQ
	(envelope-from <stable+bounces-238778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:19:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D59C42B8D6
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A3A3006797
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8B53A1688;
	Mon, 20 Apr 2026 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zO7qaLnd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4E83A16AB
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690903; cv=none; b=XY/DIlAI8RM6f+nUPyFsDcU7gU+utePJl85K8Rb47+5LBq6XLE1hJqgMb5NBMnEpQKSeLBIjLU3ZBPnaZ+pTfntZcJgPTV0z0Tc8D1wPSZxrIURB3wrKLg2iMzZzaYUxd2C5CnYbdmKz6bZVjscryPuVm05Yfbp3sEdFjxf8oDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690903; c=relaxed/simple;
	bh=WT1yk4A3oFgoQgs6qENAcqv/YnPh9bL6v+HMM8NX/VM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GbxrZc40siaXjdiH1BZ7qfttWogxQLZVJnhV1GOhw37/zxqfh8OfpuSyjwqKM+oj59bbuLUrM/M43ugYZ9IckdaNDsgl9xDFb5LqbjnZNxAgY/NKXmdd6hZS7QdWBIdHJ1qnH164mZWnQdOv1UZwyIYIlvVDzOG76yAVlt7HfgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zO7qaLnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2EFC19425;
	Mon, 20 Apr 2026 13:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776690903;
	bh=WT1yk4A3oFgoQgs6qENAcqv/YnPh9bL6v+HMM8NX/VM=;
	h=Subject:To:Cc:From:Date:From;
	b=zO7qaLndiHOZWnPxJoGhWaVJR0DZQv32nvicRTwlyP1u9hwdhPRoYhL8bg10hZmhL
	 Pq1sS0yHCcqmUZHchPCq5EZHvb4eEFn/uIgbOTBvcXi0i0CHuZTO4DeEKoPkpJLGQM
	 Bwn04L4wev2l8GdqpwZM28MvR6/bnizNeA7C4VAY=
Subject: FAILED: patch "[PATCH] KVM: SEV: Lock all vCPUs when synchronzing VMSAs for SNP" failed to apply to 6.12-stable tree
To: seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Apr 2026 15:15:00 +0200
Message-ID: <2026042000-busybody-palpitate-c3f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238778-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 5D59C42B8D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cb923ee6a80f4e604e6242a4702b59251e61a380
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042000-busybody-palpitate-c3f7@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cb923ee6a80f4e604e6242a4702b59251e61a380 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:13 -0700
Subject: [PATCH] KVM: SEV: Lock all vCPUs when synchronzing VMSAs for SNP
 launch finish

Lock all vCPUs when synchronizing and encrypting VMSAs for SNP guests, as
allowing userspace to manipulate and/or run a vCPU while its state is being
synchronized would at best corrupt vCPU state, and at worst crash the host
kernel.

Opportunistically assert that vcpu->mutex is held when synchronizing its
VMSA (the SEV-ES path already locks vCPUs).

Fixes: ad27ce155566 ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_FINISH command")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260310234829.2608037-6-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 10b12db7f902..709e611188c1 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -884,6 +884,8 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	u8 *d;
 	int i;
 
+	lockdep_assert_held(&vcpu->mutex);
+
 	if (vcpu->arch.guest_state_protected)
 		return -EINVAL;
 
@@ -2458,6 +2460,10 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (kvm_is_vcpu_creation_in_progress(kvm))
 		return -EBUSY;
 
+	ret = kvm_lock_all_vcpus(kvm);
+	if (ret)
+		return ret;
+
 	data.gctx_paddr = __psp_pa(sev->snp_context);
 	data.page_type = SNP_PAGE_TYPE_VMSA;
 
@@ -2467,12 +2473,12 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 		ret = sev_es_sync_vmsa(svm);
 		if (ret)
-			return ret;
+			goto out;
 
 		/* Transition the VMSA page to a firmware state. */
 		ret = rmp_make_private(pfn, INITIAL_VMSA_GPA, PG_LEVEL_4K, sev->asid, true);
 		if (ret)
-			return ret;
+			goto out;
 
 		/* Issue the SNP command to encrypt the VMSA */
 		data.address = __sme_pa(svm->sev_es.vmsa);
@@ -2481,7 +2487,7 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		if (ret) {
 			snp_page_reclaim(kvm, pfn);
 
-			return ret;
+			goto out;
 		}
 
 		svm->vcpu.arch.guest_state_protected = true;
@@ -2495,7 +2501,9 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		svm_enable_lbrv(vcpu);
 	}
 
-	return 0;
+out:
+	kvm_unlock_all_vcpus(kvm);
+	return ret;
 }
 
 static int snp_launch_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)


