Return-Path: <stable+bounces-210337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 575A8D3A77D
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12440300E4FE
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052BD314D03;
	Mon, 19 Jan 2026 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ATqrkK8a"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566FC31BC84
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823762; cv=pass; b=B6PKLDuLsEcNNaPRz+bDaAeDoTPlKZYQIJXUkMK85HY97Imw0GjPuujEENecmfEv4ltmZqTHslIAIK0KMW0QIgtZ5XS2R+nFWELRmpTL/tD51EFVBBGn9UjGDb0m+0WNU1cdDrDf4AuQC9sgw7arVxq8wLyNIDhYKWqIaVr8NxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823762; c=relaxed/simple;
	bh=pUFR2pHN0T9ftLvtv7skjicGO4HVkwZLxXTQKJ/dHeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/yvgIVOclQXgqpTrkQEN1d6jcGd4RPt3UHn6F+6v9TZjE4x3kk2sQx7qJcvs89Hw9SqV/unWkwhY8ZJbhqkFFlSa754NMwA2acOg7bdCXFzmQmb+RHcRjHePtJEU9lXmb7leky9JbnLMc6dtf3TaO81KpU+bcilNtDzgtD6rsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ATqrkK8a; arc=pass smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-94418248765so109039241.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 03:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823760; x=1769428560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgLtS7vYWHKex/2Oq8jK/CyM4I4Y1xPXlb54gfWcraA=;
        b=l6Y6vtAz5zjJVwRrkdKKsBer64SmQ3qGQDqqIQ7sEVZTRb2hwdB3nbZzPyVCBC1oer
         7XpDmVjYtmSTIJfNbetfMkNrbTpxgK1sYMp9uY9p3wH0p1rVCSJnH9EyJsdMs1WgXbeT
         XPwHiF4LbFL1ZPmf7wKzFVGykhs69X5oz/cZytdfAABC2zZOS1qysyepqlGQ5fehKZt1
         GJve7w24J+VrsCTFRI8A0eI02XgLN7Op7G7pI1tb7Q5vg4FgGVIwoPUkd1BYLJt1RcDU
         WUULOx3ozMCN1kXVSLaOMrA3NIeQeKqnWYHnVd3unOOQ85KV8oNPhXDxDtgrXjdRfaS9
         3fxg==
X-Forwarded-Encrypted: i=2; AJvYcCVsZ5jezeCgc6U5AxYS3w8KCRSvWm1JUh5a/zklrHndYtfoRKTJT4pTSDT1ANfvQ6ilarQATto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL6NU+vdkufPcFmBtaP1lV+70ZWy6Wsi/V7dAfr2ySa+yYqhc7
	ogzReZqkG6doIJyAyW06MHalaBbdUMTZk0wMMkMzUsJlVUwTO5QefYnXdNBJ/iE+70B/itybjs5
	ksulXhOFhx/VOdoRKdhiu2eCcosD/77CX7nNeAy2Aylzz+duUIvbHJnzaXLxcUOPNswbgdlUrPq
	SQc2ch4wM1gH5b6Noqjby7yhjAVUau5YUODhM9kH+2avlFk2miounOHIXxILID8okpMsZ4WAPxn
	XSaapU+JEr428uqaY14qoYauNBBZp0=
X-Gm-Gg: AY/fxX4VoU0KaT6heACWwtrP7VtGAVbV2AnsdYGS9tdZBIIfe5CmbL+Vj76ZOz7CwFW
	FBmTC/bUgc69gY6kh9KoFj5JL9A7j2z/T8r7IeoJcb2bIF55SPLj44QbLgPU8UQW8n6Dbu0QpcA
	XeVf2XWMg6klWL2qja4TjMAKNQ6l93DAGj3jNo1LYTYVSnTDtj4E3mRBDLtttAC0Bj37S5/g020
	7QUxMa95KTeKsT2zTwJmN1VzKokgkb6gLbh+4StxvGQR86HFsCaqZ5Np4f4NlWuQ9SLslFz2sQU
	/OJjjc01CUrtZwygCfQLNnrYCcvuwAEJUAYM/SpAue02fBaQFVCll5bf27FoolXbQen7AG3fNIH
	fPr8Q6y4F2SsHgPLMt7HRBYu8x+TkWaQYveuYlHXaWzYHKm0RyMbY/FuSEZtvb3Hl5PNQzT2lAd
	0mzcZLwhh8KmM83QyrycraJZlIt4ISxEIRGW9JTyAMdCDYkNrWzPw+l55v1dw=
