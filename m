Return-Path: <stable+bounces-172189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5686DB2FFD8
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F5A1882F30
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A4C2DA76C;
	Thu, 21 Aug 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vyaq6cTe"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E72DA743
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793127; cv=none; b=NoUzZBzeDZSNyQ2qzvXuZ+bo9kLxRE3SgPR47Us0VEMmAeLdtcC+0A2fLVQW9ry6M/VQJGUc5rdzUg+H8OGBhmYjoWtROsys0o+6OJPE1oJ9r0Y8vGhJ/tq4Jumg9IpFzubUJcbWYdVgaHcUo5sj1ahHJaWvIHCcS7IxHfImj3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793127; c=relaxed/simple;
	bh=KW7X69odbBm9aUyUm5Gna2h9dVBp3wBzBKo+AhbDR+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7KHTEyROBols5THC0yuWFy1FIiZN79xK0gtiE9ZnjiWiUlEO2DMZf79WWUGIpy3tzfshWYwcFXqM2g/1Gw6xXJRIGrRoceYMo2n74EXbz7tal4cU9TgGSi9QNSJVNu31EoFfQI+5Dzuxa0Jz24HPQyvP+7sLtDHXuweiRISvEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vyaq6cTe; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61d99c87d32so545242eaf.1
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755793124; x=1756397924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/kgWz84JgBVeLVTDbEVdswXhuU3eGT9Q6c09Y/7GpI=;
        b=Vyaq6cTeDKk/YCfb8C9ipxQwEsO4KBNrt6bTK0sbJnRroBSSKQsnTyTPcIeAwtBTJQ
         OzpIaDZ+rl2gbjHbUIw0Eql/8bMxS9cuYuh5Wx/0iE9BSJXc6cjN3w19wbauZ0xHBEKk
         ugnGfmTLnDU9wwAy5zWjTDAEtWoEnNeivcwu2A2scOUBSnTpb9c6BygEw495nuL3j7ds
         mZ+pLhC2c1CLYZMX3aGT2mECI4LYkQehgkt5bLh2x04YJNDjeCtnrIFn/vub6gy8U3gP
         Il4Oj14KINgAlk6arqlpR3W3BQcEFgUheBbGqWAY6zGYp6dDu/tylc+HrddoQP5OTFSY
         m2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755793124; x=1756397924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/kgWz84JgBVeLVTDbEVdswXhuU3eGT9Q6c09Y/7GpI=;
        b=g9wbMOmejx3DyJYQuEgrIBCvnSQOStbf836Zp1tz6fSkOq3sslOdExAcYzDiZOmozX
         da3TLxnOxfPp014qBrhXzWiuRdSv0q5F+Rwp96OvZdUz6h0dvv6wi2qcflogJh6S+xQQ
         mATKNIHgMtI2tmm7wOpNboAoaZvQXEcK/SHF88Xch5vvCtyzP4st7H+/Z6BwnRhQuaDV
         8sbp1Nb8HGEt9TL79qAG+LF4+d7MxrOpZSrXrcyXIkJeZIgK9GocmxoPuDqGYD4XMREF
         +cCFoXtIqI6Q5a7sn8nGj1XJgxAQuJxWC1tA92V2ibqa7UmhVWdyeWaCHfrwis5nAOpM
         opCw==
X-Forwarded-Encrypted: i=1; AJvYcCXRFnZZR8KxR6z8x6KllYufPJrmWusM+1FGIdZx7+z5R8RTvatwPmslbSrLYeVU02AycnMA+rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEKl8GYIwwItdfEPgfjvyFwt7NLkp9x46obwuqKqiEDkIPsT/A
	q1uUwYG8hev4B0EdhAkrQyY3TJKXlme6dLgdZZBkcHQ4ZNT01oHfEsZYVUHRVLdAJRLbEXGLQbL
	0aCis2S3NTxtdE5P3WntIEDzu701QIUE=
X-Gm-Gg: ASbGncuR24AzxyROaBtdywkTWDs+ROlShvqbh0S6ho/2SugIVEac1xU5aByR+XOASwP
	ZbmYXtcXzIfMB953J4F+PKhnIBZKWRdafBkZdgxFly5hE39IIuDvR3/XzJoD/Wqwd9EPiZ22BqV
	aUp5HGo73GDRul7Uq2dselTH5Mu6pY740s8OvtbdoAN2qjRvcZwO+gLVwGgyJNByx5R5mm43HA/
	F4g
