Return-Path: <stable+bounces-223420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5awyDOITrGkJkAEAu9opvQ
	(envelope-from <stable+bounces-223420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 13:02:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDC222BA3E
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 13:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2393302BDFD
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 12:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B72DF134;
	Sat,  7 Mar 2026 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UJB3qnuX"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840DF2836E;
	Sat,  7 Mar 2026 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772884955; cv=none; b=OAGiW8VIjYZuJdNALjuAuLE1GNSJHWwujjKQAjnjIOndvqGOwrVDv8JfGn6HT1HoyyTGIBeJbdv5ygeLPbtYDPelRTXv+aMqYKuVkSUK/VSmrjvRAeKZmLCjlkHvkrHjkNxOF54qIyEaGCa2yEWqfipdKg6KjhvHC12eI5Uvcf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772884955; c=relaxed/simple;
	bh=ZMGMoK71DW20ifGmPRAf0tsM9kerlbBDYGNdYE6Seuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FgugtbatECNqvW/1A8yC+aI/2AMMNvHOZRmn43jl7ZmzBnfVVPoiVCi6eX688n9/Y4AjqjIAxBaXQSwkYX+jFHTTrJjXT5u41v+jfFFOc7ON5YPJO6ZNNB8tBjTFMFZGA9cgPaE6SFO8RQ35sIWdqdgERrB2NJalQQ+GMuYE4MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UJB3qnuX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1772884951;
	bh=ZMGMoK71DW20ifGmPRAf0tsM9kerlbBDYGNdYE6Seuk=;
	h=From:To:Cc:Subject:Date:From;
	b=UJB3qnuXI42oSBRk7xI1SOpFfXw381UJW+gSgAWuqkwXiXKeDrKfy5IB533dkr+xb
	 62gAw8gDof7m7vhVQLFudvWzXLXOqXc/QneNxxxnBN01O/nD+0f0rtkOA5lA1R3fA8
	 AHj+714VMoBUtxPXPMThbMrbPThEFnBqQG/uJMb3ZCaJMohZADOEWa+n5dLKXHOaqo
	 C+mnP80vwN0VOXMsQcOA2bFPVBoljmJW4UFsRFqQDZfpUJj9Mo5rPx6Q3ld1lhzvfO
	 5+1BXaZYyy4NMSYHggb5dNNimDURXiVkkB3sWqAeSFY+5RQGICdNM/glOw/YgAd+xg
	 GBD0YtA9JMjFQ==
Received: from thinkpad (20014C4E2782E40079F207E35B989CE7.dsl.pool.telekom.hu [IPv6:2001:4c4e:2782:e400:79f2:7e3:5b98:9ce7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: valentine)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 33A4317E12A2;
	Sat,  7 Mar 2026 13:02:31 +0100 (CET)
From: Valentine Burley <valentine.burley@collabora.com>
To: maz@kernel.org
Cc: tabba@google.com,
	broonie@kernel.org,
	Valentine Burley <valentine.burley@collabora.com>,
	stable@vger.kernel.org,
	oupton@kernel.org,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	Sascha.Bischoff@arm.com,
	sebott@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: Skip interrupts in LRs during EOIcount replay
Date: Sat,  7 Mar 2026 12:59:50 +0100
Message-ID: <20260307115955.369455-1-valentine.burley@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7EDC222BA3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223420-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[valentine.burley@collabora.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-0.979];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Commit 05984ba67eb6 ("KVM: arm64: Invert ap_list sorting to push active
interrupts out") allowed active interrupts to be evicted from LRs to
make room for pending ones.

When an evicted interrupt is deactivated by the guest, the GIC
increments EOIcount. KVM replays this by finding an active interrupt
in the ap_list to deactivate. However, the replay logic may pick an
interrupt that is currently residing in an LR, leading to a spurious
deactivation and leaving the actually finished interrupt active.
This results in interrupt storms and boot failures (seen in Cuttlefish
guests on Qualcomm SC7180).

Fix this by skipping interrupts that are currently assigned to an LR
during EOIcount replay.

This allows booting Android VMs in Cuttlefish again.

Fixes: 05984ba67eb6 ("KVM: arm64: Invert ap_list sorting to push active interrupts out")
Cc: stable@vger.kernel.org
Signed-off-by: Valentine Burley <valentine.burley@collabora.com>
---
 arch/arm64/kvm/vgic/vgic-v2.c | 14 ++++++++++++++
 arch/arm64/kvm/vgic/vgic-v3.c | 19 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
index 585491fbda80..821cf5bc30da 100644
--- a/arch/arm64/kvm/vgic/vgic-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-v2.c
@@ -135,6 +135,20 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
 			      irq->active))
 				continue;
 
+			bool was_in_lr = false;
+
+			for (int i = 0; i < cpuif->used_lrs; i++) {
+				u32 intid = cpuif->vgic_lr[i] & GICH_LR_VIRTUALID;
+
+				if (intid == irq->intid) {
+					was_in_lr = true;
+					break;
+				}
+			}
+
+			if (was_in_lr)
+				continue;
+
 			lr = vgic_v2_compute_lr(vcpu, irq) & ~GICH_LR_ACTIVE_BIT;
 		}
 
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 1d6dd1b545bd..00d9bc39bffb 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -179,6 +179,25 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
 			      irq->active))
 				continue;
 
+			bool was_in_lr = false;
+
+			for (int i = 0; i < cpuif->used_lrs; i++) {
+				u32 intid;
+
+				if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
+					intid = cpuif->vgic_lr[i] & ICH_LR_VIRTUAL_ID_MASK;
+				else
+					intid = cpuif->vgic_lr[i] & GICH_LR_VIRTUALID;
+
+				if (intid == irq->intid) {
+					was_in_lr = true;
+					break;
+				}
+			}
+
+			if (was_in_lr)
+				continue;
+
 			lr = vgic_v3_compute_lr(vcpu, irq) & ~ICH_LR_ACTIVE_BIT;
 		}
 
-- 
2.51.0


