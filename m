Return-Path: <stable+bounces-105536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2239FA1B4
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 18:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10D1188D51A
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6DC1547F0;
	Sat, 21 Dec 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux+eQ7nD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3326A154BE4;
	Sat, 21 Dec 2024 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734800808; cv=none; b=Ol1RTTviHcl/V+/ElZCzkMlMxPf4Mk1EW/ZPID43/wr2VHH3nOjMWtUMFpe1tD/fHsQRL+aZ2uJUU22vI8CVP+ODEwxfXYeVGpDmiiBhF6N34tR6LXnEHW0dxVIRev4qxZHjc5vnfmWRLLvn54oySl4NcKE35KjCU3ULvqZIa1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734800808; c=relaxed/simple;
	bh=KQ9kRAwsMgtVXjzCbzp/JSJRsjYcY4KE8q41rvpS99g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAbRIjpxF0ffnAa1pzFeVyPE33AOkVfaX+dxAop6uzYu0mdmeWHS4/epVYPpwweTWc3iX4pq9d3VUEIN7gqSmSJQEllxdsm17kOiPVH86aM5ruo26n7hwinjMMc+we4QYRL8sPFaHemu5QME9YB5FF+OfQmhzhwRUVtN4+Caz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ux+eQ7nD; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53e389d8dc7so3013523e87.0;
        Sat, 21 Dec 2024 09:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734800804; x=1735405604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=agKbG4Ad2aFh5DQ9Ty8+oto7J07OzvutBur24QnJNbs=;
        b=Ux+eQ7nDPi0Rarr+HcVrMb1AsczhpkNU7N9BrPH675CGsQRR/3n/T1shp/WF5Ku9wy
         vnP3X3uuWTAmjT0ppONk+GEjsJ6+rIk8OlwZTJuDdbqSnUzRBaf6aKsE2N9Ai6DGj20/
         WJVTBY4qQ0uAkjIuatN+wAG0MofbnNVeOv0ME8zAeR+WmAiHcopJDWL/9ne/hq4wgf7p
         m++IlZxthHs+AWa2Qt6paxe5V21WO9ugLc1SuW2TJ9DmGihHXVmh396m2DOVZoFULpeF
         lJue6x+jHUHlBJluQSkld5NQM3xi4k1uNvTCPfIesTP7W+PIxN7y8W2VXxid6MMn8jmR
         g/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734800804; x=1735405604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agKbG4Ad2aFh5DQ9Ty8+oto7J07OzvutBur24QnJNbs=;
        b=q6OQG4hyGCZVUxv2JZ0leHd2H8bLmUMIpxE7g48Roto2aVBXaAjmSSY/K5h8UEfGq6
         OuNyWbTredK1gWBDZ3jrntjnwEDZwWnnIwwOdRpHXKw6xKs+PraYztEtAgc3JHYK7GSs
         5V+LP3ZRWjGmT1sEGkq6EzfejpejJAZejjsOCylP7hJOhuOoO5ogbDlJOttbLbPGFVcV
         QEhkFF8O4sLzSmY5SUHh+0Mm7uMkqdv1MZerDcS/CdqIkKgX8f/Y9tkXSGmuH13gdPV0
         G3bOJR2ppwk50DJqv+hnr+wMpzQ5IzDvwHDpnvzhh3O3UqIXkoaefemuGO5TSffUiZ3d
         gvKw==
X-Forwarded-Encrypted: i=1; AJvYcCVg9fnQQ0YEcgYXur2nIZMdyfl+afgCI01RmWQMLrVxignfPnrFDPwOEJyQmHd65dcxwE2TxqF3@vger.kernel.org, AJvYcCW+OiFt+0Xes4r9in2AofR41veFORXdGDZ8TJUNb1AIAoO5qKNZF5tihdErgG75OgsUKM0YxICOY2iUsc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTC/Do4+fVxNbGPtWhkuD9ZIyTC0Fht4Y4HcIuDKD1vurP2RQH
	FhM0cAnCRgmqs/wQ1mqcrDbQX67LuY/0K3CYjN6fdfVtl9XgdY0C/3OaCGgzbxUWjum2mxTt2Rs
	bMov+YExOXw16n5HGFukACxtJmO8=
X-Gm-Gg: ASbGncsnR8DTVeXPUbqmzuMu6ZAwunRCzyzwbsE/T3gZ7dETmImklkscvKM71UVVWlM
	CZGzTH1czUFbapJ9ZLm5JdE8KqIwOaXjDqWGh8aP7/cLjdJkdDh/sK9/cF3Fd+tqtlhko
