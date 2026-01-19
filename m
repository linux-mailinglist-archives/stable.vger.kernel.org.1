Return-Path: <stable+bounces-210255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CA5D39D8F
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 06:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2F053007DA5
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 05:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDE321D3F4;
	Mon, 19 Jan 2026 05:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BrgiULjC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4E0C2EA
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 05:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768798891; cv=pass; b=LRRVKX+u+xD4oXpoUGO/HSgw8LuVfwRrdjuwtnmeLR7pR+RMbjNyOvqlWLj4VC99pZt2aGJjYN+XNfDpukZVVT201wzSp+5zotr2jiICnI8tdBHRGiEemKIL7ux1uxS4psjNZyVys185zi3yZmowZcGzZXk4v6d8DEEqfAioJgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768798891; c=relaxed/simple;
	bh=U+fcL8pz5qEAx0m/SKO9A7brVxV4jcTOkb21xO+nB8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ce2vbRRDnYwEB5pKBnkAE/+cKKSE9jAlgJBjQnOaiXtAvjja5tC0tF8L0NDx9RSvLZo5GddB04Ki3/j32d8xgO4szDFM32ClHal7eRHQjhHASyxqGaItOEMOEF+9IuRdPx1V/Stck5mBMiyIbo+YuVnwJOSVV1STCWoL2KL0Kwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BrgiULjC; arc=pass smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a08cb5e30eso8388825ad.1
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 21:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768798889; x=1769403689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFFuMpOzoR59lhzTkmz58x26pi94wm9KmJed5f9DDEY=;
        b=w3rK/1zan38Oo/GYz7bOZjRpdfb57AlM/8v0ZUnYKcO8eyOYj6vrUjOxY+rcxWoYcf
         4oA46SAljlzP5GpeyDAvau/v0TgifzM9UI2g+lat8HRQDvWBUjXYp46nNziiRg7NSpBn
         WET5xkIfZBsvmYCoSgnKfB3LmE9L5FhjS5Ch8WhkWdAul4pWkjuz/Z2lm4xqDehmIfrB
         a9hu4HVXfseXUQi5ub8+LAt/O/e772eKe0OgVEgo5xB3XyS5+LHt3rb5q4wcb/BXdtcl
         PE8v7XKBzHVIbxapw3Sf9cGWIJpwEyp0PKxAYskT6SlRW/bxl6xchcFKLzl2yC5f81H/
         xiZw==
X-Forwarded-Encrypted: i=2; AJvYcCXRd18fsRHLufKdLzRVZzk0U136OCYLOFz3lEBYcPH8F0vJk3L7l5h8beSOzSCB/mWUsfNZego=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6jvn9untqXXpBI6NHoHbiAig+zsFeb3tO5ObbC23GT/fVwPck
	9AvDpX5ni4ysOxR/TjTjLBk+Zn5oajzSUYfqpEV8aoihixs+PJP0JicpS9S1AMOiBstSnsc3Oer
	i0hk+wI9P74mouVSw1MoIl8jdxP3rnVdWXbScTPqnsj3z1leEZegQm/uBRQG1ciPbZ9nI9wryZ0
	iIpoF08urBAHbfdRuoep31NJEeehrPGSAhi7URqmjacCwOIv38V0O+HAVuNjZIJ9CsIMhIjzmRa
	7kDaN8Xuyzzeo7QUaxDtk5QYTLG
X-Gm-Gg: AZuq6aI9wEMBNUnVMhlyO4XxRu4+52gJjnI2cIHJ/eeKQqjlJeyM8GZIVHsA0akPGjD
	3wCUhwUXMCM1+5kSiFE/Dl9QuY3uxpGK8+ltg4D+mDHNhnJ104fk0YDE8I5zMqrF1D+kCnfM0Fo
	3CUl5UYFTYxYm97Wc9/kKE5rPjX41lbQKCnRiMFaDBcaWBmcaBJFNvKpvn1IVve4XymEHEl9ezT
	lKqSdXJ7Q6MdR8HO4AyCEM+J5uVEllQru9GJsjggB3NRThcaeHaCAvnFA1h4Vbwr+qT5/BIVf3X
	huB9/JjkaGRmAjNQcEaeMz31l2//6X8u/V3v1PDLJM+5uD3INi3cRO5UZsUKlBgIVeuPitU599P
	sPTQiPNjpzX2WnvrIsiFOlTTSSzqJSiW3rCsTEvAdHP8dSrbQc6VzhK1Ag9+YlX/obZ+djL+A5b
	r5RVDkSfZkQl4npliUp/dIoaVWrB2FlOWWX0kMrhQ9Icx3n2n3Nd/FeEtOehSjSg==
