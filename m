Return-Path: <stable+bounces-210310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D360D3A659
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64002300C980
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801A33090E4;
	Mon, 19 Jan 2026 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iJDWIvOS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34E357A57
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820939; cv=pass; b=CYNOWvndk7mVMDKohgnEfhTg2is90djMaBfYza/gxshJ3bgYF8IU3IqEZoL7IMg6mQmeRedFvROQ/bXyos8De2JeL8J0iOpFaXiQYUCypJn4c/ckVnjYAYZ/M5fX7tbfWnL1b+4L16NTbabdvJTNF3lpPDaHVLsNWHuyVv7jTYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820939; c=relaxed/simple;
	bh=usYA1Ki1Qiq5nhgzPaqn6EFXe1srsaxLKrApVAwha2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6zaarq51eU5wfdQ6VRCD2Di4PF8Eea1GFvB13o/z1HR5F8o/9ZQHw2a1RgWJH9CGIMeGhb2QXsoZNE30Yv0rtDJY5SwOjA6R4l7cQvMx8brwU+5AqNUPH6env3qmvXfw2RvKpzkJ+m1cyen8H0wCpR0xF0AExbNlMiWRtGLxuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iJDWIvOS; arc=pass smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7cfd53bc33eso692883a34.2
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 03:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768820937; x=1769425737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usYA1Ki1Qiq5nhgzPaqn6EFXe1srsaxLKrApVAwha2g=;
        b=YK/P7wUNFHIsg5XfEacX6LZOYwHC5A5wAZWIOVjBr39spJj117AL0EMV5Jf2aAvWgu
         3Vee62IG7DESNGn4FU22d1TntUsai00E2HwBIUgvqMq6jCphq70/cRppc1qAa1LTGNYB
         qcvEOiO5eQJasvySUxBT10UHh4Oq93AhReG7+74+ukBM2uKeLmVjw4rGVTcnkR0ijO6Q
         m5lMu2ZynpBwBeNw9by4hvWCDUtKDVmkwmbuRZZTg8yhomwGL/UE/xvVJxECHgyBB0Sz
         weM7LhlWNB9opCXp0/K+0bxEo+9cumTHjVvs2lVtL5bVxQ572Pmyw4VZA8WxjAbsf39P
         +geg==
X-Forwarded-Encrypted: i=2; AJvYcCUaz0uS/KpVWDKz94l+xHJBwaCnnk+lgigkoSgZ94H6Mq77ZlZIxt2xBP+uboq/TpIw4zEzznk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2V9zPp/XKfHos6uORGiiW+Kz9yfQVScZKN3NYxEZl8orHRGRH
	9ephjM+faYXnfGmGMNffEC3EdUt6mgCdJ1i8iLiKM0yIGjTdsd1DvpxBZnyF8g2kC0jwTj5iDU2
	xWnEBdAhvX8RiGy/nvQSCCivCGRgT07UsmJovFLEMzb/hQwxDny4SphcemyOEoi1/fQtAFhDL+6
	ru9kWpySGcc7ZoXNptCOFNQlPqqFsYmOArFbcKDai/P3kIT4g4BSX/Ce/SDlkwtB9V0S5vozHX4
	w2ZF4KSonyyicQCSvpFyvpwCMZG
X-Gm-Gg: AY/fxX6Nf4B+Tf9CjvKAAKGbOdgFXha4Ym4qZ+ekjGb/WwMAYBuY87k342lWwfOkMS/
	Q2r8hpw5eunoPyNi/bcyxH+j/nnm56K6tp/dgO8yrwLtUWcS35/n3oIiQ/qBuHI2i63xl0TJcDI
	bHyua82RDI0o2T+AL4769YPUz9ud7drq+1HDpfSL6ba069Ant/NzkU1ptRyfT2f+a3/f6IdJptG
	hvKcnPdCyw/PeS12UjfxtrUIZU9BEnzX1/RkCgVd2PzMw7U2lDwqYIw4BlbsFxYzlnLjXWj2no8
	Piq2+F9+yRwlNDlmhVr4w7TqjEOdau3/WhmOil9PyefUTIHK4Q/lZKr8wxfL2qTt7T7IRUfXj96
	f6vBp5yZ0tzmK8hEoqsYeJejwPMjBt8uqEV9f5/aT+JYl0sl2tp86be6z7l+XrH/kYnqckRoLGS
	1G4Q/peDfS2apb+ZwciEQtgoH7MrqVk7iW2Ba30YsoTp0Lw4KvtLPBSIr+MPs=
