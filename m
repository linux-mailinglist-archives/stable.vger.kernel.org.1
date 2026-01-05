Return-Path: <stable+bounces-204846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56366CF48B1
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A263031357C7
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AAB2F9C3D;
	Mon,  5 Jan 2026 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E+1TCqg2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061AC1EC01B
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628296; cv=none; b=LQgNGDPsYQaUVLI+fnbMro3bL9C+n5GIPEA2koQbqt8NKfCB33K6jXPgL7qijSFTf74M1HHEcMi2aagCWKBzMOGzL7domThpV7Uo3YrXEDdbemw/8PcfyV/Ilfz05urA+eWH5vt5ALLvCclTWV2/lKkInckeFFtaGm3+wrs96cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628296; c=relaxed/simple;
	bh=oK/lrXMGzdXHT1/nA3IohClcFlbTXtbBiIjDgyi82bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nvy/5XZ14BUZua8gsV2RbgiRp23O0YFcIwzZrCmnbA8RLEqwaXGrDk0Jbng63Ka81atQW5w61P+Fu013A5yrS2QTp5PqKgexAF40PdBwbsvwN8xTWQQO3JiTOHnBsXBmFlxjV7Q4a5adyWsGBr+Xr1tvwHiE8GuDqFgnvo8UNmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E+1TCqg2; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-c2dc870e194so6191203a12.2
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 07:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767628294; x=1768233094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK/lrXMGzdXHT1/nA3IohClcFlbTXtbBiIjDgyi82bQ=;
        b=YMHJKFSslnOyjudzv8wy2J/mv0GfQtdI4smPX6QCPdu8jiuZQWwOA3J/f7dhXyPbTu
         hCOISRrv9Eq8NHPhaF9LWZFWlgeD0hD0B61hEFFchIs27xx8LW4zkcIe66idyD5y7E15
         +giDLOntwz/k5a+kuwr1mUZcE1T5CqES8DnW37Sk6VRSBPYMyXzmdzp+CS+89Xk/H/He
         tBY7IdU8OFKW88TvUkaH5kt9SGuwQrpgYajSQZPkEfUe4MSoQxhMmEoAayU4XComl/tB
         5WZm9HF2RMMufVoYihhiXJSs3oi5E6Gj61RZhoEeWVsNAQ7fmH7Pm3OiPLDINLkcAbb0
         9SuA==
X-Forwarded-Encrypted: i=1; AJvYcCXTFBQZJdCWpVO9nSeLPCxnTKfCvY1nY2n0prGzhey+RCCrVgF5rPQSlMUmfcuk+cH0Kr82oMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFkscZQIMceLrMvYWOwISjdfn8ESweTdihmx3HThZ0xCxcGLNx
	KdYqVtK9s7CLcxjvI78Y5z34GNXI926jmr76wAS+wlQj6x013xwLLptJ2llg/4CbrYpiaigR8GX
	U8hTOF+Si1neecXFf6KvukvE//1KHoIgFp5jMmO+DMqxA6dLu2s9n44mHMhbyKqSryOmiFzqP0x
	ssIKwdX5S+mZnrivNguRsb/9uqR2N7uOPlBC0Fh0vP34VkUkcxvfRRuiCJfHuJnMsRtSys+oIq5
	MJTxNrot6A=
X-Gm-Gg: AY/fxX7J66qLPyQA42achII3dWzXbogT3sOZqFQd810d/V87lPAxsKWGzxWvR9Tgj1G
	vVBOVQZu907bQC5/Rhp/xJ70RSqtpqZvSmucfPWhNMx5ygZRF5j5vrmAM18CJZBvgJ9E3HJcpB6
	VLhE8kcrvzxATyBy+w1bFVU3UE26OT7WPzsRxEzKmaJIqJAReU3mgtXnsf3cNWw4wUPo1qBiPks
	RFIE8HWqkCRRu6B/iOUskg85kzbVyAgpsYEKpq5L6iMpxcX1ceW+AHQgldWpPiiBzp/KYJMec9H
	nR5W9341KbemMm1OS/rVWVeDSVnP0IviRH2svOeno7nCyLKknH4Nz4G3k03K3b3oPT4eKJ2MLNp
	Cd4YOY1PuYqUYagfhi1DlwADRJGQ6AC33tnHvcgUexTlJC6/4kGG5CQ0Eq3lL3vL3jmekm2/Vjw
	9IVsuScGu+jK+EE6R7E2SJIdVb2Qu/r4IrJwppCnwQk62Lg5I=
X-Google-Smtp-Source: AGHT+IEVxkO8N2igWXC7fCI1GiVnVgDBBIhVQnUKQIyRDXajUMlTFc6NH5tuPOqPc+O7u8czH4sjxqY341TP
X-Received: by 2002:a05:7300:b0a0:b0:2ac:1e68:2342 with SMTP id 5a478bee46e88-2b05ecbeef1mr28676657eec.39.1767628293969;
        Mon, 05 Jan 2026 07:51:33 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b140c61681sm1372833eec.9.2026.01.05.07.51.33
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2026 07:51:33 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a089575ab3so513145ad.0
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 07:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767628292; x=1768233092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oK/lrXMGzdXHT1/nA3IohClcFlbTXtbBiIjDgyi82bQ=;
        b=E+1TCqg2GhjF2BCN+7cOq6JG6fwALwi6rXO+uMUtfEZCE86CFfThwySg9d4NUtZsdY
         OYbeqfNKt6uubxfSOpI9O4JWV48p5uUmDsZXq/OwGWNjS5/7tRfaUHr2MVA1jCN0JMBr
         TUylO2mM2/oDDYrMR/lv9bqmKw8A0RvXhXJvY=