X-Received: by 2002:a05:6102:370e:b0:5e4:9555:8984 with SMTP id ada2fe7eead31-5f1a556805bmr2094048137.6.1768823760003;
        Mon, 19 Jan 2026 03:56:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5f1ca498ce6sm799796137.3.2026.01.19.03.55.58
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:55:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8000581fddso50832266b.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 03:55:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768823758; cv=none;
        d=google.com; s=arc-20240605;
        b=YPt8p/SX0Uve/LjVbq/lYwzV0M2f3O11bxlZ+wf2+PTjiFk3i4+VyYdPyVf5wObCDK
         GpXpDK1shk0IMfwNl+6MD3ould01Vj4/tzyYjwHZtM+cpuGf/8g27ALdM/V13CgtSOiX
         RS97PBwz6+wWkRE8b2TRxMV07ZS8ZkmOqg74yj61vSxoW8McJ2vokpGmwA2K+xhftU+t
         leTuyP/JH/sbySluPDiQhSU8XdGmbCrdU+gBJaoY5H35XtsiFMc+xf06vzp+SycPWTH3
         Sf1961EHLx3oPLXN0f5k2L9y7LKuXZ7ZIRLEKmsPH7y6sZlrIga+YwFmvyYOeAnQ/Lf9
         1G7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jgLtS7vYWHKex/2Oq8jK/CyM4I4Y1xPXlb54gfWcraA=;
        fh=C6T8izUP53T3tJ4dbQXG2NoT/BoExl5Ia1VkheTOSw0=;
        b=M6QM1CZSUV2SsAmgCB4BZThJs91/rLwulwcJciZYTKwaUpRZCcl9yNBpw5CJsgc4zB
         QAkQfcN5pfKEW8Fm7bP5o51L/2ksb9vo3XVJrLfqjvHIRGr1+GgeEvAbWPxXRTHi/o8j
         mev2rTAajvMas4eT9hgDvoWz7h/Reb8hleTx/BUy4LePvH0/+R4JHPF+11ZT6b7k97rq
         olot+UmiKzYib14diFMO7n8Ev1Q8QtH3DzKOP9Rugq3lYkhP4ZNOQbWdnGY3BCzqkY88
         6R7gaAGSbliWTu1m6g2trUzs7TEeVtIipgO/gcyQOyznvw3OjrvqEtnofqDdG6kOEqkP
         ooUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768823758; x=1769428558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jgLtS7vYWHKex/2Oq8jK/CyM4I4Y1xPXlb54gfWcraA=;
        b=ATqrkK8ampKQVeLAmECoIvlNgMxVD7u2aKLo/xHaVQ5Flw71Oo35urI0fLvZ2YTeEL
         5wiyIbX4V7xfpqIkWJul8Uz1j+TcezMThCrgRWIBiSH1FzbE+jbcRxu+rIioEDk8j4y/
         iKDAOM4S8RQtlM9M7UgLkDGRr1ep+AU1yKJCA=
X-Forwarded-Encrypted: i=1; AJvYcCXamDS+ntHiZDs44G1VPeS3UpNSjTmVBI4bggJHclWBZYsqrrsGFTyFc3evzRmHEqp3mPTMARY=@vger.kernel.org
X-Received: by 2002:aa7:d84f:0:b0:655:b07e:95d5 with SMTP id 4fb4d7f45d1cf-655b07e99a6mr3288875a12.7.1768823757712;
        Mon, 19 Jan 2026 03:55:57 -0800 (PST)
