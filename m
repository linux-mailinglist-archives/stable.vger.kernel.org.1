Return-Path: <stable+bounces-68830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D51A953434
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5066D1C23821
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAEE1AD41F;
	Thu, 15 Aug 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zdDeIdp2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFED63C;
	Thu, 15 Aug 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731798; cv=none; b=PhQ0SSiExazD9/qr1822id5HySYlQ6uJEfpVOnHzuAAYQZAZOqdssC4jbbnXYlED5S0h5w9zz3O76miCwgcskRTV3iD4JX/6JGKvdg3wmWJDXbrs6h6a1HQjeQ1fH76Qidfix7g+6Z8GEoxDnTr54gCHZHsOHRBVk+2qdWE/hfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731798; c=relaxed/simple;
	bh=/Stmb5v9CEOJ+7uRY6krofpEtsXaUh825TBkJ4H1Vg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkvBXknH0KKvEfh2e3+Zq3AF3UMc8dZZdjuMAB+VcyED36DG3Rh82gkvijggrygP/q69tgRuYBF1valF48KdbuVvd/7+CORQhB975TpqDyGOUxvjVakFZGGlycWd+oF88RWRI6OiHWbC4M+AHEYnAgdJpe9DVhxpktKcyMJtAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zdDeIdp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054C2C4AF11;
	Thu, 15 Aug 2024 14:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731798;
	bh=/Stmb5v9CEOJ+7uRY6krofpEtsXaUh825TBkJ4H1Vg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zdDeIdp2EdTHd9bEN3F5NHc5DRtdAXO7eLrm9J8BzaBJEFelv//lrRcRLXikh4Klh
	 VULpZpGR5xMtR39ZtBedY+nE9T0tn71IgX2U/EryxzZk0iYrroixRD7hLZPKnlcse8
	 jJZeCGC+hYWy5Jd1TGShINiuPtl4qOH2iNRylmiY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shay Drory <shayd@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.4 242/259] genirq/irqdesc: Honor caller provided affinity in alloc_desc()
Date: Thu, 15 Aug 2024 15:26:15 +0200
Message-ID: <20240815131912.116388281@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shay Drory <shayd@nvidia.com>

commit edbbaae42a56f9a2b39c52ef2504dfb3fb0a7858 upstream.

Currently, whenever a caller is providing an affinity hint for an
interrupt, the allocation code uses it to calculate the node and copies the
cpumask into irq_desc::affinity.

If the affinity for the interrupt is not marked 'managed' then the startup
of the interrupt ignores irq_desc::affinity and uses the system default
affinity mask.

Prevent this by setting the IRQD_AFFINITY_SET flag for the interrupt in the
allocator, which causes irq_setup_affinity() to use irq_desc::affinity on
interrupt startup if the mask contains an online CPU.

[ tglx: Massaged changelog ]

Fixes: 45ddcecbfa94 ("genirq: Use affinity hint in irqdesc allocation")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/all/20240806072044.837827-1-shayd@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/irq/irqdesc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -491,6 +491,7 @@ static int alloc_descs(unsigned int star
 				flags = IRQD_AFFINITY_MANAGED |
 					IRQD_MANAGED_SHUTDOWN;
 			}
+			flags |= IRQD_AFFINITY_SET;
 			mask = &affinity->mask;
 			node = cpu_to_node(cpumask_first(mask));
 			affinity++;