X-Received: by 2002:a05:6871:eb17:b0:3ec:44cf:e8e2 with SMTP id 586e51a60fabf-4044c1064d6mr4432784fac.1.1768820936536;
        Mon, 19 Jan 2026 03:08:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4044bd7ce19sm1098967fac.14.2026.01.19.03.08.55
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:08:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-64e4d1559bcso353597a12.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 03:08:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768820934; cv=none;
        d=google.com; s=arc-20240605;
        b=IhgWGV9gAALlxfHlkXYNWOYCXFHyPZb4H6hIX5K9ZaZQVrOIS0xJyCyRdIcP2OHwUI
         6kSnOOBjkDUgwedL+6IcPjIzENXF31y1Pqy3CYwUwPYgJ+XmZb7Wp/x0QE+Mwa0zVhwj
         YM6Eptdx3OlbT+Iw6cr3pb6EyH9Lyqos1BK4QPMdNq8mFF1qCj3+m5A/ytZ29VU2msfb
         xmIlzOr9nxNItvBOUVMu1YY7bhkIBSncHKn6FRwjZTwJoXsoO2TFeSfqKgVcgu4WQxQM
         SNl8cxsicIY9pt8U35eGD22FoKQZbiRh0zEojrpaVak6uMVDqAl+jftR1pS55asG1PuG
         7KPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=usYA1Ki1Qiq5nhgzPaqn6EFXe1srsaxLKrApVAwha2g=;
        fh=5SAMncL73lqlvC0agLRjhu+Wu/0HSoH3uv+9mrpfb2w=;
        b=HmxoFqnpUZB502/5+Uk/9kAtSb/mXa5r5JbJ1BShJ1ZdDi41tJGmQ5HDMUgjpqh0vI
         Q8dUhRHcrC/9qCbVxJj+SLoncqlDPeJetz9Hb7SC+cekojMi5EhdpPuEhn4QkiGCZw3p
         Qpy/Q3ioiCqSPM+8g1zfYxNEM2PTTU8fgRAthtu7XUr2PuEMzCYD/lD7elZBr+pUtvfP
         gps/1z8J2XVD7lMU6dVDW2GUz9j/LJXiHPY5g+USV4GNNq9dY9ZnW+7paHKmIpE4vP+F
         /M7Cs+hTX+a8guzGOBSyy31x6f6aL5vsAQnvXNFCco+jJnyr32BmUDxeQ2+YnFuo6Rla
         /pWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768820934; x=1769425734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=usYA1Ki1Qiq5nhgzPaqn6EFXe1srsaxLKrApVAwha2g=;
        b=iJDWIvOS28xU2sfYfko/1rpepwu7blyrw1+iG8y6Yf/DCpbL1cP8FGjdWewj5qurnk
         z5L6dFFqnXYOxRK/2jXl7W21Nz0lDZ0AGE/Yx05hh9LT7KP8KhmD7uUiEhNNUuhHlxpp
         8LkNCDkTiWEaz6MoelM6aDAxdgYxJBKF1LXrQ=
X-Forwarded-Encrypted: i=1; AJvYcCXKDeBg0M2icdMucY4VcXij8w3vpsBf/Q6sH4xCurn2MdDSvDu2XGM2cXhLws1VS1+nI0Na6bE=@vger.kernel.org
X-Received: by 2002:a05:6402:3487:b0:64d:1bbf:9548 with SMTP id 4fb4d7f45d1cf-65452cd78f9mr4762033a12.6.1768820933909;
        Mon, 19 Jan 2026 03:08:53 -0800 (PST)
X-Received: by 2002:a05:6402:3487:b0:64d:1bbf:9548 with SMTP id
 4fb4d7f45d1cf-65452cd78f9mr4762017a12.6.1768820933433; Mon, 19 Jan 2026
 03:08:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164230.864985076@linuxfoundation.org> <20260115164246.242565555@linuxfoundation.org>
 <4ca8d0770343eae44e19854cf197c76017a7c1ad.camel@decadent.org.uk>
 <CAM8uoQ-F++6iScZBzntmF=KhHRK3=rQvc-oug3KAXPddJPqR-Q@mail.gmail.com>
 <CAM8uoQ_7HD0AtJLqXsRvO=F2knq=BtrdTM2Fv0Dd4h-4oYebNw@mail.gmail.com> <2026011944-wielder-ignition-dee8@gregkh>
