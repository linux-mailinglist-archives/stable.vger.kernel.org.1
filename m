Return-Path: <stable+bounces-236637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ED8OUYe3WmSaAkAu9opvQ
	(envelope-from <stable+bounces-236637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:48:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B33EFD6F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C8E33259034
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF1F28505E;
	Mon, 13 Apr 2026 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RSbXP6np"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F381030ACE6
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097417; cv=pass; b=FGdCTUDK8dUJTaC4q6afx60PG2JwmFSwmxglVV7ipZnN6oKyF3QNDMek0N2w/St+vjfjDW8PIl9SbUQi1mQNAN5ebwaYpTV3evZ37e01yP2QEXZiQPMgbMA65YFpDNF1NMK4pAhCWE48VL+UC/qIjHa/3cZKj40eKZHxjp8H+e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097417; c=relaxed/simple;
	bh=I3fRn6+viXk6ZMxjfrHAbFF8xP5mMdxIAQ9t2D07ldk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc2aCRO5lMdhggJczahCy5JfVxqcWi4Ni8peYqgj95IR6zRE60HL7b37k+1UpUllipz7M2Z/xRlB0Z/rrKlWwIIov3gsxWH+Ha627Kxyj17M9cBtoLyV7c6zywY3Q7NxPbkcPKXG2eQuFCYS5McHfmO/CcGSdo82P9vrJJURY9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RSbXP6np; arc=pass smtp.client-ip=209.85.217.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-605def5b800so2975090137.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776097415; x=1776702215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iy22RXZw2QJOFIDZ+2N6eI0Q/6hpWg4hd5eKencYyeI=;
        b=Q4qmvTJG+G0+AD/agvIEqCV3MBSQtfygYXhWSuxXyebvkKoYARmfNyKwVhNjs+2wq+
         yhhk452d7bXqbzonhtZ7EMeIV+ahFbZyfSjuevpwssAi70PRu3xsz8KYpA6j9ncz9L+b
         VzLkscT7MlDWXHhPaQgfizztvFcvCnzvfoEAuS7tSWCa450Z/W4hJ80AwJ/xDQaOQ6Y3
         VrI3GAauU7prSIYAI8TmjiHf95ICRMf0KhPMPXInBmsI7m61/R9haFuEomAP9ynNHcir
         j3ITqckblMbgpgY0y7i1+UuYpnNnFoT1bMIUb0KWfHx12fehcgoHTrgL3L7qH8tAwn0p
         4dkA==
X-Forwarded-Encrypted: i=2; AFNElJ/knBwaMLphBv1bEJTk2CvFlFZGdNUM/EyMMHHCk4vimw+R+WyaEITLSvpykDtt9wP0SjNQWyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5P95GxT71fmw6TeN2SiRcaymzhERsuZRuLIQxjiRIxWvL2DxL
	Ku5nSxwEWmLI3m0O9OAKY4plc6c4Yzbsv6oU/CAHJrC8nKm5vQYnphcxVqBdOrOWEbsHhva4bn/
	8506IuVtCs4Eqq4JGeWTwUnRzuIrBxTtl4m10XEWHhYi+Mzm8KfepLdLJyrG3eRADLtX1zms8HL
	VTIbmixXYSVIIBiMsfv7G0CiUEHYzgJ/sAUGUikpo2+1fFQyzHwFI54e/Sz9mycerwZv4YXemMX
	so+7RAL4W0=
X-Gm-Gg: AeBDievvPmHDrs1o2V/pF4X7EfCR+6jkJO2VV7C+/ASOczpuoofRKlKHDqdVBRkv86e
	TuazfVh15LXwzxY23HrHLkOk4IWHlIyeR0vq8IpPTKrcG7PRIVzay1UTQlMVSN4GxmfE84WGkIf
	KNRZQactEZKl57T1CyQlu0CyEfyoga+nOX2Qtad1AfLsgfnNo3TPW3063EnICpBRFzsSl0mCJ5D
	kEDWq59UepzHyS1ciWUpnv+J4bnDIlkY7IZuS7M7eVhAzBwgmEjryzM4U0vxfNUUDTJDaWRVHFt
	93k2nmRXbMHQZE2hADHplWDz4JYN8LkKr8QSrP5VZCmKJd01WStq34wqKDarX8Bl/i/p2EQ9LsA
	pydY2dWQHiwbpguFjXH1zaAgND0/NyajHBlktCCBVEaLvBl6PHZME4UpZpSWUn45Y6AHoy+uCDE
	KUbTx8iuU3mfVH1qEXrBe4BxuhZL9ARJa7oBbpkNp4B3xuSWj/tesMrsz7
X-Received: by 2002:a05:6102:6a94:b0:607:a3cb:4573 with SMTP id ada2fe7eead31-60a00c36c76mr6343702137.26.1776097414726;
        Mon, 13 Apr 2026 09:23:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-609db4ffa1bsm848213137.18.2026.04.13.09.23.34
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2026 09:23:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b9c4d00d361so410381866b.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776097413; cv=none;
        d=google.com; s=arc-20240605;
        b=g+GbghiJAM+A/Nk1S7O/RoCpRLANI6o1cnSaF7Y3L6rpMtdCm2A6ujXOrWdGanXy9H
         esBrtVcZFW6mt0gzq8o3jtINsYgsOfSOimNTbJfUrqkc24S0pNZ8sjPTvSQGLMRvT2+H
         mJEKz+xqELOorjSkX48MFu2D0lTir3G18uS4bGszR3YUkLkDeGJDUsrUcfQp80ZAds8M
         llz284td/T8xjkAI6y3lyVWYg2ZVquUUu3Jn73K21ajSrQrd9Tkf0Neg0GnCcgJIWneP
         vdO+/awPtyly4TbPXoIjPrlX4WU2mSbmCYphOEKhE8DbaN1q1vx+RbDBS53PVm6XOtTw
         W20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iy22RXZw2QJOFIDZ+2N6eI0Q/6hpWg4hd5eKencYyeI=;
        fh=JSEeS+OATSX0CXAHpJ3xqkPH2d+BvIS4phceTIuFqKs=;
        b=TWoV8OcZus9DO3DKtxsPtfZ9xYdQQR432wsj6RRpvtTPvkSeWCpniRppbXmwv6/szA
         psczs5OtQpv9ruCwXzEhxKDqDnyIex3v5f/tvgyDWNDr4qdm57bVpKteI2zVia8GSdas
         vOUiohWmBzb2r6lVY5bmSzONa1MyalzLysMerGjX9TT4P+ADR7nIRxW2S1sumk3cA/bi
         x9WLm+8Q5xYADi7ELR3cyi4zYTSWBZ/0ns6aoD8G0S1un7OQhFnG9w+uBgTT4JwF95Mk
         StTlhP9YnA5v4sRWwMZGtFn/oN+3++Z4KJI5GMjrgr732b9aP2/K3ndRd3l2cnOQXCEg
         /F2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776097413; x=1776702213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iy22RXZw2QJOFIDZ+2N6eI0Q/6hpWg4hd5eKencYyeI=;
        b=RSbXP6np4IzbP+h6BItFZ9o7oGt4AoG5GPLpKohgqcik18zI6J27D1u6sYb3SGtQyW
         XmtJSJEZFwo4NNgNTwsXK48c2ufiSNtIQKEhmdW6zHGS8Dguvx5laYn2cTSOp/BDJhPB
         QLqkt3fDILHqtvjZKCQnDUkpaPkV8M0ReO1j4=
X-Forwarded-Encrypted: i=1; AFNElJ+6fxnWXSVaQihrBE/171FIWb5jCZCKaJ4VrodUxc/3/1v9okmcoEHLi4+s9zfwnCMb7YVk7Pg=@vger.kernel.org
X-Received: by 2002:a17:906:6a26:b0:b9d:3f8b:1dec with SMTP id a640c23a62f3a-b9d7297e7b8mr777968566b.28.1776097412771;
        Mon, 13 Apr 2026 09:23:32 -0700 (PDT)
X-Received: by 2002:a17:906:6a26:b0:b9d:3f8b:1dec with SMTP id
 a640c23a62f3a-b9d7297e7b8mr777966566b.28.1776097412055; Mon, 13 Apr 2026
 09:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411080006.50010-1-ranjan.kumar@broadcom.com>
 <20260411080006.50010-2-ranjan.kumar@broadcom.com> <52c6b77a-bb2b-423d-98b7-cb1bbf606bfb@kernel.org>
In-Reply-To: <52c6b77a-bb2b-423d-98b7-cb1bbf606bfb@kernel.org>
From: Ranjan Kumar <ranjan.kumar@broadcom.com>
Date: Mon, 13 Apr 2026 21:53:18 +0530
X-Gm-Features: AQROBzBrLZqBK9sbwq8DWozEQXZfHQvzWjbYNuxhOKN9RvcSnQE6V0e7tflgx4E
Message-ID: <CAMFBP8ND50CunC5RzfUdz+buHOVoQbqM_aoOKk6qnwCWDTqAqA@mail.gmail.com>
Subject: Re: [PATCH v2] mpt3sas: Limit NVMe request size to 2 MiB
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-scsi@vger.kernel.org, martin.petersen@oracle.com, 
	sathya.prakash@broadcom.com, chandrakanth.patil@broadcom.com, 
	stable@vger.kernel.org, Mira Limbeck <m.limbeck@proxmox.com>, 
	Keith Busch <kbusch@kernel.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006aae78064f59e7ed"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,multipart/alternative,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236637-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ranjan.kumar@broadcom.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B9B33EFD6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000006aae78064f59e7ed
Content-Type: multipart/alternative; boundary="0000000000005534c6064f59e7bc"

--0000000000005534c6064f59e7bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Damien,

Thanks for the feedback. I will send a v3 patch addressing all issues.

Thanks,
Ranjan

On Sun, Apr 12, 2026 at 12:48=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org=
> wrote:

> On 4/11/26 10:00, Ranjan Kumar wrote:
> > Some firmware reports NVMe maximum transfer sizes that follow the drive
> > capability. When those values are very large, the block layer may build
> > I/O that this driver cannot handle, which can cause a kernel oops.
> >
> > When an NVMe device is set up, cap how large a single transfer may be
> > to the smaller of the firmware-reported limit and roughly two mebibytes
> > with a small margin. If no valid limit is reported, apply the same
> > upper bound.
>
> What margin ? I do not see any...
>
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
> > Reported-by: Mira Limbeck <m.limbeck@proxmox.com>
> > Closes:
> https://lore.kernel.org/r/291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.co=
m
> > Link:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D9b8b84879d4a
> > Suggested-by: Keith Busch <kbusch@kernel.org>
> > Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
> > ---
> >  drivers/scsi/mpt3sas/mpt3sas_scsih.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> > index 6ff788557294..fca9d6722fc8 100644
> > --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> > +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> > @@ -54,6 +54,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/raid_class.h>
> >  #include <linux/unaligned.h>
> > +#include <linux/sizes.h>
> >
> >  #include "mpt3sas_base.h"
> >
> > @@ -2737,9 +2738,17 @@ scsih_sdev_configure(struct scsi_device *sdev,
> struct queue_limits *lim)
> >                               "connector name( %s)\n", ds,
> >                               pcie_device->enclosure_level,
> >                               pcie_device->connector_name);
> > -
>
> Spurious whiteline change. The white line is nice before the big block
> below.
>
> > +             /*
> > +              * Firmware may report large NVMe MDTS values on some
> ASICs.
>
> What ASICs ? The SSD controller or the HBA controller ? Also, does the HB=
A
> firmware change the MDTS ? Or does it report the SSD reported MDTS as is =
?
> If it
> is the former, then an explanation would be nice. If it is the latter,
> instead
> of "Firmware may report" I suggest "The NVMe device controller may report=
"
>
> > +              * Limit max_hw_sectors to the smaller of the reported MD=
TS
> > +              * and 2 MiB to avoid issuing I/O the driver cannot handl=
e.
>
> Without any explanations, 2MiB appears to be a "magic" value here. There
> is a
> clear explanation for it with the 4K device page size that can fit 512 PR=
P
> entries each pointing to one 4K page. So let's state that.
>
> > +              */
> >               if (pcie_device->nvme_mdts)
> > -                     lim->max_hw_sectors =3D pcie_device->nvme_mdts / =
512;
> > +                     lim->max_hw_sectors =3D min_t(u32,
> > +                                     pcie_device->nvme_mdts / 512,
> > +                                     (SZ_2M / 512));
> > +             else
> > +                     lim->max_hw_sectors =3D (SZ_2M / 512);
>
>                 lim->max_hw_sectors =3D SZ_2M >> SECTOR_SHIFT;
>                 if (pcie_device->nvme_mdts)
>                         lim->max_hw_sectors =3D min_t(u32,
> lim->max_hw_sectors,
>                                         pcie_device->nvme_mdts >>
> SECTOR_SHIFT);
>
> is I think a bit nicer.
>
> >
> >               pcie_device_put(pcie_device);
> >               spin_unlock_irqrestore(&ioc->pcie_device_lock, flags);
>
>
> --
> Damien Le Moal
> Western Digital Research
>

