Return-Path: <stable+bounces-225590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNhJOrsiuGk8ZgEAu9opvQ
	(envelope-from <stable+bounces-225590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:33:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EAD29C747
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13F93310E001
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326523A782E;
	Mon, 16 Mar 2026 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QaePW7Xz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98953A63FB
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674771; cv=none; b=WAQDjNxlmqHbYIX1xeoU9yh08rzAnD0+m6qlo/MS3ZzzHg6ya6fnZ/EPN0a1/UMZfggx1nklNqo4sMY1aypcVyUaR2deTeJlJmQT7veyCvONNaPGre6ykzlkNydfm3yhX/rHpK5nqmZCZKlEWTnXMx6eSa7rfFQUnuAzsA/+e2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674771; c=relaxed/simple;
	bh=tQal3wLkhhGi+u4kP5INtBAAyeJC9wL062aS1aQZnVg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qPis+uQlbE3DJG9E0m7Cj/f6BpAaOPFChgCET7Eg332sx575wknaR/tsrdW4nxDrhbADt5FsJcX1/pDczwGDc4Hnlii5rejdRo5eu1cWB2a2hwRYZ9cTd5xbrrtIYl49Ij2wjcnHKZmKwH73ciH4IxZqxqshVaP82dsIm4OO6zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QaePW7Xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250D6C2BC87;
	Mon, 16 Mar 2026 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773674770;
	bh=tQal3wLkhhGi+u4kP5INtBAAyeJC9wL062aS1aQZnVg=;
	h=Subject:To:Cc:From:Date:From;
	b=QaePW7Xz6gSYWThLXAfNvo+5F1elFxuiuB/PcLgZgvTtZuxyhu0CpH/bG5CmKOkHu
	 0w8eDJIErN6z8Tf+kUL0UZma/K+Q4NiiRaN8tfD5ag7k1uE/dhfKaflytvBrXIZJ0p
	 Apkl4znv1X/rhv/+E8KQF1ooUuS8o+0aMwVozPns=
Subject: FAILED: patch "[PATCH] KVM: arm64: Eagerly init vgic dist/redist on vgic creation" failed to apply to 6.19-stable tree
To: maz@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Mar 2026 16:26:07 +0100
Message-ID: <2026031607-maimed-erasable-eac8@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225590-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 26EAD29C747
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
git checkout FETCH_HEAD
git cherry-pick -x ac6769c8f948dff33265c50e524aebf9aa6f1be0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031607-maimed-erasable-eac8@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ac6769c8f948dff33265c50e524aebf9aa6f1be0 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Sat, 28 Feb 2026 16:45:59 +0000
Subject: [PATCH] KVM: arm64: Eagerly init vgic dist/redist on vgic creation

If vgic_allocate_private_irqs_locked() fails for any odd reason,
we exit kvm_vgic_create() early, leaving dist->rd_regions uninitialised.

kvm_vgic_dist_destroy() then comes along and walks into the weeds
trying to free the RDs. Got to love this stuff.

Solve it by moving all the static initialisation early, and make
sure that if we fail halfway, we're in a reasonable shape to
perform the rest of the teardown. While at it, reset the vgic model
on failure, just in case...

Reported-by: syzbot+f6a46b038fc243ac0175@syzkaller.appspotmail.com
Tested-by: syzbot+f6a46b038fc243ac0175@syzkaller.appspotmail.com
Fixes: b3aa9283c0c50 ("KVM: arm64: vgic: Hoist SGI/PPI alloc from vgic_init() to kvm_create_vgic()")
Link: https://lore.kernel.org/r/69a2d58c.050a0220.3a55be.003b.GAE@google.com
Link: https://patch.msgid.link/20260228164559.936268-1-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 9b3091ad868c..e9b8b5fc480c 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -143,23 +143,6 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 	kvm->arch.vgic.in_kernel = true;
 	kvm->arch.vgic.vgic_model = type;
 	kvm->arch.vgic.implementation_rev = KVM_VGIC_IMP_REV_LATEST;
-
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		ret = vgic_allocate_private_irqs_locked(vcpu, type);
-		if (ret)
-			break;
-	}
-
-	if (ret) {
-		kvm_for_each_vcpu(i, vcpu, kvm) {
-			struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
-			kfree(vgic_cpu->private_irqs);
-			vgic_cpu->private_irqs = NULL;
-		}
-
-		goto out_unlock;
-	}
-
 	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
 
 	aa64pfr0 = kvm_read_vm_id_reg(kvm, SYS_ID_AA64PFR0_EL1) & ~ID_AA64PFR0_EL1_GIC;
@@ -176,6 +159,23 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 	kvm_set_vm_id_reg(kvm, SYS_ID_AA64PFR0_EL1, aa64pfr0);
 	kvm_set_vm_id_reg(kvm, SYS_ID_PFR1_EL1, pfr1);
 
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		ret = vgic_allocate_private_irqs_locked(vcpu, type);
+		if (ret)
+			break;
+	}
+
+	if (ret) {
+		kvm_for_each_vcpu(i, vcpu, kvm) {
+			struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+			kfree(vgic_cpu->private_irqs);
+			vgic_cpu->private_irqs = NULL;
+		}
+
+		kvm->arch.vgic.vgic_model = 0;
+		goto out_unlock;
+	}
+
 	if (type == KVM_DEV_TYPE_ARM_VGIC_V3)
 		kvm->arch.vgic.nassgicap = system_supports_direct_sgis();
 


