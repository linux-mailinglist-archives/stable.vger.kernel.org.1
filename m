Return-Path: <stable+bounces-135155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A82A972CB
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 18:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80488188753D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5382900AB;
	Tue, 22 Apr 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C98Az8tJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488384A35
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339472; cv=none; b=h/n9O3x7w7dfwPX0k4r6+jjiKmpSrYML57YOOiELeEMsGWxyAz0Kx6k4Z0n2YQfGU9VOgmGwAsgmbfOm09UNFL8IxIAtdUChGGrSWLcB7ERtFZtxXbHNRYIrclJ9/4fIwQ8zLyb9mGJodUj9PRSdj7nmmqSq8roJ7xDQpSg5xi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339472; c=relaxed/simple;
	bh=jgtclGIYMxmMr5hKAcQQ6ne+/06R77FdIz70kFwatdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTNJ09zqwSxJqEXj7uThp0HbLeOhS5Qtr3l5O1wgNx2YJm98QX0SnoYGSabcbvnHkWnfwsDVPzjVlia339LfDTBz/xeDrzN9LLfXOmBblXMG0d59GjZwhkD4B185GIqMvpNlE6nYsivWnM0meWMPWjW0CMjMrnZOYcrwrG6fj7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C98Az8tJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30549dacd53so30849a91.1
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 09:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745339470; x=1745944270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jgtclGIYMxmMr5hKAcQQ6ne+/06R77FdIz70kFwatdA=;
        b=C98Az8tJVI+9i/kVc8C10u+VlLePeqnW0f7MhQlYMz1vw0aHd+dZlnm8z05bNOozXO
         Q++sUyEULYfk3EfRO4kkBlOGHg8xkUk/b+QruswNJkhhJzDvhGCgieC1YCeF+LvmNqCx
         kdaSBfs1wCrlrpS8Ep0JaVpYLbplD8FKWj31E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339470; x=1745944270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgtclGIYMxmMr5hKAcQQ6ne+/06R77FdIz70kFwatdA=;
        b=VTS+OjY5WRIpIjQJIzMitMcZS5FwrLRTEYsMcwx6FNK54wZHWJjnxCyL3AoQIgYzek
         lNW4C4qfbkQo/rpTxpIUBXrlxUpNcgdI0NAs3nxSXdB3Fi7kzBN/02U5L0RSQPl14kXm
         FYXGyNTJ3hqMivvM2ubXyRv9cGlJl4pwInSbqONwPeHSPqHORJIydG2Fmm4qXw/WGMKj
         Z4EMGFrpPBl87Er0v0n2tlbXs3r7MgUibVkFoPXFdQz40S3mteDHG1I4WuNpuinUS9tX
         b5xns4r18EWYMw4GiOA0ioYy864FkDrmdM7BekxXBv6oCpXh53aW4Td5d0elAT8cmM9U
         4CuQ==
X-Gm-Message-State: AOJu0Yxd05OQP5oIUGYTz5g325YN7O3c1l/C14qC6YrIBK0wlCQhNOGz
	ZYN1NMkibi4wtHDClzDiYcZRipY0p8QkkpIJ/bYygKx1sf7zrSYujdBe6SHxzy8OiEXP/fHWoUg
	bpr19ZEwRoq8yxNKFobnvqtbfZR9k5mjZUVwU
X-Gm-Gg: ASbGnct6j9+yc7UuwZMLzSKeWqz9H/x8XxsCScuTTfGAkyQCrLfC8P53sGb2jtL3Dsu
	4o433nZE1z+brxx8wTTp070Ntrqw9wKeHUPQZ1CPI3z/oB6NHeAwGp2EJbRck6S5a8t32KSAYJW
	cDZO39jl49XYD7DkC75Yz8BPY=
X-Google-Smtp-Source: AGHT+IG/WOvnz1m/ML7MLmg75OE0YM6kc2ULFI/vD29W9fcGb1BYFdX+scowv4H9DOYLRHVKhQXnQDlN8FMYsL/aGjM=
X-Received: by 2002:a17:90b:2802:b0:2ee:5c9b:35c0 with SMTP id
 98e67ed59e1d1-3087c2ea0fcmr21005809a91.9.1745339470345; Tue, 22 Apr 2025
 09:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025032414-unsheathe-greedily-1d17@gregkh> <20250324204639.17505-1-kamal.dasu@broadcom.com>
 <20250324204639.17505-4-kamal.dasu@broadcom.com> <2025042242-wildfowl-late-9470@gregkh>