--0000000000005534c6064f59e7bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div>Hi Damien,<br><br>Thanks f=
or the feedback. I will send a v3 patch addressing all issues.<br><br>Thank=
s,<br>Ranjan<br><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Sun, Apr 12, 2026 at 12:48=E2=80=AFPM Da=
mien Le Moal &lt;<a href=3D"mailto:dlemoal@kernel.org">dlemoal@kernel.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 4/11/26 10:00, Ranjan Kumar wrote:<br>
&gt; Some firmware reports NVMe maximum transfer sizes that follow the driv=
e<br>
&gt; capability. When those values are very large, the block layer may buil=
d<br>
&gt; I/O that this driver cannot handle, which can cause a kernel oops.<br>
&gt; <br>
&gt; When an NVMe device is set up, cap how large a single transfer may be<=
br>
&gt; to the smaller of the firmware-reported limit and roughly two mebibyte=
s<br>
&gt; with a small margin. If no valid limit is reported, apply the same<br>
&gt; upper bound.<br>
<br>
What margin ? I do not see any...<br>
<br>
&gt; <br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable=
@vger.kernel.org</a><br>
&gt; Fixes: 9b8b84879d4a (&quot;block: Increase BLK_DEF_MAX_SECTORS_CAP&quo=
t;)<br>
&gt; Reported-by: Mira Limbeck &lt;<a href=3D"mailto:m.limbeck@proxmox.com"=
 target=3D"_blank">m.limbeck@proxmox.com</a>&gt;<br>
