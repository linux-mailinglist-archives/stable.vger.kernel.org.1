Return-Path: <stable+bounces-199958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E480CA2648
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 06:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1699C301A711
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 05:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00282C0299;
	Thu,  4 Dec 2025 05:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WtuQH4lH"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC3198E91
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 05:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764824780; cv=none; b=f/bPU/gF0HNoMbeVMoinvV+SEbt2k9HY7/cEO3UDe8/cCAYa5I5fyLeNfxuuHIONVCMB2lkRcE4DZ0lc0SgM3nClONfjbKIUCzlivu83vkbmyF2hWmuS5Q/oilF+yYa5C9awupuxXD2US3kZ8z4sP44WvcuS0gNoEHhBwP15p0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764824780; c=relaxed/simple;
	bh=Ko7er0ytImledpl4/p7GJHH+mS070MPSSjCYInQlaF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=di4NDZraNVCSPtmAEXumSAMI6FMmIHF+3ZeffvM6mhAITF103nGdN2cbquj5+IVNyUuB4cdek2uRi9Bi5U4AvJz7jtkdyH4w4Q6puwOO7Ue/eBPCg5MlMjufCtKs/P9QMU9GO/NWAZPGK58uR8TX4U9g//fmveqXfhJv4B2bVKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WtuQH4lH; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-641e942242cso559090d50.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 21:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764824778; x=1765429578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3HpMMahHcu5pa9O1OGW1WOvG6ODQZNTxJ3CeJQD+Y8=;
        b=Q67eVx8h3ugwBchrU92f2pZ0cnrzRl9i6gGfzy2TPu3qe5vadnXTQTofWWYysPgWhP
         iBaRdyrzgf9XBE/4WPEdn93CFFbbVc79mi23oLYgxsac4w5/lW7anoUdZKDDeIhcfuh2
         AfyK4X2Z6GFuOp6oLiEdsijjZfZdun+UihR5xkkxZlrJwppIxQhjUoGaybvdL8jwJpdv
         rSbmb9eSSkwDAX215lJ84NTByCA7wMI9e4NAhPsxsVBxElChVw63iOD3IRoBX4mTzmb4
         2ZnkiB3KIVMuXykrXCYZIbks/YvUvNPHFvrqrEmqT2KtQ3MiLbZorE13rM+UiDZqMi1J
         OtKA==
X-Gm-Message-State: AOJu0YyWX9fdmKXni+ZDPE11tOJXDZ1xyeUPQRSuF5lgdsCP195GKNS0
	ARGetl2ghRldymy3pGvKFAEZyRDUN42vn6IDTZkJM6A9Oi3+gi6bewdjqWYg7tQVZ/UIBKm/SQI
	pt0H5qB7S8u4N0oDP+eFzWpnXqdF4hZ8318ZZI3KZQEgA8K+V7R4+mSl+qOTEfSaExBeOkxt0Lq
	E4QfAzoXe9ZXnrVSckbAUoIHHNEgFPdfleDxxaKeuJxQT1tNMTp6SExjzYfu/SXj5NB/TCR7Xkj
	KL0P3sHuU8=
X-Gm-Gg: ASbGncvRP9BqNwUA4lo4URT+X19oUhzNiIKoKd4v/0RSxp8XdCZh4sf4ksIVbAeE4ke
	H9EbXgd7mfv1pEVjVOQZAxDgjk7QT/mvjyaRs3xosYrhcw37/MyEMym/yaoo273DA/rscVolVn6
	fDAc50z5timaooDDZWqRLDXKgarW39eQb1ilSyPyNNOR7pQwa00eRBKisto+jTef74se/Kd5YFA
	BjpKmABI6E2wlbpL9ayqzz4K4PVxcaREfVTFj8QOOe/l0JAhe1344k4UeWIFxjaFbcw7bar6pop
	Jc0HbkNGv2db5nDAhfHDrW8YO6v2l0rGRCwlAoTF3ACBm8HBOYKcbH9G8AZEOj20h2SQMk8+Ldq
	guMJ2tr50lX+z2Pd+0QLzOv7CIotZmTvaYAoyYyBuu8kX1aV2G6qRu3oyK3sWZabwzyF2AVv4Fn
	cO/WJsqyujp0M1yfjnm6OS6dIiliwGRYbSJMaA1VSAPL0Y
