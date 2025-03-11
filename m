Return-Path: <stable+bounces-124039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAD3A5CA49
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE78D18967CD
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EAD25FA17;
	Tue, 11 Mar 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IKpJOb69"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D0A1C2DB2
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709220; cv=none; b=RQI0w6QQJhY8I3UrYfkN4+7Y+9Li2IN9NM9kSqXzZe65VciSzBehHAEx1alh7nLr4GQ0TdgoU5I8G5tnY/zzIiVcYjMfx+9j/hjziluThSe7wO/e0tCXOVsDL9rEqs2sGuN+iWkL2ykp+5EZdxH3U2BlltEaqT0rnNu+KCAxibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709220; c=relaxed/simple;
	bh=Gv4NcRvfFYy171gwcH8TG4cbNpP/XZq7QSncgnYXRAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LADl4KAFsWxKyp12PH2s1cK8jHIo46myH7PyNk2SKhoX7bM6DLfgGKoXHLx6X24zq1jWoLoPRTCzIo9DOdjAYOI/kAzxvkoUTx6w3UsVYEkZ1yLyDM+o+cmnRBlfgk5WTNneJrnVkiIjFMCQaUbVAxOWf/wc24+mgbmc58TRF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IKpJOb69; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso9675695a91.1
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741709218; x=1742314018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OuBUqRj/1FqUJ1Aq8K/Qn/UROi8EiP5FLwbeK6/DGjg=;
        b=IKpJOb69wTx/YlUdZTYnYPyk2C7+Dnc5DqHQAg6XaNsjQB1cb+kfr8E5YN8g3gm2Yp
         Nss/MqL0f7r0wQhtKz5adQWY0J8LYfXmLw4dG1najkeILS6dBEyUzlvhVeC3o00BtB1B
         ae2lKsReeokf8mDII+s75t182OuN3JNjBKyZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709218; x=1742314018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuBUqRj/1FqUJ1Aq8K/Qn/UROi8EiP5FLwbeK6/DGjg=;
        b=KVq+dMnOfjdsbpnx1FglX4ZmEy/BD9lzEYMh4bBdxOyGcOnBOUt0cBt5WJziqskhyW
         JT5+oW+0LzZ9dbWPJvbhehrBYv5T15cXIuV/MqtpKYI0eWEIq//OcZiHPr+kNTtemBV3
         b5+DepQ10yKsCpiF21ZdwWc0Zlny+fisd1Q+48nvQulVWq7iE83JRN1aHyZXMmxtOcko
         4Agle0EQW/u2xHr4RH7TQUeC2Ot39r1XAdL23ng+uLp6aD0jaMLT/Dg5wF9yosNPmml6
         Q9nzFiiDLzJ0BmQHxdKl0GH72sYZKp5HwCxNv2nTETDBeqwwd6u/h8u4boQ6v9x3fUfi
         cifQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxuNEbAaswMXn0V2BF5pM6F0/njJRz4Q4qCsOMISdRGVyCjfuIgIZ2bpvNgqZBFb+yhbqaDYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAJvntlWCkQHG5v4VhqyNlUqbHC95cyPGywsTJMXb4qYYxEHdd
	8Zm/ZXzFYs4/zfY7IwJtpl2MVB3zjEwqWz+aIQsWGyLOKzGby7dVwjL3PHmE8iFclgqOjdiDX2l
	tyU1NCzWTm86P18iTU6Jpzy/KAF8vnw4ax52Z
X-Gm-Gg: ASbGnctGfrUyEc5HH3sEVFhxn2EDi7SiaRCFcs55APGVPt2o76COFB1IPaFDm4qZDf1
	gHUmDWIAEwCLqSwXnpV61TZtiWiVVdC1PZ3urSBwJI8LG3XzU2CzEiYIRCTiWCPBd8+KfEbucEP
	NkgocDYYnrlHBzrazcKJonRra8lvE=
X-Google-Smtp-Source: AGHT+IE36fk6W16fZ24D9Um05YI34qYQeMpFD/Fu13W3g0zHxL6+gSNZuwbSkxqQdxCB8t1MRNP32lKWlS+bzVOdJuM=
X-Received: by 2002:a17:90b:53c3:b0:2fa:6793:e860 with SMTP id
 98e67ed59e1d1-301002eadf6mr5953818a91.0.1741709217074; Tue, 11 Mar 2025
 09:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311150136.46938-1-kamal.dasu@broadcom.com> <aa4284fa-1f68-4c7e-8d58-1c5129adda27@broadcom.com>
In-Reply-To: <aa4284fa-1f68-4c7e-8d58-1c5129adda27@broadcom.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Tue, 11 Mar 2025 12:06:19 -0400
X-Gm-Features: AQ5f1JpSi62VLJlBuC0dak2KFHVpwzvRvnj9P8OVAxmHNa-s7uCtBu4nwXoQ5HI
Message-ID: <CAKekbevwB9Nd36WNkuh6Xh45puf3dPmfHDKgQBgUEVApbTm2rw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Al Cooper <alcooperx@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000042e290063013471e"

--00000000000042e290063013471e
Content-Type: multipart/alternative; boundary="0000000000002fc6fc06301347ad"

--0000000000002fc6fc06301347ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 11:46=E2=80=AFAM Florian Fainelli <
florian.fainelli@broadcom.com> wrote:

