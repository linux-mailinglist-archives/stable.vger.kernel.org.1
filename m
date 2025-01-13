Return-Path: <stable+bounces-108529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30AAA0C141
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 20:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3EFA1883241
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E21C5F1B;
	Mon, 13 Jan 2025 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOoj0yyp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874D1C5F0F
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796141; cv=none; b=Kxlc3PpXi4maVt+EXVDSDu44VfcQEGZxfBLdYbKT0+KFa5RSXzIIoyhdcym5zfeYG4hlUlxG2vhttZve3B6UWL7/MK2pdrzvD1Q2i1oGSRnPA1I4q7r5tB+ovwQO+KsDWYLhIEpv47FfLR08BSiOqMeKcEkU2pCvQ7Pyc/3UfmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796141; c=relaxed/simple;
	bh=IP3oT9TrcqZ0Bnf86EMH5jRtZjfj1ziDMjZViaZM28Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nd8K5Bv2CIur7+A5WzrUoCnVlVLzXE4rCxR0/jp9b1hTAm2/OopuoX0NN9N7UI8SbV5b71/1Kca3LjnPF3QOHj5CbxeiwoxnQkavo3mNs9yjP4ADzyBQETfe6Tbs7hq2XA1bzWqX+qUJ1RZkWf7bCS08YgxFRV1S+ByUCN1gcOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eOoj0yyp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d9f0ab2313so1211a12.0
        for <stable@vger.kernel.org>; Mon, 13 Jan 2025 11:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736796138; x=1737400938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0xjsKp2OLYRFRqJwssjhQwqwCL4yYWaWjRpYckyAMc=;
        b=eOoj0yypOis2se7MJLIZou0TKkRkl4JtavSCm+uTnVh7s652t4wZ+yCvo6wdTMTxUJ
         pT1XjStOZ13X6ZagE4zA5C9RiMtYjwOxB/pW4cEmPfjfitXR/wKQZVP25WmUKDodR4ys
         tGN7OB+W4aMOdOJ1mEeB6v8eTPx9Xr6ckgBKTtRQRJHmy0yk3pqs7eEFhW9z/M5IcSBc
         V7SAAFZ3shIbh5vodLkM/wflEoTgb5y1VAv5KwxqY8/afDJTNPFwJlY373CDAzeteqKy
         GWM94xu5LFeWYFBJub9xhySyCfBr70kcd4l/IUPWKF+9VIOKbaOJDsBeTISBA9JqI4QO
         C7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796138; x=1737400938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0xjsKp2OLYRFRqJwssjhQwqwCL4yYWaWjRpYckyAMc=;
        b=StnY8EYDJUL8q25DLva2XAegPB9olxxtO5dCd9G3iMWM/oocoTF7Sl66/vxnyTJQk+
         GaSzaLfhNu57VJc8E/oTBpuGQy7dIyiMrRyM9annqXKIPNqMIKNabNfrVgQA3IlX28zZ
         MDCv+gbjzl/UTcZkA9Sf/Yapa3u27d8A7QIJiui5HL785AQkRMWgUHMeL0nfZAAj/4Ep
         /6HCRgzW6Zepl7NWQFU/5mKKY8QZNjsNQRd3f532WCJmEjNmFX206e8nEgQlPuicc/8b
         ZU58T78OVAs74XSnP6IWGoRyXgzd/4IW2hxEv8W0ZM1Ju2lhuXa+HYfkvPipEyp1yB1W
         +YFA==
X-Forwarded-Encrypted: i=1; AJvYcCWNIkx7stUFa4B7EazJJgqYp2ehl6aJm+dsTl7vB9lNqtWYgOthHs0w2fjF9Js/aTDSgMv9NvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7YFc1flWtzSE1dkfsZLO53xqvXVje6MLp+I+x/fk4uWIXrlrh
	S/Ru/303MlybUWRPQfgSc1ANrfu9jS9hN/ISQOb8eyJQaCnnakDK20DolKu58xbNIZqGTY8NU81
	zPacHAIehYvp+K5NSyfqmE/yC+913T6P3hTFv
