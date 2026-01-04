Return-Path: <stable+bounces-204553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B25CCF0A7A
	for <lists+stable@lfdr.de>; Sun, 04 Jan 2026 07:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81F3D300FFAF
	for <lists+stable@lfdr.de>; Sun,  4 Jan 2026 06:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF28C2DEA77;
	Sun,  4 Jan 2026 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NA+u4y8U"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146A51FBC92
	for <stable@vger.kernel.org>; Sun,  4 Jan 2026 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767507657; cv=none; b=Mph5dpbUaiNsrC+8hu7tfqZbBwDoRH8Ai0u9qx5CHPHKwVF+WKfbU3zvabf0R2YBt+9xoSPnEIIukPvxBto+CL3YN0732jm1hQeaMwK3iR+pvD4L8TBq8O0D5WLbGSR+ezRTFBiK4poqXVoSjdm8lbVITPbhMzHpWGukZZgnRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767507657; c=relaxed/simple;
	bh=fL2ICFMNS5sRQkRpPukcKfGLzOeDgdMerVyM219LAqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uy0GfgnvPJTR8TdW5zlXi9j5JFxoSwg64dC1UteJGFEw5u0SCYXM2L50bQxSCXffmuj1edP9Z7nJFJprsMgra3LDe7xohY4KH1ZSGqWYvGPbxG98b7e6bxVwTQHhRVSm+tUxNK3CK/ifL2Bpz60M9B96jSYAshFszMw7iwlRRHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NA+u4y8U; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-4f1b212ba25so118084821cf.2
        for <stable@vger.kernel.org>; Sat, 03 Jan 2026 22:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767507655; x=1768112455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zB9oB9VHOh19RcfIXy+eCA7NDB2rTf/0lIyXbQ95bRQ=;
        b=eG5ttKbMUufDwuMP4eqjBYa7tHKrmW5E8XdlM3Na+ow0qqoKcpkYflSfFxcvL7h5VK
         5uuGZ/gr4NCH6TgxOmn8tb9lNpiQLrYF8y/hpFTEOm+ySDroMu+dnN8N2Emd/u84VFL/
         mhCV5p4vPAQ6VgiuG9wLcSKQVsysz0qtaZuRGM5ebQnr1MLH+wSiJdqrGVx2zF1rsKjq
         I1KIj95DzYcQJ6g0w+EN27/MGoqNhIMrlrE3btz4Y1xFGvMdLuVzSBnf+6m/5SxxCvHt
         ClFptzjgpaUYxSZW9aLTkGLXBkSn0a8IPnc+QlFqeIYe/b7jUmNNQ1QFkapNekoopMG5
         TJwA==
X-Forwarded-Encrypted: i=1; AJvYcCVTBbadkRWx+fo0U6crS6ki1dqqYrZFO5qMwdThGggNEv2rGP2T1+igaOob9p4ADiE5kcadHQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuQpEEBli/Lin0cU0EzSGS3gX0TFIQYls1Uk5B0OmGWa26KK4u
	aRDvGurNayMc5wZHp/0a1CMqNMwh7m4rVXdfl3Nsn+okDrol3ciLy5mfYzHW8mOWN2d1P7QYDc3
	2NsfccwLQSSBYMqUyS/5BOZdUzhrWyAuW/Y6W0+uE/bfenN/TzL5l4VPwmfFCz2djpxcQSxJiHB
	5uMHSNNw1Vu+hvhAmQaDG1aKx0E9sK7HOJAKgUqRCQv0efbacQuHLAbGfr2tPlbV33UnHbF6EKS
	f4J/l2xvcZAMQ==
X-Gm-Gg: AY/fxX6rwCD4plzpSKaoBM3LVal0TpM5Ee9v0RbdJW2DTDX2KmKeMBPbY61sU6XfGJR
	xTtoRia9TZsN0vGmjsuCpNNavkM4XaswYuSPbZv3rylU4sLwvXckEt/2k1hsDFc7SdA5O4UnMM0
	gnYGWkpdYP/pPJTVgyDy0727YCEURpfwGWAuKZnm892D6OmOwMm7kiQtRw8wkbhzR3TNcM+4YC6
	ia0iuviaPyQn6lSTthgd71XNRxtW9roK6cueA06nqZHfUXJVOz3nDJAbAMHjYryYk3VkMgNJfYL
	0jTg4d/yGj+4ebPlmqlk9hQYH1Ov7VZWJ8iTWfSSwcapBxjLc06PL9J1jRjbmLGiq2AIHzV+Rqp
	+BRNMa86KiBjHDe4K/RXNqHEoo4Lu8lCprzwium6xDkOBQcWOGczDOCSgAZ4O4oT73MV4lL6tgC
	WA5qVrsU4+9wiIOYWp0FI9bL4B6RUS9A/3D4iAdJXyzoXcObA=