X-Google-Smtp-Source: AGHT+IFlbPcGmfsM9lCdXkpNmrdsNPjnuj/3oeIGySw+8+ouW9qKDdkS6zFmZVV0L0qLBb8weZW1jPVbzwqmFTzG3VQ=
X-Received: by 2002:a05:6512:2214:b0:53e:38df:672a with SMTP id
 2adb3069b0e04-5422956289amr2032769e87.36.1734800803975; Sat, 21 Dec 2024
 09:06:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUWHU=oXOEj5wHTzxrw_wj1w5hTvqq8Ry400s0ZCJjTEZw@mail.gmail.com>
 <099d3a80-4fdb-49a7-9fd0-207d7386551f@citrix.com> <CA+icZUX98gQ54hePEWNauiU41XQV7qdKJx5PiiXzxy+6yW7hTw@mail.gmail.com>
 <CA+icZUW-i53boHBPt+8zh-D921XFbPb_Kc=dzdgCK1QvkOgCsw@mail.gmail.com>
 <90640a5d-ff17-4555-adc6-ae9e21e24ebd@citrix.com> <CA+icZUVo69swc9QfwJr+mDuHqJKcFUexc08voP2O41g31HGx5w@mail.gmail.com>
 <43166e29-ff2d-4a9d-8c1b-41b5e247974b@citrix.com>
In-Reply-To: <43166e29-ff2d-4a9d-8c1b-41b5e247974b@citrix.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Sat, 21 Dec 2024 18:06:06 +0100
Message-ID: <CA+icZUVhzsc+_PJr0RSwaVQTbz5TKa8wmyzgBNQEcody4YGesg@mail.gmail.com>
Subject: Re: [Linux-6.12.y] XEN: CVE-2024-53241 / XSA-466 and Clang-kCFI
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Jan Beulich <jbeulich@suse.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev, 
	xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 2:39=E2=80=AFAM Andrew Cooper <andrew.cooper3@citri=
x.com> wrote:
>
> On 20/12/2024 12:27 am, Sedat Dilek wrote:
> > On Fri, Dec 20, 2024 at 12:26=E2=80=AFAM Andrew Cooper
> > <andrew.cooper3@citrix.com> wrote:
> >> On 19/12/2024 11:10 pm, Sedat Dilek wrote:
> >>> On Thu, Dec 19, 2024 at 6:07=E2=80=AFPM Sedat Dilek <sedat.dilek@gmai=
l.com> wrote:
> >>>> On Thu, Dec 19, 2024 at 5:44=E2=80=AFPM Andrew Cooper <andrew.cooper=
3@citrix.com> wrote:
> >>>>> On 19/12/2024 4:14 pm, Sedat Dilek wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> Linux v6.12.6 will include XEN CVE fixes from mainline.
> >>>>>>
> >>>>>> Here, I use Debian/unstable AMD64 and the SLIM LLVM toolchain 19.1=
.x
> >>>>>> from kernel.org.
> >>>>>>
> >>>>>> What does it mean in ISSUE DESCRIPTION...
> >>>>>>
> >>>>>> Furthermore, the hypercall page has no provision for Control-flow
> >>>>>> Integrity schemes (e.g. kCFI/CET-IBT/FineIBT), and will simply
> >>>>>> malfunction in such configurations.
> >>>>>>
> >>>>>> ...when someone uses Clang-kCFI?
> >>>>> The hypercall page has functions of the form:
> >>>>>
> >>>>>     MOV $x, %eax
> >>>>>     VMCALL / VMMCALL / SYSCALL
> >>>>>     RET
> >>>>>
> >>>>> There are no ENDBR instructions, and no prologue/epilogue for hash-=
based
> >>>>> CFI schemes.
> >>>>>
> >>>>> This is because it's code provided by Xen, not code provided by Lin=
ux.
> >>>>>
> >>>>> The absence of ENDBR instructions will yield #CP when CET-IBT is ac=
tive,
> >>>>> and the absence of hash prologue/epilogue lets the function be used=
 in a
> >>>>> type-confused manor that CFI should have caught.
> >>>>>
> >>>>> ~Andrew
> >>>> Thanks for the technical explanation, Andrew.
> >>>>
> >>>> Hope that helps the folks of "CLANG CONTROL FLOW INTEGRITY SUPPORT".
> >>>>
> >>>> I am not an active user of XEN in the Linux-kernel but I am willing =
to
> >>>> test when Linux v6.12.6 is officially released and give feedback.
> >>>>
> >>> https://wiki.xenproject.org/wiki/Testing_Xen#Presence_test
> >>> https://wiki.xenproject.org/wiki/Testing_Xen#Commands_for_presence_te=
sting
> >>>
> >>> # apt install -t unstable xen-utils-4.17 -y
> >>>
> >>> # xl list
> >>> Name                                        ID   Mem VCPUs      State=
   Time(s)
> >>> Domain-0                                     0  7872     4     r-----=
     398.2
