Return-Path: <stable+bounces-67045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE394F3A7
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20A0281687
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33063186E38;
	Mon, 12 Aug 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="seeaAjGf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612C183CA6;
	Mon, 12 Aug 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479621; cv=none; b=c60XROucqSwy2AHOdjzndHoDkb5lC0JrXsRL2ZwRQ48rw6oPQKF67GmocL5Eez2Yy1UAkWw1xltzuKNHZ2+5JdLoTKFPpc0p71aN1qWETp0ZhZhWFuIZyUtXn0H24yhLI9J2XCAyTAXAFdreWlL4WlRCrOxTAgRyNWYCr3a5rkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479621; c=relaxed/simple;
	bh=vIGe9u9605uF+Fda++UounZfhiMDZLmBMbG1G254HC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0e5Fes9/VjmiMU+YFb7pFo427/0bRorL99463zOouAl6HwFnFgs2xa0SZBk+r5vMMQvLY1jYAKQ/lDUklHiELahGKsNADSN3Zch8jIj3YUq/BT9t/uPifGpjK3PlCmfTOo2qtgAyrghSw01S7p+d/8nDnDZJg0ucL2EHSM5rr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=seeaAjGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EE5C32782;
	Mon, 12 Aug 2024 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479620;
	bh=vIGe9u9605uF+Fda++UounZfhiMDZLmBMbG1G254HC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=seeaAjGfVKTpqWAAQIaSLxk2mNf8FuoQ0T/bRsk2KuNmLrH5TeOQ/ytOP5bTO6frn
	 37fvDM2to5O10tgU6e3DMdFhhB9iEmicmzDkD21vPpQjtyBZzRqiNZRfNkLE59q9uA
	 1jXzvELJ+9kggKXpS1VSyriSc0r87Vx7t8dPrIc8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shay Drory <shayd@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.6 143/189] genirq/irqdesc: Honor caller provided affinity in alloc_desc()
Date: Mon, 12 Aug 2024 18:03:19 +0200
Message-ID: <20240812160137.646128832@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
References: <20240812160132.135168257@linuxfoundation.org>
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
@@ -517,6 +517,7 @@ static int alloc_descs(unsigned int star
 				flags = IRQD_AFFINITY_MANAGED |
 					IRQD_MANAGED_SHUTDOWN;
 			}
+			flags |= IRQD_AFFINITY_SET;
 			mask = &affinity->mask;
 			node = cpu_to_node(cpumask_first(mask));
 			affinity++;



