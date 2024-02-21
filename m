Return-Path: <stable+bounces-21801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B312D85D390
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 10:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36938B20D41
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C5F3FB30;
	Wed, 21 Feb 2024 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qfGlVWRm"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61213F9D7
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507699; cv=none; b=iUzKzw+s92Jy4AzZMYgH0oLCFLHd7yeXAnqKhAbWzscnkf7Fob1oNBPopHct9ijkuZOZs4maRZ7XILrrgb2C949NqWo7aQlyYdZuVS9fXzNjBjd8ByoDbfL8f7h7RxrI8CLNmGc73IvXk+fnqAJIP8sq9N903LozWVVD8Ckd8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507699; c=relaxed/simple;
	bh=a2OBB/5yoUHI7p6/krgfnd1hy3xttNKL2QzP8l09CKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeYi17NJ/FN6mDTM/0c8+Yezy2ea1TFzblR3A1hr/O6ie5eNVf5aQLmYvoXHa+WnpePYtmht+99zu1PY7ZyJiZRgrD+NKDD0JQNyDWLJKdo4/JZjRp3Psn4BVNy61HBAW8Ps0zMbr3gCVUci/8uSasWHiqdFVLU9qPTFSIxhUR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qfGlVWRm; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708507695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cB9MF8yUSgqilWV1OVInCZs0qX6heGemiuz9gZTAH8U=;
	b=qfGlVWRmKSNbL/6Ywbi2voMM8wmb19NrGaf3WzEeBuF8kHb2eqFc9zbgIWD8AObZZuuskr
	b9ilYc9YMhMXLzwcQZ58IvVM8C8uBUpo5Ye8gx5mE9a3U3Q3OaXyjMRAnQakWcB/DtDmEh
	3XHMpl3w89bHLehZ37pT58fIx42WKhI=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()
Date: Wed, 21 Feb 2024 09:27:31 +0000
Message-ID: <20240221092732.4126848-2-oliver.upton@linux.dev>
In-Reply-To: <20240221092732.4126848-1-oliver.upton@linux.dev>
References: <20240221092732.4126848-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

vgic_get_irq() may not return a valid descriptor if there is no ITS that
holds a valid translation for the specified INTID. If that is the case,
it is safe to silently ignore it and continue processing the LPI pending
table.

Cc: stable@vger.kernel.org
Fixes: 33d3bc9556a7 ("KVM: arm64: vgic-its: Read initial LPI pending table")
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/vgic/vgic-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index e2764d0ffa9f..082448de27ed 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -468,6 +468,9 @@ static int its_sync_lpi_pending_table(struct kvm_vcpu *vcpu)
 		}
 
 		irq = vgic_get_irq(vcpu->kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
+
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		irq->pending_latch = pendmask & (1U << bit_nr);
 		vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
-- 
2.44.0.rc0.258.g7320e95886-goog