> >>>
> >>> Some basic tests LGTM - see also attached stuff.
> >>>
> >>> If you have any tests to recommend, let me know.
> >> That itself is good enough as a smoke test.  Thankyou for trying it ou=
t.
> >>
> >> If you want something a bit more thorough, try
> >> https://xenbits.xen.org/docs/xtf/  (Xen's self-tests)
> >>
> >> Grab and build it, and `./xtf-runner -aqq --host` will run a variety o=
f
> >> extra codepaths in dom0, without the effort of making/running full gue=
sts.
> >>
> >> ~Andrew
> > Run on Debian 6.12.5 and my selfmade 6.12.5 and 6.12.6.
> > All tests lead to a reboot in case of Debian or in my kernels to a shut=
down.
> >
> > Can you recommend a specific test?
>
> Oh, that's distinctly less good.
>
> Start with just "example".  It's literally a hello world microkernel,
> but the symptoms you're seeing is a dom0 crash, so it will likely
> provoke it.
>
> Do you have serial to the machine?  If so, boot Xen with `console=3Dcom1
> com1=3D115200,8n1` (or com2, as appropriate).
>
> If not and you've only got a regular screen, boot Xen with `vga=3D,keep
> noreboot` (comma is important) which might leave enough information on
> screen to get an idea of what's going on.
>
> Full command line docs at
> https://xenbits.xen.org/docs/unstable/misc/xen-command-line.html
>
> > dileks@iniza:~/src/xtf/git$ sudo ./xtf-runner --list functional xsa | g=
rep xsa-4
> > test-pv64-xsa-444
> > test-hvm64-xsa-451
> > test-hvm64-xsa-454
> >
> > Is there no xsa-466 test?
>
> No.  XSA-466 is really "well don't do that then if it matters".
>
> More generally, not all XSAs are amenable to testing in this way.
>
> ~Andrew

RUN example tests on Debian's 6.12.6 kernel.

$ cat /proc/version
Linux version 6.12.6-amd64 (debian-kernel@lists.debian.org)
(x86_64-linux-gnu-gcc-14 (Debian 14.2.0-11) 14.2.0, GNU ld (GNU
Binutils for Debian) 2.43.50.20241215) #1 SMP PREEMPT_DYNAMIC Debian
6.12.6-1 (2024-12-21)

dileks@iniza:~/src/xtf/git$ sudo ./xtf-runner --list example
test-hvm32-example
test-hvm32pae-example
test-hvm32pse-example
test-hvm64-example
test-pv32pae-example
test-pv64-example
dileks@iniza:~/src/xtf/git$ sudo ./xtf-runner test-hvm32-example
Executing 'xl create -p tests/example/test-hvm32-example.cfg'
Executing 'xl console test-hvm32-example'
Executing 'xl unpause test-hvm32-example'
--- Xen Test Framework ---
Environment: HVM 32bit (No paging)
Hello World
Test result: SUCCESS

Combined test results:
test-hvm32-example                       SUCCESS
dileks@iniza:~/src/xtf/git$ sudo ./xtf-runner test-hvm32pae-example
Executing 'xl create -p tests/example/test-hvm32pae-example.cfg'
Executing 'xl console test-hvm32pae-example'
Executing 'xl unpause test-hvm32pae-example'
--- Xen Test Framework ---
Environment: HVM 32bit (PAE 3 levels)
Hello World
Test result: SUCCESS

Combined test results:
test-hvm32pae-example                    SUCCESS
dileks@iniza:~/src/xtf/git$ sudo ./xtf-runner test-hvm32pse-example
Executing 'xl create -p tests/example/test-hvm32pse-example.cfg'
Executing 'xl console test-hvm32pse-example'
Executing 'xl unpause test-hvm32pse-example'
--- Xen Test Framework ---
Environment: HVM 32bit (PSE 2 levels)
Hello World
Test result: SUCCESS

Combined test results:
test-hvm32pse-example                    SUCCESS
dileks@iniza:~/src/xtf/git$ sudo ./xtf-runner test-hvm64-example
Executing 'xl create -p tests/example/test-hvm64-example.cfg'
Executing 'xl console test-hvm64-example'
Executing 'xl unpause test-hvm64-example'
--- Xen Test Framework ---
Environment: HVM 64bit (Long mode 4 levels)
Hello World
Test result: SUCCESS

Combined test results:
test-hvm64-example                       SUCCESS
dileks@iniza:~/src/xtf/git$ sudo ./xtf-runner test-pv32pae-example
Combined test results:
test-pv32pae-example                     SKIP
dileks@iniza:~/src/xtf/git$ sudo ./xtf-runner test-pv64-example
Executing 'xl create -p tests/example/test-pv64-example.cfg'
Executing 'xl console test-pv64-example'
Executing 'xl unpause test-pv64-example'
--- Xen Test Framework ---
Environment: PV 64bit (Long mode 4 levels)
Hello World
Test result: SUCCESS

Combined test results:
test-pv64-example                        SUCCESS

Thanks.

Best regards,
-Sedat-

