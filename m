Return-Path: <stable+bounces-108447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7F0A0B968
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB3F160EDC
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB9022F171;
	Mon, 13 Jan 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="BC0pFEET"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2622A4C7;
	Mon, 13 Jan 2025 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778394; cv=none; b=XyTenTnSM7+VvQrnulGuE4/mGRhzJhRzl8eGgDNv4Jmw2bg6Vn42WJifxoORNl0EazIHd7d33RTAllwAPuVXHnf+gTSBjmbjSuuqrFBIKgzhHLtlZxh0EDw02FtDXX9Bw7zgeJufTSLoCV6RI3kVSPZAaAQIx9xvTZxJTRgonHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778394; c=relaxed/simple;
	bh=Fq6dQWLfaWiE17zvOHcErvrrO0Ut9Ni3+ULVX3hTAZ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h95t6zsnoT0pAzko5HJDINbaVY/5YOAif9UBmr+c/nVGi/jfPlZwL7S9BQW8u2RJgewnsMW7Ope1w2B0uCH3lSb412L4VKYGirY0LPsJtRG4jlNvNEmYIt76/E3JZ7CrSfvjFae466hPhb6ASf1KFV2n4BtNi3nEl9SJYY1PadE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=BC0pFEET; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1736778393; x=1768314393;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o6Bw5jXrZBOLtr4dz7MtgdyyGCc2h6Q43SN2hAlS2io=;
  b=BC0pFEETbJADDzO16c+DURymtmxv4JiO8tFNBD1y9M6WM2yafLlKBMho
   sIuDUsDl96EF0W/GWa9Yey/uiow+2xJCDuC/iUREnJ9OwyV0ejJBBLoFf
   GRJclzcPstAZzQ0EqzlwHhpunIYZpKqACAVKK9QK1x1ySNXeTU3fep8E5
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,310,1728950400"; 
   d="scan'208";a="458419364"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 14:26:30 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:10353]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.41.86:2525] with esmtp (Farcaster)
 id f548a048-99a8-45e7-8e85-566bc953ec14; Mon, 13 Jan 2025 14:26:27 +0000 (UTC)
X-Farcaster-Flow-ID: f548a048-99a8-45e7-8e85-566bc953ec14
Received: from EX19D030EUC003.ant.amazon.com (10.252.61.173) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 13 Jan 2025 14:26:26 +0000
Received: from EX19D030EUC004.ant.amazon.com (10.252.61.164) by
 EX19D030EUC003.ant.amazon.com (10.252.61.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 13 Jan 2025 14:26:26 +0000
Received: from EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477]) by
 EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477%3]) with mapi id
 15.02.1258.039; Mon, 13 Jan 2025 14:26:26 +0000
From: "Krcka, Tomas" <krckatom@amazon.de>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: Marc Zyngier <maz@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Hagar Hemdan
	<hagarhem@amazon.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] irqchip/gic-v3-its: fix raw_local_irq_restore() called
 with IRQs enabled
Thread-Topic: [PATCH v2] irqchip/gic-v3-its: fix raw_local_irq_restore()
 called with IRQs enabled
Thread-Index: AQHbWsyyaL1fJmGgZ0O4CLa3tJcgz7MU2JuA
Date: Mon, 13 Jan 2025 14:26:26 +0000
Message-ID: <DD97EC7F-6A5A-463F-9E36-383EA9BF0F17@amazon.de>
References: <20241230150825.62894-1-krckatom@amazon.de>
In-Reply-To: <20241230150825.62894-1-krckatom@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-ID: <911E8FD41DA8E543921B9E99D4D1F304@amazon.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ping for this one.

> On 30. Dec 2024, at 16:08, Tomas Krcka <krckatom@amazon.de> wrote:
>=20
> The following call-chain leads to misuse of spinlock_irq
> when spinlock_irqsave was hold.
>=20
> irq_set_vcpu_affinity
>  -> irq_get_desc_lock (spinlock_irqsave)
>   -> its_irq_set_vcpu_affinity
>    -> guard(raw_spin_lock_irq) <--- this enables interrupts
>  -> irq_put_desc_unlock // <--- WARN IRQs enabled
>=20
> Fix the issue by using guard(raw_spinlock), since the function is
> already called with irqsave and raw_spin_lock was used before the commit
> b97e8a2f7130 ("irqchip/gic-v3-its: Fix potential race condition in its_vl=
pi_prop_update()")
> introducing the guard as well.
>=20
> This was discovered through the lock debugging, and the corresponding
> log is as follows:
>=20
> raw_local_irq_restore() called with IRQs enabled
> WARNING: CPU: 38 PID: 444 at kernel/locking/irqflag-debug.c:10 warn_bogus=
_irq_restore+0x2c/0x38
> Call trace:
>  warn_bogus_irq_restore+0x2c/0x38
>   _raw_spin_unlock_irqrestore+0x68/0x88
>   __irq_put_desc_unlock+0x1c/0x48
>   irq_set_vcpu_affinity+0x74/0xc0
>   its_map_vlpi+0x44/0x88
>   kvm_vgic_v4_set_forwarding+0x148/0x230
>   kvm_arch_irq_bypass_add_producer+0x20/0x28
>   __connect+0x98/0xb8
>   irq_bypass_register_consumer+0x150/0x178
>   kvm_irqfd+0x6dc/0x744
>   kvm_vm_ioctl+0xe44/0x16b0
>=20
> Fixes: b97e8a2f7130 ("irqchip/gic-v3-its: Fix potential race condition in=
 its_vlpi_prop_update()")
> Signed-off-by: Tomas Krcka <krckatom@amazon.de>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> ---
> drivers/irqchip/irq-gic-v3-its.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v=
3-its.c
> index 92244cfa0464..8c3ec5734f1e 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2045,7 +2045,7 @@ static int its_irq_set_vcpu_affinity(struct irq_dat=
a *d, void *vcpu_info)
> if (!is_v4(its_dev->its))
> return -EINVAL;
>=20
> - guard(raw_spinlock_irq)(&its_dev->event_map.vlpi_lock);
> + guard(raw_spinlock)(&its_dev->event_map.vlpi_lock);
>=20
> /* Unmap request? */
> if (!info)
> --=20
> 2.40.1
>=20