X-Google-Smtp-Source: AGHT+IFn+uP3FeZo74DHgP/21Q73ffSZfUAB9jO1gZAZeLV8KwCEAnd7o4DjvNiwECRnb666ccgx24ZyNRt4
X-Received: by 2002:a53:ac9d:0:b0:641:f5bc:6993 with SMTP id 956f58d0204a3-64437097080mr3596903d50.79.1764824777824;
        Wed, 03 Dec 2025 21:06:17 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78c1b77fc77sm340367b3.15.2025.12.03.21.06.17
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 21:06:17 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5e3e7dce304so1071521137.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 21:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764824777; x=1765429577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+3HpMMahHcu5pa9O1OGW1WOvG6ODQZNTxJ3CeJQD+Y8=;
        b=WtuQH4lHMG7gz8HVl8gz7SWvPwOrBjVUSHJd7z2xqWcPk40EninTrFcsJH1qd+de7P
         ZSjeNpEPd8/UP0Xx6/2EEndf54DMH60X5RzQ0heB0WeMPGsB5PSnlVFTFOgq70Erm6ym
         HHA1QYXdSM2qJaNE7dijZ/P6BkUvteDB1egp8=
X-Received: by 2002:a05:6102:2929:b0:5d6:27c7:e6b2 with SMTP id ada2fe7eead31-5e48e2229e4mr1958165137.3.1764824777004;
        Wed, 03 Dec 2025 21:06:17 -0800 (PST)
X-Received: by 2002:a05:6102:2929:b0:5d6:27c7:e6b2 with SMTP id
 ada2fe7eead31-5e48e2229e4mr1958151137.3.1764824776720; Wed, 03 Dec 2025
 21:06:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203112027.1738141-1-ajay.kaher@broadcom.com>
 <CAD2QZ9bGLRL5NyUak-=dDPyTkmrzu-22Q2tURfxUmM9Rs+c72Q@mail.gmail.com> <2025120310-likeness-subscript-f811@gregkh>
In-Reply-To: <2025120310-likeness-subscript-f811@gregkh>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Thu, 4 Dec 2025 10:36:02 +0530
X-Gm-Features: AWmQ_bkIY5TJAz08FSpbSLSoY0CC03ILAkvf6OjAaRk2GpRi4dDoDT4NTOCAk4U
Message-ID: <CAD2QZ9YieLCTC2Xmo_f3VDgyFOYTbOMbvW8QCWMoHjf6Co17nQ@mail.gmail.com>
Subject: Re: [PATCH v6.12 0/4] sched: The newidle balance regression
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, alexey.makhalov@broadcom.com, 
	yin.ding@broadcom.com, tapas.kundu@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f1f25d06451949ee"

--000000000000f1f25d06451949ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 6:46=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Dec 03, 2025 at 05:23:05PM +0530, Ajay Kaher wrote:
> > Greg, following upstream patches will directly apply to v6.17, so I am
> > not sending for v6.17:
> >
> > https://github.com/torvalds/linux/commit/d206fbad9328ddb68ebabd7cf74133=
92acd38081.patch
> > https://github.com/torvalds/linux/commit/e78e70dbf603c1425f15f32b455ca1=
48c932f6c1.patch
> > https://github.com/torvalds/linux/commit/08d473dd8718e4a4d698b1113a14a4=
0ad64a909b.patch
> > https://github.com/torvalds/linux/commit/33cf66d88306663d16e4759e9d2476=
6b0aaa2e17.patch
>
> Please don't use github for kernel stuff....

