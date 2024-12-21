Return-Path: <stable+bounces-105538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B99FA1D5
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 19:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89CCA165F84
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FE316F84F;
	Sat, 21 Dec 2024 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJT1cgAR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA571DFD8;
	Sat, 21 Dec 2024 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734805066; cv=none; b=RHWOwMwc4KpTeYjeoG2SRjW2fZHVdP5Kk1xlE2PXckk3oUoRKyec0pXujdqtQlYLE2fCemw5MaU/UUxUOc+c3GhZAHoXdPMRWozVr/CIOVNGfflXLKVbe7AgswlU7WMtgWW06U9N2UugygFAPhzoVQaWPk0ucgM83A/IlGJvrYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734805066; c=relaxed/simple;
	bh=FBPLV2lfQuZX08Qv9/rLfjfbmCMPz0VugzKJv3aLfUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYxQpSN3zeCUH9KAFTEgNyRKJmlnI6jxV+rFEPJDUNxxYCv0tTYu3hf/ZPk5Id9xIHf0ismLyTN9rzt39s7PKo937FtiBwCWCEuVn6y8XKnY61wznM88wHg/aoxb/0uRN7FCf0lRVvOyAxCdRuHcQvsuN+ljq+I0JAzpij4/fbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJT1cgAR; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so3232251e87.2;
        Sat, 21 Dec 2024 10:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734805063; x=1735409863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gww25uCrGB4X+QcRFH3IhcXrxha4JrH7h8gAWHNHg+E=;
        b=RJT1cgARQiet9SQjPrzhm2A3ds7MEpj63PwD4wR/ftRDLmoya6GqkVM1HkKjgNrUYN
         OnSumDCZJ6Q1VsT1rmFTZ6mZ9UcBuDv8YwFYF5kRC6Y3KNtJjGmWxhWscKkD/EP/FGMu
         L6Chrgi+05OrfzAwBDJi45yflSnR41qz6yB3hJdzdN5AOfM/lhNx91AxEFmEzka1Un5+
         sQMB3eqWbOvpHJz81btcpQsqMXNPtRWh+I0MDeNb8TYbv2/6Hjn6M5Bvhd+bvN/HCroa
         rfbXWl4ytRkJDuC/2mDq5gx/fcSIaZ3DbkzWdVM+QHJs0zgB1QRJ3bZTC+hizH5ZVqkb
         OA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734805063; x=1735409863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gww25uCrGB4X+QcRFH3IhcXrxha4JrH7h8gAWHNHg+E=;
        b=D+tzytDAq76ojPWKE0GzR+uqi2uBJOAH+5QNgLKI+Wv3v7wjpNOF3FR5GxjrHtJwEQ
         EracQUsnwnu/fxGoPUpzg2nQVl45xYdaRByinT4x6eOAhjBh+h9qhpjahLRjPjPo1MIT
         KziqepuZZic0D3/P42NdZrVnz98eirPdxqvU0D33lmP2QSQi9LXEE1JSAdH9lb0R7idE
         mhI0fz4dZUvaYFN2Dl91fxpmsm2/LlrmXIacSWikqXyAFSE3UDn5w00ve3nbhtekwMBT
         y+/WJzaR828fD9PbouIlBJMVBxbsspphAIcSQu5oXR46sKZNarhisW1dHAYUqN+BXvXX
         2cRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJGvc2nsUYU8auLAmM9oxszx4mjaJPX2+YSpuL3zY6gqU3cTkzG5yaVq3VJzTm+tSWWObPFCLh@vger.kernel.org, AJvYcCVc7bC/qs/q1W38siMAmn1qXIEAHXp8zKmteV1GVR3batiSahGntY1zirWxO/nRgw8FPgpC2PA1TIJp110=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+80L1ouXCEZlsZ4hOdK4vB4/OBs7y6q4mkHnY1TzuAJ/G6eU4
	Ct4N/O7RQ/8r80LI9lDux0EwR1SGU5t/AibeftKc2CXaypiUAC4j3ejLugS/XTiRcJ8ekVCu8LC
	JfmxGs3X2SzdZ4crJHgde1C0AAaA=
