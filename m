Return-Path: <stable+bounces-108654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E68A115CD
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 01:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1EF168AF2
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 00:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EB51876;
	Wed, 15 Jan 2025 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VMpH4nFA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D844536B
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899469; cv=none; b=Ukkn48qrOj/NhwBIG5Df4uaW4Yepqw58aEOb5JgpnPaat0R/ZE3G/osdweqIYHV1Nvk5TPsx5C7tsGwDKAks4ht65j2ea5+UMmCq248qvetBXRjn4aVptTdUUabhW2OPb6uad/YADW21Zpx/oD6u97JZAen51N4Rn8aI3hOb4c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899469; c=relaxed/simple;
	bh=lGdT/qhz8wpBR/XYfbcNxkSB2Ngs3f4fPi729qGH1JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YysEFBuBK9gO7IvefevY5pamIAa9TkRzthQCe7C9CadLANsxx16BSirXYqi95CRW5kS8UG0DZkJqFgWe70s3q0dkV0xndxBisbSgyN6dncQOqNL17kkUU+80fJZqHQzt0nLL73mngbuDi1w1Y25Voo+Q1hFAPMJScwmyBAdog4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VMpH4nFA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3e638e1b4so11440a12.1
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 16:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736899466; x=1737504266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqY5zzFkxq7jG4QINHaYD3F3aVB+A8QP+jnx+vp442o=;
        b=VMpH4nFAnbIdWM1wtdzF9/KQim1H8qBad7u0cvJ8A546peS58DsrVBth/5ZczJTK9+
         sb2QFfImz+dkKW+GF+6PoSlKGu3HKKfCRvjtzfq0A9g+xW8WybmKf9GC8upa+FfondGF
         Jx+bBGdnexOchKGTF9lm/4v9QhO6r/7l/Xn6Lw3fbzgL6CgttV88ybHUlxIqTTGt0OTE
         Ry5L/wKT3dhSSPePqGU5UR9fk8uD5Q5FlkrxnQiIRWTEpY9Raz5JE+lJDcbjHYdB7Z+m
         nHGFt6rIXL9lrhwRRE3T/TSgsmbolHdvKH8uAbefUAq2R+yJSluxSJfGe4HrdxQwvHAx
         3/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736899466; x=1737504266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqY5zzFkxq7jG4QINHaYD3F3aVB+A8QP+jnx+vp442o=;
        b=Guvpld8Jat5QN9xHuI4C/d2F7gZJ3Vh7SeXdxKkSYSdcNd4wcAvCVG6FlhKhhrkvvm
         fcSQ9X9dgMFoDBtZ8LsChSRu7QYV5y7ArBdJmAZsagllxX6JWMGUxc26CVG/dYHwHSrg
         ISa6Hl9dvYoUdyUCez7jdAoFRNC7drv7OB6g5pI40D4gU97r6XznKnMu6lnmfZSKCTOG
         Fp9C43R0QcCXBV/O7S9u6JyZlvYJHcIWclMiSrWTJ0145X1iHaqxLYPe1yfONaO8rjGN
         iqKbmDnnFd1r9ddO8xck8LCn9zzoO2dUXZdUrsvGocrAcw4knc8nEVd07fNeOq+aFyid
         /9bw==
X-Forwarded-Encrypted: i=1; AJvYcCXpOcrmT5x1dQ75yshApNt2yZEqV1o0PBdQHqN++b08ZJeAHvQVfiuwnbelEf6/mOKPLh9qIYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCjnMarLhzyomwGC6X746bZxJaD7pwr4v6QwzE9xWBo6XCQshm
	2ss/VDXxgS9Fo3Bd/MZC2zvng+E+mAz3G/vE0NiBUUKmaxb1Ctc6byjAD0dw5DzqUIYakNqipne
	JwFdyOW41icNJnKibMBlGqXmUJAOoh+qIYf2f
X-Gm-Gg: ASbGnctqTrYdbRRuMBA5fGJ7tNLN8xfPmCCi+XB606YTrcNG/2jNTpmRen5xi2NPaCK
	5VZhFzG5A44Uzneouw+bjvSryuvgRtTj7b68n1A9cjcm9itEQ+5zQP9IRPymtjS1/hGWpInes
