Return-Path: <stable+bounces-114943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18021A31286
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 18:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD083163594
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 17:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5990725A32A;
	Tue, 11 Feb 2025 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbTu3voo"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5E1FDA9C;
	Tue, 11 Feb 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294142; cv=none; b=oxpBHbEs8IdMDvJ7D6p2b3sftzcRlovDYCT0a9EGM2LuOM27Yh0oJwk6UKx1aRUfQFviALp6SfgOnR6FwiWmpON2+suaUvOaxDA1W3kOKvMRITWXst3WnYJZj/g450bp5HJ1AJX51dGcvwZN2Jpdr0SasbPj7lIh7DXqqoXe0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294142; c=relaxed/simple;
	bh=T1Q1rk0OE80nhZXV4WGQJSdwO49rfsJCVQlO2XadBdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsBhM7zohunlnNecxNhUnQ9RfNFwHpS7A/6+ns/Bj3ZU/np9AgDaxYYur3L/sykksfNBle9eRTEBaTMm/sREwSpqt32Lc1Y6WnfxoVZRQKthSvxwoJvh46iWT3/oLrLWvFahMEqxhasvrud8pRrfyr5+KeGECC1ReCxjn1C/JZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbTu3voo; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30227c56b11so60401211fa.3;
        Tue, 11 Feb 2025 09:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739294138; x=1739898938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfGl96TFJZs2GWRZT7rxZNxukJBT7ZKMuf9258x9V60=;
        b=bbTu3voom/QhAAf5sJcArCFcCcbNY1CYqjvacHrutrp4T1L0WC3x36xYInuJGzvvJu
         lrKpib6NxkVLH4twUmvmWzGYkq0oEfpLecMK/2nCl8go5EN49n5ijSVMR1pZq+hPZRAP
         gXWGTz2hoB2nScEO9CuSDCpc72fZ6jHOdbG/iBd8N0v0drEzSDAPisaKxKK6G43GgwtL
         ZXoA1/+LqWTcQmlCKuag3lOI6fSxNTIXfWJGjVWJUbyeN+aM3uCQaayK7GqASxJBPOUN
         YC9P/WQyzFIg0CSWmMQ0J/gB51gO9Tec9utmQOv2Lyu+EVAV1uE1KHXezsv6we6yU7Kf
         xulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739294138; x=1739898938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfGl96TFJZs2GWRZT7rxZNxukJBT7ZKMuf9258x9V60=;
        b=BkU4d/ekxlHrZ/0Z31t+oln0jjlTP9XGFAhMusP1/sNl53auvcQ4r/Lgd/nPuAf64o
         LRox10eFvJ/axQv65KQ73h30oLruEyzHiYAYgkUvxcGS5UDUg+o8J6WssKKLBMD/NNWD
         vFpKKpGxWh7bVd4vnthotN254kkslfxz5DyebFa41BjQOKgZ7qkvzqepPC3FjEMNm+hK
         P1YnqFW9/EHDOde3Nvk9zTalZE/tdG1JpC5pYOBhGUIyJtQG4oKQGi/RdnvSyFgsBo3F
         NJi2chySE6n/wuxAidBf8O1BPBsIemFGVS1MvrZri2RpuhuCty+MD+VwldSW3tQxgR+j
         WN+w==
X-Forwarded-Encrypted: i=1; AJvYcCUkUC/II9T1pQlhzHwg+FnVKTgIbudaI+VodwlJy1i2P9UX1+gBTd87cuQJuQgIjeg/CHd47cX43O7ScsYm@vger.kernel.org, AJvYcCW9SaO3aGmWer6AsEZJHc185YCRKDhQR0rkNTLD8i3o/9BgGGLKbou9wz5uBRSDegghAShloStg6Wzd2Q==@vger.kernel.org, AJvYcCXAmj9pawRe6E+ANaRzkOK2lZKHlbmaS0kzgadO0C+gc6Ffgu8vLZjpeV16IjKVWiQuNxnKMaZP@vger.kernel.org
X-Gm-Message-State: AOJu0YwOuX5shYLCMlH4rsOAWd5fduPAD5EF+zgE8L15H1DP+RsRdER+
	T9+f9ayYMd8nc3ol4QevCMcT88gMkTHDAQYBVX+0ePsqA3q7E/DQWdSJDzsMTTOwPk2JbgHADCb
	QoESuPSeWXtYOh4kJWSWlzNikNC+V065g
X-Gm-Gg: ASbGnctH7S0dHoKSoICdYsjPYDLfmKRrYi3ntsknzYzNClzPJhG6hPVF+7B5Gczu0D7
	UMSeswKGWXvqGt4e9aP2CFOO8ooZP80G9m4Qq+pE25OTpW5Z1OlvrsU0PRuIyO8JNUVqMJ2g=