&gt; Closes: <a href=3D"https://lore.kernel.org/r/291f78bf-4b4a-40dd-867d-0=
53b36c564b3@proxmox.com" rel=3D"noreferrer" target=3D"_blank">https://lore.=
kernel.org/r/291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com</a><br>
&gt; Link: <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torva=
lds/linux.git/commit/?id=3D9b8b84879d4a" rel=3D"noreferrer" target=3D"_blan=
k">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D9b8b84879d4a</a><br>
&gt; Suggested-by: Keith Busch &lt;<a href=3D"mailto:kbusch@kernel.org" tar=
get=3D"_blank">kbusch@kernel.org</a>&gt;<br>
&gt; Signed-off-by: Ranjan Kumar &lt;<a href=3D"mailto:ranjan.kumar@broadco=
m.com" target=3D"_blank">ranjan.kumar@broadcom.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 13 +++++++++++--<br>
&gt;=C2=A0 1 file changed, 11 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3s=
as/mpt3sas_scsih.c<br>
&gt; index 6ff788557294..fca9d6722fc8 100644<br>
&gt; --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c<br>
&gt; +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c<br>
&gt; @@ -54,6 +54,7 @@<br>
&gt;=C2=A0 #include &lt;linux/interrupt.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/raid_class.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/unaligned.h&gt;<br>
&gt; +#include &lt;linux/sizes.h&gt;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;mpt3sas_base.h&quot;<br>
&gt;=C2=A0 <br>
&gt; @@ -2737,9 +2738,17 @@ scsih_sdev_configure(struct scsi_device *sdev, =
struct queue_limits *lim)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;connector name( %s)\n&quot;,=
 ds,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie_device-&gt;enclosure_level,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie_device-&gt;connector_name);<b=