X-Gm-Gg: ASbGncuSY/SKhSm9jEL8HZx7iXt7kVwjfwQNoDpqld41BW7892BeqXAB+2F8cf8EzHQ
	/LQUiEFCGjK1D1YWbEJ+WDQb/dUp3xeg5IKoOfcLFXVUmYIH7fp6Xp06oQUGjpg63612Y
X-Google-Smtp-Source: AGHT+IFbWOqrEDILJB7D/dZAXmHjad5/5gydpfde4ub7xLCzRPKhGigQWT8r2WIqnERkBGgVj5RjNd5ekYb5iXu0I/M=
X-Received: by 2002:a05:6512:683:b0:542:2f0f:66d9 with SMTP id
 2adb3069b0e04-5422f0f69d8mr919287e87.16.1734805062927; Sat, 21 Dec 2024
 10:17:42 -0800 (PST)
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
Date: Sat, 21 Dec 2024 19:17:05 +0100
Message-ID: <CA+icZUUp9rgx2Dvsww6QbTGRZz5=mf75D0_KncwdgCEZe01-EA@mail.gmail.com>
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

YES

# xl info | grep xen_commandline
xen_commandline        : placeholder vga=3D,keep noreboot

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

On Debian 6.12.6 kernel the TESTS stop with test-hvm64-xsa-454 -
machine freezes - hard reboot.

dileks@iniza:~/src/xtf/git$ sudo ./xtf-runner -a --host

root@iniza:/var/log/xen# LC_ALL=3DC ls -alth | head -20
total 1.7M
-rw-r--r--  1 root adm  1008K Dec 21 19:10 xenstored-access.log
drwxr-xr-x 16 root root  4.0K Dec 21 18:59 ..
-rw-r--r--  1 root adm     32 Dec 21 18:58 xenstored.log
drwxr-s---  2 root adm    36K Dec 21 18:58 .
-rw-r--r--  1 root adm    229 Dec 21 18:53 xl-test-hvm64-xsa-317.log
-rw-r--r--  1 root adm     67 Dec 21 18:53 xl-test-hvm64-xsa-454.log
-rw-r--r--  1 root adm    145 Dec 21 18:53 qemu-dm-test-hvm64-xsa-454.log
-rw-r--r--  1 root adm    232 Dec 21 18:53 qemu-dm-test-hvm64-xsa-451.log
-rw-r--r--  1 root adm    211 Dec 21 18:53 xl-test-hvm64-xsa-451.log
-rw-r--r--  1 root adm    232 Dec 21 18:53 xl-test-hvm32pse-xsa-317.log
-rw-r--r--  1 root adm    228 Dec 21 18:53 xl-test-pv64-xsa-444.log
-rw-r--r--  1 root adm    228 Dec 21 18:53 xl-test-pv64-xsa-339.log
-rw-r--r--  1 root adm    228 Dec 21 18:53 xl-test-pv64-xsa-333.log
-rw-r--r--  1 root adm    228 Dec 21 18:53 xl-test-pv64-xsa-317.log
-rw-r--r--  1 root adm    232 Dec 21 18:53 qemu-dm-test-hvm64-xsa-317.log
-rw-r--r--  1 root adm    232 Dec 21 18:53 xl-test-hvm32pae-xsa-317.log
-rw-r--r--  1 root adm    232 Dec 21 18:53 qemu-dm-test-hvm32pse-xsa-317.lo=
g
-rw-r--r--  1 root adm    229 Dec 21 18:53 xl-test-hvm32-xsa-317.log
-rw-r--r--  1 root adm    232 Dec 21 18:53 qemu-dm-test-hvm32pae-xsa-317.lo=
g

root@iniza:/var/log/xen# cat qemu-dm-test-hvm64-xsa-454.log
VNC server running on 127.0.0.1:5900
xen-qemu-system-i386: failed to create 'console' device '0': declining to h=
andle
console type 'xenconsoled'

root@iniza:/var/log/xen# cat xl-test-hvm64-xsa-454.log
Waiting for domain test-hvm64-xsa-454 (domid 94) to die [pid 4686]

-Sedat-

