Return-Path: <stable+bounces-214608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5//NGR6PhWkODgQAu9opvQ
	(envelope-from <stable+bounces-214608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 07:50:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C02FAC17
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 07:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99FA63011F11
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 06:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127082EC0A7;
	Fri,  6 Feb 2026 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="izJYBqxr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C12E1EE7
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770360600; cv=pass; b=d2/DuNktZ4FRZORcl/tfDf1CdCcjBt4xD9N6oIxq1j5LgE3COP2IpFacbrg7q+xpdxB/yhysrX3LgdrQ5fD+iFnUPOPGQdhn0+wbVFQss+f6VF1AC/9z+3b3haWiYvZFzhsDLN1zBKpAmhL1FoRev4zoMiLGacp7QdRAwCxJvdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770360600; c=relaxed/simple;
	bh=zn56MDqZou2YUQ0C8t2gVrhqqWmPgwauHHH4EwxmVhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqSnTHtSG3yaGsCaNPkxnT1R2qnsMBGQZ97PqlI9NXHTAVp2AKR2+nrnA9NK4J+YbSaEKuWletYSFBmIeXZT6fkNuYfjIbJC0zKBDdme0eZljQEIlzrQYjGPRPaBB3oryG0loUA4s0ZtSgfD52tp7v2TR/+ERiftpBqb9agSm7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=izJYBqxr; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-658b7d13f09so2891351a12.2
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 22:50:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770360599; cv=none;
        d=google.com; s=arc-20240605;
        b=hubVIXpoLl2ITVCRWM5pPnRJoEEEfvKYzAcETznIYMX2FPUiZ2KpeB8kDOQswKcMRm
         l8ekuzEXSDNorOPYRQsVbxVON7kxHcZtQekeW1tXECfhtz2A7CE4BGV0MfiWrfwlueRH
         upfD6gDI/wqnSe22OLId6qSDk/4fowCzWdVr3QDmkn6fPttA/qn5JWYa8Ya5rc1owolF
         ftk4Y/GtEZWXfzHNtD6xGFW/T8c/Txxu5nZlj9SakpgcpwXiMyNyZrvWsNojmn73swkn
         IewrXk5rf+ayqkzBOlQLIB9UBg7ZiNQ4NkRNeXuUNAVQgi3tqN4nk9KpgDzcDtMLCXaS
         A6jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bM8AdAe3UKJD/AbD1OSOI8ewszluelbCga2Rkvp6g/M=;
        fh=nRZVpg3oRx1GJ2xQlTjNaSDyr7Qy0hcVrHc33indEq0=;
        b=CLCTL5fSNHj8wMEkOyJLalo0i3JaQ5D3+JWY/ftAS+vXgI7Y7sMy6G2M8eDSGpxrp7
         BL7830joy5bE4Uf09A7jzeQsfmhFKsi9tBrJkKaONmBob4fURcyV3NXZtq/npJeujU+d
         442M06l/1BprA76IwVXqAO6rpNy4v+WPFsoLgsw0d9XX1OU7+LyosY32bROx9Ch2QdP7
         2ZEwncGsPlfgkLgdhAEVGpoVb/WBzH2LF8iHCR/f30VapYBUx2cfQPU5gXfz+51hMgv+
         82DfmsP6fPO588ET/aI7c28B7janKTt1QGqRuSJ+47VU9G9Nuh7SkfHvRzYB7ma+M3zB
         vD1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1770360599; x=1770965399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bM8AdAe3UKJD/AbD1OSOI8ewszluelbCga2Rkvp6g/M=;
        b=izJYBqxrHLekGasycFJnHuxcF9cHoM2ogXggCF9Ng3BndqfE589aLc9d4QCqiYomuW
         n2hHcGojuPnXYJdgtjepX1z1pbSDeIwOaBrda+xmRPPaHjNuySmU7Q+07cezIvxEHbEN
         J9xcBHyFcJY74kJIsBHLaOVbNMJXBnXoSgDcCZdVTwKxHHMikt68NKUmg7+Vdbtz/akJ
         pknxIsECUji+jtxKqV+MFUrEvPFDyODPq/lRCFw/QhDa3oJjYZh0PJuXJ3PeLWJFbwMM
         XgZvVTKRyrLnGV94fPw4sfmzPUmNUKutcKmFS6NV3C69KMwDjdsw71RECLXIeaWBYwbo
         EPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770360599; x=1770965399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bM8AdAe3UKJD/AbD1OSOI8ewszluelbCga2Rkvp6g/M=;
        b=uIE5lU9GYmxrGj96dm7ylXn2O+SEahRzCfjhMozOth4DFV+NtmbSZnWU8qI8vt6uWI
         U0R/tn7YWLcAG9+rEDjd528oQ/WvE+IXPfhfRaOlzekECxKFasylw2hs5VLIJE8D+QD2
         4CyKJFOJekptT0s9krkcexm1snXayxOJHeCQn/E4POO/eFFZ7YWJJv6nLrIC3ih5qH8Y
         c/nVK/rK5xhxHiyX28Yznw+aY0xDFev3IGrREZlMDva147gtm2m1wNA4xbEVST3Wb2QI
         RT4ViOIolGkb2A5AmGN7XyiMATxxqqQ16Nvh1xk6z7eyPAFBs6SpfQDL5CayuAuckqfu
         3xXg==
X-Forwarded-Encrypted: i=1; AJvYcCXXLXub1JySDcSy3sKqd1RYtjtXF4LXsykXhjBHwcJy3E2/e8OXFhz+WPFBHK27+aHXWzwtiRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWKyGv3nYf/Pij0ILKAWTwPZ3ps12uGV3ydMEE/g6ukW5VqHyn
	xMg6D19H1G3qCMLeKCTVgPYpibUIklACwZZNR104Y7H6IgvxpRR6W0hXuOD2e1MPjh+AKnHX92v
	mOk/SMtKZzbXmmfPv/NFfDQrt5jtV5Tf17cE3zq32kw==
X-Gm-Gg: AZuq6aKTcdmRwUSxbCMLFyUy4I5wd5BpyBEtS7k8e0deSHgj6Fjs7lzYzo8XBqOvN52
	Ap1S/V/uiet7kj3VhqIs3WqN9aAWQa609ZNrqQzE8HZJ0JVP4lU6ADWxo320PhphNgR0gKKmSn8
	fYusCiQAiXUisKiAP/i5+SiGDSajEeRSAQBIpYrTSRkQUFrbOh+FefhmkFAjeqI1dBon7v6zHWh
	cGjbA6xO8aHQkCsblJ88WyCCeg0kH8geMuwL2WAQeOaaS0G1+XGF1yAmMsfolccOedvlXvSipQ5
	qRiLCUTeVvAAwvqJH6KQ/Yu3qbpO
X-Received: by 2002:a17:907:782:b0:b8e:64e:1fe with SMTP id
 a640c23a62f3a-b8edf38468dmr94509666b.55.1770360598768; Thu, 05 Feb 2026
 22:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-ufs-rpmb-v2-1-5e1572ee52bf@flipper.net> <acc28d2d-3a85-4fba-8c15-fb956c34edf0@acm.org>
In-Reply-To: <acc28d2d-3a85-4fba-8c15-fb956c34edf0@acm.org>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 6 Feb 2026 10:49:50 +0400
X-Gm-Features: AZwV_Qh60k4ZH69X3yTEHM2-LuMmU8iNtZP6b3zNYT4SfIokl9ZJKac7I8JvAIA
Message-ID: <CAKTNdwEd5-V6REf4BDTtm37tBzWZ2baf92X3A6HvHULsUj6=Kg@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: ufs: core: Fix RPMB region size detection for
 UFS 2.2
To: Bart Van Assche <bvanassche@acm.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214608-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,flipper.net:dkim]
X-Rspamd-Queue-Id: A7C02FAC17
X-Rspamd-Action: no action

