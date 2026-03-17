Return-Path: <stable+bounces-226117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBllMJp7uWmxHAIAu9opvQ
	(envelope-from <stable+bounces-226117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:04:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4052AD90A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E41530D546A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9B2F25F3;
	Tue, 17 Mar 2026 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J1XpSxLp"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D14C2F290A;
	Tue, 17 Mar 2026 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763298; cv=none; b=O00gZsLtEy+mBfNzzth5P7nuvWpFzUlf56O/XtGJNnu8BsWFz99tbcItYu/4OZ3aKhj2xYYE+vKk3wdz6ZT0RAXEORa5yFRDzKuW1HeQxSl/fbX8cUDfay/its3jLoEKFyULlGJnc6kahAZf9vhie6zKIA5Ia24KjRFWQX2RtCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763298; c=relaxed/simple;
	bh=AWri0f85fFtB3abpuUnYuGybc0M2uT6xMVli4DkCchg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=FWg5WJoybuR/njXtk1XD1NWxecFWWVqP3XI/VCd/XJgLZUw4koInnmiirYFr3zoKLlfLqK/X33N7diHUgEmRmQqouaoAiodL/HHehkael8tDctkODqfTg1rVb/V/pnyTusnrvlVkwK5ZYSBH4pR5mAlSUthVYQ3e0qakyT8CVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J1XpSxLp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 156554E42661;
	Tue, 17 Mar 2026 16:01:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DE17C5FC9A;
	Tue, 17 Mar 2026 16:01:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC8B710450632;
	Tue, 17 Mar 2026 17:01:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773763289; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HhGa/RXAuKajY3CB9WPbpFraNRpSzGcKk0rpLOk9Mjc=;
	b=J1XpSxLpRI/XD/FmQLEO+CaWSguzlyViJsHQHVtkPzZXXxyWqzxYdr87o9UwbfdjcqZvgC
	a5x0Tj0JuEECI9PzJCudsKdYuqqrz602RNFGy+359NCnr3GJwnkO57ff8hPvKVcq/j/hrT
	5uZHOvIN/MtgMBDpfVbrnotteR2IOSYS8OyFVMAa1a6f7AwFOyVaKCJvPskjCs9Njetbqi
	v4FPrj+WB8Cg/T9L18t3FE1Uf3VEwRrc79RfC1Dygs35MOjd/xv9qJGL5WUKob5kyB5Xan
	Qjm8dyWubDfbZkgnrygNC51wqdCqdtiiDt2owJcyFZs7N83h/+3udq2sp3S99g==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 17:01:21 +0100
Message-Id: <DH56LUJ9OPV1.1VVOD6J6PKUHJ@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net 1/2] net: macb: Move devm_{free,request}_irq() out
 of spin lock area
Cc: <netdev@vger.kernel.org>, "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Vineeth Karumanchi"
 <vineeth.karumanchi@amd.com>, "Harini Katakam" <harini.katakam@amd.com>,
 <stable@vger.kernel.org>
To: "Kevin Hao" <haokexin@gmail.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260315-macb-irq-v1-0-0154104cbf61@gmail.com>
 <20260315-macb-irq-v1-1-0154104cbf61@gmail.com>
 <DH4ER021HKCB.23RHADC1HSCTF@bootlin.com> <abitgDJLgpLiPgap@pek-khao-d3>
In-Reply-To: <abitgDJLgpLiPgap@pek-khao-d3>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226117-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid,bootlin.com:email,bootlin.com:url]
X-Rspamd-Queue-Id: 4B4052AD90A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Mar 17, 2026 at 2:25 AM CET, Kevin Hao wrote:
> On Mon, Mar 16, 2026 at 07:11:34PM +0100, Th=C3=A9o Lebrun wrote:
>> On Sun Mar 15, 2026 at 12:44 PM CET, Kevin Hao wrote:
>> > @@ -5962,6 +5962,7 @@ static int __maybe_unused macb_suspend(struct de=
vice *dev)
>> >  			/* write IP address into register */
>> >  			tmp |=3D MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
>> >  		}
>> > +		spin_unlock_irqrestore(&bp->lock, flags);
>> > =20
>> >  		/* Change interrupt handler and
>> >  		 * Enable WoL IRQ on queue 0
>> > @@ -5974,11 +5975,12 @@ static int __maybe_unused macb_suspend(struct =
device *dev)
>> >  				dev_err(dev,
>> >  					"Unable to request IRQ %d (error %d)\n",
>> >  					bp->queues[0].irq, err);
>> > -				spin_unlock_irqrestore(&bp->lock, flags);
>> >  				return err;
>> >  			}
>> > +			spin_lock_irqsave(&bp->lock, flags);
>> >  			queue_writel(bp->queues, IER, GEM_BIT(WOL));
>> >  			gem_writel(bp, WOL, tmp);
>> > +			spin_unlock_irqrestore(&bp->lock, flags);
>> >  		} else {
>> >  			err =3D devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrup=
t,
>> >  					       IRQF_SHARED, netdev->name, bp->queues);
>> > @@ -5986,13 +5988,13 @@ static int __maybe_unused macb_suspend(struct =
device *dev)
>> >  				dev_err(dev,
>> >  					"Unable to request IRQ %d (error %d)\n",
>> >  					bp->queues[0].irq, err);
>> > -				spin_unlock_irqrestore(&bp->lock, flags);
>> >  				return err;
>> >  			}
>> > +			spin_lock_irqsave(&bp->lock, flags);
>> >  			queue_writel(bp->queues, IER, MACB_BIT(WOL));
>> >  			macb_writel(bp, WOL, tmp);
>> > +			spin_unlock_irqrestore(&bp->lock, flags);
>> >  		}
>> > -		spin_unlock_irqrestore(&bp->lock, flags);
>> > =20
>> >  		enable_irq_wake(bp->queues[0].irq);
>> >  	}
>>=20
>> So it used to be that approximatively the whole macb_suspend() function
>> was ran under the bp->lock spinlock. Now you split it in two to avoid
>> calling IRQ functions in atomic context:
>>  - (1) the disable queues & silence IRQs part and,
>>  - (2) the enable WOL part (IER and WOL reg writes).
>>=20
>> Why do you need to grab bp->lock for the 2nd part? All queues are
>> disabled anyway and IRQs masked. BH features like our work queues are
>> disabled during the dev_pm_ops.suspend() calls anyway. Maybe I am
>> forgetting?
>
> You are right. I agree that the lock may not be necessary in this scenari=
o.
>
>> Or this was just out of caution?
>
> This is just out of cautious consideration. Do you think I should delete =
these
> spinlocks?

Nah, after all no one is going to be bothered by those locks that
almost never happen. They have been here for a while after all. The
macb_resume() ones as well are probably useless because IRQs are
disabled.

Anyway, for this patch:

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


