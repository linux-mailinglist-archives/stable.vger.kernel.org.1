Return-Path: <stable+bounces-23769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E4286835F
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6272AB22E65
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 21:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5DF131E21;
	Mon, 26 Feb 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ShCWjyaX"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE1131733
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984587; cv=none; b=mZyZ0Oour4zpQHzKPfHppH+FUF36Mne4+lNZNAxKDLFlxHo1Uto0AQ97rUXuL4t0+/xiCFPndCMvuqQM6wJZ+x6uuJEfndvqz77INpBjTgBk0fnuBPnzeIKRbGQ/efd63T7+OaeBBM0RaKIMCn/XV6FWFCflM5ZClCDW9tfko2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984587; c=relaxed/simple;
	bh=h3m8ET3lTNE6IH77eNGffBBgvRW2D1sJ9VMmtSrZWDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmhR3OR2SEBYh1KSmI1CTVfP4hIWUctRt64j5biuNUC1nvxR3kMOPi8unJ+R2un2cThoxyGu7DM7+ie1BFaGy5m6WcnY2IOj+Nrs2Ev5tIA4ALmGNq42g7MrO3ZS36tRl32juO6EjrxZ1H30emSpz13Q0ue/jcs1im0/3AL5r4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ShCWjyaX; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708984583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=if1udu4bRHtTblkcFdHq3gFZ4aMm/ISKwS4hYx0k1Co=;
	b=ShCWjyaXBGpZC1ET7UZfXx9OoVJsi7rfvnQK16E3yW1iW1x8u/3n9vzZia/PlG0LLsURYQ
	xgCJ5MY/tTPeeUyfjMbFw2Q+eE1yszgc6fmyDd4Mwf7P1LgprnQSkdP4MHNg5Or5sD4C2L
	C4NhdW9tcbsS6Sc10sT0HZDD1o6Xns8=
From: Oliver Upton <oliver.upton@linux.dev>
To: stable@vger.kernel.org
Cc: maz@kernel.org,
	gregkh@linuxfoundation.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 5.4.y 1/2] KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()
Date: Mon, 26 Feb 2024 21:56:11 +0000
Message-ID: <20240226215612.1387774-2-oliver.upton@linux.dev>
In-Reply-To: <20240226215612.1387774-1-oliver.upton@linux.dev>
References: <20240226215612.1387774-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

commit 8d3a7dfb801d157ac423261d7cd62c33e95375f8 upstream.

vgic_get_irq() may not return a valid descriptor if there is no ITS that
holds a valid translation for the specified INTID. If that is the case,
it is safe to silently ignore it and continue processing the LPI pending
table.

Cc: stable@vger.kernel.org
Fixes: 33d3bc9556a7 ("KVM: arm64: vgic-its: Read initial LPI pending table")
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20240221092732.4126848-2-oliver.upton@linux.dev
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 virt/kvm/arm/vgic/vgic-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 0533881bd2ab..0589dfbc7685 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -459,6 +459,9 @@ static int its_sync_lpi_pending_table(struct kvm_vcpu *vcpu)
 		}
 
 		irq = vgic_get_irq(vcpu->kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
+
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		irq->pending_latch = pendmask & (1U << bit_nr);
 		vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
-- 
2.44.0.rc1.240.g4c46232300-goog


