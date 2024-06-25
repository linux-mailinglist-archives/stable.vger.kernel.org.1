Return-Path: <stable+bounces-55554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7B0916424
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDD01C20971
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A5214A092;
	Tue, 25 Jun 2024 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="teXr4DaA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819CD149DEF;
	Tue, 25 Jun 2024 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309245; cv=none; b=kQrTptKdR3XbaprVOSEbKg5oqeWl+0XcFTjXM14SoI7jaB53GmMGGfggU0cF9NO40XQ7R3/alaA7OUBIX8bdbkuHny8dYdFcdDKQydjetD4rMTCPqnkU853JhumAjqCOlIWpoAvxNcRj+jp+sveX+46kXKPAsnZ0Ujk527eh04g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309245; c=relaxed/simple;
	bh=z2S5YdNjfCP9nwNFNU6L5+0JmyosQ094GtfePxkJxEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dao77zPGI5x/Covtn0PSAkaVEsYWXY9dh6p1K+IXR4QapcRrIGVuskBKWoXmvq4+f4gGwJqvmNnLNu1mCk8ptUozsTQqTPjJWy6u44ObrpWYPFeBAhRmZSjnnQfQR2hjCDCrvuDNS/ss/3LOQpentDKuIQ61vfUETajj2ISyrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=teXr4DaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A011CC32781;
	Tue, 25 Jun 2024 09:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309245;
	bh=z2S5YdNjfCP9nwNFNU6L5+0JmyosQ094GtfePxkJxEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=teXr4DaAyz2UOlz4pDN+fhFNahMbYf/ojOQswz2bs1l8yq3NeFzWbNasLA0m0ln2S
	 49Gg8AD8LSbKo0bICl46suPcSo1gmg5r0OtdyWDdHug4JQZPt0o1rP3FcpzsNLx5/Q
	 gm4mS9YrwaxT8r2YwyGupzThhXdczfUbSl9WQbIM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Potapenko <glider@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.6 143/192] KVM: arm64: Disassociate vcpus from redistributor region on teardown
Date: Tue, 25 Jun 2024 11:33:35 +0200
Message-ID: <20240625085542.647900536@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <maz@kernel.org>

commit 0d92e4a7ffd5c42b9fa864692f82476c0bf8bcc8 upstream.

When tearing down a redistributor region, make sure we don't have
any dangling pointer to that region stored in a vcpu.

Fixes: e5a35635464b ("kvm: arm64: vgic-v3: Introduce vgic_v3_free_redist_region()")
Reported-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20240605175637.1635653-1-maz@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/vgic/vgic-init.c    |    2 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c |   15 +++++++++++++--
 arch/arm64/kvm/vgic/vgic.h         |    2 +-
 3 files changed, 15 insertions(+), 4 deletions(-)

--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -355,7 +355,7 @@ static void kvm_vgic_dist_destroy(struct
 
 	if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
 		list_for_each_entry_safe(rdreg, next, &dist->rd_regions, list)
-			vgic_v3_free_redist_region(rdreg);
+			vgic_v3_free_redist_region(kvm, rdreg);
 		INIT_LIST_HEAD(&dist->rd_regions);
 	} else {
 		dist->vgic_cpu_base = VGIC_ADDR_UNDEF;
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -942,8 +942,19 @@ free:
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
@@ -968,7 +979,7 @@ int vgic_v3_set_redist_base(struct kvm *
 
 		mutex_lock(&kvm->arch.config_lock);
 		rdreg = vgic_v3_rdist_region_from_index(kvm, index);
-		vgic_v3_free_redist_region(rdreg);
+		vgic_v3_free_redist_region(kvm, rdreg);
 		mutex_unlock(&kvm->arch.config_lock);
 		return ret;
 	}
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -310,7 +310,7 @@ vgic_v3_rd_region_size(struct kvm *kvm,
 
 struct vgic_redist_region *vgic_v3_rdist_region_from_index(struct kvm *kvm,
 							   u32 index);
-void vgic_v3_free_redist_region(struct vgic_redist_region *rdreg);
+void vgic_v3_free_redist_region(struct kvm *kvm, struct vgic_redist_region *rdreg);
 
 bool vgic_v3_rdist_overlap(struct kvm *kvm, gpa_t base, size_t size);
 