X-Gm-Gg: ASbGncuwb9jl6qPQ00oa0hANkSGSYA0oROGKo46gZehjvun7GrLc3hOJjrATLPd4G1G
	KhuSJ/OpdGFRf4bGN1zPw5DUUJvDjhj8sovxvYnndQVTqBXdzEsrg1aEvBlQqWHlVFWovpvu8
X-Google-Smtp-Source: AGHT+IGGZSYZZCqG+QsrlIe8oZgoFyNwW4y2dGZDFrel3NZa4DIalawZv0wHEcwF1odQcv3YxYY0SyXDhAUf9Bb7oaM=
X-Received: by 2002:aa7:dbc1:0:b0:5d0:eb21:264d with SMTP id
 4fb4d7f45d1cf-5d9f696d4f7mr2247a12.1.1736796137755; Mon, 13 Jan 2025 11:22:17
 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205074650.200304-1-quic_kriskura@quicinc.com>
 <ME0P300MB05534EDF5293054B53061567A61C2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
 <CANP3RGc_SBROWVA2GMaN41mzCU28wGtQzT5qmSKcYsYDY03G5g@mail.gmail.com>
 <ME0P300MB0553900AF75E50947B011FF3A61D2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
 <CANP3RGc7n2vv6vGh7j0Y=7DNqfXnQxZaTcwdPD15kzoY1in08Q@mail.gmail.com> <ME0P300MB05538EF3A86116EF73BE3BE9A61F2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <ME0P300MB05538EF3A86116EF73BE3BE9A61F2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Mon, 13 Jan 2025 11:22:06 -0800
X-Gm-Features: AbW1kvZRLF5VehN_NpB_EfzPpuIFACGspEu8crYcUGGWt2h1hk2BctjKq1uiJmo
Message-ID: <CANP3RGdj0gRohsT=3GUZ84dYZxPDUhe3-Zz26bQrsavYnwtDmQ@mail.gmail.com>
Subject: Re: [PATCH v3] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
To: Junzhong Pan <panjunzhong@outlook.com>
Cc: quic_kriskura@quicinc.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	quic_jackp@quicinc.com, quic_ppratap@quicinc.com, quic_wcheng@quicinc.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 5:31=E2=80=AFAM Junzhong Pan <panjunzhong@outlook.c=
om> wrote:
>
> Hi Maciej,
>
> On 2025/1/13 1:49, Maciej =C5=BBenczykowski Wrote:> (a) I think this look=
s like a bug on the sending Win10 side, rather
> > than a parsing bug in Linux,
> > with there being no ZLP, and no short (<512) frame, there's simply no
> > way for the receiver to split at the right spot.
> >
> > Indeed, fixing this on the Linux/parsing side seems non-trivial...
> > I guess we could try to treat the connection as simply a serial
> > connection (ie. ignore frame boundaries), but then we might have
> > issues with other senders...
> >
> > I guess the most likely 'correct' hack/fix would be to hold on to the
> > extra 'N*512' bytes (it doesn't even have to be 1, though likely the N
> > is odd), if it starts with a NTH header...Make sence, it seems we only =
need to save the rest data beside
> dwBlockLength for next unwrap if a hack is acceptable, otherwise I may
> need to check if a custom host driver for Windows10 user feasible.
>
> I didn't look carefully into the 1byte and padding stuff with Windows11
> host yet, I will take a look then.
>
> > (b) I notice the '512' not '1024', I think this implies a USB2
> > connection instead of USB3
> > -- could you try replicating this with a USB3 capable data cable (and
> > USB3 ports), this should result in 1024 block size instead of 512.
> >
> > I'm wondering if the win10 stack is avoiding generating N*1024, but
> > then hitting N*512 with odd N...Yes, I am using USB2.0 connection to be=
tter capture the crime scene.
>
> Normally the OUT transfer on USB3.0 SuperSpeed connection comes with a bu=
nch
> of 1024B Data Pakcet along with a Short Packet less than 1024B in the end=
 from