r>
&gt; -<br>
<br>
Spurious whiteline change. The white line is nice before the big block belo=
w.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Firmware may repor=
t large NVMe MDTS values on some ASICs.<br>
<br>
What ASICs ? The SSD controller or the HBA controller ? Also, does the HBA<=
br>
firmware change the MDTS ? Or does it report the SSD reported MDTS as is ? =
If it<br>
is the former, then an explanation would be nice. If it is the latter, inst=
ead<br>
of &quot;Firmware may report&quot; I suggest &quot;The NVMe device controll=
er may report&quot;<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Limit max_hw_secto=
rs to the smaller of the reported MDTS<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * and 2 MiB to avoid=
 issuing I/O the driver cannot handle.<br>
<br>
Without any explanations, 2MiB appears to be a &quot;magic&quot; value here=
. There is a<br>
clear explanation for it with the 4K device page size that can fit 512 PRP<=
br>
entries each pointing to one 4K page. So let&#39;s state that.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pcie_device-=
&gt;nvme_mdts)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0lim-&gt;max_hw_sectors =3D pcie_device-&gt;nvme_mdts / 512;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0lim-&gt;max_hw_sectors =3D min_t(u32,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie_device-=
&gt;nvme_mdts / 512,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(SZ_2M / 512=
));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0lim-&gt;max_hw_sectors =3D (SZ_2M / 512);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lim-&gt;max_hw_sect=
ors =3D SZ_2M &gt;&gt; SECTOR_SHIFT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pcie_device-&gt=
;nvme_mdts)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 lim-&gt;max_hw_sectors =3D min_t(u32, lim-&gt;max_hw_sectors,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcie_dev=
ice-&gt;nvme_mdts &gt;&gt; SECTOR_SHIFT);<br>
<br>
is I think a bit nicer.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie_device_put(=
pcie_device);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqr=
estore(&amp;ioc-&gt;pcie_device_lock, flags);<br>
<br>
<br>
-- <br>
Damien Le Moal<br>
Western Digital Research<br>
</blockquote></div></div></div>