X-Google-Smtp-Source: AGHT+IGxACO7kH68mlIPQDJwfQx47btTYeEYansRlFPlEsG5+FVpUByjsEau5fDufd6iahxuOsNnmbg4LO7E
X-Received: by 2002:a05:622a:5816:b0:4ee:4422:5a75 with SMTP id d75a77b69052e-4f4abccf16dmr646396551cf.14.1767507654895;
        Sat, 03 Jan 2026 22:20:54 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88d98055ca8sm62905016d6.28.2026.01.03.22.20.54
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Jan 2026 22:20:54 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0c495fc7aso185731005ad.3
        for <stable@vger.kernel.org>; Sat, 03 Jan 2026 22:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767507653; x=1768112453; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zB9oB9VHOh19RcfIXy+eCA7NDB2rTf/0lIyXbQ95bRQ=;
        b=NA+u4y8UBbdRAt6pKFNz2B/tuuT+GcvaTvvxzutxrSDChc67O2xHBTe5OExQnyU3wY
         u+c16D0EeBQQgjrDy721wJoZwT/qg14wbujwsUWI/HbFJoUVPT7mc9+qChQkrkS/Bx36
         BWzxI0J6www2ukyDf4bq9TQrL1ggkmWNgdDK4=
X-Forwarded-Encrypted: i=1; AJvYcCXYH1rP4vLN5+cePOQ4N2HeaeQ4V0QJSHwPrAp4UJLqnpJfkJyQi2qJHs5z6HlisqQmM7sxOa4=@vger.kernel.org
X-Received: by 2002:a17:903:230c:b0:29d:a26c:34b6 with SMTP id d9443c01a7336-2a2f293d4f7mr490664945ad.50.1767507653090;
        Sat, 03 Jan 2026 22:20:53 -0800 (PST)
X-Received: by 2002:a17:903:230c:b0:29d:a26c:34b6 with SMTP id
 d9443c01a7336-2a2f293d4f7mr490664765ad.50.1767507652672; Sat, 03 Jan 2026
 22:20:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-bnxt-v1-1-8f9cde6698b4@debian.org> <CALs4sv2qQuL0trq3ZB6SczPK5BmFMF6p2Ki-3q+4Xqc_qzauoQ@mail.gmail.com>
 <nejlqwxc4ekfhmpodjm63cfob4o5uf2z7qukk3daofykegnwvs@sksxy4lmxrnd>
In-Reply-To: <nejlqwxc4ekfhmpodjm63cfob4o5uf2z7qukk3daofykegnwvs@sksxy4lmxrnd>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sun, 4 Jan 2026 11:50:41 +0530
X-Gm-Features: AQt7F2p0-gVmqAE8mM3PeFt257kK6eS-wedg7UZB-tKTetQD9G94en78QukvySI
Message-ID: <CALs4sv1wProin+_J-k3h0Vr_BXcTdrOp1ZezhBiWYh1twFNd9Q@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
 during error cleanup
To: Breno Leitao <leitao@debian.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d4c08c064789f196"