X-Received: by 2002:aa7:d84f:0:b0:655:b07e:95d5 with SMTP id
 4fb4d7f45d1cf-655b07e99a6mr3288861a12.7.1768823757220; Mon, 19 Jan 2026
 03:55:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164230.864985076@linuxfoundation.org> <20260115164246.242565555@linuxfoundation.org>
 <4ca8d0770343eae44e19854cf197c76017a7c1ad.camel@decadent.org.uk>
 <CAM8uoQ-F++6iScZBzntmF=KhHRK3=rQvc-oug3KAXPddJPqR-Q@mail.gmail.com>
 <CAM8uoQ_7HD0AtJLqXsRvO=F2knq=BtrdTM2Fv0Dd4h-4oYebNw@mail.gmail.com>
 <2026011944-wielder-ignition-dee8@gregkh> <CAM8uoQ-NyJQatRYXty2XdiTjsuO6hRmEam_YaNrBbgEUuK6KQA@mail.gmail.com>
 <2026011923-coat-strict-6cc4@gregkh>
In-Reply-To: <2026011923-coat-strict-6cc4@gregkh>
From: Keerthana Kalyanasundaram <keerthana.kalyanasundaram@broadcom.com>
Date: Mon, 19 Jan 2026 17:25:45 +0530
X-Gm-Features: AZwV_QidpVlyEJFYDzcYPJXBOyZFe9sHM_VK0cLeYAEd_5jdpbLz20ZJKMxsbgA
Message-ID: <CAM8uoQ_qTaBU9eR9ybzreXkOvTFD3nwqFfA1hdaoPATWkL-5eg@mail.gmail.com>
Subject: Re: [PATCH 5.10 423/451] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
To: Greg KH <gregkh@linuxfoundation.org>
Cc: patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <edumazet@google.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>, 
	Ben Hutchings <ben@decadent.org.uk>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c4f4a90648bc5f9f"

--000000000000c4f4a90648bc5f9f
Content-Type: multipart/alternative; boundary="000000000000b853d10648bc5f57"

--000000000000b853d10648bc5f57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:09=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:

> On Mon, Jan 19, 2026 at 04:38:41PM +0530, Keerthana Kalyanasundaram wrote=
:
> > On Mon, Jan 19, 2026 at 3:36=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org>
> wrote:
> >
> > > On Mon, Jan 19, 2026 at 03:09:32PM +0530, Keerthana Kalyanasundaram
> wrote:
> > > > Hi Greg,
> > > >
> > > > I have backported the two additional patches required for the 5.10.=
y
> tree
> > > > and submitted a v2 series. You can find the updated patches here:
> > > >
> > >
> https://lore.kernel.org/stable/20260119092602.1414468-1-keerthana.kalyana=
sundaram@broadcom.com/T/#t
> > > >
> > > >
> > > > Could you please consume these in the next version, or
> alternatively, add
> > > > the two missed patches (commit IDs 5b998545 and 719a402cf) to the
> current
> > > > queue?
> > >
> > > I've dropped them all from the 5.10.y tree now, and from the 5.15.y
> > > tree. Can you also resend that series?
> > >
> >
> > Hi Greg,
> >
> > The other two commits are already part of the stable 5.15.y tree, so
> > changes are only needed for the 5.10.y tree.
> >
> > Please check my latest v2 patchset : (
> >
> https://lore.kernel.org/stable/20260119092602.1414468-1-keerthana.kalyana=
sundaram@broadcom.com/T/#t
> > )
>
> I see the series, sorry, they are now dropped.  Can you resend them for
> 5.15?
>

Hi Greg,

I have resent the patches for 5.15.y. You can find them here: (
https://lore.kernel.org/lkml/20260119114910.1414976-1-keerthana.kalyanasund=
aram@broadcom.com/
)

Thank you,
Keerthana K

>
> thanks,
>
> greg k-h
>

