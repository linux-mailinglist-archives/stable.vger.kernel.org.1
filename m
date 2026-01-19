Return-Path: <stable+bounces-210293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78568D3A344
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 10:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7824F30038C3
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8375354AC1;
	Mon, 19 Jan 2026 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YaQTG7IJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691FC247291
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768815589; cv=pass; b=d9wwBXz5w7mqieTavcPAnOBrUmBB0sytQI0pPZrlwNqGhk7SHpotQ6ng53u9PagRfw28UasUrjnMvZVwR3EWtaSIYDGSS30OfWw3dV7AReAn0C6WKNbj1CBvMUW8zouIlmFuW5ATju2msXujDzIUcy2GPcXgbY54SohIgB7CeEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768815589; c=relaxed/simple;
	bh=+ovWmj286zBo2767GIk4FTZ7EoyxzgylMaveGN42FYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLhB8N0vaXVmZtPaII9dVsxPFw+7UqEZo9nyenZDr/XJ7NpxBLvSOaxvRiG0h5DKSXbONsFtQGyUuGiaKu1Ze37rcs6MQDWrwXsS1LXrcchdUTtNCpgsodKFSxBjkccIgzUE9lOod+L4TWf2SwaOieYbqVVSPVKsUuiFO/azBiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YaQTG7IJ; arc=pass smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a0f3d2e503so6681495ad.3
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768815587; x=1769420387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/V0Zoi5rBV312iiL1bXYuubr3YJ8DJ2XfvfuZA1Y6ac=;
        b=fJL3mE9GAR/xi/H9+tmEMAebFUoZ97ukM+pATd3I7ils+FwVq+ZFclzHyPHyxWjcpN
         il5SZ2C5L1Nqy871D/9RBa3hr7Ab3wOpZYZB7LNemexXOscQEochO/a0i9A4UCOAMfh/
         tIzL9BbfzzJIsg6BNtpUqdT/74eF0m515h8FA3MNbEm0Ky4zyeUC8EoSXv2DnA4/GIX8
         qOxQAZedRSe4hFo2Lz1xohkJI227Y2yabE1HUjobdBd/+5iZ61LZ02d9vCA/p735vvWW
         HnMbobBcB0D+8ww4cwt/BtQXEylnigfEHhU6Qy/fxTvyhPNUoi5zPfRL7no/rZfZFYx2
         K1OA==
X-Forwarded-Encrypted: i=2; AJvYcCXjgZb08XjfEg+9MyyNP3hGoDxibsrxn/qVbZrhHXdqTDRL98ItubNMWCibpSJc+qoATCGYLic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBPmj6LLW5oX9Kud6tRoEPS8XfkCSveb9d9Mwig2EMDby2RyoQ
	LGuNgOoE4d7X6h4hLOEJk2QABFnQycEuvSooIZt9a1Bn4cRUdq39aqiYachbih7DabqCVXpuHYO
	7Nj042onkb9+iZ0FNBkgWTd0yNjXrpBV5V8qf2AN7258BbqfBZ96kBzLNTNh+aG4H+vkCRl0k6r
	FNSQL9Ik2nq3ekEXSHNtYTsukKqukOfIaCYVlcTg+b08eIRFphCYm4O18jEjv3ZyPS/QWpEuWq+
	DopgJfd4qBiSGEfVT/TA+Fro8Su/8A=
X-Gm-Gg: AZuq6aJM4DVzNqaqJNx7ZCt3+AXpvwBRo89Dp6PY/6h4znzfGgrASMAD2cPItKYdSo2
	c038h+Y/D7emloceyVo5wipZJZLggBgs5FylLsQkMw0z0UuOOuNlWBxYtsJqqt744dK5U2UybOI
	9TS10EvwGQpXB3csh7wOI+gu7aB1wxbLkxk+B+P3CrHzicldNO7VGVBk/FEImIEP4XnN/H0/IMj
	FTopVNg8IruWZHBUDNsfP2ysbSB839A2HghCljrb88iZVQFfEsFxmLP/rz0KDeQqpWMSnFgHb/d
	O5jo+nRFMXnlNYfx5TkYme9HiGe76ZtRB8Or0rHj+/DMbbxdYAcBc/xLVW801MR0QdtVeWAO8NW
	D2ilxrCwI6hAzLFC0cw8x9GyhIvN4ZSgzOUTsFoXVbnr58kDEbc4rsd6If9P5HcWtqZx9/D0C5x
	20fKg1zVRjmYSw8Xo7kEMkzXHVvfaW5hopWaMf/blEbhlXUsT/3vV5kNo2voE=
