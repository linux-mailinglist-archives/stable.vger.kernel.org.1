Return-Path: <stable+bounces-105539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B0E9FA1D9
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 19:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD86188D9A1
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 18:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063C61714A0;
	Sat, 21 Dec 2024 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW7v35EN"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C806A1632C5;
	Sat, 21 Dec 2024 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734805594; cv=none; b=WjriCD4E7ttxWVV46xYpEFedm58X8GJVkHO5wcGNA21m9i2ypHAj3AQIRt/97yXYAc5W+diHa9gAnsu4KaczziNkLZGrKVzaftcIvHn5sxMBzV8Aqux8lAOMDbeAv8SxXK5zKjC+ukdI2f5aprLb0lyPfwUOKWpXt9lQckVDW1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734805594; c=relaxed/simple;
	bh=jxlc4tI/4f+Cod2pnpANcbpDdC1Syipwex2tavQxrfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bR/ti+RrZD7vfMDXaFtu/HpknB1G/6r0ezGukkeiEpaeiwbebvOBZGlb/xQ6NKLn/WTfkycXcMV2d069WgnPsACEPYZTEejI5vwk+x2lYOa6t2o3jHPry8GlUU0q0Fa0NfIEg6TCYK97HcFX/TdDzoricxmQk2d4kvM3mXZyoj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW7v35EN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5401e6efffcso3559836e87.3;
        Sat, 21 Dec 2024 10:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734805591; x=1735410391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ug+2S38akg/OGmu5JFa1fwvkZP6FmAvIFxWtE1sypCI=;
        b=UW7v35EN+KxxEmpadrCMIOBKY5rBZ5btsjIqAvmLNNzO6FZ1HwybV3MQPrgK7DvrEm
         plXAsGd16mp2tyukGW/Y44ACWWpddyHuPWqnQQeRqOPNHDc0o35MEkc0vJl9THZFuYZL
         kcJf19MGJTrXq/I94EGl1LzoBaYMWfNgtSa/SyVxPlZMhxtZxU5skFZMMhoUuqevXYBc
         ikK5/RZYl+cCbQ4JNtnxkbs5i5tflE8BnJ+N0SiHCeRC8xIhnwHa/1hzwTT83E+CW8+o
         4oC1tq1sZ2w7Hzj7dbt+SdX+tnMd6zJgZRtpB1/k2zMKSG1nm/Hn+Tqt6S/N6eYbRzlf
         ciVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734805591; x=1735410391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ug+2S38akg/OGmu5JFa1fwvkZP6FmAvIFxWtE1sypCI=;
        b=hUH8rvU7P9MTm1N6bqH/04osuhWg/WFNbODRG5zLdU373mlDSJkCFtlz/WXHXF8ld6
         6hdlTAWISP0MUJYxjsQeaLoUpHhki+MXTDo4c0T5PDiwiUoF5lbu5VsPDmar8x0AEhDm
         RsM/NUSWDygD2l6FwxXcIA/KcWh45nqWGS1WfZ4Q6WUo+R151LyRKqif1nVrlkmY/S4h
         9nr2HETygQvE8ofWXuzAaAsQksoM0yqNOdhX48XlLzoRCjNiYGC5WcwF923HFdaJORyJ
         iRpudVzsfFSKloRU2cFX0NkszJFj/O4zel9tnzihT4uQtRt6IlW1Ec7z9nvC8p59bNGN
         itxg==
X-Forwarded-Encrypted: i=1; AJvYcCXQL3ldBnzpbJo2KJ5S0sYDHGFMdFr5I0Bac48Escpryu10aSNq0r/0VPxlise8VFIMnOhJCVTXI0t2xbY=@vger.kernel.org, AJvYcCXVjQZkapvrzbkj5PepjBRQ6tKcUTc4yh2St+xm8bZnCWLcExZ+lWysM51LW0n0+C3xcr/U36as@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+9CKFbwdnOvUgVT5jtb1dop/FwajxaCJFiEGD7mnghc3qp1/a
	/rw05qMnQEPsRxLvcqB+l8rsHh+ZwO8lcu5y+tV++JeB7xr8+KmzMjoAjzA7heAATT1N7iWUjLN
	Mo5fiwSxVi0rlqNYnSTCAdvJk6sE=
