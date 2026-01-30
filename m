Return-Path: <stable+bounces-212888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OAzBRTFfGm+OgIAu9opvQ
	(envelope-from <stable+bounces-212888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 15:49:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAD4BBBDB
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 15:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 602AB302F3B6
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80427324700;
	Fri, 30 Jan 2026 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="9O4q55gZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF4303C9F
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769784568; cv=pass; b=NFSK1QhsfXaeNi6waOXVEAJYqELFlDJmzOZW1fYeY0uZbPteSdwHQ74KfPFi6BQeYZcCfo65NQz084Hoavqw0dCY9xmhBZEYu+9CdUU+QSrUbLZ/Fq0YIjmoE1x/wugoq7lx0jbXwfRwvrdrTb+7szJjJ7b5HKuIQhhVeY2EXps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769784568; c=relaxed/simple;
	bh=t4RRHGhKC9qO704K4djE/1HbC4sMRGVkjqlOcgIBrdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uss1oJRs4jKsf4GXdW56vp1r0i2lkel3kQBgnlMedWMzg5MN+M8OIzhwlXO02AcPvOWv26G+79cR0FiLa3kQtXy2Y5PtPGT2Vpxlx1MRLQA9rVEg9fo0fQ9f3Q8ZPsKBw7iWEMkSNxJ7sPt7QiaL5nHHegUaN7kX0KP9Kuap9xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=9O4q55gZ; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so3986798a12.3
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 06:49:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769784565; cv=none;
        d=google.com; s=arc-20240605;
        b=ARMfyhFC7LIzGwfeY0jDpgFqZ4CLLdbhfNnCV6RilsYZhJuR0XdYcAtQ/6LQxFdF5K
         ykXjwOdNFx9/Xd+k8zpm36UQVGIB8b5MBczIUicVZTgk9KfNBp/Ce2q2wfF+Ke43h4o7
         HrVJOEjn4w0OJRwv76oyaIwhqbkxf8V1+0BsQcokNHcXNKQ2gtmSqjm9Mz6ghrfUYbb9
         9b+NCW0GmGqTjECtPfsDNt6Bh0/8ZStrol/Jg1M+NZoLxKZlnx1ZzrQEe5z+8FsEYKDk
         8/c7KYW2CcN8FKOCSiFML0gGbF+3OleeXmOUVYVY8bPD29HZe0CmrYcog2HGciK6TPXv
         kfOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x6T4fm8App9HWL62KcSJuniw6LuHUvq2dfOPNBe2zag=;
        fh=C6v3FVX1gKACb2x5F6INfKx1PHmNRT0nn0b6GHNSqQ0=;
        b=AzY8/4BLcAq3D5OkYrO+iyhkCkJudR3yLEslaIlPs8wipsTj6EorFRfPWt4XwEZW55
         3Z6ppDgplUXj58dfAQfSrKle81qX39tvfxJy5VjiSQkrdLX1t3jtlFuhpempDAqFHf7p
         BgqoDR+L4WKKjShUJiayY23J8ttm3BBC2aMNCJq/22PVxQxlJAYu0Rd70PqpVa42Pyrg
         WUBOD73farA+592tstLUUo8mBvPG1UXVFg4S/+gHNhYnQkqCPyCaNL8ddRGqPglh20As
         k9lI/B6FqmGfwJvB2mnLsz31hFj2y6VAxlwojKwFn4jcHYS4SqfHPZaythlx8QPZIhDB
         lDhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1769784565; x=1770389365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6T4fm8App9HWL62KcSJuniw6LuHUvq2dfOPNBe2zag=;
        b=9O4q55gZ48tBmbH5KulEm2lX+1IWxcoaUuNjUC8wFx2wrrTKdHh1E7i+flosSMwiml
         JqnPzetZ8i5fvY+EDYO/9VRCjj1CGDAuJdaTY4o55kaRxt5QsDJMQ8nBGdTxb/UCMXBc
         drP251s4Q4Co9sX6ZmLA+0TWm4F1lJbR1xJ+YFlwHHmPB75ze14THmhsYovFoSKB/8tM
         fnk2G0XIZ7HdH7c7+sF+bSz7Dn15KhsjssvjgQ1LkQ3Dwx5uzQL+tspBMPj65CUD0U8N
         4XYT6V/x/m5Glj2jLIfJMLSN7qlCFYQwusloUfxBrgNNZmREtEiC4iRld+2dS5wxnAuH
         wonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769784565; x=1770389365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x6T4fm8App9HWL62KcSJuniw6LuHUvq2dfOPNBe2zag=;
        b=hS5yHLy8A0gh+CLKqmj1PbYqKIKL1jyNRHkLNxjUIeDqAyFQV1OrdyYCURvHF2BpOM
         EjMclL8XCQlojp04PhFWmdzMwlkUvNfP/A3yxMlpMP9EuwNcDJzN+MHJ2AtgzkrSDp83
         hkXAsfg0uv90Of3S8gOdrkbeNdLyvikur6Wz7pe8tI0rZPOi02WylGdxZjt99/jgog4u
         HxyGdQq6rOnxu1dklwwz8JltYAYwBeNI3BZluQFItfgwZvauvPWjPdWI8DUZuvZ9TAPJ
         s5QLcP/S45hgvsZgZ5qWpgZf1/TDtyvh7ukO8sCaKpjIjg/Co/uO4NoSxsUB1u0XPm4x
         MyKA==
X-Forwarded-Encrypted: i=1; AJvYcCVU1CQHrvVylqcbgk+LYPxGR/zi7fxMkuteMPdsyxrivNLgOVVHc2HEEdHgm/ZXvnblKn9dd4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwabDb2R+az8AIyKsHtMXNt2tVQoegarkWgvgHzfZUSSIeaMtZv
	/oWHNsgYFWO7Q7uqkc6Fp8vBoOp7t/Nj6nbgi3k2tR/VZ1NCEWX1qQtddeMktDVo9Gtxo7aV7f6
	22GQuoUhGJTtEeb/ns47cAMZ2UQhACJp+1iFAsU5aFg==
X-Gm-Gg: AZuq6aLWbvBPQXGpSGfZaVzfRBV6rMfUVeNPM08MaFKkz+vG2jw+6BzT9g9ye7+Bd9e
	VmIcU7ga8Gk5oGBOUUS92GAA/O0leDCDgc3/nqDb/ir2x75zAEQLkw9wZM14HME4YFBaL1Eed4Y
	p/3G5f4Bd7Vb2cXHzu8ZIBqnMdTOiJ26fERNMZItJEF0GY13c5L+kHAAR9M+AZJyjWw6013p9ww
	nXBsBk1cFJnL/qJ+wAqtvJaTVcdp3JAwoiNVYwT6IxXMWST2n1uyp9o0p9q4kSdaswQ0kw3oB7o
	Dd9q1BT0AuzrE/fM2day3E0NAEF7
X-Received: by 2002:a17:906:4785:b0:b87:2c88:ce40 with SMTP id
 a640c23a62f3a-b8dff6073d9mr215693166b.27.1769784565271; Fri, 30 Jan 2026
 06:49:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-ufs-rpmb-v1-1-691534ab723f@flipper.net>
 <8149b8cb5a7b36a1543ca05666f33a6373674e0e.camel@gmail.com>
 <CAKTNdwG=He3iJ8cPo4fFbcEwQQRrt_SGzoviMhi2a3kMXAO8hA@mail.gmail.com> <ad7e2d0e5b219b4b2ef2aa7ab342513a2c66171f.camel@gmail.com>
In-Reply-To: <ad7e2d0e5b219b4b2ef2aa7ab342513a2c66171f.camel@gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 30 Jan 2026 18:49:14 +0400
X-Gm-Features: AZwV_QiavZVaj1w9rZNPzvcULQmPuISNIJXVnTsDwBtZZh2I1Sg-X-NvmZQE7LI
Message-ID: <CAKTNdwG_RycHp++Z++D5HzcybSyQwvKbb++AhtXhNgE6sOoThQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: core: Fix RPMB region size detection for UFS 2.2
To: Bean Huo <huobean@gmail.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Bean Huo <beanhuo@micron.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212888-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,flipper.net:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6AAD4BBBDB
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 2:26=E2=80=AFPM Bean Huo <huobean@gmail.com> wrote:
>
> On Thu, 2026-01-29 at 21:10 +0400, Alexey Charkov wrote:
> > On Thu, Jan 29, 2026 at 8:53=E2=80=AFPM Bean Huo <huobean@gmail.com> wr=
ote:
> > >
> > > On Thu, 2026-01-29 at 11:38 +0400, Alexey Charkov wrote:
> > > > +                       hba->dev_info.rpmb_region_size[0] =3D
> > > > +                               get_unaligned_be64(desc_buf
> > > > +                                       +
> > > > RPMB_UNIT_DESC_PARAM_LOGICAL_BLK_COUNT)
> > > > +                               <<
> > > > desc_buf[RPMB_UNIT_DESC_PARAM_LOGICAL_BLK_SIZE]
> > > > +                               >> 17; /* convert to 128 kBytes uni=
ts */
> > > > +               }
> > > >          }
> > >
> > > Hi Alexey,
> > >
> > > thanks for your fix, I didn't notice there is UFS 2.x on the market w=
hich
> > > will
> > > use UFS OP-TEE RPMB framework.
> >
> > Hi Bean, it turns out many of the UFS modules for Rockchip RK3576
> > based devices are 2.2. I'm poking around the OP-TEE support on that
> > platform, and discovered that the existing driver didn't see the RPMB
> > at all, spent quite a bit of time trying to figure it out before
> > spotting the difference between the two spec versions :)
> >
> > > here is potential u8 Overflow, since for the UFS3.x+, it is u8 in uni=
t
> > > descriptor, but
> > >
> > >
> > > The calculation can overflow for larger RPMB regions (>32MB):
> > >    - A u8 can only represent up to 255 =C3=97 128KB =3D ~32MB
> > >    - The shift result is assigned directly without bounds checking
> >
> > The spec says it can only be up to 16MB maximum (see section 12.4.3.1
> > RPMB Resources), so it should always fit. Happy to add a comment about
> > that.
> >
> > Best regards,
> > Alexey
>
> Hi Alexey,
>
> Thanks for the clarification on the 16MB RPMB limit - that addresses the
> overflow concern.
>
>
> In your above operation, why not use SZ_128K to avoid the magic number?
> BTW, please update your comment.

Good point, thanks Bean! Will amend in v2.

Best regards,
Alexey