--000000000000d4c08c064789f196
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 9:13=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> Hello Pavan,
>
> On Wed, Dec 31, 2025 at 09:30:57PM +0530, Pavan Chebbi wrote:
> > On Wed, Dec 31, 2025 at 6:35=E2=80=AFPM Breno Leitao <leitao@debian.org=
> wrote:
> > > Fix this by checking if bp->hwrm_dma_pool is NULL at the start of
> > > bnxt_ptp_enable(). During error/cleanup paths when HWRM resources hav=
e
> > > been freed, return success without attempting to send commands since =
the
> > > hardware is being torn down anyway.
> > >
> > > During normal operation, the DMA pool is always valid so PTP
> > > functionality is unaffected.
> > >
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable e=
vents")
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_ptp.c
> > > index a8a74f07bb54..a749bbfa398e 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> > > @@ -482,6 +482,13 @@ static int bnxt_ptp_enable(struct ptp_clock_info=
 *ptp_info,
> > >         int pin_id;
> > >         int rc;
> > >
> > > +       /* Return success if HWRM resources are not available.
> > > +        * This can happen during error/cleanup paths when DMA pool h=
as been
> > > +        * freed.
> > > +        */
> > > +       if (!bp->hwrm_dma_pool)
> >
> > Thanks for the fix. While it's valid, just that to me, this check here
> > looks a bit odd.
> > Why not call bnxt_ptp_clear() before bnxt_free_hwrm_resources() in the
> > unwind path?
>
> I thought about it, but, I didn't understand all the implication of
> changing the unwind order.

It looks safe, it should just be fine.

>
> Anyway, I've have tested the current patch and it worked fine. Do you
> think we should move kfree(bp->ptp_cfg) closer to bnxt_ptp_clear()?

Yes, that looks like a right thing to do, along with bp->ptp_cfg =3D NULL.

>
> Thanks for the review,
> --breno
>
>
> commit d07c08889f75966d6829b93304de5030cf4e66aa
> Author: Breno Leitao <leitao@debian.org>
> Date:   Wed Dec 31 04:00:57 2025 -0800
>
>     bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable during error clean=
up
>
>     When bnxt_init_one() fails during initialization (e.g.,
>     bnxt_init_int_mode returns -ENODEV), the error path calls
>     bnxt_free_hwrm_resources() which destroys the DMA pool and sets
>     bp->hwrm_dma_pool to NULL. Subsequently, bnxt_ptp_clear() is called,
>     which invokes ptp_clock_unregister().
>
>     Since commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to
>     disable events"), ptp_clock_unregister() now calls
>     ptp_disable_all_events(), which in turn invokes the driver's .enable(=
)
>     callback (bnxt_ptp_enable()) to disable PTP events before completing =
the
>     unregistration.
>
>     bnxt_ptp_enable() attempts to send HWRM commands via bnxt_ptp_cfg_pin=
()
>     and bnxt_ptp_cfg_event(), both of which call hwrm_req_init(). This
>     function tries to allocate from bp->hwrm_dma_pool, causing a NULL
>     pointer dereference:
>
>       bnxt_en 0000:01:00.0 (unnamed net_device) (uninitialized): bnxt_ini=
t_int_mode err: ffffffed
>       KASAN: null-ptr-deref in range [0x0000000000000028-0x00000000000000=
2f]
>       Call Trace:
>        __hwrm_req_init (drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c:72=
)
>        bnxt_ptp_enable (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:323=
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:517)
>        ptp_disable_all_events (drivers/ptp/ptp_chardev.c:66)
>        ptp_clock_unregister (drivers/ptp/ptp_clock.c:518)
>        bnxt_ptp_clear (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1134=
)
>        bnxt_init_one (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16889)
>
>     Lines are against commit f8f9c1f4d0c7 ("Linux 6.19-rc3")
>
>     Fix this by clearing and unregistering ptp (bnxt_ptp_clear()) before
>     freeing HWRM resources.
>
>     Suggested-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
>     Signed-off-by: Breno Leitao <leitao@debian.org>
>     Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable e=
vents")
>     Cc: stable@vger.kernel.org
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index d17d0ea89c36..68fc9977b375 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -16882,10 +16882,10 @@ static int bnxt_init_one(struct pci_dev *pdev, =
const struct pci_device_id *ent)
>
>  init_err_pci_clean:
>         bnxt_hwrm_func_drv_unrgtr(bp);
> +       bnxt_ptp_clear(bp);
>         bnxt_free_hwrm_resources(bp);
>         bnxt_hwmon_uninit(bp);
>         bnxt_ethtool_free(bp);
> -       bnxt_ptp_clear(bp);
>         kfree(bp->ptp_cfg);
>         bp->ptp_cfg =3D NULL;
>         kfree(bp->fw_health);

--000000000000d4c08c064789f196
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCA/QA2s
xePEEHnh4zsxT9bhDd6GLs/kbHv6jyiI35q9LTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMDQwNjIwNTNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBZF9ebyz75M76pp6cz8RP8Y6DtqN0lbAmbY/3Z5xyK
EK6G4TOy2gUQTeaPIdUDZyNIizgczSWp2OptVnjBzlCzentZ0RxnPDlZRW4nG4YHxUcVNNMCYsnT
LSCW3XzPs7ZmZgXC5Vn/q12JuY9DPnBE889prgARTRjdugQrZz/UIA/HF4iJaqRFVHYWv0sfh5J0
Y8dHVRRLRNG1gjd/z4zy2/jr0wgK6Z/9xCzvPQ7zpibWG00yGcQlAWj8WEMtJ3jGN7pjynm3/Qd1
6o68Rbf6T0bHbulnMPhKkkKE9Jv1mlEe0WasjERRQ3EfJVeI+N3vrLlM/wV70jctt+9VE7Mt
--000000000000d4c08c064789f196--