X-Forwarded-Encrypted: i=1; AJvYcCV+NnCjvHetcKaSfnf0Z4x11Wl0xFiGpgeTC+NDG7su/3so9DXsJ17j3PCQ+fQJF25fmQ0HeN0=@vger.kernel.org
X-Received: by 2002:a17:903:3c64:b0:2a1:e19:ff0 with SMTP id d9443c01a7336-2a3e2d00f7bmr1613915ad.39.1767628291976;
        Mon, 05 Jan 2026 07:51:31 -0800 (PST)
X-Received: by 2002:a17:903:3c64:b0:2a1:e19:ff0 with SMTP id
 d9443c01a7336-2a3e2d00f7bmr1613755ad.39.1767628291493; Mon, 05 Jan 2026
 07:51:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-bnxt-v2-1-9ac69edef726@debian.org> <aVu8xIfFrIIFqR0P@shell.armlinux.org.uk>
In-Reply-To: <aVu8xIfFrIIFqR0P@shell.armlinux.org.uk>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 5 Jan 2026 21:21:19 +0530
X-Gm-Features: AQt7F2oUM47ns1M3ftrROqBtJ9QJsHhV8zfYKwhUbIv5oQ9RNohjq9sGFqDJ_KY
Message-ID: <CALs4sv0s-cJqyK3Gn9X95o82==e8zGcaEeuLHns3VPJCo7v6rw@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
 during error cleanup
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Breno Leitao <leitao@debian.org>, Michael Chan <michael.chan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000077ba430647a6083f"

--00000000000077ba430647a6083f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 6:59=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jan 05, 2026 at 04:00:16AM -0800, Breno Leitao wrote:
> > When bnxt_init_one() fails during initialization (e.g.,
> > bnxt_init_int_mode returns -ENODEV), the error path calls
> > bnxt_free_hwrm_resources() which destroys the DMA pool and sets
> > bp->hwrm_dma_pool to NULL. Subsequently, bnxt_ptp_clear() is called,
> > which invokes ptp_clock_unregister().
> >
> > Since commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to
> > disable events"), ptp_clock_unregister() now calls
> > ptp_disable_all_events(), which in turn invokes the driver's .enable()
> > callback (bnxt_ptp_enable()) to disable PTP events before completing th=
e
> > unregistration.
> >
> > bnxt_ptp_enable() attempts to send HWRM commands via bnxt_ptp_cfg_pin()
> > and bnxt_ptp_cfg_event(), both of which call hwrm_req_init(). This
> > function tries to allocate from bp->hwrm_dma_pool, causing a NULL
> > pointer dereference:
>
> This has revealed a latent bug in this driver. All the time that the
> PTP clock is registered, userspace can interact with it, and thus
> bnxt_ptp_enable() can be called. ptp_clock_unregister() unpublishes
> that interface.
>
> ptp_clock_unregister() must always be called _before_ tearing down any
> resources that the PTP clock implementation may use.
>
> From what you describe, it sounds like this patch fixes that.
>
> Looking at the driver, however, it looks very suspicious.
>
> __bnxt_hwrm_ptp_qcfg() seems to be the place where PTP is setup and
> initialised (and ptp_clock_register() called in bnxt_ptp_init()).
>
> First, it looks like bnxt_ptp_init() will tear down an existing PTP
> clock via bnxt_ptp_free() before then re-registering it. That seems
> odd.

This is to handle the firmware capabilities changes post an update,
like you guessed.

>
> Second, __bnxt_hwrm_ptp_qcfg() calls bnxt_ptp_clear() if
> bp->hwrm_spec_code < 0x10801 || !BNXT_CHIP_P5_PLUS(bp) is true or
> hwrm_req_init() fails. Is it really possible that we have the PTP
> clock registered when PTP isn't supported?

Right, this check may not make much sense because we call
__bnxt_hwrm_ptp_qcfg() only after we know PTP is supported.
Michael may tell better but I think we could improve by removing that check=
.

>
> Third, same concern but with __bnxt_hwrm_func_qcaps().

This case is different? __bnxt_hwrm_func_qcaps() is always called post
fw reset, where the capability could have changed.

>
> My guess is that this has something to do with firmware, and maybe
> upgrading it at runtime - so if the firmware gets upgraded to a
> version that doesn't support PTP, the driver removes PTP. However,
> can PTP be used while firmware is being upgraded, and what happens
> if, e.g. bnxt_ptp_enable() were called mid-upgrade? Would that be
> safe?

Hm.. you have a point. This is a consequence of commit a60fc3294a37.
We never had this situation before.
As it stands now, from what I know, bnxt_ptp_enable()'s fw commands
will be no-ops.
But yes, to be correct, I think we should have a fw PTP capability
check inside bnxt_ptp_enable().

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--00000000000077ba430647a6083f
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDBM+Sd
NVfW5kDmxl530uYXUs1LoY7B+1FS48P9k80EEjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMDUxNTUxMzJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBKQIeESOK1rJAVxKrh496/E4RkIRB0hxQpKkbp1obe
DH4M4AP2W7zSr2U0YMx+smer5Bt0Dli4o8OW9xJ8x87YDz59eSbwqP0bGtomSag3F8R/7QzUaRmx
hI5oQAgu5ZL2c0ZtcXyc7o0ea/oLuBchDE80yaD/8q6CvaBxYOupabugYyOlBziyLtm62RjeOpHy
Vt10rYlG/OSY2VdEZ2oydjLIzyry/eVuegtm2k/DB8M1G5XGqPhy307t/ROtyj6ID+ihi6Drt6qp
JFsAMA6YAII07unNrmfklsVN1ayT8qaoqyMCrzrTwOJZzh/GrAhAIfagDS1GGshdd3y5jqJk
--00000000000077ba430647a6083f--

