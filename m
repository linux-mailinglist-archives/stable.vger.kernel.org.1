Return-Path: <stable+bounces-23762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDCD868340
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05491F2DA72
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 21:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671E8130E2E;
	Mon, 26 Feb 2024 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qKJWDrVf"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B46130E3E
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983522; cv=none; b=hKNUdw6oMZE7sjqa8/tq2HsmISNYQkdRF9geEO+ICVqGjgiw5MMKBMF14+zP7olJHSF7zbZChhCH/GA7odqCSEUkANGRZ/YMtYOV1dUj1aSRL4Fwip+Jw03abW5G5g0O3Bb2ZxcBCWyonawPiZOVPh7za7HytJB9QZBmVx6m+fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983522; c=relaxed/simple;
	bh=gcDTUu5GxAbUOw6Bmi+vEdyxioVKk4KY3Rg/HGcT+Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecMafGY72vnfrG7F8pjpBbJM4VHecahIqg7gW0eoxU4E4rA3Y5x2/zf0XRXzPrdwH/sjf/wfrsE63WdIR1kKDrXl96Z0FKR0YKWgBhQMuwpeb6JANJpdm7grFgJTgOQ6lK6HXDTBuVeK2rb8mPtXS8UQvYcOeY/JyuWltrCMgBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qKJWDrVf; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708983518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4NAvCQVnqvUZj57BcFoyhfCFvLaQmf2oR0+15bOHkA=;
	b=qKJWDrVfiQrSC80VSG9oXo2Ek0uWO5UJyx7JRME05Qi2AuRe2SCAe4y3JkPfHJSWeX4JJG
	MeSXpLFS4b/svqnkgwCEd+5GT4jjT5YZPFt2axVVHX685OvsXLRHY/9bC0MYsddFsh3Rhz
	veBluEAL3eUUxVRM8j2G6bBL2s3kcU8=
From: Oliver Upton <oliver.upton@linux.dev>
To: stable@vger.kernel.org
Cc: maz@kernel.org,
	gregkh@linuxfoundation.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 4.19.y 1/2] KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()
Date: Mon, 26 Feb 2024 21:38:21 +0000
Message-ID: <20240226213822.1228736-2-oliver.upton@linux.dev>
In-Reply-To: <20240226213822.1228736-1-oliver.upton@linux.dev>
References: <20240226213822.1228736-1-oliver.upton@linux.dev>
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
index cb36774a750c..30d1809f720b 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -469,6 +469,9 @@ static int its_sync_lpi_pending_table(struct kvm_vcpu *vcpu)
 		}
 
 		irq = vgic_get_irq(vcpu->kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
+
 		spin_lock_irqsave(&irq->irq_lock, flags);
 		irq->pending_latch = pendmask & (1U << bit_nr);
 		vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
-- 
2.44.0.rc1.240.g4c46232300-goog


