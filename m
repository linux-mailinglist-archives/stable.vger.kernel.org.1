Return-Path: <stable+bounces-105383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1549F88F8
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 01:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED57169774
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 00:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29917259497;
	Fri, 20 Dec 2024 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKnT5c8S"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DDE4C85;
	Fri, 20 Dec 2024 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734654484; cv=none; b=EXSlmXySmnvO/XofKSwdlhz4xUWLqOxXyr78AcLSz2c0Ztmclxb9a5Mzy7Ga9dIS7pWIK0/1Wp3sjkLuFCPZV8o1BRJUYvSm4Ih2iIua9S/hDMqTROwj3eeWgisP+v2Ic7zR8voVwil/r1mUk/PGtqnDGYVx+IbhA3Qb53Fomkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734654484; c=relaxed/simple;
	bh=eTO4qLFVLWM7uDPgkBqgHCUS/GGGhm4RqKXT6sImQfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxgFg6agS6DLC1zi8wXJMJhoM13G96GmY3OoCBvfJlZLjrG3OGNPzgnIZXwdFYYYfPjORMSjDwV1+l9Ipiz/vSCPWh6SdbrCRA4uJlU/HlRVwSW1TyoVjBh/7+eF6rEzvHpjviQhtVQ2wBDiGZOQBBD7gbrw9FbWgXlWI5rkxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKnT5c8S; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5401bd6ccadso1274771e87.2;
        Thu, 19 Dec 2024 16:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734654481; x=1735259281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UhCGwjT4MNgsAsS3x60eka2ReGd19hVX6zntAyJ6Al4=;
        b=UKnT5c8SsXAMpKO5lAF0Cxv9sqcUdKEu3k0V3xETBgHZnTlqSmT+N2fQKfbkOA0ScN
         UB1erDcNflu2Nm+OxPrQYd5IiT98prNAvewcjAChSQ7fHCvmt58ndMIttAR3WO1RFHGW
         8OEGzSuzpj9NSFJxqMJHPy/PpKAmiPKG4gs25e2kISy5K25ElY2EK6jo7tcdaR+8dSQQ
         E2wBgdDLbgBjGZEtuKFJNmoxJeU2TFW9tyFYplRlvBJKPOxsACREk+1Dwyei9+nHg6d0
         oCdVf5zFxCSyD6TGvGjuRAwzbzscrIV+xFPu415FNztzvn+zN8M/ZAzHdWMh/Zby19/V
         395g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734654481; x=1735259281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhCGwjT4MNgsAsS3x60eka2ReGd19hVX6zntAyJ6Al4=;
        b=wly0KSDOfmFzbAuhmE6AGQTB/Ha5HixMdDJOJbEzxtnjQ6RoCCUmVHDXoaQyLSpDDg
         XU5D/6CEBSBeRilpkIeVakRtO2/+UsnI3NXiIVCigRNsiTv5KiF7hffiYaMqnEJtlGYL
         x8NzXLbSTMjhaJBWAdmKjhdqi/eZGE3ospKwTA8oIki34ZUZKl63RDpni5yWHIqhJqLj
         9GLsP05pxHigZecosG/TGaO2NElePxpPD3JrmGEoY0IkbwlMsrYATwk7Yy8s5cO/45t0
         CtYGu0R78Kcs2+tT+ar3Rzkq0Ln6db3IynNUnHvNhSL+5vg5r1VampzGguGY3aGs4xhb
         55/g==
X-Forwarded-Encrypted: i=1; AJvYcCUjC2GQ+83s1I1QDZzNsYZ6hRzPnrkFEWydWFS4aOZTLl9AWB4quGFEp8yQdTggZqSAAN3pPbMZ@vger.kernel.org, AJvYcCUxalAKXMHAaQCv74Lgz7fun2bVxccHrS0C5zi1V6Z2rlnKTbq7s7xnyTdxH0BKEl5IEabWO6VA1WIRAkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXrpy5GXHTM+HkEYPPHvK6NEJW5fiCdCb+5of7nOsrTWk8nM0i
	ovDVqbzJxKA2l87dZHYgRUvPvmgm9Mn/rBXfF48rjR6r8seE9nF5VssogzdGxVT5wNTbP23uQwe
	Nau94OnlXfg6VwPJWm7PbVfB/NQk=
X-Gm-Gg: ASbGncvpXdeQUouneqZOgF5G3obQ5a+TikzcEvVFlxONC1XL38krGczmkL4cpVw2zQJ
	yrdV7VTprZj8ehxo31l9BXY18M+RWCq5bZTzD7lqc3mooDb38aLrY957ylTCCNmBZdKrb
