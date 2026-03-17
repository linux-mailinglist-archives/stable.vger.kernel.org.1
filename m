Return-Path: <stable+bounces-225728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HCI3O42tuGlvhgEAu9opvQ
	(envelope-from <stable+bounces-225728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 02:25:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 483A32A2877
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 02:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B46EE3008213
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 01:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D403126C0;
	Tue, 17 Mar 2026 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk2jj4Tf"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C0C2D8798
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773710729; cv=none; b=RUCUlxhHimT0GpVmVdEjm3uXzH3wsOuMtCfi/rwGhdn+rnCw6ArZKnahabjp/gjgGE9/kEOmlb42PwbIrAoks8/G7uFO5L9c7tkOar33yZoBlvuvixqWr5V5nh8GdhRtgG+BlDmPsc2JKis8a18+NAIgrFlLXOaiEOC+YmFXJYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773710729; c=relaxed/simple;
	bh=rsxl2IWzNOzAu6w6/DK6/1xM4qXCu4a43lJZr1tz2uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PShoQPB/AKNoaPeTJZqusCWxafYIMq7F2OT3ywD0TlddjnEF7q74Bn6uIXpzlNcTARC1a/Im6a55s32xST8i3fXlxHf4/X0iFktjwWjRLvv+VumV/2zRBPwcVFdTOGbC4XxZsKDr4D8g1lCIey7aC7adgYrU7sQSwLvk7LoTbJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk2jj4Tf; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso6219377eec.1
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 18:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773710728; x=1774315528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OO47/IfHvx9H58g5i2nmyxKJYItyb9tS+PSXsmFY7MI=;
        b=Kk2jj4TfrCsYbAv0+ipt0M69JEFO3aCj4w1vERBqVn2HKVf8muwYFlk9KSVWVnROjK
         iByPKLoj+mR+63F++JeDUxmFWOuy0I2aipyvoCOlsPchzbQNIw1v4zCb7kMOROY8AxXw
         9nZVZnWcqOcd3HMYrz5/OswiPCRN84F4mVbISo72kiJK9pefcNvb3fjQZ4ATZUBzAHuK
         86SLR3ciEhaQuwpAtY5PcdhJ+sXMoEY8ncnWE8ulRYVtckpBiq8MEfPGTpqOqKijjhPs
         IqGv+MSxgAC+Cg9FjmI+N7A8UalYFA9uPuf/DFmVfOdFlAVqQeaf6phdx7VMKnsJc2rB
         yAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773710728; x=1774315528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OO47/IfHvx9H58g5i2nmyxKJYItyb9tS+PSXsmFY7MI=;
        b=Jw5q8BaPljEwuw00vRnUpd4ILtmXsyiZXpV4+eh7eqf2eDiCM9Is3rxQk1YY292eaq
         z4pMNin54YXFN2oybEDmQlvpg8Zcnzaqkl7O13tV5ut+ic/nUIz5Cuxm2yd/G0gPAl9X
         DkjzWMLpSwZ4e+zxZNyMsaKvZbVbDTicpDVOLNT24rq4O4EjKvFFZ6bAFS8YlF4XmPAj
         Bml9MoI8m/752c3XJF4WLphmN03S04pXgWoP2mYGfwKMrzuxlM4L4K9xkyjeP2oj01Jn
         tgQgHnKARpJbYxNq5by/nNybSZyxAmyzQKim60y4L7FZSzgBjU7wcKaJuVSrjyzBGxjC
         hZPA==
X-Forwarded-Encrypted: i=1; AJvYcCUrjs9UEb+JgL8wqC1Wkp12GamDokBTCmbCr4xbSGG3b60E5Dz2yxe4+9l8tJ2Bh8HYT6zdWAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNhmeebFSxHZ0enQa199UE9Tgrzxr9Iq1yXDb84vC4K5yZQiRy
	5B9bYMRGrxasb0Mv6X4HWEwpzpzy4rDwUHBgAkrJOgv8zmUibE5B4yDE
X-Gm-Gg: ATEYQzxWjBA6HLpDCLpv3o+TdGACaE19dmMSF8eeGq2+PXbRtoE1kEA8Hxh+tFPMndp
	26qMbItFAWBb1NUhPuj1LeCtAfm/JlpLkB1au3uB7dNRbO6h/Jp6pGQkHIPDuHm4QcEYInIjxor
	mXq4tvITMnfQ6g3IV5CuLjZhLjZdcQM0WR9DZhpU/Q8YXEBZAKnaHD1t0OH+SmGuhmd7f8RCy+s
	z+5JswAuKou2UZ81FamKinSTWhCqUeAY8e/cHF9j7h74TYZMwr+kZvYkPCC+AuSmQhMTwh39MIX
	fs0AfB5s+KrJjjyDkmLhyFA9qdmse/q4m3+78FHdSy9+if00uvvVu/YewqN5Io9/LauXcJDlYHC
	StdU1OtUEjdxQMZHKBFXV7Yr10xIpNsNYG7wLbH/acGqBb2kO8QArkC1V2J3fNRJbr3M3fA3hsx
	gSxs8wwOCXzYVMdrPHNkU=
X-Received: by 2002:a05:7301:9bcb:b0:2be:2f62:8bb6 with SMTP id 5a478bee46e88-2bea553a875mr6439787eec.30.1773710727353;
        Mon, 16 Mar 2026 18:25:27 -0700 (PDT)
Received: from pek-khao-d3 ([128.224.246.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab5706bdsm20268411eec.28.2026.03.16.18.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 18:25:26 -0700 (PDT)
Date: Tue, 17 Mar 2026 09:25:20 +0800
From: Kevin Hao <haokexin@gmail.com>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Harini Katakam <harini.katakam@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: macb: Move devm_{free,request}_irq() out of
 spin lock area
Message-ID: <abitgDJLgpLiPgap@pek-khao-d3>
References: <20260315-macb-irq-v1-0-0154104cbf61@gmail.com>
 <20260315-macb-irq-v1-1-0154104cbf61@gmail.com>
 <DH4ER021HKCB.23RHADC1HSCTF@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xazflkdqN4rUxQSU"
Content-Disposition: inline
In-Reply-To: <DH4ER021HKCB.23RHADC1HSCTF@bootlin.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225728-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 483A32A2877
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--xazflkdqN4rUxQSU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 07:11:34PM +0100, Th=E9o Lebrun wrote:
> On Sun Mar 15, 2026 at 12:44 PM CET, Kevin Hao wrote:
> > @@ -5962,6 +5962,7 @@ static int __maybe_unused macb_suspend(struct dev=
ice *dev)
> >  			/* write IP address into register */
> >  			tmp |=3D MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
> >  		}
> > +		spin_unlock_irqrestore(&bp->lock, flags);
> > =20
> >  		/* Change interrupt handler and
> >  		 * Enable WoL IRQ on queue 0
> > @@ -5974,11 +5975,12 @@ static int __maybe_unused macb_suspend(struct d=
evice *dev)
> >  				dev_err(dev,
> >  					"Unable to request IRQ %d (error %d)\n",
> >  					bp->queues[0].irq, err);
> > -				spin_unlock_irqrestore(&bp->lock, flags);
> >  				return err;
> >  			}
> > +			spin_lock_irqsave(&bp->lock, flags);
> >  			queue_writel(bp->queues, IER, GEM_BIT(WOL));
> >  			gem_writel(bp, WOL, tmp);
> > +			spin_unlock_irqrestore(&bp->lock, flags);
> >  		} else {
> >  			err =3D devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
> >  					       IRQF_SHARED, netdev->name, bp->queues);
> > @@ -5986,13 +5988,13 @@ static int __maybe_unused macb_suspend(struct d=
evice *dev)
> >  				dev_err(dev,
> >  					"Unable to request IRQ %d (error %d)\n",
> >  					bp->queues[0].irq, err);
> > -				spin_unlock_irqrestore(&bp->lock, flags);
> >  				return err;
> >  			}
> > +			spin_lock_irqsave(&bp->lock, flags);
> >  			queue_writel(bp->queues, IER, MACB_BIT(WOL));
> >  			macb_writel(bp, WOL, tmp);
> > +			spin_unlock_irqrestore(&bp->lock, flags);
> >  		}
> > -		spin_unlock_irqrestore(&bp->lock, flags);
> > =20
> >  		enable_irq_wake(bp->queues[0].irq);
> >  	}
>=20
> So it used to be that approximatively the whole macb_suspend() function
> was ran under the bp->lock spinlock. Now you split it in two to avoid
> calling IRQ functions in atomic context:
>  - (1) the disable queues & silence IRQs part and,
>  - (2) the enable WOL part (IER and WOL reg writes).
>=20
> Why do you need to grab bp->lock for the 2nd part? All queues are
> disabled anyway and IRQs masked. BH features like our work queues are
> disabled during the dev_pm_ops.suspend() calls anyway. Maybe I am
> forgetting?

You are right. I agree that the lock may not be necessary in this scenario.

> Or this was just out of caution?

This is just out of cautious consideration. Do you think I should delete th=
ese
spinlocks?

Thanks,
Kevin

--xazflkdqN4rUxQSU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmm4rYAACgkQk1jtMN6u
sXGuNAf/S9rZLmxUxfhPBdbvDTrFK3Ouf3xz5RWJo/nRinwqjA9GNlZq5qsCz7QN
tc6bJukbZumTT/Bs/oeZTeNPmo4bYMB2E1hzLctp+1FcyJF/GlybKHn+kw2/x+RV
V43LizaIOrue3Aff76w64f8c/sKI1438hvCRwuzgQfhTjKNVuAh0rz3rCn19z2Np
NBjAkXijut/cvRoUJEM7PnIItfzkhuQleIyeeWv2ylnsIzFeU+lS3BkxAastqwqj
NXynazrNpgOmhHVUS4LLFZeHNJloATK7lOicM8e6gSjvHBLwxSsEPgGVxtbtYsDX
YD3JzZsclNoDvZfj33+R80r+nj/wog==
=Dm7P
-----END PGP SIGNATURE-----

--xazflkdqN4rUxQSU--