> the Lecroy trace.
>
> It's also reproducible on USB3.0 SuperSpeed connection using dwc3 control=
ler,
> but it will cost more time and make it difficult to capture the online da=
ta
> (limited tracer HW buffer), I can try using software tracing or custom lo=
gs
> later:
>
> [  5]  26.00-27.00  sec   183 MBytes  1.54 Gbits/sec
> [  5]  27.00-28.00  sec   182 MBytes  1.53 Gbits/sec
> [  206.123935] configfs.gadget.2: Wrong NDP SIGN
> [  206.129785] configfs.gadget.2: Wrong NTH SIGN, skblen 12208
> [  206.136802] HEAD:0000000004f66a88: 80 06 bc f9 c0 a8 24 66 c0 a8 24 65=
 f7 24 14 51 aa 1a 30 d5 01 f8 01 26 50 10 20 14 27 3d 00 00
> [  5]  28.00-29.00  sec   128 MBytes  1.07 Gbits/sec
> [  5]  29.00-30.00  sec   191 MBytes  1.61 Gbits/sec>
> > Presumably '512' would be '64' with USB1.0/1.1, but I guess finding a
> > USB1.x port/host to test against is likely to be near impossible...
> >
> > I'll try to see if I can find the source of the bug in the Win
> > driver's sources (though based on it being Win10 only, may need to
> > search history)
> > It's great if you can analyze from the host driver.
> I didn't know if the NCM driver open-sourced on github by M$ is the corre=
spond
> version. They said that only Win 11 officially support NCM in the issue o=
n github
> yet they do have a built-in driver in Win10 and 2004 tag there in the rep=
o.

Looking at https://github.com/microsoft/NCM-Driver-for-Windows

commit ded4839c5103ab91822bfde1932393bbb14afda3 (tag:
windows_10.0.22000, origin/master)
Author: Brandon Jiang <jiangyue@microsoft.com>
Date:   Mon Oct 4 14:30:44 2021 -0700

    update NCM to Windows 11 (21H2) release, built with Windows 11
(22000) WDK and DMF v1.1.82

-- vs previous change to host/device.cpp

commit 40118f55a0843221f04c8036df8b97fa3512a007 (tag:
windows_10.0.19041, origin/release_2004)
Author: Brandon Jiang <jiangyue@microsoft.com>
Date:   Sun Feb 23 19:53:06 2020 -0800

    update NCM to 20H1 Windows release, built with 20H1 WDK and DMF v1.1.20

it introduced

    if (bufferRequest->TransferLength < bufferRequest->BufferLength &&
        bufferRequest->TransferLength %
hostDevice->m_DataBulkOutPipeMaximumPacketSize =3D=3D 0)
    {
        //NCM spec is not explicit if a ZLP shall be sent when
wBlockLength !=3D 0 and it happens to be
        //multiple of wMaxPacketSize. Our interpretation is that no
ZLP needed if wBlockLength is non-zero,
        //because the non-zero wBlockLength has already told the
function side the size of transfer to be expected.
        //
        //However, there are in-market NCM devices rely on ZLP as long
as the wBlockLength is multiple of wMaxPacketSize.
        //To deal with such devices, we pad an extra 0 at end so the
transfer is no longer multiple of wMaxPacketSize

        bufferRequest->Buffer[bufferRequest->TransferLength] =3D 0;
        bufferRequest->TransferLength++;
    }

Which I think is literally the fix for this bug you're reporting.
That 'fix' is what then caused us to add the patch at the top of this threa=
d.

So that fix was present in the very first official Win11 release
(build 22000), but is likely not present in any Win10 release...

https://en.wikipedia.org/wiki/Windows_10_version_history (2004 - 20H1
- May 2020 Update - 19041 - May 27, 2020)
https://en.wikipedia.org/wiki/Windows_11 (first version is 21H2 - Sun
Valley - 22000 - October 5, 2021)