Hi Bart,

On Thu, Feb 5, 2026 at 8:08=E2=80=AFPM Bart Van Assche <bvanassche@acm.org>=
 wrote:
>
> On 2/5/26 12:30 AM, Alexey Charkov wrote:
> > @@ -5249,6 +5250,20 @@ static void ufshcd_lu_init(struct ufs_hba *hba, =
struct scsi_device *sdev)
> >               hba->dev_info.rpmb_region_size[1] =3D desc_buf[RPMB_UNIT_=
DESC_PARAM_REGION1_SIZE];
> >               hba->dev_info.rpmb_region_size[2] =3D desc_buf[RPMB_UNIT_=
DESC_PARAM_REGION2_SIZE];
> >               hba->dev_info.rpmb_region_size[3] =3D desc_buf[RPMB_UNIT_=
DESC_PARAM_REGION3_SIZE];
>
> Executing the above code if (hba->dev_info.wspecversion <=3D 0x0220) is
> risky, isn't it?

I don't think so. On <=3D0x0220 this part of the descriptor (four bytes
at offset 0x13) should always return zeros, so a compliant device
shouldn't get confused, nor make the driver confused.

The spec there is worded a bit weirdly, but it does say clearly that
these are set to zero, and I can confirm it on the devices I have at
hand (a couple of Biwin and a Samsung one, all 2.2 spec).

The spec says (Section 14.1.4.6 RPMB Unit Descriptor, table entry for
offset 13h):
4 bytes. dEraseBlockSize. Value 00h. User-configurable: no. Erase
Block Size In number of Logical Blocks. For RPMB, Erase Block Size is
ignored; set to =E2=80=980=E2=80=99

Not sure what was the rationale for giving this region a name at all,
as it is effectively reserved and zeroed out (and then change the name
and purpose of it in the next spec version anyway). But in this
context "Value 00h" is all that matters AFAICT :)

Shall I also add a comment to that effect?

> > +             if (hba->dev_info.wspecversion <=3D 0x0220) {
> > +                     /* These older spec chips have only one RPMB regi=
on,
> > +                      * sized between 128 kB minimum and 16 MB maximum=
.
> > +                      * No per region size fields are provided, so get=
 it
> > +                      * from the logical block count and size fields f=
or
> > +                      * compatibility
> > +                      */
>
> Please follow the Linux kernel coding style for source code comments.
>  From Documentation/process/coding-style.rst:
>
> The preferred style for long (multi-line) comments is:
>
> .. code-block:: c
>
>         /*
>          * This is the preferred style for multi-line

Right, the top empty line. Thanks for the pointer!

Best regards,
Alexey