X-Received: by 2002:a17:903:11cc:b0:297:f3a7:9305 with SMTP id d9443c01a7336-2a7177d6fc7mr74097505ad.6.1768815587271;
        Mon, 19 Jan 2026 01:39:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7190b3f32sm14348055ad.16.2026.01.19.01.39.46
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:39:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64b568e714cso342029a12.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:39:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768815585; cv=none;
        d=google.com; s=arc-20240605;
        b=YMINfX/OLrXxJxYBmyHeBny/FHeW8cXlKThBaedGybgYFgcYCLNjMUei5YFZRljEY8
         mLaLy7qLesbIP8hk51SlxSB6ixnAk8TLOo2F12DYoGyOg2Sof+71Z1hbDWVOdNHPNMeC
         trWyLgcgUtM3SE+ygda1Yz/EZxwetKUS3vBNEOjFgfCVrPEEBTfgtcJZCe7TxN7MnlIZ
         Q0W51y//fHnDlb1WgB2OmUGHfNNudnt+IE54+l596gSEBLWU6GyjVjaf4BzkLQqi7AJA
         mh/ffpIOEXf1EvTRrj9sJxlpTjKvJny6HqWjs/aNzeRLZkBCTsEn71T4lJXrgaUwiYhV
         M3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/V0Zoi5rBV312iiL1bXYuubr3YJ8DJ2XfvfuZA1Y6ac=;
        fh=CPcCZ1i4uoNBYUbA6KGwgh6YjGCfj3nBTck2weAZQYs=;
        b=RoRTSir+aj9L/CZROzbBNQsVM+EGREYIIew5fPTRpgz4dUnkqFJ5f9CnfgApLxV1jQ
         D62by+dnlJbQmoBsKhP0MfNDuoEwNqBfnFzxY57qDORT0LLyfeLCHNcdLbI98jH629Ay
         5Kd9cRtwQtgZq0N41zmdX7500xsQhZNuojIT4R0W0yrld+69wNoyk7U0IjmCQQAfkg4Y
         6M8+xX30YyMzY3JBY46mrrsmkJW2keicsHYMM97eqwNUMM1OTJHtALhbFfSEfYFLDle8
         aDSTkMB1OZLTqajpa7e9HM+BVBeP+YiVIzkNkfw3AVOO2WJKesM0XunrGLuJu3rsAxYM
         eISQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768815585; x=1769420385; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/V0Zoi5rBV312iiL1bXYuubr3YJ8DJ2XfvfuZA1Y6ac=;
        b=YaQTG7IJnJjIBLDcxeuGH27hJy0AdQtxkGu/UvfyV7T1rtNolsQSXWX5vZwos/Bqt2
         75CYYmCpxhBo5Ti5zpsnVMxAaWaN3KcfgHf1k9ptTIhymdl+EUlUpyZMxpy7KnLLZ42c
         snuhGtZMjJ0T3z+1zrg6AxXBhTZNm4NcBVKUw=
X-Forwarded-Encrypted: i=1; AJvYcCXxEY+2gqbzko2xNGu1UWmVXoVYiIJHP9EQ45YdXP2eGCnMgzbs2dvMRAaeShjgDqaCsvqd2dc=@vger.kernel.org
X-Received: by 2002:a05:6402:2342:b0:64b:a1e6:8013 with SMTP id 4fb4d7f45d1cf-65452ad28edmr4466299a12.6.1768815585209;
        Mon, 19 Jan 2026 01:39:45 -0800 (PST)
X-Received: by 2002:a05:6402:2342:b0:64b:a1e6:8013 with SMTP id
 4fb4d7f45d1cf-65452ad28edmr4466286a12.6.1768815584678; Mon, 19 Jan 2026
 01:39:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164230.864985076@linuxfoundation.org> <20260115164246.242565555@linuxfoundation.org>
 <4ca8d0770343eae44e19854cf197c76017a7c1ad.camel@decadent.org.uk> <CAM8uoQ-F++6iScZBzntmF=KhHRK3=rQvc-oug3KAXPddJPqR-Q@mail.gmail.com>
In-Reply-To: <CAM8uoQ-F++6iScZBzntmF=KhHRK3=rQvc-oug3KAXPddJPqR-Q@mail.gmail.com>
From: Keerthana Kalyanasundaram <keerthana.kalyanasundaram@broadcom.com>
Date: Mon, 19 Jan 2026 15:09:32 +0530
X-Gm-Features: AZwV_QjKNqOInOKN050mzCHEoShb74nhxG56a1Rae_6DRaW3SD4fASVDyy68IXo
Message-ID: <CAM8uoQ_7HD0AtJLqXsRvO=F2knq=BtrdTM2Fv0Dd4h-4oYebNw@mail.gmail.com>
Subject: Re: [PATCH 5.10 423/451] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
To: Greg KH <gregkh@linuxfoundation.org>
Cc: patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <edumazet@google.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>, 
	Ben Hutchings <ben@decadent.org.uk>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a7c2e00648ba78f7"

--000000000000a7c2e00648ba78f7
Content-Type: multipart/alternative; boundary="0000000000009981320648ba7881"

--0000000000009981320648ba7881
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

I have backported the two additional patches required for the 5.10.y tree
and submitted a v2 series. You can find the updated patches here:
https://lore.kernel.org/stable/20260119092602.1414468-1-keerthana.kalyanasu=
ndaram@broadcom.com/T/#t


Could you please consume these in the next version, or alternatively, add
the two missed patches (commit IDs 5b998545 and 719a402cf) to the current
queue?

- Keerthana K