X-Google-Smtp-Source: AGHT+IHXhXIil0mJkKjM0UNPwB+/GIcgp4QxQg+uZGbCFB7Hzd0beIjAU9fNHW0TvAqCYPNh0xLEqV7JrtPYjKUwYE4=
X-Received: by 2002:a05:651c:4cb:b0:308:eb34:1037 with SMTP id
 38308e7fff4ca-309036d7af3mr1310821fa.23.1739294138031; Tue, 11 Feb 2025
 09:15:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204223524.6207-1-ink@unseen.parts> <9a70a5806083499db5649f8c76167a1a61cde058.camel@physik.fu-berlin.de>
In-Reply-To: <9a70a5806083499db5649f8c76167a1a61cde058.camel@physik.fu-berlin.de>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 11 Feb 2025 12:15:25 -0500
X-Gm-Features: AWEUYZkLtW6GbKRbmIuUzfDkea097tD_F3kJE3D2DWvxdVKj23WttOx86_vFV4g
Message-ID: <CAEdQ38EwN5Ybm31GxOdo-tE6U8Wa4imWZgY=VjmGB=X_XQSaog@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] alpha: stack fixes
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Ivan Kokshaysky <ink@unseen.parts>, Richard Henderson <richard.henderson@linaro.org>, 
	Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Magnus Lindholm <linmag7@gmail.com>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 2:20=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi,
>
> On Tue, 2025-02-04 at 23:35 +0100, Ivan Kokshaysky wrote:
> > This series fixes oopses on Alpha/SMP observed since kernel v6.9. [1]
> > Thanks to Magnus Lindholm for identifying that remarkably longstanding
> > bug.
> >
> > The problem is that GCC expects 16-byte alignment of the incoming stack
> > since early 2004, as Maciej found out [2]:
> >   Having actually dug speculatively I can see that the psABI was change=
d in
> >  GCC 3.5 with commit e5e10fb4a350 ("re PR target/14539 (128-bit long do=
uble
> >  improperly aligned)") back in Mar 2004, when the stack pointer alignme=
nt
> >  was increased from 8 bytes to 16 bytes, and arch/alpha/kernel/entry.S =
has
> >  various suspicious stack pointer adjustments, starting with SP_OFF whi=
ch
> >  is not a whole multiple of 16.
> >
> > Also, as Magnus noted, "ALPHA Calling Standard" [3] required the same:
> >  D.3.1 Stack Alignment
> >   This standard requires that stacks be octaword aligned at the time a
> >   new procedure is invoked.
> >
> > However:
> > - the "normal" kernel stack is always misaligned by 8 bytes, thanks to
> >   the odd number of 64-bit words in 'struct pt_regs', which is the very
> >   first thing pushed onto the kernel thread stack;
> > - syscall, fault, interrupt etc. handlers may, or may not, receive alig=
ned
> >   stack depending on numerous factors.
> >
> > Somehow we got away with it until recently, when we ended up with
> > a stack corruption in kernel/smp.c:smp_call_function_single() due to
> > its use of 32-byte aligned local data and the compiler doing clever
> > things allocating it on the stack.
> >
> > Patche 1 is preparatory; 2 - the main fix; 3 - fixes remaining
> > special cases.
> >
> > Ivan.
> >
> > [1] https://lore.kernel.org/rcu/CA+=3DFv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=
=3DEi90G98ukRcRJA@mail.gmail.com/#r
> > [2] https://lore.kernel.org/rcu/alpine.DEB.2.21.2501130248010.18889@ang=
ie.orcam.me.uk/
> > [3] https://bitsavers.org/pdf/dec/alpha/Alpha_Calling_Standard_Rev_2.0_=
19900427.pdf
> > ---
> > Changes in v2:
> > - patch #1: provide empty 'struct pt_regs' to fix compile failure in li=
bbpf,
> >   reported by John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>;
> >   update comment and commit message accordingly;
> > - cc'ed <stable@vger.kernel.org> as older kernels ought to be fixed as =
well.
> >
> > Changes in v3:
> > - patch #1 dropped for the time being;
> > - updated commit messages as Maciej suggested.
> > ---
> > Ivan Kokshaysky (3):
> >   alpha: replace hardcoded stack offsets with autogenerated ones
> >   alpha: make stack 16-byte aligned (most cases)
> >   alpha: align stack for page fault and user unaligned trap handlers
> >
> >  arch/alpha/include/uapi/asm/ptrace.h |  2 ++
> >  arch/alpha/kernel/asm-offsets.c      |  4 ++++
> >  arch/alpha/kernel/entry.S            | 24 ++++++++++--------------
> >  arch/alpha/kernel/traps.c            |  2 +-
> >  arch/alpha/mm/fault.c                |  4 ++--
> >  5 files changed, 19 insertions(+), 17 deletions(-)
>
> Can we get this landed this week, maybe for v6.14-rc3? This way it will q=
uickly
> backported to various stable kernels which means it will reach Debian uns=
table
> within a few days.
>
> Thanks,
> Adrian

Yeah, I'll vacuum the patches up and send them to Linus.

I've been running them on my ES47 and while my ES47 is still unstable,
these patches definitely solve this bug [1] and fix failures I saw
with the rcu_torture module!

Thanks a bunch to all of you!

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D213143