--000000000000b853d10648bc5f57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><span class=3D"gmail_default" style=
=3D"font-family:verdana,sans-serif"></span><br clear=3D"all"></div><div sty=
le=3D"font-family:verdana,sans-serif"><br></div></div><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, J=
an 19, 2026 at 5:09=E2=80=AFPM Greg KH &lt;<a href=3D"mailto:gregkh@linuxfo=
undation.org">gregkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On Mon, Jan 19, 2026 at 04:38:41PM =
+0530, Keerthana Kalyanasundaram wrote:<br>
&gt; On Mon, Jan 19, 2026 at 3:36=E2=80=AFPM Greg KH &lt;<a href=3D"mailto:=
gregkh@linuxfoundation.org" target=3D"_blank">gregkh@linuxfoundation.org</a=
>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Mon, Jan 19, 2026 at 03:09:32PM +0530, Keerthana Kalyanasundar=
am wrote:<br>
&gt; &gt; &gt; Hi Greg,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I have backported the two additional patches required for th=
e 5.10.y tree<br>
&gt; &gt; &gt; and submitted a v2 series. You can find the updated patches =
here:<br>
&gt; &gt; &gt;<br>
&gt; &gt; <a href=3D"https://lore.kernel.org/stable/20260119092602.1414468-=
1-keerthana.kalyanasundaram@broadcom.com/T/#t" rel=3D"noreferrer" target=3D=
"_blank">https://lore.kernel.org/stable/20260119092602.1414468-1-keerthana.=
kalyanasundaram@broadcom.com/T/#t</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Could you please consume these in the next version, or alter=
natively, add<br>
&gt; &gt; &gt; the two missed patches (commit IDs 5b998545 and 719a402cf) t=
o the current<br>
&gt; &gt; &gt; queue?<br>
&gt; &gt;<br>
&gt; &gt; I&#39;ve dropped them all from the 5.10.y tree now, and from the =
5.15.y<br>
&gt; &gt; tree. Can you also resend that series?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Hi Greg,<br>
&gt; <br>
&gt; The other two commits are already part of the stable 5.15.y tree, so<b=
r>
&gt; changes are only needed for the 5.10.y tree.<br>
&gt; <br>
&gt; Please check my latest v2 patchset : (<br>
&gt; <a href=3D"https://lore.kernel.org/stable/20260119092602.1414468-1-kee=
rthana.kalyanasundaram@broadcom.com/T/#t" rel=3D"noreferrer" target=3D"_bla=
nk">https://lore.kernel.org/stable/20260119092602.1414468-1-keerthana.kalya=
nasundaram@broadcom.com/T/#t</a><br>
&gt; )<br>
<br>
I see the series, sorry, they are now dropped.=C2=A0 Can you resend them fo=
r 5.15?<br></blockquote><div><br></div><div style=3D"font-family:verdana,sa=
ns-serif">Hi Greg,</div><div style=3D"font-family:verdana,sans-serif"><br><=
/div><div style=3D"font-family:verdana,sans-serif">I have resent the patche=
s for 5.15.y. You can find them here: (<a href=3D"https://lore.kernel.org/l=
kml/20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com/">https=
://lore.kernel.org/lkml/20260119114910.1414976-1-keerthana.kalyanasundaram@=
broadcom.com/</a>)</div><div style=3D"font-family:verdana,sans-serif"><br><=
/div><div style=3D"font-family:verdana,sans-serif">Thank you,</div><div><sp=
an style=3D"font-family:verdana,sans-serif">Keerthana K</span>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks,<br>
<br>
greg k-h<br>
</blockquote></div></div>

--000000000000b853d10648bc5f57--

--000000000000c4f4a90648bc5f9f
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
i36nH2SuVm4wDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIGHGMCaSzJEoNOhjEhGH
wP7ytQRrDN52zIIffj1Sx2hGMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI2MDExOTExNTU1OFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0G
CSqGSIb3DQEBAQUABIIBAG8YH+KwPSvLA2LXPsyqNhmJPf4Hvryj7DDVIViDzKksx9DsPNlA0RL/
FVJ3k3BQocRO1M51K5B6+5ckIp5354Jv6934lkps9O790AP8vyFyppLSVtnZ1Tyq1J51nD8ARRJV
ED2GiwYp4/m6igWJSgOk568x4zrR5RCLNGPZwm6v9SLzo4doo3fRD6hosjoOqaYTiCp5v3+5ZtzB
q7PufanUdkWDsXVCdYywhGM8mie5k163ml57HZ5ThbDM4r8WLZ3Xhfr/Pt96k+XbLuCladwJp+Cm
NqSNZsvXNRc8Auh8QBmqHEG8vaogjsd/qJtoXy4wDcQJUmCDTavFGt86Uks=
--000000000000c4f4a90648bc5f9f--

