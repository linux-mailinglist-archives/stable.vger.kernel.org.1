Return-Path: <stable+bounces-135157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C03CA972E1
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 18:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14873189FC23
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 16:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B31293B6B;
	Tue, 22 Apr 2025 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EFBde9s9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD0228F939
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339842; cv=none; b=CdweekFbSWTnTiGW4u+/zLYK8PyS6NLdKICR24+UMwV43CvlJNNrbWvU9fWtLjHx0JYi4aDmSJUpgj2F7tLAbc0ouWT0uphO8KfeR6aOQ1OkWF+0HDmdeMm4cCxHsREGsrFQTO0zwjzgTGcGUR8GRcp861PThaXW4IAhwtDXgdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339842; c=relaxed/simple;
	bh=VoeDodQoqrdD05E0gVc9ZrhWPxMU9fIoQD7UZWs5Ork=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1eX3gyxIkqxrpjmwHu2VSgwL/gpPRq41Xps/TfP3vj045GA3rDW/t7WfX/mmOMdRNksVqKmpVPqNLj/ZBqYXu12fnBfIBmpqRredeXAg87C/jkddAMaRu6v/Ri2tlNqJYTwgJ7Hxyb/gj9hBBsvCA7KJGxKFe7T/6Eu+U3Rwxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EFBde9s9; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736b0c68092so4597571b3a.0
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745339839; x=1745944639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VoeDodQoqrdD05E0gVc9ZrhWPxMU9fIoQD7UZWs5Ork=;
        b=EFBde9s9dT4LMkdzK8VfIwrYzIIr9LX4QnR4GsCvf3tiTSwO6FUdmPxTA9pFGmkiWM
         94SinV8sFNoAAUQG9LoNf7TY6lgkPmmrD5e6oxVLuK0HPFPcgowbp0Rqia6rVZPkag76
         BgUs8w993WqYRkPRCyIr3zxjuS7gfIDOcXXYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339839; x=1745944639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VoeDodQoqrdD05E0gVc9ZrhWPxMU9fIoQD7UZWs5Ork=;
        b=YCPa8eWusqZItbX55XETtJtdepwqsACCw/gq+MyUlHR6awYHWUOJ+zPGMRD06GQTF8
         0X/1G3MiB4xobucb3sIMgKV+dG1CFh8dBVcocTop3FYyuPLev90O4W/56JGJ1cG7Qmx+
         6ltcR2hF1UwGorwN/oFRzeCgiINdXweXM0ma3zUAEYCf6hPazunrrmjwKai9h7J+dPgs
         xEyjpieAJ05g+HqKzS47k0RO2jEQomNENP07fNo2as8jtPD2VnqD5DGIl9vCPMZuaqdk
         Zgvq2507bdq4SKJi9DvEndUlQaboD/FSfoEf5cM16QUhtSVRQcY3UWG9/w4mBrOq/ilr
         ETpw==
X-Gm-Message-State: AOJu0YwXbVMFBnA3j3ze6E2c3nK2/vJWelH5re/pQyWQouHJuSIu1CC0
	bkxSCkaBhcfRAFaCO1uA+Kc43/sOfLQyxpnYs+BlCJMIctVepwiW7ElpdddN0WLiePXMTFRAmof
	N5LDXppQwIlkRbX+lh9Fb5b/KWpYeGeWDq+sWduRjS77ZIsi9Vg==
X-Gm-Gg: ASbGncv90mFlLat7CT7fup/XUoWXhLySObFJpM1LjciDI1DbOcqlIosI/+wYf4X7zMm
	M7MJCkUV4NofZf6wU67n+aZQvLjp00ROAJ9cGf7tUQrBmzdAHjrjKUsK8tXaILO1HSdS9LvgyOP
	nkJjCHT5b3eAuGmqoWlMUs6+E=