In-Reply-To: <2026011944-wielder-ignition-dee8@gregkh>
From: Keerthana Kalyanasundaram <keerthana.kalyanasundaram@broadcom.com>
Date: Mon, 19 Jan 2026 16:38:41 +0530
X-Gm-Features: AZwV_Qg_OXVHwp91a5NRCTbyCx0gv0COFYIkUpPvLFHJiwcfd3eoFI8A0tqxL2o
Message-ID: <CAM8uoQ-NyJQatRYXty2XdiTjsuO6hRmEam_YaNrBbgEUuK6KQA@mail.gmail.com>
Subject: Re: [PATCH 5.10 423/451] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
To: Greg KH <gregkh@linuxfoundation.org>
Cc: patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <edumazet@google.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>, 
	Ben Hutchings <ben@decadent.org.uk>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000751ebe0648bbb71e"

--000000000000751ebe0648bbb71e
Content-Type: multipart/alternative; boundary="00000000000068bedf0648bbb72b"

--00000000000068bedf0648bbb72b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 3:36=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:

> On Mon, Jan 19, 2026 at 03:09:32PM +0530, Keerthana Kalyanasundaram wrote=
:
> > Hi Greg,
> >
> > I have backported the two additional patches required for the 5.10.y tr=
ee
> > and submitted a v2 series. You can find the updated patches here:
> >
> https://lore.kernel.org/stable/20260119092602.1414468-1-keerthana.kalyana=
sundaram@broadcom.com/T/#t
> >
> >
> > Could you please consume these in the next version, or alternatively, a=
dd
> > the two missed patches (commit IDs 5b998545 and 719a402cf) to the curre=
nt
> > queue?
>
> I've dropped them all from the 5.10.y tree now, and from the 5.15.y
> tree. Can you also resend that series?
>

Hi Greg,

The other two commits are already part of the stable 5.15.y tree, so
changes are only needed for the 5.10.y tree.

Please check my latest v2 patchset : (
https://lore.kernel.org/stable/20260119092602.1414468-1-keerthana.kalyanasu=
ndaram@broadcom.com/T/#t
)

Thanks,
Keerthana K

>
> thanks,
>
> greg k-h
>

--00000000000068bedf0648bbb72b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><br></div></div><=
/div></div></div><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Jan 19, 2026 at 3:36=E2=80=AFPM Greg =
KH &lt;<a href=3D"mailto:gregkh@linuxfoundation.org">gregkh@linuxfoundation=
.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Mon, Jan 19, 2026 at 03:09:32PM +0530, Keerthana Kalyanasundaram wro=
te:<br>
&gt; Hi Greg,<br>
&gt; <br>
&gt; I have backported the two additional patches required for the 5.10.y t=
ree<br>
&gt; and submitted a v2 series. You can find the updated patches here:<br>
&gt; <a href=3D"https://lore.kernel.org/stable/20260119092602.1414468-1-kee=
rthana.kalyanasundaram@broadcom.com/T/#t" rel=3D"noreferrer" target=3D"_bla=
nk">https://lore.kernel.org/stable/20260119092602.1414468-1-keerthana.kalya=
nasundaram@broadcom.com/T/#t</a><br>
&gt; <br>
&gt; <br>
&gt; Could you please consume these in the next version, or alternatively, =
add<br>
&gt; the two missed patches (commit IDs 5b998545 and 719a402cf) to the curr=
ent<br>
&gt; queue?<br>
<br>
I&#39;ve dropped them all from the 5.10.y tree now, and from the 5.15.y<br>
tree. Can you also resend that series?<br></blockquote><div style=3D"font-f=
amily:verdana,sans-serif"><br></div><div style=3D"font-family:verdana,sans-=
serif">Hi Greg,</div><div style=3D"font-family:verdana,sans-serif"><br></di=
v><div style=3D"font-family:verdana,sans-serif">The other two commits are a=
lready part of the stable 5.15.y tree, so changes are only needed for the 5=
.10.y tree.</div><div style=3D"font-family:verdana,sans-serif"><br></div><d=
iv style=3D"font-family:verdana,sans-serif"><span class=3D"gmail_default"><=
/span>P<span class=3D"gmail_default">lease check my latest v2 patchset=C2=
=A0</span>: (<a href=3D"https://lore.kernel.org/stable/20260119092602.14144=
68-1-keerthana.kalyanasundaram@broadcom.com/T/#t">https://lore.kernel.org/s=
table/20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com/T/#t<=
/a>)</div><div style=3D"font-family:verdana,sans-serif"><br></div><div styl=
e=3D"font-family:verdana,sans-serif">Thanks,</div><div><span style=3D"font-=
family:verdana,sans-serif">Keerthana K</span>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
thanks,<br>
<br>
greg k-h<br>
</blockquote></div></div>

--00000000000068bedf0648bbb72b--

