Return-Path: <stable+bounces-225651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P2+GOBHuGlTbgEAu9opvQ
	(envelope-from <stable+bounces-225651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:11:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F2E29EDB8
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69C34301DEEC
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43A03D3002;
	Mon, 16 Mar 2026 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f41kVzn3"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5B3D3321;
	Mon, 16 Mar 2026 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684701; cv=none; b=bM55y3L/Yr57PuFXuHSv4apb5yfZN2wUPxv4j5QfSxmVpsaG6WLAInj1FYI7b5ZitDl+UlQzF31aGI7FGb4Yo8HZmtG4RCXn05P5/YxgPIk1/mHVc88VG11biIhd+ss+XitmyvQK3c9ktVERVxID7iJzQr8ACQLK2sqKIYI8JS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684701; c=relaxed/simple;
	bh=6m73jU4PfOdCnf89AKcCpnsbYhuH3jWd6E6INcRIDeI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Edtl28HhqinePc1nDtXVwqua6QR7GCreHL3tBrq8b1lUX9wJa2L8qrigj5TeEyGuoLF6X0jVrBIQVX6wUJLXGLMuoJ+YUFGAnkmlHDia47itMtrhMOTvC/U1jnYTuWU2FagQgTXi5sA/Ffl3fk5ASX8N82CydMZMv8UUlL1xnl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f41kVzn3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2B3841A2DC3;
	Mon, 16 Mar 2026 18:11:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E9E775FC4A;
	Mon, 16 Mar 2026 18:11:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 40BBC10450463;
	Mon, 16 Mar 2026 19:11:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773684697; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ThhfLgqlr7YbjbLdrOOaAW5n9JSkqrHDYXd5hwsDx8g=;
	b=f41kVzn32iqLCGmegXZOD0HcLCss7l+66+LBM9QtsOIGWOATyNnaBi9Wl9vsescv5hdX8H
	SZ8Ys67fEFqlwMv9DY5ekFZPgRCR4oJfHcIINOL+Xh5GyuntR8mnQ+BOfbpb/VTmXW93TI
	WvliyXVEigW9cEWZQgZjMd/7jmB7fieVDg76gqyIZATeweXRrsZmGDiXt9RFkhd1tXiJfJ
	NOtYnhN4w2OXSdS8x5CwKffiig90avQPBslLloP9963NjE5e3GXePNaLrT2XwB8sA7xDyp
	1shhJiAOI0Ovub9yoghXungDFONns3nJU9HYQbM0meK++hTk6BMFiTu7EoUJog==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 19:11:34 +0100
Message-Id: <DH4ER021HKCB.23RHADC1HSCTF@bootlin.com>
Subject: Re: [PATCH net 1/2] net: macb: Move devm_{free,request}_irq() out
 of spin lock area
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Vineeth Karumanchi" <vineeth.karumanchi@amd.com>, "Harini Katakam"
 <harini.katakam@amd.com>, <stable@vger.kernel.org>
To: "Kevin Hao" <haokexin@gmail.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260315-macb-irq-v1-0-0154104cbf61@gmail.com>
 <20260315-macb-irq-v1-1-0154104cbf61@gmail.com>
In-Reply-To: <20260315-macb-irq-v1-1-0154104cbf61@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225651-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid,bootlin.com:url]
X-Rspamd-Queue-Id: 08F2E29EDB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun Mar 15, 2026 at 12:44 PM CET, Kevin Hao wrote:
> @@ -5962,6 +5962,7 @@ static int __maybe_unused macb_suspend(struct devic=
e *dev)
>  			/* write IP address into register */
>  			tmp |=3D MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
>  		}
> +		spin_unlock_irqrestore(&bp->lock, flags);
> =20
>  		/* Change interrupt handler and
>  		 * Enable WoL IRQ on queue 0
> @@ -5974,11 +5975,12 @@ static int __maybe_unused macb_suspend(struct dev=
ice *dev)
>  				dev_err(dev,
>  					"Unable to request IRQ %d (error %d)\n",
>  					bp->queues[0].irq, err);
> -				spin_unlock_irqrestore(&bp->lock, flags);
>  				return err;
>  			}
> +			spin_lock_irqsave(&bp->lock, flags);
>  			queue_writel(bp->queues, IER, GEM_BIT(WOL));
>  			gem_writel(bp, WOL, tmp);
> +			spin_unlock_irqrestore(&bp->lock, flags);
>  		} else {
>  			err =3D devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
>  					       IRQF_SHARED, netdev->name, bp->queues);
> @@ -5986,13 +5988,13 @@ static int __maybe_unused macb_suspend(struct dev=
ice *dev)
>  				dev_err(dev,
>  					"Unable to request IRQ %d (error %d)\n",
>  					bp->queues[0].irq, err);
> -				spin_unlock_irqrestore(&bp->lock, flags);
>  				return err;
>  			}
> +			spin_lock_irqsave(&bp->lock, flags);
>  			queue_writel(bp->queues, IER, MACB_BIT(WOL));
>  			macb_writel(bp, WOL, tmp);
> +			spin_unlock_irqrestore(&bp->lock, flags);
>  		}
> -		spin_unlock_irqrestore(&bp->lock, flags);
> =20
>  		enable_irq_wake(bp->queues[0].irq);
>  	}

So it used to be that approximatively the whole macb_suspend() function
was ran under the bp->lock spinlock. Now you split it in two to avoid
calling IRQ functions in atomic context:
 - (1) the disable queues & silence IRQs part and,
 - (2) the enable WOL part (IER and WOL reg writes).

Why do you need to grab bp->lock for the 2nd part? All queues are
disabled anyway and IRQs masked. BH features like our work queues are
disabled during the dev_pm_ops.suspend() calls anyway. Maybe I am
forgetting? Or this was just out of caution?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