--0000000000005534c6064f59e7bc--

--0000000000006aae78064f59e7ed
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
zZSItX49nLoa4TBbzuCzoINrv59QeSCVlVdAYussUS3840ZjvcYHSQx3tqYcBN+an07lDASmGEM5
7PEXJPVInjl/Fva3ksL3r8anR4PWc3Xz5jLD8Xg6BU4zmIcR/t1GlqWuz8uTWmQtm40C9m91Q9a+
2alIIV6BTs8IG2ELtt4EfcVvi5af+Hu878sGeBtMx6Z9ljoKl3MfvDdtUNO4bkJ97a7PXy/CKxiy
TApQj4qg9SKQcsH0xzQan67XeXjkvk4frNDhRikCAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcmFuamFuLmt1bWFyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUfLdm66N7GfDsoL8cYp3s4YdO
isMwDQYJKoZIhvcNAQELBQADggIBAA/lnAxDb9jbesclnBxWIKUSxAMIrq4XKO5WKHUYIOOzd2sL
o59fH9AWg1AfVONfWIUNdWDrmNNLs0+drSKaZbGx2RWMbaL9ubo7+BTQV33ZRBxnnkmc9QszlOo5
m6FB9uPOGB9LvJMCkJ8S7hNc9G/p7dB79s1IKc8JGEDIrsgX3s4xSCJA20WdePHY5rLh5ySwXyI2
3sVTUC+oK0HJFRo+TpdMMtdpOetWzIkUbGceiOA2ur8372+0KOmvlIHA/jEnW3BRfmB2vmdk+raY
C/xbXY9JEfS6D881+X/90w+cCQ7nuA1OELebS1RbSdXT6YkRDPWYA/DPFhOYCAiMwVAPRaAH1AQc
8J8yTDigwRUCq4qKCYU9YnqQh3YZRbUYnW+i3+rAO2SUbKl0VM5y0tq+GOGLC7w+v6yGossZmy+6
3w72qp/Colr4r5ZaROb+L2FXqk4tL/HfkRhliyPPPNIjre2mIkvFuShk5A5FcvQYCzDtejAz9JHq
ZVJ1ZD+auQDbIUxT+Dn9bI5XkQnWJ9KrlcORtztdYTDafN8VQuweS3JY0X/VCNBNZkiYXd7fzOza
hvkw/S+v8cIfiakLKBREtiBHqWLdVf5CNDVYpd17yz0LGz0TKARbfuK/EiKflA10pnnnOB33Ru9D
WPp9aHW3szGYr3+H9AHS6IDwkIxyMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMDcMaKRu9LrbAxERoMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCPSaXZ
OPzRPd8gUk0ZDkw4HfJLhY85+mLyG2Dj7B4vBzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA0MTMxNjIzMzNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBFhOCEcaGKn5zgE0NNAc8ppG8KzETJb/bsmMCwu5gI
txT/n69IudMTEjMWD5r3xAMbAmV8KkMeeq85ws3ThG2X8nu/6jjINBLCALFXBsEc7pcPLUDUGVP7
6d0eNJwXqNumA5cuv8KjaMZ8Jm523ncdgZumP7bWAOk6z3Ve8HfQgE/bfIlsd0+LzTBqHxpEtG5L
wYKOV5PDGPsH7TfZGAO0684WTmk+rokDlmvQYNFCvtHL6fdbr7SU57cmxc0Kh90trwFK4g/6XQoT
1iksIpN1fX8cGsUtwrJnv1E04jdnztpbyc8bogx6S6aDbvfGC6CatjVOVBnyL7p3Adv+r57H
--0000000000006aae78064f59e7ed--