X-Gm-Gg: ASbGnculgfzdOnRK0tHYjc4BWUsozdPfwKO3JriPpZpZ49/xhT7GIwkxyNiE3cCxIrk
	dPUfuBlywdEptz+DWf8VzaPKMLJye7vDiwsIZsBP+urs7BLxdfgHxLWcyHKly/AIufzMd
X-Google-Smtp-Source: AGHT+IG/uxf+62mSAJV0vjaX5OOSPPXiQApbIfNWpW/j/U/azuxZEVr6AdlTIyiVOEKxrku3T2iYp/pg0hA3s2YrLws=
X-Received: by 2002:a05:6512:23a0:b0:540:75d3:95a4 with SMTP id
 2adb3069b0e04-54229538b24mr2653607e87.17.1734805590494; Sat, 21 Dec 2024
 10:26:30 -0800 (PST)
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
 <43166e29-ff2d-4a9d-8c1b-41b5e247974b@citrix.com> <CA+icZUUp9rgx2Dvsww6QbTGRZz5=mf75D0_KncwdgCEZe01-EA@mail.gmail.com>
In-Reply-To: <CA+icZUUp9rgx2Dvsww6QbTGRZz5=mf75D0_KncwdgCEZe01-EA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Sat, 21 Dec 2024 19:25:54 +0100
Message-ID: <CA+icZUV0HEF_hwr-eSovntfcT0++FBrQN-HbFL+oZtnKjJzLtA@mail.gmail.com>
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

On Sat, Dec 21, 2024 at 7:17=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> On Fri, Dec 20, 2024 at 2:39=E2=80=AFAM Andrew Cooper <andrew.cooper3@cit=
rix.com> wrote:
> >
> > On 20/12/2024 12:27 am, Sedat Dilek wrote:
> > > On Fri, Dec 20, 2024 at 12:26=E2=80=AFAM Andrew Cooper
> > > <andrew.cooper3@citrix.com> wrote:
> > >> On 19/12/2024 11:10 pm, Sedat Dilek wrote:
> > >>> On Thu, Dec 19, 2024 at 6:07=E2=80=AFPM Sedat Dilek <sedat.dilek@gm=
ail.com> wrote:
> > >>>> On Thu, Dec 19, 2024 at 5:44=E2=80=AFPM Andrew Cooper <andrew.coop=
er3@citrix.com> wrote:
> > >>>>> On 19/12/2024 4:14 pm, Sedat Dilek wrote:
> > >>>>>> Hi,
> > >>>>>>
> > >>>>>> Linux v6.12.6 will include XEN CVE fixes from mainline.
> > >>>>>>
> > >>>>>> Here, I use Debian/unstable AMD64 and the SLIM LLVM toolchain 19=
.1.x
> > >>>>>> from kernel.org.
> > >>>>>>
> > >>>>>> What does it mean in ISSUE DESCRIPTION...
> > >>>>>>
> > >>>>>> Furthermore, the hypercall page has no provision for Control-flo=
w
> > >>>>>> Integrity schemes (e.g. kCFI/CET-IBT/FineIBT), and will simply
> > >>>>>> malfunction in such configurations.
> > >>>>>>
> > >>>>>> ...when someone uses Clang-kCFI?
> > >>>>> The hypercall page has functions of the form:
> > >>>>>
> > >>>>>     MOV $x, %eax
> > >>>>>     VMCALL / VMMCALL / SYSCALL
> > >>>>>     RET
> > >>>>>
> > >>>>> There are no ENDBR instructions, and no prologue/epilogue for has=
h-based
> > >>>>> CFI schemes.
> > >>>>>
> > >>>>> This is because it's code provided by Xen, not code provided by L=
inux.
> > >>>>>
> > >>>>> The absence of ENDBR instructions will yield #CP when CET-IBT is =
active,
> > >>>>> and the absence of hash prologue/epilogue lets the function be us=
ed in a
> > >>>>> type-confused manor that CFI should have caught.
> > >>>>>
> > >>>>> ~Andrew
> > >>>> Thanks for the technical explanation, Andrew.
> > >>>>
> > >>>> Hope that helps the folks of "CLANG CONTROL FLOW INTEGRITY SUPPORT=
".
> > >>>>
> > >>>> I am not an active user of XEN in the Linux-kernel but I am willin=
g to
> > >>>> test when Linux v6.12.6 is officially released and give feedback.
> > >>>>
> > >>> https://wiki.xenproject.org/wiki/Testing_Xen#Presence_test
> > >>> https://wiki.xenproject.org/wiki/Testing_Xen#Commands_for_presence_=
testing
> > >>>
> > >>> # apt install -t unstable xen-utils-4.17 -y
> > >>>
> > >>> # xl list
> > >>> Name                                        ID   Mem VCPUs      Sta=
te   Time(s)
> > >>> Domain-0                                     0  7872     4     r---=
--     398.2
> > >>>
> > >>> Some basic tests LGTM - see also attached stuff.
> > >>>
> > >>> If you have any tests to recommend, let me know.
> > >> That itself is good enough as a smoke test.  Thankyou for trying it =
out.
> > >>
> > >> If you want something a bit more thorough, try
> > >> https://xenbits.xen.org/docs/xtf/  (Xen's self-tests)
> > >>
> > >> Grab and build it, and `./xtf-runner -aqq --host` will run a variety=
 of
