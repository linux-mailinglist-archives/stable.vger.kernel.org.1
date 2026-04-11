Return-Path: <stable+bounces-235684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKeGOWHh2Wm6uAgAu9opvQ
	(envelope-from <stable+bounces-235684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 07:51:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB213DE79E
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 07:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 462D63027B4D
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 05:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1830C339A8;
	Sat, 11 Apr 2026 05:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EMhVU+z1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936B52C0307
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775886569; cv=pass; b=sFt6fCIMGs3OYJR1CFJ8DcD7PzmiHXLq3QrRJOG3b2URR9gBeQK/VgFtNc3uX09YqSEEvN0gIqsDFV76+qYhLHYBmbCaqva1Hw2yEeRg95/aiAz0L79BDxAbrLFmZxoiNa52Nw+wSZ2OEYz1HV/2vDJXdVez2JOrXi4/ETD4NTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775886569; c=relaxed/simple;
	bh=rUmU83FXywr0dbIeHXyVXTafPhg7eW0a6Gv0rgIRwN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8sidBzE4n4f63/FsR0taSVaeJB89ujPzRU76oWv3VsE6YwBdZaDk4ApEMegzYXfKkMIAbh/nVrvJjPGu16zYx/Vwvv6NQelQPv6fHMNps9wExpbITlhVxITE7qjHwzm4GV6vnrDeX/TB5iDHgcPseZ3xYOmrDft35VolVBAjJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EMhVU+z1; arc=pass smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7dbcd92eda5so2044964a34.2
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 22:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775886567; x=1776491367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IA2PuxNMFuqo2l/D1bWIZ+YAHzNR34OHG8gCkzUBRz8=;
        b=aGnDF+5B9XnvOVmLO15ptQUpoEVl6Cey1n+3irmObHreyh/jQ34F0vzmJdGYXtb+dc
         QSkh89UIm+n3G9gf+0nupzRIMayr8QvsOATzYAOtEsctKS+oGLUDQP9rjc0t1Q2KJdYI
         O/j7Fu7pkitJjrW7daOeJsmMrhr/8GDJZ/WHFkKpbK+neASNH3O7DMe7IcY/KGGlQWNH
         Lal8stZoJySPGcASJBtAVsv3KmFFMbsz9wDeOa27e/tDd4hoq+HbCeXTAVtO6eexNRM3
         5LB1BF8G7D7UrjS999XUBhTPACPaXIRNCAHz+oW+JXNQL0f/eaeETSxeouJWVOXq3cjk
         C1xQ==
X-Forwarded-Encrypted: i=2; AJvYcCWQYImjFpjbiX6cjmvMnm4T9ULDxf2BheCHzQVjdkk3Itb46y1+XPwwfeVMDqRlcsQCwtr3i3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/YMa3ZifwEU28apePbh14aQKfGupjFmj5xlOa9jCf5zsbFun
	lMBueUObmgHZijlzFp5RBQYrFEi2q/LXqmlhVsRFGBaDFwsVebqa7H1eBLhEucfVvBUiLs9TMsj
	nuhBjrvJWett/h9GKsUVBZBOMTP+oyhex1jktRZaqeZ/5ZPVKEWeCYP83HRmsItuECY+xhWhvVm
	KoRwYKv9XkQ91whuRJhwTiXvbRQeggkSD9ICtTcq03PdOBDZiPpmjmcv2WI62GHWQsxVQo7o2uy
	s/97ayTRck=
X-Gm-Gg: AeBDievV6MMUFWrzpf4x99xikCaRRkBv0knLqDvqFokwrpsz49uD8AMGqby2YL38Bst
	Ns1MM6JNGC2TOCacuc/+AMuzTLnxIaEhLADpPN/4/ffRw+RTOFSTvvSexSbWFSfRkomri5HKXxd
	2TScLlXHVlcEUk+AwMzgepT4RY0RS5Sh5nY1EidZCRW4vS5AUtHhO3LbYOgIEY0FdQyi3E8ZrIn
	HQlH9NnTwvSE94WY8y6u4MtAB6D3LmYhhPCHWFNEn9eBQJdOQHO4XhK74NWoTUdQF/1pwBS4A7R
	7rt2gU6ebXO9ryUFZOqruFsWJzZ3ryi41IEy62Wnx20rUgkK5hvLwB2T36aW3cE/qiWL4u0XgFu
	i2ONSgwCE+M2M/BJB0IjRLhvjv/msQg+UwEHaddJN8Vfp3Wc7aemBtQCZZQA1yQ+XazW0d/EzYy
	qXyJPBcFQ7vF5DFkh/g+StDIsd2M5pA3HLHYBph2BxEOWsXhff52VlxyGd
X-Received: by 2002:a05:6830:2116:b0:7d9:b0d7:ffda with SMTP id 46e09a7af769-7dc27cc51d4mr3560560a34.11.1775886567459;
        Fri, 10 Apr 2026 22:49:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7dc267945a5sm521850a34.6.2026.04.10.22.49.26
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2026 22:49:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b9360e9f43bso279407166b.3
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 22:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775886565; cv=none;
        d=google.com; s=arc-20240605;
        b=aoyn3/scch9dQvKK4hDkHqWGVPBrxC3wedur1PzSiE5g3xpoUBbjAKkw0kv2UIHQuV
         6+LU0j0ds84fiX4b5EyR7kPr8iBaHLRWpkz8J3w2QbuZuN7KyRQESaBQGqNirX8b77G4
         tzLsMPU2fyYxerhdqx39nJzbCAbRrHfHKC4gJ3Prq6lmpBBh8VuczqSYplHd5x9lJ0Vt
         kq2egVGEIb3hLS1+eja+aG5pRyqa9kxuYpg2kndWEMAMK2H4o4khdMp5UkuhVGCX7EF0
         oD8utQfxG7ESaL8veuYGOTlwjCzv7WyUMBCWiCBRGow/vbOoEDYI7PgcMvIfJB+4u5ej
         tVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IA2PuxNMFuqo2l/D1bWIZ+YAHzNR34OHG8gCkzUBRz8=;
        fh=5rvwpJ9scRiizOt2u5sN1oFZNAT0PZDtQzFSiO6Y0Ho=;
        b=c4dI86jmLzaaDItQE2uBpZciCBBw6JZr7xTk0WxwkBXQfwEGoXEhnQJ95VcE136C+V
         +ffhAihr07XPim2ZZm8jUEK2U2Xja6Q1lGlx4OmjbIlR8JrwGOGPk5UWin3ljLKLPptf
         A0skaHyM8hSRx5xGNJP5Hl+Jvjc6I7Wy1FADD8Av+/zEsqs9B96kZ/vExo/2qi25B/YC
         NlPEmFdlKib4G8OFG7dNRFA+tjSbZOXpnFawa1OeWodk9qby2tydTY/Q9nA2xrN4ZhUk
         thrDUk/shgntYJOUPKBtZoL23ZWW2GFxcP8KpT4X5MY7EmTRtGUxObk614KmFQoY8ure
         C0gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775886565; x=1776491365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IA2PuxNMFuqo2l/D1bWIZ+YAHzNR34OHG8gCkzUBRz8=;
        b=EMhVU+z1vrcYbuTIylT+9bL6e2A2CKwLo+jCNYHq8gvo3Q1yvV9FEGgYY0L9EQCTTp
         HWHXNR97AowubJVo19KOQW/E+XBPF2uyxeZD002yNqMjJJeljy3sPApxyxF1lmuJGiv6
         EvTGk+8x5iBRE9VAMBWxTG6stMo49ZzKgrvQI=
X-Forwarded-Encrypted: i=1; AJvYcCXZ502PfKIr/tkAKwq/Dnp1gAyzY0ToXqmSMb/JZC4ywNpIQ341pSSLSioPqNgCaU+oX31wB/4=@vger.kernel.org
X-Received: by 2002:a17:907:9709:b0:b97:87e4:7f40 with SMTP id a640c23a62f3a-b9d726572b5mr334064166b.27.1775886565000;
        Fri, 10 Apr 2026 22:49:25 -0700 (PDT)
X-Received: by 2002:a17:907:9709:b0:b97:87e4:7f40 with SMTP id
 a640c23a62f3a-b9d726572b5mr334062966b.27.1775886564467; Fri, 10 Apr 2026
 22:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409184217.32992-1-ranjan.kumar@broadcom.com>
 <eec3bbd3-5503-423b-bb3e-22657026d573@kernel.org> <adkqob9VZ-G6mrsW@kbusch-mbp>
In-Reply-To: <adkqob9VZ-G6mrsW@kbusch-mbp>
From: Ranjan Kumar <ranjan.kumar@broadcom.com>
Date: Sat, 11 Apr 2026 11:19:11 +0530
X-Gm-Features: AQROBzC0AvpwG8JoxrkNeTejPAZUHI6liB6BxxJp1xS2RHQ0II3s0jbXa-Qe3e0
Message-ID: <CAMFBP8P6H1Xc6YBs9KDUrp4V-5pPxTxeeAYyomeOeyjiQYYH9w@mail.gmail.com>
Subject: Re: [PATCH v1] mpt3sas: Limit NVMe request size to 2 MiB
To: Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-scsi@vger.kernel.org, martin.petersen@oracle.com, 
	sathya.prakash@broadcom.com, chandrakanth.patil@broadcom.com, 
	stable@vger.kernel.org, Mira Limbeck <m.limbeck@proxmox.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e364d3064f28cf43"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235684-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ranjan.kumar@broadcom.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4BB213DE79E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000e364d3064f28cf43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Damien and Keith,

Thank you both for the review and the clarifications.I will submit the v2 p=
atch.


On Fri, Apr 10, 2026 at 10:21=E2=80=AFPM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Fri, Apr 10, 2026 at 06:11:22AM +0200, Damien Le Moal wrote:
> > On 2026/04/09 20:42, Ranjan Kumar wrote:
> >
> > >             if (pcie_device->nvme_mdts)
> > > -                   lim->max_hw_sectors =3D pcie_device->nvme_mdts / =
512;
> > > +                   lim->max_hw_sectors =3D min_t(u32,
> > > +                                   pcie_device->nvme_mdts / 512,
> > > +                                   (SZ_2M / 512) - 8);
> > > +           else
> > > +                   lim->max_hw_sectors =3D (SZ_2M / 512) - 8;
> >
> > I am very confused here: SZ_2MB assumes that you have an SSD with a min=
imum page
> > size of 4K, which can fit 4K / 8 =3D 512 PRP entries, each referencing =
4K (one
> > page), so a maximum of 2MiB. However, if I am not mistaken, there is no=
thing in
> > nvme specs that forces the MPS field to be 0 (which leads to a page siz=
e of 4K).
> >
> > So this seems incorrect to me, even though that will probably work for =
the vast
> > majority of SSDs out there, some exotic ones will not be correctly supp=
orted.
> >
> > Keith ? Am I missing something here ?
> >
> > Or do we simply do not care about SSDs with a minimum page size > 4K ha=
ving
> > their maximum command size truncated ?
>
> Spec doesn't require it, but industry converged on that as always being
> the minimum supported page size. The nvme driver rejects any device that
> doesn't support 4k pages because they can't be reliably supported on a
> lot of archs, even ones with larger page sizes. So it should be a safe
> assumption that everyone supports 4k since no on is complaining. :)
>
> On the patch, I initially left the "- 8" in the calculation to account
> for page offsets. But it's not necessary because that gets absorbed in
> PRP1 within the command, so we'd have at most 512 entries in the PRP
> list for a 2M transfer.

--000000000000e364d3064f28cf43
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
MjAyMwIMDcMaKRu9LrbAxERoMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDq7oak
R3tBXasfd7nyLCT9NkhQmHde5+gYGVmOe3wfbjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA0MTEwNTQ5MjVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC8a9mLabIAXWhROPRM2E+qKImhWQuq7f5LpEvDuyRx
3eCFgqohyiD8YP3YhUZcpuNyWj5HFN2DUIZH4ZLl5RQN+aZi3ECVMh0jufm5fgCQvmoxF2/ldqdv
PWUuTRnnwHJoNW7uMosvFmvoiVrq4vuODCMJU3Q+yZqxbyQBVTeDgQT8P6c3vLmpewxLAo+1EUxk
nu2D1Jq992n0xhRHGyObAo7g89U2kVcIz60N2Rx3KFXvP0hjjkQnPIGjyRPeBzdHBo2qFSu+oaZU
dy/c93Idi79aZUHB0xR1N8HaWRhMZHwysGRrXjMDNt8Inut2KySJ0dFql2I/pjq6kcNgox1R
--000000000000e364d3064f28cf43--

