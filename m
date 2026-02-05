Return-Path: <stable+bounces-214542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH7XOZrphGkj6gMAu9opvQ
	(envelope-from <stable+bounces-214542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 20:03:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E980BF6AC2
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 20:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A11F30074E9
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 19:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D57330DEA9;
	Thu,  5 Feb 2026 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK4lD3Ew"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769E30DD19
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318223; cv=none; b=o4m1QKsx8f9cPIZzImcaLSMl8l/9zuUp2hMIi5I8dwUJxKymCzXmhEs5c7luTXH/CQAsVafub4Xedo5jfad6ih15ECCZ5CsJoBe/IB8FKwr0JXl9fiEBMbM3ALIE0Dcgn3s0mS7cqeyXbm8+qXdE3N4+p0T8aAKsTaDM9sc7M5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318223; c=relaxed/simple;
	bh=mTvvcXgDBvcbR8q3T6BKAKNhHRfSg1JBnMWu7iWUrgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u8G92CP9CtX/+FvS2jeKMpB30Og8AEVp82guNrMaFiwlUxJ+rwrwPnNlZsWuYWNIdjM/Z0vG4uLLUgNrcKgxCVaILmxkAURGGVYEBiOl3IQLXr9hjfMvxPBp3Nvn4TKR9FX0/2CRHV50cRhKa4fE+hCOcJgCW1eInskBe4/hS0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK4lD3Ew; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43596062728so1737852f8f.1
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 11:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770318221; x=1770923021; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GtNGjTQpUi+skXrIS19K/ys+bSMRdS9DMijYI8S5F3k=;
        b=fK4lD3EwIiiK2/QUVPnYjNHV9gCm6zN48hBR3/s5jrQPxsDEl+47PJW9RBIj2dXOfm
         WuV6MQaGKlulMIm8KGHMAKrlv407WMDDFcTAb7IJrf7PXH4JgGiffXWrLkgf3uLIBKo/
         NQaw0IdVxr1TFP9HXo7S5ruEhgpgRi1+eIGDIzaX2A0tR8r4veyipocTnoc34FfiwMBQ
         nYHJsFunr8AGio61NCC00PFIigz9+8RweCBtXhDh/FHxq8kLTP0Cxm6ede2tHxZ9cKFZ
         GMCqrCPOS7b1iqziYOyh6pCNqa+v3Wh+jSy8gRcZRJ+uJ6igwPYi+yKa006aUFl02Yhr
         e/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770318221; x=1770923021;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtNGjTQpUi+skXrIS19K/ys+bSMRdS9DMijYI8S5F3k=;
        b=nu9Ho4yhReMrKS3U7tPyw04SXLk3inWxQzjRC+SIj7TOdghl/TPO+Nn3VFyk9EW5Eb
         1UaZ/zITQPqR/ZFNgFrEHg/LBNL5eosE2CXI6o/awZ+q2OX/1kU46n5dAN8ssQSWvf9H
         xuUMu8rT3Ij+sy2xYXF04TvtitKImx54jxzd0KpuUM13tT7Lz+jNglPKBfIKKnJ/Csek
         V5wwPv2rH057do0fiMN2XhNgyE1T44N1mZfN2PiWfJmaI+vS5xlDi4Qgk53YuIom3y5R
         g0N4ay3Y1gq6hFCDXphyaSx1t9ffP5YUxwI4UKqxC4LwStIWvEuYTrDpQ52copZqMO3B
         i1cw==
X-Forwarded-Encrypted: i=1; AJvYcCUzeYUliYGiE8rpNxeUbQ+Rcpe8H0tqqZfrFrElmlVDq9f6/NiB5/mLvbDyQBrEiWziso9xcTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKfGYYgJoBIizIq1n5CsllywE+aYoUCFNjQTJ0A//OXf6362p3
	mzyWTpE3YsCu6ShD4Adqia3BB7feWifHJ0onPtdu9hyi3aF/aHWejujv
X-Gm-Gg: AZuq6aLM1RF5bNq/JVHOW298uGF5knPv5bYKD7hFfaAm90tbpySxb+hvhFF2pI4cLLN
	CvVh8//JrP1b9GHt4iNYeqj2SjECKRJlrLGkeZUrUVZ62jgFBrrIUbza1n+GIsJEEB7pEtSztFt
	keZqmRyBXDsEVJpeCNqLJHcLeIAksiO7/iLj2F8BCSWrbhCFEN8yFbdHj1w94iCXMsGP4kWt4RQ
	sDGbj42VhSZWcobSpcPhhOlrhXkNBmd60pYptO2a487JfndA2OgetA5jNENJujM1K0e96/TsDyY
	NUwN6Ubf1Rv+NsjUWt4Z02HQxK+Ay/3U/b4N6x+prHCcitLY1gSOcP39q55F1ST7PFOBD6nxlsB
	oynjw+8So/eroSExKWE8TUfCglYd5WMAIbHNl+p+/YAXabtIRxNde5o2mzt/dKklhXlhya7Knpx
	W/V4tUvmRMBHtBbfMK3jajqGs1lQQx
X-Received: by 2002:a05:6000:2210:b0:435:96a1:ee4d with SMTP id ffacd0b85a97d-4362933f3e9mr435562f8f.14.1770318221215;
        Thu, 05 Feb 2026 11:03:41 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd4desm239733f8f.18.2026.02.05.11.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 11:03:40 -0800 (PST)
Message-ID: <a7bd135730919a8a5c5d4b2ccaae945c76c7376e.camel@gmail.com>
Subject: Re: [PATCH net 1/2] net: cpsw_new: Fix unnecessary netdev
 unregistration in cpsw_probe() error path
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Kevin Hao <haokexin@gmail.com>, netdev@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros
 <rogerq@kernel.org>,  Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Saeed Mahameed	 <saeedm@nvidia.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, Lorenzo Bianconi	
 <lorenzo@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Murali
 Karicheri <m-karicheri2@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Grygorii Strashko	
 <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 05 Feb 2026 20:03:40 +0100
In-Reply-To: <20260205-cpsw-error-path-v1-1-6e58bae6b299@gmail.com>
References: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
	 <20260205-cpsw-error-path-v1-1-6e58bae6b299@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214542-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,nxp.com,nvidia.com,gmail.com,6wind.com,linaro.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandersverdlin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E980BF6AC2
X-Rspamd-Action: no action

On Thu, 2026-02-05 at 10:47 +0800, Kevin Hao wrote:
> The current error handling in cpsw_probe() has two issues:
> - cpsw_unregister_ports() may be called before cpsw_register_ports() has
> =C2=A0 been executed.
>=20
> - cpsw_unregister_ports() is already invoked within cpsw_register_ports()
> =C2=A0 in case of a register_netdev() failure, but the error path would c=
all
> =C2=A0 it again.
>=20
> Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based d=
river part 1 - dual-emac")
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> Cc: stable@vger.kernel.org
> ---
> =C2=A0drivers/net/ethernet/ti/cpsw_new.c | 12 +++++-------
> =C2=A01 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti=
/cpsw_new.c
> index 21af0a10626aaf0ce6ecb04837899801743f3894..b9fc31eb06134dae33427eaba=
06341c39eb4b41c 100644
> --- a/drivers/net/ethernet/ti/cpsw_new.c
> +++ b/drivers/net/ethernet/ti/cpsw_new.c
> @@ -2003,7 +2003,7 @@ static int cpsw_probe(struct platform_device *pdev)
> =C2=A0	/* setup netdevs */
> =C2=A0	ret =3D cpsw_create_ports(cpsw);
> =C2=A0	if (ret)
> -		goto clean_unregister_netdev;
> +		goto clean_cpts;
> =C2=A0
> =C2=A0	/* Grab RX and TX IRQs. Note that we also have RX_THRESHOLD and
> =C2=A0	 * MISC IRQs which are always kept disabled with this driver so
> @@ -2017,14 +2017,14 @@ static int cpsw_probe(struct platform_device *pde=
v)
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, dev_name(dev), cpsw);
> =C2=A0	if (ret < 0) {
> =C2=A0		dev_err(dev, "error attaching irq (%d)\n", ret);
> -		goto clean_unregister_netdev;
> +		goto clean_cpts;
> =C2=A0	}
> =C2=A0
> =C2=A0	ret =3D devm_request_irq(dev, cpsw->irqs_table[1], cpsw_tx_interru=
pt,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, dev_name(dev), cpsw);
> =C2=A0	if (ret < 0) {
> =C2=A0		dev_err(dev, "error attaching irq (%d)\n", ret);
> -		goto clean_unregister_netdev;
> +		goto clean_cpts;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (!cpsw->cpts)
> @@ -2034,7 +2034,7 @@ static int cpsw_probe(struct platform_device *pdev)
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, dev_name(&pdev->dev), cp=
sw);
> =C2=A0	if (ret < 0) {
> =C2=A0		dev_err(dev, "error attaching misc irq (%d)\n", ret);
> -		goto clean_unregister_netdev;
> +		goto clean_cpts;
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Enable misc CPTS evnt_pend IRQ */
> @@ -2043,7 +2043,7 @@ static int cpsw_probe(struct platform_device *pdev)
> =C2=A0skip_cpts:
> =C2=A0	ret =3D cpsw_register_notifiers(cpsw);
> =C2=A0	if (ret)
> -		goto clean_unregister_netdev;
> +		goto clean_cpts;
> =C2=A0
> =C2=A0	ret =3D cpsw_register_devlink(cpsw);
> =C2=A0	if (ret)
> @@ -2065,8 +2065,6 @@ static int cpsw_probe(struct platform_device *pdev)
> =C2=A0
> =C2=A0clean_unregister_notifiers:
> =C2=A0	cpsw_unregister_notifiers(cpsw);
> -clean_unregister_netdev:
> -	cpsw_unregister_ports(cpsw);
> =C2=A0clean_cpts:
> =C2=A0	cpts_release(cpsw->cpts);
> =C2=A0	cpdma_ctlr_destroy(cpsw->dma);

--=20
Alexander Sverdlin.

