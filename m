Return-Path: <stable+bounces-67698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4881A95220C
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 20:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5771C22737
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 18:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7981BD4E9;
	Wed, 14 Aug 2024 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MSmeiv/W"
X-Original-To: stable@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA581B0111
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660142; cv=none; b=qXo2+IAwCv6RgbVm+4NVahTZp2HYXVu6XaM1+4MUzIJWMMFgnj9arwd9LvvmWJ8quJkmkVkpwmGYFTvHzzd8m0ib9N0gMfS9aCm4ANPGapI7+KChf93rsk2mmsuOK1b3wE4aR09RpxEWLJjkdizrU3ZRtzEPww0vO+z1xnqzqGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660142; c=relaxed/simple;
	bh=TaSeZpcKZTLMHZvFq83TQgcbdtPv+HYWDdutnM+5Fqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuTc3COMJZDexeXIsW1orQXniyGaQV10vaujIP8xPMBxusvgv8z1kEfzBhbwtAlY81rSvwvMHmwxRfrLna/fLGGEapWsTs0qPk14BbmvJDT699fWqF9iTRUVG8cDokXgu8iZbXVrHa2kbnZy6GjOL6NmJv2NNWsIz0Ampyw+79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MSmeiv/W; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WkcGN2qmqz6CmLxd;
	Wed, 14 Aug 2024 18:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1723660136; x=1726252137; bh=67Qhj
	hOvf73WSxlmttlpgMIuwxkEusL2I3F5Tlic4r4=; b=MSmeiv/WyVZxJXACXunKN
	3XP14tIvvWTvWY9gGH27jKOU8VmugAIqjVQ/CdcfyjXn3S+zfLXUxFCZUnEpwfsq
	I3wej/UQRbHJJc9uokXDiFkS8mK/sdd2I3sipjHjkE8kkKcYepwLEkv8lcQFnaEf
	83Raof8up3MFvDJxXNR8Jv2pktoy1teToL7JgIb0iFNwiVCjXj+zcZNU7NrA+UCd
	f+yrtEHFYr5stDpsx5Yx8WgIJ3EtN/io1HDfRZ9p3+eGPIZtBn3xTWK/VUdjAWAN
	JWsRYz8/crmdfCO7GtUF4lCh0U2dn4mQVJemSsGys2aE0uoHGlR9J3Q4WYD+m8q2
	A==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9gM1rRK0NYNz; Wed, 14 Aug 2024 18:28:56 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WkcGG4w9fz6CmLxj;
	Wed, 14 Aug 2024 18:28:54 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Stevens <stevensd@chromium.org>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	stable@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 6.6 2/2] genirq/cpuhotplug: Retry with cpu_online_mask when migration fails
Date: Wed, 14 Aug 2024 11:28:26 -0700
Message-ID: <20240814182826.1731442-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240814182826.1731442-1-bvanassche@acm.org>
References: <20240814182826.1731442-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Dongli Zhang <dongli.zhang@oracle.com>

commit 88d724e2301a69c1ab805cd74fc27aa36ae529e0 upstream.

When a CPU goes offline, the interrupts affine to that CPU are
re-configured.

Managed interrupts undergo either migration to other CPUs or shutdown if
all CPUs listed in the affinity are offline. The migration of managed
interrupts is guaranteed on x86 because there are interrupt vectors
reserved.

Regular interrupts are migrated to a still online CPU in the affinity mas=
k
or if there is no online CPU to any online CPU.

This works as long as the still online CPUs in the affinity mask have
interrupt vectors available, but in case that none of those CPUs has a
vector available the migration fails and the device interrupt becomes
stale.

This is not any different from the case where the affinity mask does not
contain any online CPU, but there is no fallback operation for this.

Instead of giving up, retry the migration attempt with the online CPU mas=
k
if the interrupt is not managed, as managed interrupts cannot be affected
by this problem.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240423073413.79625-1-dongli.zhang@oracl=
e.com
---
 kernel/irq/cpuhotplug.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 367e15a2f570..eb8628390156 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -130,6 +130,22 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	 * CPU.
 	 */
 	err =3D irq_do_set_affinity(d, affinity, false);
+
+	/*
+	 * If there are online CPUs in the affinity mask, but they have no
+	 * vectors left to make the migration work, try to break the
+	 * affinity by migrating to any online CPU.
+	 */
+	if (err =3D=3D -ENOSPC && !irqd_affinity_is_managed(d) && affinity !=3D=
 cpu_online_mask) {
+		pr_debug("IRQ%u: set affinity failed for %*pbl, re-try with online CPU=
s\n",
+			 d->irq, cpumask_pr_args(affinity));
+
+		affinity =3D cpu_online_mask;
+		brokeaff =3D true;
+
+		err =3D irq_do_set_affinity(d, affinity, false);
+	}
+
 	if (err) {
 		pr_warn_ratelimited("IRQ%u: set affinity failed(%d).\n",
 				    d->irq, err);