X-Google-Smtp-Source: AGHT+IHdMSqXFO0bUVEDAZ4SCZ2fQwBZ1kEmH9L/snNjAN+YPeQgREXfx920dn0tlJ68REUVRA6KTN5FtpWwCfHyps0=
X-Received: by 2002:a05:6512:318d:b0:542:2192:3eb6 with SMTP id
 2adb3069b0e04-5422956bdb6mr135555e87.52.1734654481033; Thu, 19 Dec 2024
 16:28:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUWHU=oXOEj5wHTzxrw_wj1w5hTvqq8Ry400s0ZCJjTEZw@mail.gmail.com>
 <099d3a80-4fdb-49a7-9fd0-207d7386551f@citrix.com> <CA+icZUX98gQ54hePEWNauiU41XQV7qdKJx5PiiXzxy+6yW7hTw@mail.gmail.com>
 <CA+icZUW-i53boHBPt+8zh-D921XFbPb_Kc=dzdgCK1QvkOgCsw@mail.gmail.com> <90640a5d-ff17-4555-adc6-ae9e21e24ebd@citrix.com>
In-Reply-To: <90640a5d-ff17-4555-adc6-ae9e21e24ebd@citrix.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 20 Dec 2024 01:27:24 +0100
Message-ID: <CA+icZUVo69swc9QfwJr+mDuHqJKcFUexc08voP2O41g31HGx5w@mail.gmail.com>
Subject: Re: [Linux-6.12.y] XEN: CVE-2024-53241 / XSA-466 and Clang-kCFI
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Jan Beulich <jbeulich@suse.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 12:26=E2=80=AFAM Andrew Cooper
<andrew.cooper3@citrix.com> wrote:
>
> On 19/12/2024 11:10 pm, Sedat Dilek wrote:
> > On Thu, Dec 19, 2024 at 6:07=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.=
com> wrote:
> >> On Thu, Dec 19, 2024 at 5:44=E2=80=AFPM Andrew Cooper <andrew.cooper3@=
citrix.com> wrote:
> >>> On 19/12/2024 4:14 pm, Sedat Dilek wrote:
> >>>> Hi,
> >>>>
> >>>> Linux v6.12.6 will include XEN CVE fixes from mainline.
> >>>>
> >>>> Here, I use Debian/unstable AMD64 and the SLIM LLVM toolchain 19.1.x
> >>>> from kernel.org.
> >>>>
> >>>> What does it mean in ISSUE DESCRIPTION...
> >>>>
> >>>> Furthermore, the hypercall page has no provision for Control-flow
> >>>> Integrity schemes (e.g. kCFI/CET-IBT/FineIBT), and will simply
> >>>> malfunction in such configurations.
> >>>>
> >>>> ...when someone uses Clang-kCFI?
> >>> The hypercall page has functions of the form:
> >>>
> >>>     MOV $x, %eax
> >>>     VMCALL / VMMCALL / SYSCALL
> >>>     RET
> >>>
> >>> There are no ENDBR instructions, and no prologue/epilogue for hash-ba=
sed
> >>> CFI schemes.
> >>>
> >>> This is because it's code provided by Xen, not code provided by Linux=
.
> >>>
> >>> The absence of ENDBR instructions will yield #CP when CET-IBT is acti=
ve,
> >>> and the absence of hash prologue/epilogue lets the function be used i=
n a
> >>> type-confused manor that CFI should have caught.
> >>>
> >>> ~Andrew
> >> Thanks for the technical explanation, Andrew.
> >>
> >> Hope that helps the folks of "CLANG CONTROL FLOW INTEGRITY SUPPORT".
> >>
> >> I am not an active user of XEN in the Linux-kernel but I am willing to
> >> test when Linux v6.12.6 is officially released and give feedback.
> >>
> > https://wiki.xenproject.org/wiki/Testing_Xen#Presence_test
> > https://wiki.xenproject.org/wiki/Testing_Xen#Commands_for_presence_test=
ing
> >
> > # apt install -t unstable xen-utils-4.17 -y
> >
> > # xl list
> > Name                                        ID   Mem VCPUs      State  =
 Time(s)
> > Domain-0                                     0  7872     4     r-----  =
   398.2
> >
> > Some basic tests LGTM - see also attached stuff.
> >
> > If you have any tests to recommend, let me know.
>
> That itself is good enough as a smoke test.  Thankyou for trying it out.
>
> If you want something a bit more thorough, try
> https://xenbits.xen.org/docs/xtf/  (Xen's self-tests)
>
> Grab and build it, and `./xtf-runner -aqq --host` will run a variety of
> extra codepaths in dom0, without the effort of making/running full guests=
.
>
> ~Andrew

Run on Debian 6.12.5 and my selfmade 6.12.5 and 6.12.6.
All tests lead to a reboot in case of Debian or in my kernels to a shutdown=
.

Can you recommend a specific test?

dileks@iniza:~/src/xtf/git$ sudo ./xtf-runner --list functional xsa | grep =
xsa-4
test-pv64-xsa-444
test-hvm64-xsa-451
test-hvm64-xsa-454

Is there no xsa-466 test?

Thanks.

BR,
-Sedat-

