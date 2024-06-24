Return-Path: <stable+bounces-55044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E645D9151A0
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D5D1F21AB6
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A419D06A;
	Mon, 24 Jun 2024 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m0uWPFV3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756619CD1E
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241901; cv=none; b=d60DZjZb9mz0ZgLL/N7cR/v5GVNz3GMx2AhyRP3efc3sEbI2l7aOVRHLo5R4vLM25JGXCFUKfYRQ9DkL/beBMKkQM5rGFV7vny5sfshhETLGRZQODA5T2VVlyJ21DrJCdOqIirJkvxBNEQhfQhGKx8VZo0UX/9waRVsNJaUfX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241901; c=relaxed/simple;
	bh=+aiLDYK8gjA2uakXjYNr+VU18Yyo7H8ZPRvdwZfqVRQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P1aLGAP/Ig7/2SbVykKSj4ayHb7BjnEpbA87Jc9zKr9FwvlKzslGXM36OfyFn4toX+zlQQI1UTey4FlfNvPbJ6YUuMuV/QJu+Y9hTKP0C9bZac8jeDn4a/zL7QnWQNzu8sY7Izg5e1ffv1j0BuM8M846UEivZaalfTfHvXPX/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m0uWPFV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC171C32782;
	Mon, 24 Jun 2024 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719241901;
	bh=+aiLDYK8gjA2uakXjYNr+VU18Yyo7H8ZPRvdwZfqVRQ=;
	h=Subject:To:Cc:From:Date:From;
	b=m0uWPFV3ezSm/NYs/vsRE7XUkaHD+SMzHP6fUBoQ5rJlc4D9sOaAkbn8TCUybm39x
	 o+u6R9jEoCsYJkyXImY7BVddU2SwdcuOCu/6myXzFRVJxLy8+TnNnT8/sWM5hlRPEK
	 RmSOb2aAUZtXCO6tNT3teOa8FLQj60dsVizFTNfg=
Subject: FAILED: patch "[PATCH] KVM: arm64: Disassociate vcpus from redistributor region on" failed to apply to 5.15-stable tree
To: maz@kernel.org,glider@google.com,oliver.upton@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 17:11:38 +0200
Message-ID: <2024062438-dean-sacrifice-9c3b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0d92e4a7ffd5c42b9fa864692f82476c0bf8bcc8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062438-dean-sacrifice-9c3b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0d92e4a7ffd5c42b9fa864692f82476c0bf8bcc8 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Wed, 5 Jun 2024 18:56:37 +0100
Subject: [PATCH] KVM: arm64: Disassociate vcpus from redistributor region on
 teardown

When tearing down a redistributor region, make sure we don't have
any dangling pointer to that region stored in a vcpu.

Fixes: e5a35635464b ("kvm: arm64: vgic-v3: Introduce vgic_v3_free_redist_region()")
Reported-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20240605175637.1635653-1-maz@kernel.org
Cc: stable@vger.kernel.org

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 8f5b7a3e7009..7f68cf58b978 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -391,7 +391,7 @@ static void kvm_vgic_dist_destroy(struct kvm *kvm)
 
 	if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
 		list_for_each_entry_safe(rdreg, next, &dist->rd_regions, list)
-			vgic_v3_free_redist_region(rdreg);
+			vgic_v3_free_redist_region(kvm, rdreg);
 		INIT_LIST_HEAD(&dist->rd_regions);
 	} else {
 		dist->vgic_cpu_base = VGIC_ADDR_UNDEF;
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index a3983a631b5a..9e50928f5d7d 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -919,8 +919,19 @@ static int vgic_v3_alloc_redist_region(struct kvm *kvm, uint32_t index,
 	return ret;
 }
 
-void vgic_v3_free_redist_region(struct vgic_redist_region *rdreg)
+void vgic_v3_free_redist_region(struct kvm *kvm, struct vgic_redist_region *rdreg)
 {
+	struct kvm_vcpu *vcpu;
+	unsigned long c;
+
+	lockdep_assert_held(&kvm->arch.config_lock);
+
+	/* Garbage collect the region */
+	kvm_for_each_vcpu(c, vcpu, kvm) {
+		if (vcpu->arch.vgic_cpu.rdreg == rdreg)
+			vcpu->arch.vgic_cpu.rdreg = NULL;
+	}
+
 	list_del(&rdreg->list);
 	kfree(rdreg);
 }
@@ -945,7 +956,7 @@ int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count)
 
 		mutex_lock(&kvm->arch.config_lock);
 		rdreg = vgic_v3_rdist_region_from_index(kvm, index);
-		vgic_v3_free_redist_region(rdreg);
+		vgic_v3_free_redist_region(kvm, rdreg);
 		mutex_unlock(&kvm->arch.config_lock);
 		return ret;
 	}
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index 6106ebd5ba42..03d356a12377 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -316,7 +316,7 @@ vgic_v3_rd_region_size(struct kvm *kvm, struct vgic_redist_region *rdreg)
 
 struct vgic_redist_region *vgic_v3_rdist_region_from_index(struct kvm *kvm,
 							   u32 index);
-void vgic_v3_free_redist_region(struct vgic_redist_region *rdreg);
+void vgic_v3_free_redist_region(struct kvm *kvm, struct vgic_redist_region *rdreg);
 
 bool vgic_v3_rdist_overlap(struct kvm *kvm, gpa_t base, size_t size);
 