X-Google-Smtp-Source: AGHT+IHJqcg3Y81UgamEVev6/mvztmmdM2swuYvPWopz7os3r5sNU/sTd5vdZzsFuz+A0YMw6oGtSsufO+ULbxeELmo=
X-Received: by 2002:a17:90b:1d4e:b0:2fa:228d:5af2 with SMTP id
 98e67ed59e1d1-3087bb623b5mr21777339a91.15.1745339839267; Tue, 22 Apr 2025
 09:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025032413-email-washer-d578@gregkh> <20250324221236.35820-1-kamal.dasu@broadcom.com>
 <20250324221236.35820-4-kamal.dasu@broadcom.com> <2025042202-profile-worshiper-c2b0@gregkh>
 <CAKekbevHy0v78=3QmDeOWTXCX+oj5zxixw19Wz8VKLByA+MygA@mail.gmail.com>
In-Reply-To: <CAKekbevHy0v78=3QmDeOWTXCX+oj5zxixw19Wz8VKLByA+MygA@mail.gmail.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Tue, 22 Apr 2025 12:36:42 -0400
X-Gm-Features: ATxdqUHav3Hw3xpbkeQ7UHRvFp4T6l7tpw4hwF7LM0i9u8Tiug49dyw1eSUvxGI
Message-ID: <CAKekbetDRWC5FfO1KvcMrwbUwr2V3MWX6_YQHifOd+J0KWSEaA@mail.gmail.com>
Subject: Re: [PATCH 5.15.y 4/4] mmc: sdhci-brcmstb: add cqhci suspend/resume
 to PM ops
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000025f2690633609972"

--00000000000025f2690633609972
Content-Type: multipart/alternative; boundary="0000000000002202a706336099e6"

--0000000000002202a706336099e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greg,

Do you want me to resend v2 for the series or just the Patch 4/4 ?



On Tue, Apr 22, 2025 at 12:30=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.co=
m> wrote:

> Should be
>
> commit 723ef0e20dbb2aa1b5406d2bb75374fc48187daa upstream
>
> On Tue, Apr 22, 2025 at 8:14=E2=80=AFAM Greg KH <gregkh@linuxfoundation.o=
rg>
> wrote:
>
>> On Mon, Mar 24, 2025 at 06:12:36PM -0400, Kamal Dasu wrote:
>> > commit 7116ceb621274510ccbc7e9511f44ba6c3456ff8 upstream
>>
>> Not a valid git commit id :(
>>
>

--0000000000002202a706336099e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Greg,</div><div><br></div>Do you want me to resend v2=
 for the series or just the Patch 4/4 ?<div><br></div><div><br></div></div>=
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Apr 22, 2025 at 12:30=E2=80=AFPM Kamal Dasu &lt;<a =
href=3D"mailto:kamal.dasu@broadcom.com">kamal.dasu@broadcom.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"=
ltr"><div>Should be=C2=A0</div><div><br></div>commit 723ef0e20dbb2aa1b5406d=
2bb75374fc48187daa=C2=A0upstream</div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 22, 2025 at 8:14=E2=80=AFAM Gre=
g KH &lt;<a href=3D"mailto:gregkh@linuxfoundation.org" target=3D"_blank">gr=
egkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Mon, Mar 24, 2025 at 06:12:36PM -0400, Kamal Das=
u wrote:<br>
&gt; commit 7116ceb621274510ccbc7e9511f44ba6c3456ff8 upstream<br>
<br>
Not a valid git commit id :(<br>
</blockquote></div>
</blockquote></div>

--0000000000002202a706336099e6--

--00000000000025f2690633609972
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
AWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIDEaKT8/k31Cn/7Xb2d1hwqyTOjuI2B1QhSqrqN5
mNnqMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQyMjE2Mzcx
OVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIB
AJTXIwGjCNNZ7zvrMUK5BBvJOJNTIhWwF2xCcjEiyH7nGqkjCzTqzHPphaAaF0zBPTgxZmTBSu7G
0f64acUgANMCI7ZB8bxZmuOToxcBJldQI2w90gVEoOBf1dyHMPACCI/VxDbkgendOyjpY/eb6/gE
qZ+5jWpy2WC6rsEP9+lpnQec/QgwlvsfgSJL4ChrAEIk21Oo9AXUlKQwvuxJBJYBRJ3YGiy72hKi
3E7emrTkfJfvbc3xVHvJkZJFOO1a9fbvlg8nRd17P7Q9VLYkCVsZ7Ztw4Oc8JZCLsD0oVR1HnjJS
KPALmVE4uW7SyFcYBedD9lY3pAqLf3f2qBOA0ZY=
--00000000000025f2690633609972--