ok.

> Anyway, these are not in a -rc kernel yet, so I really shouldn't be
> taking them unless the author/maintainer agrees they should go in
> "right now".  And given that these weren't even marked as cc: stable in
> the first place, why the rush?

Agree. No rush.

> Also, you forgot about 6.18.y, right?

Yes. However, upstream patches will directly apply till v6.17.

-Ajay

--000000000000f1f25d06451949ee
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
fEfjRz/Z5b6J+pnCj2dzb2Wir3qx4rt1/aShjQasncmTZ0r8rOk2G3RmKolDmTmWPMeCgzL2KeQs
QRXTsKFFi0np4iUyWo+MDCofsswor1HkoXwlmoIAdrFL+cw3qvOowpOB0pe3+G1rWNvJvYsOAzG6
2a8X0kwMSTEGjJgAX+jQjqwdP8C4ZxmE7n236E9GiM8kfhFFAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF2FqYXkua2FoZXJAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQkdXtSp1Dzqn1C33ctprG/
nnkbNDANBgkqhkiG9w0BAQsFAAOCAgEAQbg6h5rEci8mKF65wFYkl7cvu+zaAia4d24Ef/05x2/P
WAuBmkkDNwevol3iJzQNwlOuR4yR0sZchzw7mXSsqBhq1dgSNbReQ0qJU0YWze48y5rGlyZvCB1Q
Z8FbyfrHGx4ZQJcjB1zeXJqqW6DPE5O8XOw+xTEKzIQxJFLgBF71RT5Jg4kJIY560kzMLBYKzS1f
7fRmy20PR3frP6J2SwKPhNCsXVDP3t0KC5dUnlUf/1Ux2sVe/6G8+G7lBCG3A1TaN4j9woYHN7Y/
U0LCVM46Gf7bFsu7RzwcrKtSOnfJ3Fs7V+IWCrTMvbCSQylAy3+BMkMGFZ0WwtXNLxbYIEhKAZmH
npugOtDKS6j4LkLxkHr/dTYZvfdOXZXTIlz8qTfkTKw4ES4KW3EGzfnRZCL2VD27/GAtt0hwPWrY
HL087+VQLA9RUVdfnigRjZOPWo//78ZaDd9PPWbLKqa6EIboR2nSV5miF9fQinDnxToBGplQEcXG
WwCF8syc/0n0xzLlb/IOwxmkzMizN/3/vVp5eGh64OGdhSwzZDBQuVS08Wgfd3nVHT6zh1F0jBgZ
ACv82jjjtABB+Tg1VZ0vcRr5ZzTC1WylB7ik6soemgWAgbrQfhNh0uHr9jq+NAbTA4wqUK6gA5LP
kPwzH0/UqVP+eM3EQII1r4Uiee8YifwxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgwc6GO95nPh0DhXVGYwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEILj8
nnCCkOBlr9R+LXZtV8jpo6BViHCsyB92JMvHb8WbMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MTIwNDA1MDYxN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEhe3eWFHmJa2ywGDTiiBK1hxfFzaxXdh17SfNtp
FKNgs6snSt83AffyxjqLmCRtm+zLLGntL+/6ZcUAMu2nyQIbgFqKd8klf/Syv9l917IElhjof0Tr
wInnLZt5gExt62hFmJ5zwLv6+u3EoafJiqvdOzqVW1N2HMpcR52CjCgq6Ao07p0jR/h79lzXGb4R
yvLgZvw9sM68E5r8/vAWAcs9vY8JdV5AKcOJ+lH3GgRRxiLy4JI9POgXUg5rn/wt5FL57xgYCubU
DcM3K9JBB3uH/3ebJSV8bvyoMd0j31bo7uF1IOe79gIfFj4nVPGjjM369t0RqivQxHW9As+KJS8=
--000000000000f1f25d06451949ee--