X-Google-Smtp-Source: AGHT+IEUEbQypVw1mRfmbnTIf4Ukyb7+76eD4I9b04vMNyyXvxqrWfo9orEAwoZLePsfoZJ4Qujt2DezTMRTHdgI43A=
X-Received: by 2002:a50:8e14:0:b0:5d4:428e:e99f with SMTP id
 4fb4d7f45d1cf-5da0dd6825bmr16057a12.3.1736899465888; Tue, 14 Jan 2025
 16:04:25 -0800 (PST)
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
 <CANP3RGc7n2vv6vGh7j0Y=7DNqfXnQxZaTcwdPD15kzoY1in08Q@mail.gmail.com>
 <ME0P300MB05538EF3A86116EF73BE3BE9A61F2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
 <CANP3RGdj0gRohsT=3GUZ84dYZxPDUhe3-Zz26bQrsavYnwtDmQ@mail.gmail.com> <ME0P300MB0553E15D02A52DB482496B2CA6182@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <ME0P300MB0553E15D02A52DB482496B2CA6182@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Tue, 14 Jan 2025 16:04:13 -0800
X-Gm-Features: AbW1kvZf6lbKucEi2XjVR3ji7JTiy35boIEgV6OwYyYsGuIHElBDcKBxGBxUAy8
Message-ID: <CANP3RGczVx8qVG=joNJGtj2cFfh5hd0Ni2Xs2ZSA37s-jB1epA@mail.gmail.com>
Subject: Re: [PATCH v3] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
To: Junzhong Pan <panjunzhong@outlook.com>
Cc: quic_kriskura@quicinc.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	quic_jackp@quicinc.com, quic_ppratap@quicinc.com, quic_wcheng@quicinc.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 7:46=E2=80=AFPM Junzhong Pan <panjunzhong@outlook.c=
om> wrote:
>
> Hi Maciej,
>
> Thanks for your quick reply.
>
> On 2025/1/14 3:22, Maciej =C5=BBenczykowski Wrote:
> > Looking at https://github.com/microsoft/NCM-Driver-for-Windows
> >
> > commit ded4839c5103ab91822bfde1932393bbb14afda3 (tag:
> > windows_10.0.22000, origin/master)
> > Author: Brandon Jiang <jiangyue@microsoft.com>
> > Date:   Mon Oct 4 14:30:44 2021 -0700
> >
> >     update NCM to Windows 11 (21H2) release, built with Windows 11
> > (22000) WDK and DMF v1.1.82
> >
> > -- vs previous change to host/device.cpp
> >
> > commit 40118f55a0843221f04c8036df8b97fa3512a007 (tag:
> > windows_10.0.19041, origin/release_2004)
> > Author: Brandon Jiang <jiangyue@microsoft.com>
> > Date:   Sun Feb 23 19:53:06 2020 -0800
> >
> >     update NCM to 20H1 Windows release, built with 20H1 WDK and DMF v1.=
1.20
> >
> > it introduced
> >
> >     if (bufferRequest->TransferLength < bufferRequest->BufferLength &&
> >         bufferRequest->TransferLength %
> > hostDevice->m_DataBulkOutPipeMaximumPacketSize =3D=3D 0)
> >     {
> >         //NCM spec is not explicit if a ZLP shall be sent when
> > wBlockLength !=3D 0 and it happens to be
> >         //multiple of wMaxPacketSize. Our interpretation is that no
> > ZLP needed if wBlockLength is non-zero,
>
> In NCM10, 3.2.2 dwBlockLength description, it states:
> > If exactly dwNtbInMaxSize or dwNtbOutMaxSize bytes are sent, and the
> > size is a multiple of wMaxPacketSize for the given pipe, then no ZLP
> > shall be sent.

But the Linux ncm gadget driver sets both of those
(dwNtbIn/OutMaxSize) to 16 kiB (I can never remember which one is
relevant to which direction, I think in this case it's 'In' cause it's
relevant to the gadget/device and thus affects what is sent by Windows
and parsed by Linux).
So with 15.5 kiB this is not relevant, right?
(Please correct me if I'm wrong)

Furthermore that 16 kiB is also the size of the preallocated receive
buffer it passes to the usb stack, so there won't be a problem without
ZLP (post 16 kiB xfer), because the buffer will naturally terminate.

> I don't know if its a Microsoft's problem or really **not explicit**.

I *think* (in this case) this is very much an MS problem (and the fix
in the newer driver confirms it).
Short packet / ZLP termination is simply how USB works to transfer packets.=
..

Unfortunately MS is not the only one with problems with ZLP.
See Linux's drivers/net/usb/cdc_ncm.c 'NO ZLP' vs 'SEND ZLP' and the
FLAG_SEND_ZLP.
and note it's set on Apple tethering...
[I think your quote up above is exactly why the standard requires 'NO
ZLP' operation]

So there's very clearly ample confusion here...

> Maybe most of the device implementations treat the incoming data as a
> stream and do contiguous parsing on it.
>
> >         //because the non-zero wBlockLength has already told the
> > function side the size of transfer to be expected.
> >         //
> >         //However, there are in-market NCM devices rely on ZLP as long
> > as the wBlockLength is multiple of wMaxPacketSize.
> >         //To deal with such devices, we pad an extra 0 at end so the
> > transfer is no longer multiple of wMaxPacketSize
> >
> >         bufferRequest->Buffer[bufferRequest->TransferLength] =3D 0;
> >         bufferRequest->TransferLength++;
> >     }
> >
> > Which I think is literally the fix for this bug you're reporting.
> > That 'fix' is what then caused us to add the patch at the top of this t=
hread.
> >
> > So that fix was present in the very first official Win11 release
> > (build 22000), but is likely not present in any Win10 release...
>
> As you mentioned before to fix it in the gadget side, it seems very
> complicated, maybe we need a extra skb with size=3Dntb_size as an interme=
diate
> buffer to move around those ntb data before parsing it, but may (or may n=
ot)
> lead to performance drop. Any other idea?

It would definitely lead to a fair bit of code complication, and in
the particular case of this happening it would involve (at least) an
extra copy (to linearize), so definitely be a performance hit.

I think we'd have to have a potential extra buffer/offset/length.
Initially it would be null/0/0.

Whenever we receive a frame and parsing it leaves us with leftover
bytes, we'd have to allocate this buffer, and copy the leftover stuff
into this temporary area.

Try to parse it (note: potentially repeatedly, because we could have 8
2kiB merged pkts...) and swallow the part that parsed, but if the
buffer is too short, then hold on to it until we receive more data.
If we ever manage to fully parse it - we could potentially deallocate
it (or hold on to the memory to avoid multiple alloc/deallocs).

When we receive a usb xfer, if the buffer already exists (or is non
zero size), the new xfer needs to be appended to it, and parsing
repeats.

This btw. implies this needs to be a 32 kiB (2*16) buffer... vmalloc
would be fine.

I think we'd likely need to get rid of the way this stuff abuses skbs
for usb anyway.
I've wanted to do this anyway (note: not sure I've seen this in the
gadget or host side ncm driver).

Ugh...

> Do you think hacking in the gadget side to fix this compatible issue is
> a good idea consider that there are still a large number of users using
> Win10?

I'm still thinking about it, but I'd far prefer for MS to fix their
Win10 driver.
This just seems really hard to fix in the gadget.

> (Though Win10 will reach end of support on October 14, 2025,

Far longer than that.  Since there's (purchasable) extended support
(+2 years), and non consumer Win10 EOL is further out as well
(Enterprise is Jan 2027, business/school Oct 2028, IoT Jan 2032, etc).

> but people may still use it for a long time

Yeah, Win10 will be around for many many years to come...

> since many PCs in good condition cannot install win11.)

Or people don't want to, even when they could :-)
I personally have a win11 capable PC that I'm refusing to upgrade...
(and a pair that are too old)

This is only the *second* time Win11 actually has something (beyond
what's in Win10) I could potentially maybe actually want (the first
being related to WSL, though I've since stopped using it).
I miss XP with classic UI (maybe Win7 was better? not sure).