X-Received: by 2002:a17:903:40cb:b0:29f:a288:31e2 with SMTP id d9443c01a7336-2a71750a34amr71306485ad.1.1768798888865;
        Sun, 18 Jan 2026 21:01:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7190d5587sm13296675ad.25.2026.01.18.21.01.28
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jan 2026 21:01:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64b5ea061c8so281261a12.3
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 21:01:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768798887; cv=none;
        d=google.com; s=arc-20240605;
        b=ZfAFBWj+eVPt67m7Fqh715p6cuQxhQ6zL8QGsj7oHXn7JPk+UGMsQSqunkuu9wH75J
         E5taUhjF2Md6HjZnSD06cOd37/ec6kn+uSUz/gUaPU9jvbRZXAfSReF6stIELKhpC1AG
         fn9hR+s5xOTsb2lgMnmM7j/8uRqDqSCEi4XgRjC/ct6GucUJupkvRZ/LLsVYbhGAT8L6
         J6/zm5fFfLTu1cV4g3B35ju6SmYUChs6T7AMAH9UhUXmD5bY0vammsqWwsKfT/TbfcNE
         R5EIIoTZfy1k8ooYjACBUiJxcSX1xzXiSulOrEUduarD8w7EVSlULKELAWuKZ/tZKj1G
         UH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nFFuMpOzoR59lhzTkmz58x26pi94wm9KmJed5f9DDEY=;
        fh=H7yk98vJ5+77jHVj7qX4jy+5FgxZS4ETrhBlByx6SeI=;
        b=R81GAhBhqeY04fvygqVuXKuffWjOe8CxGew33oc+elDyOt9LKWKqfW/b16q6YAg998
         uk48FmP/yQV0eHvghjgs/p4BES8HFBwzWLAkIfupiekB8AepoHoCmBXJx6z8A+mAuaNl
         4S+AoRuYIXJDxVGpXn33nC/lvVk7XwgaT74jQ2iZA+AYQcgUqWW9n9pYsGwkdxcp+xKZ
         Yflgro2vSTP5xilc7Hemb860kqXBNiHjYAj+1w5sHCQbWJEKgnhfD5J9STYT0T2Yscl+
         JXIq2hsi58eM6ETLZYxKvdmAhJMKixwSXSecpTXdpCpQzRrz/sypoAKIaGcUuABOmMqT
         KCPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768798887; x=1769403687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nFFuMpOzoR59lhzTkmz58x26pi94wm9KmJed5f9DDEY=;
        b=BrgiULjCxc+xDnDhrHOV9FNxpC9/c5fgKFvjLKssRa/9B54SJ8Ihx0iIweF7ttMUlh
         sqh+OSdaXTrhDjDP6YlpGmC/7nUOhYOXEhbNU5p6Na8QTpidSa0H8+r9BmZ3quo+KtBX
         m8TajROAnpf3qOx5/S7knAoUR1JfX/77etkEw=
X-Forwarded-Encrypted: i=1; AJvYcCUIgVgclILY8DSbiCfnyyMOY/AvtFD0sMNysSFabtIv7VUcT6208BZLWaDs19cPoxm7gCFLHXQ=@vger.kernel.org
X-Received: by 2002:a05:6402:518e:b0:649:9aff:9f42 with SMTP id 4fb4d7f45d1cf-654517f1219mr4344232a12.0.1768798886568;
        Sun, 18 Jan 2026 21:01:26 -0800 (PST)
