Return-Path: <stable+bounces-166458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E26B19F74
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DC57ACDEF
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBB424BBF0;
	Mon,  4 Aug 2025 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cueDMIy8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aE+VyAuq"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DA0242D87;
	Mon,  4 Aug 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302061; cv=none; b=Tmy6RBhVubOTVzkWn3YHLPy5eByoq8gZm13r4+VbYWE+i/lykz12fqoBDC7Zfrl0ZErRLJvenXwaz1HAcfTlSaKEQIGvbqkSrxbVR/fiCGRBx/F9oMyZ1XctjubN6Gvs4M5N/BW3Gc/6wQcT8lo0Irn2JdWUALe8ytjByWNlkaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302061; c=relaxed/simple;
	bh=oiQMlkrXcO+aPEChRoO64pS6g7V1XkVmPaeAn8eRcc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VadhiJ8m+8PWuqa99/7g7VfcKhAdXStyV0utSlgKBjAQt4vPWlX+F89stF4i3Pua2JcrPX3pdN6rmH7/vauEIe/uuuPFuf1WejddoD9onJ0jZiqLvwePqsTAfSdFLhfK8O4HnbIMYwrPEtDh4jeeQcNfom/ImzCTo4xTg4K3Ls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cueDMIy8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aE+VyAuq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754302057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JjChbKi0Rx93+Tu2sjL4XTOUdNd3zTW9vbhD+j3CVZ8=;
	b=cueDMIy8Ro5gB+R96xllpBtDUM3dcrqgXK1eWLGoTc32TJde0nm+5uCv4QV15DEf6rw7AN
	uPs8MfcLhLB4KZeyb+wrt9XjlwQ06jl1Wwx75j7rO0q4KLuoQEReOEfJauBonnBwo2JIaH
	HkFBwQhbnVn1aPMpt5RLieH3ICpXp+0p1gyweMpjjSTB07SL9VNfzH1weAChE2UPdGjhzs
	8EEAL+F/wXQ9N3tGAt5h+S7mjxP9SF8Jo9NwdX4QXZS1B1vcpJ3ArlWk1hF1GyOdZxaDQf
	V054yG6dj87ds1abhK3LOdwhMKVjXWBMhufJw98rMRJ+Xp3n1LgJ1oPqtMykBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754302057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JjChbKi0Rx93+Tu2sjL4XTOUdNd3zTW9vbhD+j3CVZ8=;
	b=aE+VyAuqBsX0dOcnYOYHE7uJKfAO3KB/0ng80qh9CmmL6D/7lmf9bpCRHMYm2VrgyMzAMa
	y+OkvktQhtj3XBAw==
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
Subject: [PATCH 1/2] powerpc/pseries/msi: Fix potential underflow and leak issue
Date: Mon,  4 Aug 2025 12:07:27 +0200
Message-Id: <a980067f2b256bf716b4cd713bc1095966eed8cd.1754300646.git.namcao@linutronix.de>
In-Reply-To: <cover.1754300646.git.namcao@linutronix.de>
References: <cover.1754300646.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

pseries_irq_domain_alloc() allocates interrupts at parent's interrupt
domain. If it fails in the progress, all allocated interrupts are
freed.

The number of successfully allocated interrupts so far is stored
"i". However, "i - 1" interrupts are freed. This is broken:

  - One interrupt is not be freed

  - If "i" is zero, "i - 1" wraps around

Correct the number of freed interrupts to 'i'.

Fixes: a5f3d2c17b07 ("powerpc/pseries/pci: Add MSI domains")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/powerpc/platforms/pseries/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/=
pseries/msi.c
index ee1c8c6898a3..9dc294de631f 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -593,7 +593,7 @@ static int pseries_irq_domain_alloc(struct irq_domain *=
domain, unsigned int virq
=20
 out:
 	/* TODO: handle RTAS cleanup in ->msi_finish() ? */
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 	return ret;
 }
=20
--=20
2.39.5