--000000000000751ebe0648bbb71e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVTwYJKoZIhvcNAQcCoIIVQDCCFTwCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghK8MIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGhTCCBG2g
AwIBAgIMD+aKIot+px9krlZuMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NDkyM1oXDTI2MTEyOTA2NDkyM1owgcMxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEiMCAGA1UEAxMZS2VlcnRoYW5hIEthbHlhbmFz
dW5kYXJhbTE1MDMGCSqGSIb3DQEJARYma2VlcnRoYW5hLmthbHlhbmFzdW5kYXJhbUBicm9hZGNv
bS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCzJUx8cxWWLKOtWyrWjmxtNemY
IAZzJtBCZUu44YcV0VWRTEyy7ETgVKv+gsS31DMOAW6riOQk4Kq1NwaqGpWcNeN4lDbjYNgdsVd+
o9k4EYujmMl0cgM7K7hzNddW+Ay96MU9XKfPz2sgaaEg+yf7Lc4qEJAHoeB0ZjdbljIIRWD7Y/NA
zvboOGCqVTtK/MDNUbO3DM22mnISOsFdyh2D45TWDZTwu4xaGvcSWxLWmvKT/F8eOAs9WQstDJfq
Tmu6blTu87+GvJDl7ve1uoTZ2v8iJJgVmw4FHt60UKs2YygdJ0VyVdlGaqP2t1tRmfUlu7CGVl1p
CsZtHLW+HDLdAgMBAAGjggHnMIIB4zAOBgNVHQ8BAf8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGD
MEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2
c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1odHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9n
c2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJBgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgor
BgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9z
aXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWdu
LmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMDEGA1UdEQQqMCiBJmtlZXJ0aGFuYS5rYWx5YW5h
c3VuZGFyYW1AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAAp
Np5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQHh8+7satHOJPcYL7AeQdvH3LpMDANBgkqhkiG
9w0BAQsFAAOCAgEAYWBk58l2FyT07DXkrrA2hlcTBcEZihWQx8/9g29moMSrBsNjKgfWEAXXBONl
VItnKxTO0LLFBDk0aORtQ77l8a5shNEChWVYr6HaQ4+yEzwgzGmYro7sX9H0WNhPYqGxkaOhvirw
pVpXqJuPEzKRu/cGLsd/0yta4ifC8tbv2NS+/0xF92mVwwFk/drV6gzbXet3UR0Oc4E8X6cuqker
//F6sqQvY8JqD4mfN+FYlRsJMJbaotK+vEh80P3H+DiIl5yMKVsV+IDp7lNqqEr8vp6x1Sd5+kqm
iw/P5dRLJ1fqzim8rqtJ/7qy6A7f9XW26mrfXgopzpH+PpyOWTNn+1WHE3Qsf56FygZkoyRkyNeg
LDRtQlfPVV4VzF2T4Isd4+38Ec+rpHUjh92yzjrf7FL1NWhk9Q7IEFNhX6Ss1VY+qawoyAwq3PCX
N38TFnsqQc+ulwWwKrr/UAidp1h/nDizvfesRK5Iy/qJ+ey9WDm2cuRgn9EKPN4hqc1KVeLWhMS5
2Q76mvXu00vebvmkm8gEOUWX/f/7sJ9OiTxEUFA914opWhBW681OZe8N3qTdG0WpE+Dwuz0tXpzB
QjeGoKexgsMfSRTmaxQT/YnlZiJPM3qfsvSl3wUoJ+GrMGtrszD3Ehg1jbcHkUM/n2fmYA4m1ObI
fGQEpn8e5I0CKl4xggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwP5ooi
i36nH2SuVm4wDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIPnYdv5C/1IrBW9wQiAC
sCLGU8GR8wEVcGG8RKS4E+ECMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI2MDExOTExMDg1NFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0G
CSqGSIb3DQEBAQUABIIBALApfGcA9xEv0g9BHb8KWahIeMs6j7OJKnpKX2cDsCsVE3NYhjQ3nsgg
jf7Wdx0m+XXSoAZuSbv7iZTMyQMgRasBMpvaaSeCk3MrFTbdkFIcOW2dNBMg09PpyA4fg5pRHOxk
HBAvNsGQ4RogmtWiH0LdqXk5EFIZ93lerO42cNMWpYBcQMhVQorFC1La59OErOFlaUQ4qRq81Fyw
Q2qMZuPc96mrG4PdfStQDLGXj+Vh82JoQCCeC5y1nfCsoEPOPRSuAdRUwAe+2y0nyFwtMeIC4IrI
XoVZj1PV2Mm+Jl+wd/fKH2g0eFK1gBQ6KOeP/7cYtSB44V8YLW1RDP5tweE=
--000000000000751ebe0648bbb71e--