X-Received: by 2002:a05:6402:518e:b0:649:9aff:9f42 with SMTP id
 4fb4d7f45d1cf-654517f1219mr4344221a12.0.1768798886158; Sun, 18 Jan 2026
 21:01:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164230.864985076@linuxfoundation.org> <20260115164246.242565555@linuxfoundation.org>
 <4ca8d0770343eae44e19854cf197c76017a7c1ad.camel@decadent.org.uk>
In-Reply-To: <4ca8d0770343eae44e19854cf197c76017a7c1ad.camel@decadent.org.uk>
From: Keerthana Kalyanasundaram <keerthana.kalyanasundaram@broadcom.com>
Date: Mon, 19 Jan 2026 10:31:13 +0530
X-Gm-Features: AZwV_QiApkccmQyjOoV_3uoxeF5xaTy1NNkIlgGxsoFZVM8_b-lHMLc52omJ_ds
Message-ID: <CAM8uoQ-F++6iScZBzntmF=KhHRK3=rQvc-oug3KAXPddJPqR-Q@mail.gmail.com>
Subject: Re: [PATCH 5.10 423/451] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
To: Ben Hutchings <ben@decadent.org.uk>
Cc: patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <edumazet@google.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005771b00648b69559"

--0000000000005771b00648b69559
Content-Type: multipart/alternative; boundary="0000000000004a51940648b69503"

--0000000000004a51940648b69503
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:03=E2=80=AFAM Ben Hutchings <ben@decadent.org.uk>=
 wrote:

