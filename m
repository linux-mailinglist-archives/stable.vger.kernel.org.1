Return-Path: <stable+bounces-166459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4134DB19F78
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90CF16B753
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A58224E4C3;
	Mon,  4 Aug 2025 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jhQi5Miz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cSUMp+lC"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925BB248176;
	Mon,  4 Aug 2025 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302062; cv=none; b=Ns/vpaW0czjaajmy0CdtHmKbRShCTDvOOodf3AWs7ohQmmuyEI+M8HLQ5VuKoZmCdfA/oiU1EXWWC1+h8TLB6E8NtYkuDiCRF0mdWYIpll9aMyEblvr10H8skW7rkXOj0XntiVfCQ/tZ2rye6Svug8w0QRxUW8pl6dA4n9C/E/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302062; c=relaxed/simple;
	bh=9FJa5cnoRi4/m2V++5onhLC6nw8Udm0vtnZvljuKqAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g4gsYUwEp0FHgXBYu/qfj2gzY3+muYwQ65B5hTnzFdC1F3plmfMbal/42ZoMZ6vybpdXTFl0rQzEEXWXSy/hyHNaLCzWd7NCM3CLO4wcZjjbmiamPtp+CY9l1M/hN5MkCZ4mvcr2IbwpqEVjBrYnuWL941Gu2MY/Sle2MjXrJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jhQi5Miz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cSUMp+lC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754302057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfNEYV4azBODPkXCFpVp5ETyBOPcIAUZ4WPfo58yan0=;
	b=jhQi5Miz84mSJDlCRDll/KaL0uUb4xBNytAYfmdikDUa09352eXlbvYz5JQrMI8+hlVmQG
	lqvAe20rWJiE1mUcXiOn4gHV/Yxg4WFQuqgehpCXBj2m7Rom+XP8MhT26or4ejesQ2ZL2T
	xLMhflezjrAlSG2gdXGKStEBTe4d0p0QNZwyxxXrsQVThzn/CRDaFOq91m4GH+iR3GrEPQ
	c5Yz+g2lPwQEXB255EQd0UBz94xwoeGxzCSNKC9X3+gI3osAZqzTW70LSJHyTy7TqSWyLn
	JRVXciCcSCLo3Q2woGN/Q09Kg33x4wrQ0zynjDWRVIhheb8pjkd5qpHzQVzAGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754302057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfNEYV4azBODPkXCFpVp5ETyBOPcIAUZ4WPfo58yan0=;
	b=cSUMp+lC1a9J9y9pYNmaymkHXnLszknvyani9UfAClOFVCEZZoBnhhQ7zV9IcDgr0pk9zF
	PNSi05pwk+pTJVAA==
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Gautam Menghani <gautam@linux.ibm.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] powerpc/powernv/pci: Fix underflow and leak issue
Date: Mon,  4 Aug 2025 12:07:28 +0200
Message-Id: <70f8debe8688e0b467367db769b71c20146a836d.1754300646.git.namcao@linutronix.de>
In-Reply-To: <cover.1754300646.git.namcao@linutronix.de>
References: <cover.1754300646.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

pnv_irq_domain_alloc() allocates interrupts at parent's interrupt
domain. If it fails in the progress, all allocated interrupts are
freed.

The number of successfully allocated interrupts so far is stored
"i". However, "i - 1" interrupts are freed. This is broken:

    - One interrupt is not be freed

    - If "i" is zero, "i - 1" wraps around

Correct the number of freed interrupts to "i".

Fixes: 0fcfe2247e75 ("powerpc/powernv/pci: Add MSI domains")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platf=
orms/powernv/pci-ioda.c
index d8ccf2c9b98a..0166bf39ce1e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1854,7 +1854,7 @@ static int pnv_irq_domain_alloc(struct irq_domain *do=
main, unsigned int virq,
 	return 0;
=20
 out:
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 	msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq, nr_irqs);
 	return ret;
 }
--=20
2.39.5


