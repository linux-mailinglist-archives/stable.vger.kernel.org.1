Return-Path: <stable+bounces-9007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8248205CE
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A37B213F7
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB9B79E0;
	Sat, 30 Dec 2023 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Y8cN5gM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4C8487;
	Sat, 30 Dec 2023 12:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E8BC433C7;
	Sat, 30 Dec 2023 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938331;
	bh=5zAo6hM/+35hMrOdPj7TcwrqRz8C0kPE0dkiy2Qflas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2Y8cN5gM4Kp3qvcr1coWHKKfCua0FUvkbBC2SGpg+PMEqzwRAXGSbPd37GcALPXzI
	 BartvSKtOCZzcS74PTwLqRYEAy3PhTTB+HZiKInZwN3n3tcmTvwz6qJQiSQc0bHNYi
	 f+S2gEDMYUatjk8FnN8CrBgjMb5seUb1MNxqGIbE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 6.1 105/112] KVM: arm64: vgic: Simplify kvm_vgic_destroy()
Date: Sat, 30 Dec 2023 12:00:18 +0000
Message-ID: <20231230115810.133010203@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <maz@kernel.org>

commit 01ad29d224ff73bc4e16e0ef9ece17f28598c4a4 upstream.

When destroying a vgic, we have rather cumbersome rules about
when slots_lock and config_lock are held, resulting in fun
buglets.

The first port of call is to simplify kvm_vgic_map_resources()
so that there is only one call to kvm_vgic_destroy() instead of
two, with the second only holding half of the locks.

For that, we kill the non-locking primitive and move the call
outside of the locking altogether. This doesn't change anything
(we re-acquire the locks and teardown the whole vgic), and
simplifies the code significantly.

Cc: stable@vger.kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20231207151201.3028710-2-maz@kernel.org
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/vgic/vgic-init.c |   29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -382,26 +382,24 @@ void kvm_vgic_vcpu_destroy(struct kvm_vc
 	vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
 }
 
-static void __kvm_vgic_destroy(struct kvm *kvm)
+void kvm_vgic_destroy(struct kvm *kvm)
 {
 	struct kvm_vcpu *vcpu;
 	unsigned long i;
 
-	lockdep_assert_held(&kvm->arch.config_lock);
+	mutex_lock(&kvm->slots_lock);
 
 	vgic_debug_destroy(kvm);
 
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		kvm_vgic_vcpu_destroy(vcpu);
 
+	mutex_lock(&kvm->arch.config_lock);
+
 	kvm_vgic_dist_destroy(kvm);
-}
 
-void kvm_vgic_destroy(struct kvm *kvm)
-{
-	mutex_lock(&kvm->arch.config_lock);
-	__kvm_vgic_destroy(kvm);
 	mutex_unlock(&kvm->arch.config_lock);
+	mutex_unlock(&kvm->slots_lock);
 }
 
 /**
@@ -469,25 +467,26 @@ int kvm_vgic_map_resources(struct kvm *k
 		type = VGIC_V3;
 	}
 
-	if (ret) {
-		__kvm_vgic_destroy(kvm);
+	if (ret)
 		goto out;
-	}
+
 	dist->ready = true;
 	dist_base = dist->vgic_dist_base;
 	mutex_unlock(&kvm->arch.config_lock);
 
 	ret = vgic_register_dist_iodev(kvm, dist_base, type);
-	if (ret) {
+	if (ret)
 		kvm_err("Unable to register VGIC dist MMIO regions\n");
-		kvm_vgic_destroy(kvm);
-	}
-	mutex_unlock(&kvm->slots_lock);
-	return ret;
 
+	goto out_slots;
 out:
 	mutex_unlock(&kvm->arch.config_lock);
+out_slots:
 	mutex_unlock(&kvm->slots_lock);
+
+	if (ret)
+		kvm_vgic_destroy(kvm);
+
 	return ret;
 }
 