> On Thu, 2026-01-15 at 17:50 +0100, Greg Kroah-Hartman wrote:
> > 5.10-stable review patch.  If anyone has any objections, please let me
> know.
> >
> > ------------------
> >
> > From: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > [ Upstream commit c65f27b9c3be2269918e1cbad6d8884741f835c5 ]
> >
> > get_netdev_for_sock() is called during setsockopt(),
> > so not under RCU.
> >
> > Using sk_dst_get(sk)->dev could trigger UAF.
> >
> > Let's use __sk_dst_get() and dst_dev_rcu().
> >
> > Note that the only ->ndo_sk_get_lower_dev() user is
> > bond_sk_get_lower_dev(), which uses RCU.
> [...]
>
> So should 5.10 also have a backport of commit 007feb87fb15
> ("net/bonding: Implement ndo_sk_get_lower_dev")?  Or is the use of
> netdev_sk_get_lowest_dev() here not actually that important?
>
> It seems kind of wrong to add the netdev operation and a caller for it,
> but no implementation.
>
>
Hi Ben,
Thank you for catching this issue.
I agree that we should also add commit 007feb87fb15 ("net/bonding:
Implement ndo_sk_get_lower_dev") to the 5.10.y tree to ensure the
implementation is complete. I will send an updated patch soon.
- Keerthana

Ben.
>
>
> --
> Ben Hutchings
> Power corrupts.  Absolute power is kind of neat. - John Lehman
>

--0000000000004a51940648b69503
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br></div></div><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, =
Jan 19, 2026 at 5:03=E2=80=AFAM Ben Hutchings &lt;<a href=3D"mailto:ben@dec=
adent.org.uk">ben@decadent.org.uk</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Thu, 2026-01-15 at 17:50 +0100, Greg Kr=
oah-Hartman wrote:<br>
&gt; 5.10-stable review patch.=C2=A0 If anyone has any objections, please l=
et me know.<br>
&gt; <br>
&gt; ------------------<br>
&gt; <br>
&gt; From: Kuniyuki Iwashima &lt;<a href=3D"mailto:kuniyu@google.com" targe=
t=3D"_blank">kuniyu@google.com</a>&gt;<br>
&gt; <br>
&gt; [ Upstream commit c65f27b9c3be2269918e1cbad6d8884741f835c5 ]<br>
&gt; <br>
&gt; get_netdev_for_sock() is called during setsockopt(),<br>
&gt; so not under RCU.<br>
&gt; <br>
&gt; Using sk_dst_get(sk)-&gt;dev could trigger UAF.<br>
&gt; <br>
&gt; Let&#39;s use __sk_dst_get() and dst_dev_rcu().<br>
&gt; <br>
&gt; Note that the only -&gt;ndo_sk_get_lower_dev() user is<br>
&gt; bond_sk_get_lower_dev(), which uses RCU.<br>
[...]<br>
<br>
So should 5.10 also have a backport of commit 007feb87fb15<br>
(&quot;net/bonding: Implement ndo_sk_get_lower_dev&quot;)?=C2=A0 Or is the =
use of<br>
netdev_sk_get_lowest_dev() here not actually that important?<br>
<br>
It seems kind of wrong to add the netdev operation and a caller for it,<br>
but no implementation.<br>
<br></blockquote><div><span class=3D"gmail_default" style=3D"font-family:ve=
rdana,sans-serif"><br></span></div><div><span class=3D"gmail_default" style=
=3D"font-family:verdana,sans-serif">Hi Ben,</span></div><div style=3D"color=
:rgb(31,31,31);font-family:Roboto,Helvetica,Arial,sans-serif;font-size:14px=
;letter-spacing:0.2px">Thank you for catching this issue.</div><div style=
=3D"color:rgb(31,31,31);font-family:Roboto,Helvetica,Arial,sans-serif;font-=
size:14px;letter-spacing:0.2px"><span style=3D"letter-spacing:0.2px">I agre=
e that we should also add commit 007feb87fb15 (&quot;net/bonding: Implement=
 ndo_sk_get_lower_dev&quot;) to the 5.10.y tree to ensure the implementatio=
n is complete.</span><span style=3D"font-family:Arial,Helvetica,sans-serif;=
font-size:small;letter-spacing:normal;color:rgb(34,34,34)">=C2=A0<span clas=
s=3D"gmail_default" style=3D"font-family:verdana,sans-serif">I will send an=
 updated patch soon.</span></span></div><div style=3D"color:rgb(31,31,31);f=
ont-family:Roboto,Helvetica,Arial,sans-serif;font-size:14px;letter-spacing:=
0.2px"><span style=3D"font-family:Arial,Helvetica,sans-serif;font-size:smal=
l;letter-spacing:normal;color:rgb(34,34,34)">-<span class=3D"gmail_default"=
 style=3D"font-family:verdana,sans-serif"> Keerthana</span></span></div><di=
v style=3D"color:rgb(31,31,31);font-family:Roboto,Helvetica,Arial,sans-seri=
f;font-size:14px;letter-spacing:0.2px"><span style=3D"font-family:Arial,Hel=
vetica,sans-serif;font-size:small;letter-spacing:normal;color:rgb(34,34,34)=
"><span class=3D"gmail_default" style=3D"font-family:verdana,sans-serif"><b=
r></span></span></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Ben.<br>
<br>
<br>
-- <br>
Ben Hutchings<br>
Power corrupts.=C2=A0 Absolute power is kind of neat. - John Lehman<br>
</blockquote></div></div>

--0000000000004a51940648b69503--

--0000000000005771b00648b69559
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
i36nH2SuVm4wDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIGGRwwi6vX0SssTMKfig
pp9/IMf1H4d5Wp2MG01hOzzWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI2MDExOTA1MDEyN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0G
CSqGSIb3DQEBAQUABIIBAGVZWPL9jry8Tmstgx7npL6+u0m4RPl/YDL1MGADD4C/pNoSFub9877X
UeOzYwmZRXW7jwx2FA0HAQH9eoLgzr14ZW5V1ME/h69xXMvL3nFTUa0oNnAoQyF2wZPoqZPUdTOL
PPH+kW+OkhtRMhPCFXsrtEeyC4HJxCG4lYta/OYaCYNYfrr2CDn3At1wL4myy4MODZrkxShPnYay
GkY/LU6YdgowiaOnwK2B3K+I9iMAN4w0EkiUrJyXZN41aYI/6vcf2HyMEjuID+r4ofv1uufFWLe7
s+UXsiiRbnpM1nMg2K37Lwxv9IA5uGKAnMh+Wx7KzLCcBfcQRKW9f0VAcC4=
--0000000000005771b00648b69559--