In-Reply-To: <2025042242-wildfowl-late-9470@gregkh>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Tue, 22 Apr 2025 12:30:33 -0400
X-Gm-Features: ATxdqUHFLNw1ExAxDxTY7wzVD0bSWA0duxIxoZMvrcJCjO4seEMMg9HqdWzOkaw
Message-ID: <CAKekbevzJ=-dzxRh+VyNvmJQq-q5ZCA8zxGcvqqgRJaWWakNZw@mail.gmail.com>
Subject: Re: [PATCH 5.10.y 4/4] mmc: sdhci-brcmstb: add cqhci suspend/resume
 to PM ops
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002ab82606336083e1"

--0000000000002ab82606336083e1
Content-Type: multipart/alternative; boundary="00000000000024af4406336083b5"

--00000000000024af4406336083b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Should be

commit 723ef0e20dbb2aa1b5406d2bb75374fc48187daa upstream

On Tue, Apr 22, 2025 at 8:13=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:

> On Mon, Mar 24, 2025 at 04:46:39PM -0400, Kamal Dasu wrote:
> > commit 7116ceb621274510ccbc7e9511f44ba6c3456ff8 upstream
>
> Not a valid commit id :(
>
>

--00000000000024af4406336083b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Should be=C2=A0</div><div><br></div>commit 723ef0e20d=
bb2aa1b5406d2bb75374fc48187daa=C2=A0upstream</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, A=
pr 22, 2025 at 8:13=E2=80=AFAM Greg KH &lt;<a href=3D"mailto:gregkh@linuxfo=
undation.org">gregkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On Mon, Mar 24, 2025 at 04:46:39PM =
-0400, Kamal Dasu wrote:<br>
&gt; commit 7116ceb621274510ccbc7e9511f44ba6c3456ff8 upstream<br>
<br>
Not a valid commit id :(<br>
<br>
</blockquote></div>

--00000000000024af4406336083b5--

--0000000000002ab82606336083e1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DxuNuBlySpn/GYqPcDcRZd8EENWqnZrjtjHMk0j7ZfrPGXq8sQkbG3OX+DOwSaefPRq1pLGWBZaZ
YuUo5O7CNHo7h7Hc9GgjiW+6X9BjKAzSaDy8jwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdrYW1hbC5kYXN1QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUcRYSWvAVyA3hgTrQ2c4AFquBsG0wDQYJ
KoZIhvcNAQELBQADggEBAIKB2IOweF2sIYGBZTDm+Hwmhga+sjekM167Sk/KwxxvQFwZYP6i0SnR
7aR59vbfVQVaAiZH/a+35EYxP/sXaIM4+E3bFykBuXwcGEnYyEn6MceiOCkjkWQq1Co2JyOdNvkP
nAxyPoWlsJtr+N/MF1EYKGpYMdPM7S2T/gujjO9N56BCGu9yJElszWcXHmBl5IsaQqMS36vhsV0b
NxffjNkeAdgfN/SS9S9Rj4WXD7pF1M0Xq8gPLCLyXrx1i2KkYOYJsj0PWlC6VRg6E1xXkYDte0VL
fAAG4QsETU27E1HBNQyp5zF1PoPCPvq3EnWQnbLgYk+Jz2iwIUwiqwr/bDgxggJgMIICXAIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw89WX2Pp7ue922QVkwDQYJYIZI
AWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIJEQ7c3e+Z0R6nCj3Nsq2adyU5eOF1TUcoo7Hr7y
l3pVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQyMjE2MzEx
MFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIB
AIQzmthzuI0WVh6Xq+uXavvDVx8N/w6dajF8aT1+509rEwL2nhBcvk457Ubmp1os9FKsGQaowY3U
yzGnv/l9qUv2uNsWmDLfAKVZAQ57LYCksQF6RYkfbuPs6andOLMhSjyYZwC75WcGMKmJDv8Znql8
a8WBUfItKqArfFbmWnjZbwHELzQ/uYXslWYdvaAu/X9fF4RVKScdda1xpKhY8w7uPv4Pys3wCH+s
NFQsEjVvG2d+bC32f+KMU+dnM1sI+ieOjxBzvkezAv0jreItYPXiCEeGJRL2L/koUrymGK92hlEo
sz/js2g+EGMux6QAyEg+1zQEGMUkYKeGPxfX2zk=
--0000000000002ab82606336083e1--