X-Google-Smtp-Source: AGHT+IGxmLuafPwAwDkyNnqlueog5FlfgG/j27pU5nhQ2cB04Y8TJM9Suwdckz/XzevG80YdbjM0/bKtFAjNu506HBg=
X-Received: by 2002:a05:6820:1c99:b0:61c:4fa:7465 with SMTP id
 006d021491bc7-61dab06512emr1351756eaf.0.1755793124399; Thu, 21 Aug 2025
 09:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABFDxMHgOPt5zx3q=KRxGGfp86R4V0AgO+FrHDftqLYoG20BWw@mail.gmail.com>
 <20250821155833.57597-1-sj@kernel.org>
In-Reply-To: <20250821155833.57597-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Fri, 22 Aug 2025 01:18:32 +0900
X-Gm-Features: Ac12FXzi3h9xpcGpuOkzdRydRGIYtRmhUHBmyrmZ9RELoX71HPL9qduVXxKXs_E
Message-ID: <CABFDxMFy18rb3K0NYYKifsBVD8MoA=O5Aj=g+KS5gR1R9GCEdQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at
 first charge window
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 12:58=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> On Thu, 21 Aug 2025 20:06:58 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > On Thu, Aug 21, 2025 at 2:41=E2=80=AFPM SeongJae Park <sj@kernel.org> w=
rote:
> [...]
> > > Let's restart.  Could you please rewrite the commit log for this patc=
h and send
> > > the draft as a reply to this?
> > >
> > > We can further discuss on the new draft if it has more things to impr=
ove.  And
> > > once the discussion is finalized, you can post v4 of this patch with =
the
> > > updated commit message.
> >
> > Good Idea. This is the draft for commit message. Also, Thank you for
> > your patience and understanding.
>
> Thank you for accepting my humble suggestion.
>
> >
> > Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> > include/linux/jiffies.h
> >
> > /*
> >  * Have the 32 bit jiffies value wrap 5 minutes after boot
> >  * so jiffies wrap bugs show up earlier.
> >  */
> >  #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> >
> > And jiffies comparison help functions cast unsigned value to signed to
> > cover wraparound
> >
> >  #define time_after_eq(a,b) \
> >   (typecheck(unsigned long, a) && \
> >   typecheck(unsigned long, b) && \
> >   ((long)((a) - (b)) >=3D 0))
> >
> > When quota->charged_from is initialized to 0, time_after_eq() can incor=
rectly
> > return FALSE even after reset_interval has elapsed. This occurs when
> > (jiffies - reset_interval) produces a value with MSB=3D1, which is inte=
rpreted
> > as negative in signed arithmetic.
> >
> > This issue primarily affects 32-bit systems because:
> > On 64-bit systems: MSB=3D1 values occur after ~292 million years from b=
oot
> > (assuming HZ=3D1000), almost impossible.
> >
> > On 32-bit systems: MSB=3D1 values occur during the first 5 minutes afte=
r boot,
> > and the second half of every jiffies wraparound cycle, starting from da=
y 25
> > (assuming HZ=3D1000)
> >
> > When above unexpected FALSE return from time_after_eq() occurs, the
> > charging window will not reset. The user impact depends on esz value
> > at that time.
> >
> > If esz is 0, scheme ignores configured quotas and runs without any
> > limits.
> >
> > If esz is not 0, scheme stops working once the quota is exhausted. It
> > remains until the charging window finally resets.
> >
> > So, change quota->charged_from to jiffies at damos_adjust_quota() when
> > it is considered as the first charge window. By this change, we can avo=
id
> > unexpected FALSE return from time_after_eq()
>
> This new draft looks good to me.  I find nothing to further modify.  Coul=
d you
> please send v3 of this patch with the above commit log?

I'm really glad to hear that! Your thoughtful comments really brought
this together.

>
> Thanks,
> SJ
>
> [...]

Best Regards
Sang-Heon Jeon