On Mon, Jan 19, 2026 at 10:31=E2=80=AFAM Keerthana Kalyanasundaram <
keerthana.kalyanasundaram@broadcom.com> wrote:

>
> On Mon, Jan 19, 2026 at 5:03=E2=80=AFAM Ben Hutchings <ben@decadent.org.u=
k> wrote:
>
>> On Thu, 2026-01-15 at 17:50 +0100, Greg Kroah-Hartman wrote:
>> > 5.10-stable review patch.  If anyone has any objections, please let me
>> know.
>> >
>> > ------------------
>> >
>> > From: Kuniyuki Iwashima <kuniyu@google.com>
>> >
>> > [ Upstream commit c65f27b9c3be2269918e1cbad6d8884741f835c5 ]
>> >
>> > get_netdev_for_sock() is called during setsockopt(),
>> > so not under RCU.
>> >
>> > Using sk_dst_get(sk)->dev could trigger UAF.
>> >
>> > Let's use __sk_dst_get() and dst_dev_rcu().
>> >
>> > Note that the only ->ndo_sk_get_lower_dev() user is
>> > bond_sk_get_lower_dev(), which uses RCU.
>> [...]
>>
>> So should 5.10 also have a backport of commit 007feb87fb15
>> ("net/bonding: Implement ndo_sk_get_lower_dev")?  Or is the use of
>> netdev_sk_get_lowest_dev() here not actually that important?
>>
>> It seems kind of wrong to add the netdev operation and a caller for it,
>> but no implementation.
>>
>>
> Hi Ben,
> Thank you for catching this issue.
> I agree that we should also add commit 007feb87fb15 ("net/bonding:
> Implement ndo_sk_get_lower_dev") to the 5.10.y tree to ensure the
> implementation is complete. I will send an updated patch soon.
> - Keerthana
>
> Ben.
>>
>>
>> --
>> Ben Hutchings
>> Power corrupts.  Absolute power is kind of neat. - John Lehman
>>
>

--0000000000009981320648ba7881
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"font-family:verdana,sans-se=
rif"><span class=3D"gmail_default" style=3D"font-family:verdana,sans-serif"=
></span>H<span class=3D"gmail_default" style=3D"font-family:verdana,sans-se=
rif">i</span> Greg,</div><div style=3D"font-family:verdana,sans-serif"><br>=
</div><div style=3D"font-family:verdana,sans-serif">I have backported the t=
wo additional patches required for the 5.10.y tree and submitted a v2 serie=
s. You can find the updated patches here: <a href=3D"https://lore.kernel.or=
g/stable/20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com/T/=
#t">https://lore.kernel.org/stable/20260119092602.1414468-1-keerthana.kalya=
nasundaram@broadcom.com/T/#t</a>=C2=A0</div><div style=3D"font-family:verda=
na,sans-serif"><br></div><div style=3D"font-family:verdana,sans-serif">Coul=
d you please consume these in the next version, or alternatively, add the t=
wo missed patches (commit IDs 5b998545 and 719a402cf) to the current queue?=
</div><div style=3D"font-family:verdana,sans-serif"><br></div><div style=3D=
"font-family:verdana,sans-serif"><span class=3D"gmail_default" style=3D"fon=
t-family:verdana,sans-serif">-=C2=A0</span>Keerthana K</div><div><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><br></div></div></=
div></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 19, 2026 at 10:31=E2=80=AFAM Ke=
erthana Kalyanasundaram &lt;<a href=3D"mailto:keerthana.kalyanasundaram@bro=
adcom.com">keerthana.kalyanasundaram@broadcom.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=
=3D"ltr"><div><br></div></div><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Mon, Jan 19, 2026 at 5:03=E2=80=AFAM Ben Hutchings &=
lt;<a href=3D"mailto:ben@decadent.org.uk" target=3D"_blank">ben@decadent.or=
g.uk</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Thu, 2026-01-15 at 17:50 +0100, Greg Kroah-Hartman wrote:<br>
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
</blockquote></div></div>

--0000000000009981320648ba7881--

--000000000000a7c2e00648ba78f7
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
i36nH2SuVm4wDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIMLT/s58vi8s1mW8MjFI
5ppBoXpKFK0mGXgvZ2lGkhI6MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI2MDExOTA5Mzk0NVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0G
CSqGSIb3DQEBAQUABIIBAKWeP/1ooTXKgfulMmU9CCRTlw2mdOik7yndMM5Wb3yitvanxdSRQ8se
qwUpCSqQr5bd8TSaHxQdJYr/SFsbL3/MIUHL3HGqAMm5yyqgY+81KG6OqAY/OPS3eesGsMqgQyvK
5ofNNSy44ueFdUz06tToq2KJaWELsnSGF0AujWSdrD29NPk6QvAhlGVlBx8DbJx9muS3yVJIo7SZ
/SfvR+UMhceGlsGkrYzTg8noMAMGCoCqShVEa1P/oFZ8ns4S3Uv5IN8NsqxXAEOpMr3xJTjPDxJm
bPDTwYbVfEmSDwPJObMhdMjczjLgQguv5+MGV3vv1ePElhA930kqdS99RDk=
--000000000000a7c2e00648ba78f7--