> On 3/11/25 08:01, Kamal Dasu wrote:
> > cqhci timeouts observed on brcmstb platforms during suspend:
> >    ...
> >    [  164.832853] mmc0: cqhci: timeout for tag 18
> >    ...
> >
> > Adding cqhci_suspend()/resume() calls to disable cqe
> > in sdhci_brcmstb_suspend()/resume() respectively to fix
> > CQE timeouts seen on PM suspend.
> >
> > Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command
> Queuing (CQE)")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> > ---
> >   drivers/mmc/host/sdhci-brcmstb.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-brcmstb.c
> b/drivers/mmc/host/sdhci-brcmstb.c
> > index 0ef4d578ade8..bf55a9185eb6 100644
> > --- a/drivers/mmc/host/sdhci-brcmstb.c
> > +++ b/drivers/mmc/host/sdhci-brcmstb.c
> > @@ -505,6 +505,12 @@ static int sdhci_brcmstb_suspend(struct device *de=
v)
> >       struct sdhci_brcmstb_priv *priv =3D sdhci_pltfm_priv(pltfm_host);
>
> Missing an int ret declaration here, otherwise that won't build.
>
> oops will fix it and send v2.


> >
> >       clk_disable_unprepare(priv->base_clk);
> > +     if (host->mmc->caps2 & MMC_CAP2_CQE) {
> > +             ret =3D cqhci_suspend(host->mmc);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> >       return sdhci_pltfm_suspend(dev);
> >   }
> >
> > @@ -529,6 +535,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
> >                       ret =3D clk_set_rate(priv->base_clk,
> priv->base_freq_hz);
> >       }
> >
> > +     if (host->mmc->caps2 & MMC_CAP2_CQE)
> > +             ret =3D cqhci_resume(host->mmc);
> > +
> >       return ret;
> >   }
> >   #endif
>
>
> --
> Florian
>

--0000000000002fc6fc06301347ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 11, 2025=
 at 11:46=E2=80=AFAM Florian Fainelli &lt;<a href=3D"mailto:florian.fainell=
i@broadcom.com" target=3D"_blank">florian.fainelli@broadcom.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 3/11/25 0=
8:01, Kamal Dasu wrote:<br>
&gt; cqhci timeouts observed on brcmstb platforms during suspend:<br>
&gt;=C2=A0 =C2=A0 ...<br>
&gt;=C2=A0 =C2=A0 [=C2=A0 164.832853] mmc0: cqhci: timeout for tag 18<br>
&gt;=C2=A0 =C2=A0 ...<br>
&gt; <br>
&gt; Adding cqhci_suspend()/resume() calls to disable cqe<br>
&gt; in sdhci_brcmstb_suspend()/resume() respectively to fix<br>
&gt; CQE timeouts seen on PM suspend.<br>
&gt; <br>
&gt; Fixes: d46ba2d17f90 (&quot;mmc: sdhci-brcmstb: Add support for Command=
 Queuing (CQE)&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable=
@vger.kernel.org</a><br>
&gt; Signed-off-by: Kamal Dasu &lt;<a href=3D"mailto:kamal.dasu@broadcom.co=
m" target=3D"_blank">kamal.dasu@broadcom.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/mmc/host/sdhci-brcmstb.c | 9 +++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 9 insertions(+)<br>
&gt; <br>
&gt; diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci=
-brcmstb.c<br>
&gt; index 0ef4d578ade8..bf55a9185eb6 100644<br>
&gt; --- a/drivers/mmc/host/sdhci-brcmstb.c<br>
&gt; +++ b/drivers/mmc/host/sdhci-brcmstb.c<br>
&gt; @@ -505,6 +505,12 @@ static int sdhci_brcmstb_suspend(struct device *d=
ev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sdhci_brcmstb_priv *priv =3D sdhci_pl=
tfm_priv(pltfm_host);<br>
<br>
Missing an int ret declaration here, otherwise that won&#39;t build.<br>
<br></blockquote><div>oops will fix it and send v2.</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(priv-&gt;base_clk);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0if (host-&gt;mmc-&gt;caps2 &amp; MMC_CAP2_CQE) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D cqhci_suspend=
(host-&gt;mmc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return sdhci_pltfm_suspend(dev);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -529,6 +535,9 @@ static int sdhci_brcmstb_resume(struct device *dev=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ret =3D clk_set_rate(priv-&gt;base_clk, priv-&gt;base_freq_hz)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (host-&gt;mmc-&gt;caps2 &amp; MMC_CAP2_CQE)<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D cqhci_resume(=
host-&gt;mmc);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0#endif<br>
<br>
<br>
-- <br>
Florian<br>
</blockquote></div></div>
</div>

--0000000000002fc6fc06301347ad--

--00000000000042e290063013471e
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
AWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIFI8CS7ruiokp1AAnPPloQL5mWMLRhBc5BZqZzDA
EMlUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMxMTE2MDY1
OFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIB
ABglf3sIsmAe5TJQX4ezh8yohJ7UJU/zdGG2edFl0TexHW/cNxDmAqJAjDTSTf0jV4P+BggtWBk3
0Zy3MKcKaHYkynhnHIkUb57ruuGZt1HDnroORnqeqMNFBEhX7EaID29iL2XnMEviLk1YyyHykwX0
vjkQ6OFtO5Vjz8OLuWb05KP0oqqc/4FVJJ3tSl6B/BlaYDk3XefIvjy67KOwfv8Xkgh+x0YRhrvx
7P3q8qzKes9eK1ownmvvQfR0LxIn8/7Iumc2a97szTpY3GHKPBsasjUc4ZURytGD11CgZPqZTsBm
MIaeI8fvbOzA7jZRiF/QWyjzQznL/V6RBWSb7rU=
--00000000000042e290063013471e--