> > >> extra codepaths in dom0, without the effort of making/running full g=
uests.
> > >>
> > >> ~Andrew
> > > Run on Debian 6.12.5 and my selfmade 6.12.5 and 6.12.6.
> > > All tests lead to a reboot in case of Debian or in my kernels to a sh=
utdown.
> > >
> > > Can you recommend a specific test?
> >
> > Oh, that's distinctly less good.
> >
> > Start with just "example".  It's literally a hello world microkernel,
> > but the symptoms you're seeing is a dom0 crash, so it will likely
> > provoke it.
> >
> > Do you have serial to the machine?  If so, boot Xen with `console=3Dcom=
1
> > com1=3D115200,8n1` (or com2, as appropriate).
> >
> > If not and you've only got a regular screen, boot Xen with `vga=3D,keep
> > noreboot` (comma is important) which might leave enough information on
> > screen to get an idea of what's going on.
> >
>
> YES
>
> # xl info | grep xen_commandline
> xen_commandline        : placeholder vga=3D,keep noreboot
>
> > Full command line docs at
> > https://xenbits.xen.org/docs/unstable/misc/xen-command-line.html
> >
> > > dileks@iniza:~/src/xtf/git$ sudo ./xtf-runner --list functional xsa |=
 grep xsa-4
> > > test-pv64-xsa-444
> > > test-hvm64-xsa-451
> > > test-hvm64-xsa-454
> > >
> > > Is there no xsa-466 test?
> >
> > No.  XSA-466 is really "well don't do that then if it matters".
> >
> > More generally, not all XSAs are amenable to testing in this way.
> >
> > ~Andrew
>
> On Debian 6.12.6 kernel the TESTS stop with test-hvm64-xsa-454 -
> machine freezes - hard reboot.
>
> dileks@iniza:~/src/xtf/git$ sudo ./xtf-runner -a --host
>
> root@iniza:/var/log/xen# LC_ALL=3DC ls -alth | head -20
> total 1.7M
> -rw-r--r--  1 root adm  1008K Dec 21 19:10 xenstored-access.log
> drwxr-xr-x 16 root root  4.0K Dec 21 18:59 ..
> -rw-r--r--  1 root adm     32 Dec 21 18:58 xenstored.log
> drwxr-s---  2 root adm    36K Dec 21 18:58 .
> -rw-r--r--  1 root adm    229 Dec 21 18:53 xl-test-hvm64-xsa-317.log
> -rw-r--r--  1 root adm     67 Dec 21 18:53 xl-test-hvm64-xsa-454.log
> -rw-r--r--  1 root adm    145 Dec 21 18:53 qemu-dm-test-hvm64-xsa-454.log
> -rw-r--r--  1 root adm    232 Dec 21 18:53 qemu-dm-test-hvm64-xsa-451.log
> -rw-r--r--  1 root adm    211 Dec 21 18:53 xl-test-hvm64-xsa-451.log
> -rw-r--r--  1 root adm    232 Dec 21 18:53 xl-test-hvm32pse-xsa-317.log
> -rw-r--r--  1 root adm    228 Dec 21 18:53 xl-test-pv64-xsa-444.log
> -rw-r--r--  1 root adm    228 Dec 21 18:53 xl-test-pv64-xsa-339.log
> -rw-r--r--  1 root adm    228 Dec 21 18:53 xl-test-pv64-xsa-333.log
> -rw-r--r--  1 root adm    228 Dec 21 18:53 xl-test-pv64-xsa-317.log
> -rw-r--r--  1 root adm    232 Dec 21 18:53 qemu-dm-test-hvm64-xsa-317.log
> -rw-r--r--  1 root adm    232 Dec 21 18:53 xl-test-hvm32pae-xsa-317.log
> -rw-r--r--  1 root adm    232 Dec 21 18:53 qemu-dm-test-hvm32pse-xsa-317.=
log
> -rw-r--r--  1 root adm    229 Dec 21 18:53 xl-test-hvm32-xsa-317.log
> -rw-r--r--  1 root adm    232 Dec 21 18:53 qemu-dm-test-hvm32pae-xsa-317.=
log
>
> root@iniza:/var/log/xen# cat qemu-dm-test-hvm64-xsa-454.log
> VNC server running on 127.0.0.1:5900
> xen-qemu-system-i386: failed to create 'console' device '0': declining to=
 handle
> console type 'xenconsoled'
>
> root@iniza:/var/log/xen# cat xl-test-hvm64-xsa-454.log
> Waiting for domain test-hvm64-xsa-454 (domid 94) to die [pid 4686]
>
> -Sedat-

With...

dileks@iniza:~/src/xtf/git$ mv tests/xsa-454 ../
dileks@iniza:~/src/xtf/git$ mv tests/xsa-consoleio-write ../

Combined test results:
test-hvm32-cpuid-faulting                SKIP
test-hvm32pae-cpuid-faulting             SKIP
test-hvm32pse-cpuid-faulting             SKIP
test-hvm64-cpuid-faulting                SKIP
test-pv64-cpuid-faulting                 SKIP
test-hvm64-fpu-exception-emulation       SKIP
test-hvm32-invlpg~hap                    SUCCESS
test-hvm32-invlpg~shadow                 SUCCESS
test-hvm32pae-invlpg~hap                 SUCCESS
test-hvm32pae-invlpg~shadow              SUCCESS
test-hvm64-invlpg~hap                    SUCCESS
test-hvm64-invlpg~shadow                 SUCCESS
test-hvm64-lbr-tsx-vmentry               SUCCESS
test-hvm32-livepatch-priv-check          SUCCESS
test-hvm64-livepatch-priv-check          SUCCESS
test-pv64-livepatch-priv-check           SUCCESS
test-hvm32-lm-ts                         SUCCESS
test-hvm64-lm-ts                         SUCCESS
test-hvm32pae-memop-seg                  SUCCESS
test-hvm64-memop-seg                     SUCCESS
test-pv64-memop-seg                      SUCCESS
test-hvm32pae-nmi-taskswitch-priv        SUCCESS
test-pv64-pv-fsgsbase                    SKIP
test-pv64-pv-iopl~hypercall              SUCCESS
test-pv64-pv-iopl~vmassist               SUCCESS
test-hvm32-swint-emulation               SKIP
test-hvm32pae-swint-emulation            SKIP
test-hvm32pse-swint-emulation            SKIP
test-hvm64-swint-emulation               SKIP
test-hvm32-umip                          SKIP
test-hvm64-umip                          SKIP
test-hvm32-xsa-122                       SUCCESS
test-hvm32pae-xsa-122                    SUCCESS
test-hvm32pse-xsa-122                    SUCCESS
test-hvm64-xsa-122                       SUCCESS
test-pv64-xsa-122                        SUCCESS
test-hvm32-xsa-123                       SKIP
test-pv64-xsa-167                        SKIP
test-hvm64-xsa-168~shadow                SUCCESS
test-hvm64-xsa-170                       SKIP
test-hvm64-xsa-173~shadow                SUCCESS
test-pv64-xsa-182                        SUCCESS
test-hvm32-xsa-186                       SKIP
test-hvm64-xsa-186                       SKIP
test-hvm32-xsa-188                       SUCCESS
test-hvm32pae-xsa-188                    SUCCESS
test-hvm32pse-xsa-188                    SUCCESS
test-hvm64-xsa-188                       SUCCESS
test-pv64-xsa-188                        SUCCESS
test-hvm32-xsa-191                       SKIP
test-hvm32-xsa-192                       SUCCESS
test-pv64-xsa-193                        SUCCESS
test-hvm64-xsa-195                       SUCCESS
test-hvm64-xsa-196                       SKIP
test-hvm32-xsa-200                       SKIP
test-hvm32-xsa-203                       SKIP
test-hvm64-xsa-204                       SKIP
test-pv64-xsa-212                        SUCCESS
test-pv64-xsa-213                        SUCCESS
test-hvm64-xsa-221                       SUCCESS
test-pv64-xsa-221                        SUCCESS
test-pv64-xsa-224                        SUCCESS
test-pv64-xsa-227                        SUCCESS
test-hvm64-xsa-231                       SUCCESS
test-pv64-xsa-231                        SUCCESS
test-hvm64-xsa-232                       SUCCESS
test-pv64-xsa-232                        SUCCESS
test-pv64-xsa-234                        SUCCESS
test-hvm32-xsa-239                       SUCCESS
test-pv64-xsa-255                        SUCCESS
test-pv64-xsa-259                        SUCCESS
test-pv64-xsa-260                        SUCCESS
test-hvm64-xsa-261                       SUCCESS
test-pv64-xsa-265                        SUCCESS
test-hvm64-xsa-269                       SUCCESS
test-hvm64-xsa-277                       SUCCESS
test-hvm64-xsa-278                       SUCCESS
test-pv64-xsa-279                        SUCCESS
test-pv64-xsa-286                        SUCCESS
test-pv64-xsa-296                        SUCCESS
test-pv64-xsa-298                        SUCCESS
test-hvm64-xsa-304                       SUCCESS
test-hvm64-xsa-308                       SUCCESS
test-pv64-xsa-316                        SUCCESS
test-hvm32-xsa-317                       SUCCESS
test-hvm32pae-xsa-317                    SUCCESS
test-hvm32pse-xsa-317                    SUCCESS
test-hvm64-xsa-317                       SUCCESS
test-pv64-xsa-317                        SUCCESS
test-pv64-xsa-333                        SUCCESS
test-pv64-xsa-339                        SUCCESS
test-pv64-xsa-444                        SKIP
test-hvm64-xsa-451                       SKIP

-Sedat-

