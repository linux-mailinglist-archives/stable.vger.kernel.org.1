Return-Path: <stable+bounces-106294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF659FE772
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D7297A12C1
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0DD1A9B42;
	Mon, 30 Dec 2024 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="JdB5apSi"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8C1A83E9;
	Mon, 30 Dec 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735571323; cv=none; b=hYb16cPTIC3Oo6iBTj38p/QtC6ptctwtzS9fhXaPumPGS1Ba/XEYy6qMe0L2mXgvY/XUt1OSQmCR4G0jQNYyaK6JQnRy8rwdzwKL35A9Wt7ds2WTjGueecOW7CaY27V29NP+MlZvxck4LXmAQuJhAby1vmeKYwr0xHD9df4ixxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735571323; c=relaxed/simple;
	bh=hZUDCn3flRMIUfmi68S/ktf9VjUsS25yZBO0t785Xks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aRzhAszTnhvBI8qCQGzI6ETPr8ygj6vE/rqkcsmwLmC0lerjAibb4Qr2nz0k+M/pT3TGwV+RIe49ajoNC9bqMh6E0lj+opsd7HsgA6cSPR+wxPwzzF24G4Jh/VkJrMiTWO1KcNwueJILwzYWT6Gj8JcTokDmlZRl12Zyz6JhMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=JdB5apSi; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1735571181; x=1767107181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=owVTKHB8kipu7woU/ieGXOWqB6uxgQm/ITw6hnvhEyE=;
  b=JdB5apSij988EYOoCospm2eInIDn1TZ8lDPwQkP1rO0vrxywaSTYKfIc
   00qcYDrMgwDRhJvGloR1XfjrdLKbCxqkxNhem4DGmsPMxQUm16H0d1l5i
   HwwyvFcZtdNFrMw0gaOzkiOE5dEZl2oY2aNTZTZhY7G/yxVkWO6ko3Dws
   c=;
X-IronPort-AV: E=Sophos;i="6.12,276,1728950400"; 
   d="scan'208";a="10801241"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2024 15:06:19 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:58068]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.45.187:2525] with esmtp (Farcaster)
 id 60cdf5fc-d20e-4e87-a70d-74071fd860d6; Mon, 30 Dec 2024 15:08:38 +0000 (UTC)
X-Farcaster-Flow-ID: 60cdf5fc-d20e-4e87-a70d-74071fd860d6
Received: from EX19D030EUB001.ant.amazon.com (10.252.61.82) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 30 Dec 2024 15:08:34 +0000
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19D030EUB001.ant.amazon.com (10.252.61.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 30 Dec 2024 15:08:34 +0000
Received: from email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Mon, 30 Dec 2024 15:08:33 +0000
Received: from dev-dsk-krckatom-1b-7b393aa4.eu-west-1.amazon.com (dev-dsk-krckatom-1b-7b393aa4.eu-west-1.amazon.com [10.13.225.85])
	by email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com (Postfix) with ESMTPS id C08C440303;
	Mon, 30 Dec 2024 15:08:32 +0000 (UTC)
From: Tomas Krcka <krckatom@amazon.de>
To: <linux-arm-kernel@lists.infradead.org>
CC: <nh-open-source@amazon.com>, Tomas Krcka <krckatom@amazon.de>, "Marc
 Zyngier" <maz@kernel.org>, <stable@vger.kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Hagar Hemdan <hagarhem@amazon.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] irqchip/gic-v3-its: fix raw_local_irq_restore() called with IRQs enabled
Date: Mon, 30 Dec 2024 15:08:25 +0000
Message-ID: <20241230150825.62894-1-krckatom@amazon.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following call-chain leads to misuse of spinlock_irq
when spinlock_irqsave was hold.

irq_set_vcpu_affinity
  -> irq_get_desc_lock (spinlock_irqsave)
   -> its_irq_set_vcpu_affinity
    -> guard(raw_spin_lock_irq) <--- this enables interrupts
  -> irq_put_desc_unlock // <--- WARN IRQs enabled

Fix the issue by using guard(raw_spinlock), since the function is
already called with irqsave and raw_spin_lock was used before the commit
b97e8a2f7130 ("irqchip/gic-v3-its: Fix potential race condition in its_vlpi_prop_update()")
introducing the guard as well.

This was discovered through the lock debugging, and the corresponding
log is as follows:

raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 38 PID: 444 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x2c/0x38
 Call trace:
  warn_bogus_irq_restore+0x2c/0x38
   _raw_spin_unlock_irqrestore+0x68/0x88
   __irq_put_desc_unlock+0x1c/0x48
   irq_set_vcpu_affinity+0x74/0xc0
   its_map_vlpi+0x44/0x88
   kvm_vgic_v4_set_forwarding+0x148/0x230
   kvm_arch_irq_bypass_add_producer+0x20/0x28
   __connect+0x98/0xb8
   irq_bypass_register_consumer+0x150/0x178
   kvm_irqfd+0x6dc/0x744
   kvm_vm_ioctl+0xe44/0x16b0

Fixes: b97e8a2f7130 ("irqchip/gic-v3-its: Fix potential race condition in its_vlpi_prop_update()")
Signed-off-by: Tomas Krcka <krckatom@amazon.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 92244cfa0464..8c3ec5734f1e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2045,7 +2045,7 @@ static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 	if (!is_v4(its_dev->its))
 		return -EINVAL;
 
-	guard(raw_spinlock_irq)(&its_dev->event_map.vlpi_lock);
+	guard(raw_spinlock)(&its_dev->event_map.vlpi_lock);
 
 	/* Unmap request? */
 	if (!info)
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


