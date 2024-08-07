Return-Path: <stable+bounces-65928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D6294ACF3
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B63A1C210BD
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E2685931;
	Wed,  7 Aug 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N2KgxLJi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kOk8Qt28"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A0082499;
	Wed,  7 Aug 2024 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044769; cv=none; b=MF5027OdcX7+gv/PiXAeCuV+Omc36IILlA+FdRpy5iAvUBGfs0P4ni8KzRMe223nogXQULqQ4RfXOsrvFGuWBVXLRQdgWUQ8Jr5xWIcuQxsAzQPm5cVdOYV3cYgJUcBNwQ/M3uX5fbrpttJ3FRhA2Upad1/y5HqhQRXCrjBpA4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044769; c=relaxed/simple;
	bh=5Mj8SXHMcEKQVrYr8pZWaXF311MX5ewWkbhfV5N07nE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LC7dvoFhEkt/2Bs97h+1JRN+TDA4dK6T7XdV5xiu6zrMbQyiH+0oHlBp0GeJkbudGjY/A9hkMnDRGtOm38AzeTIN0O/xYoudVwUYaZX6J2N2f0exDbRBl4tnilSuu3pu4MN8UmgxTKZyY50INCkH0pLyi5DgHRRBn08aPTXnNQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N2KgxLJi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kOk8Qt28; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 15:32:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723044766;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGlL1b2Cl+k2Fq0XtZmXv+Zg2zYI+3nb3hAswDvKywM=;
	b=N2KgxLJiqXPW/qwJg85PKx7j0giggXEBM2b5wl08TlAHAAx2GNeXjsDXHXi3mDHAHIVWmI
	5OrLrg2IPDaFSApmi9Smz/+AzHlHdEU+tFHv28pC8EkIm5eK1OqwiczHezSEOU9mJppfkc
	G/IQlzuq9IX2ykHsD2WtQ80et6ed076ZdgfEh+kog0zrd7EUBLZmokFrA00NdzGUCKPdGV
	39jee13aclGl4+mnQeEiPP6LJvkiEvU1WdJIDwWwFsc5PE7+k3nXiCaU8uk6tTtxkNZNqN
	l2xJge2r1Zt/LjjeImPb3XUZbgfQ04BA+9pSJFgJ8S1jPYV48AxeSWmaQqm+Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723044766;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGlL1b2Cl+k2Fq0XtZmXv+Zg2zYI+3nb3hAswDvKywM=;
	b=kOk8Qt286kOomsoFhUmTEI1QiF+sA5KQEE67GVmv0PQbo2UXXiazbSL24SUZWmURxPR/6u
	ovAGVUuchFQtWgCQ==
From: "tip-bot2 for Shay Drory" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/irqdesc: Honor caller provided affinity in
 alloc_desc()
Cc: Shay Drory <shayd@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
  <stable@vger.kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240806072044.837827-1-shayd@nvidia.com>
References: <20240806072044.837827-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304476610.2215.2042942398040144931.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     edbbaae42a56f9a2b39c52ef2504dfb3fb0a7858
Gitweb:        https://git.kernel.org/tip/edbbaae42a56f9a2b39c52ef2504dfb3fb0a7858
Author:        Shay Drory <shayd@nvidia.com>
AuthorDate:    Tue, 06 Aug 2024 10:20:44 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 17:27:00 +02:00

genirq/irqdesc: Honor caller provided affinity in alloc_desc()

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

---
 kernel/irq/irqdesc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 07e99c9..1dee88b 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -530,6 +530,7 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 				flags = IRQD_AFFINITY_MANAGED |
 					IRQD_MANAGED_SHUTDOWN;
 			}
+			flags |= IRQD_AFFINITY_SET;
 			mask = &affinity->mask;
 			node = cpu_to_node(cpumask_first(mask));
 			affinity++;

