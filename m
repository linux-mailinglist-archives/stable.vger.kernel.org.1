Return-Path: <stable+bounces-106081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E64619FC02F
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 17:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6945C163E81
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C78C1FF1D9;
	Tue, 24 Dec 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQmtL/R4"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462BC1C3BE7;
	Tue, 24 Dec 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735057466; cv=none; b=H/XFvzUxltWBOd6mqRWlMhvEyIAsjba7jKv7BVJyZ0vaV+RfV5mTRuY51r7dsL62HRt11MgWafF5ywMU1rArxQT9YYoMjT5kPa4skkng8Skc/AKxxH5123sM6bqfeU8I+r+Pg1ZJq6ley1lHeWUC+JR8d1j29G8KlNZCSkUJN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735057466; c=relaxed/simple;
	bh=p7KqVG8jZUozSrF3yUtKGwmf8J8zBpBVmYtQMvxyH9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SISXz/gFPK362FsycWpD0Rlt9fJBbVg8n3nXZGZnIddsI08leHbNOID4sojqkH0u0rmHLFzYavehlXV5rTrU70EdtZpCahJ65uilm031CFNsl4pB6yRBAUZKjAoYKo1C8CCaCssHrkYwybNTaS3XuPSuqg1wAiG07kfEIBGatbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQmtL/R4; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5401b7f7141so4694795e87.1;
        Tue, 24 Dec 2024 08:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735057462; x=1735662262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4mkXKWmGiV5XXckoZsuAcHVdzO+pEYcGppRBWUinzmo=;
        b=NQmtL/R4qYLMQqZg7hmYhjjkGL6NCh1wjzG465wRBuootUUvE2O7nZ2H8xvdul0iPG
         rVrPumGZqREUPYK59zND4kTGl/M6Edo82YkjatyX82kWp9PFsmHlEghqsR3CXXkf2oYP
         ct4Pwtd9ntjc1GKZmF8TBp17nQZfOUlClPzd8opzvMxPhO03Nn7L6kdtn2GhslMLXud5
         pgq0WXXqGvE8FOi+TnRIxVlzEPwH0I8wyR2LEkwfFOtsJ/QKlCRlX+dJ5qfBxXVIsU7O
         YtpV9VV30vT7RZVs1C349hsuFfBTNeHoDkGb9mbmQh9g5tkikK+JpmuWwgO9+nldBNTB
         L0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735057462; x=1735662262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4mkXKWmGiV5XXckoZsuAcHVdzO+pEYcGppRBWUinzmo=;
        b=W+I5opUpCoIfhghZr165uXUu6M23NOuE4QjuzFhc7Rnqi97hBnlL2xMlCumfXdhxGv
         v0OpydeSMmBTixdC+c/ixL74ygqOasEpz14iY6NFxnnDytkKGmswRx/Egw8lRoXco3p/
         vYmLiBlmvLCJLTvWjwrrj6oTzBrmp/YaB7WLY1ZLQHHVZ9/tKRK8y3IKr8v0/+GYDSnt
         ewBa3xus3bU3Cn8eQo/fKkKdsaL+Gt/mqdqFd+Px3tY/iVkJdkC5YEZNTNAc4PNzX6nw
         6NFm/8bq4Jt+bZAWS7vzFtMVWXvy6rtXFhWa1oeCW4lb+4cqbJG41PKPZt4PMhvazfyy
         aHiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUokBDV1O+yZmwwetXyX2q7Na21WAz3TLLg/rsqydL2QbhhMS/mf0dtqY1wkb6/qeqQWsUTVYx+@vger.kernel.org, AJvYcCXei/eaeyQ5f7A4V2CrK+UAJia5S6/ICpd6AIikXEvbgyfqAxQqCFzq6KWR0N8rEFhWyU/T9bcST4pqkKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjypptKxPl2i9v1bhwVT0liTyApQ5iMlRWYJCaiaWliuep3g5p
	nYvJsnGWHrNUXcS9R3mOoRX8CfrSkA3igZ++dRjMT3L4PGML5F+pjUw+R6dN16ePyqPzmLyp75G
	HuWm3X6sbLNKv+EQZg44AlawulRo=
X-Gm-Gg: ASbGncsrImf6lagpPrSXGlji8daII5dA3tjp8wDTzYAMgqf15izRehMWKF7EKrpds3j
	hPTtO9exF7V7rS/lSzFBXjBtrGAGIsyTL/56sE5g2vye/GVhwoOky866iJLGmCuPrp054
X-Google-Smtp-Source: AGHT+IFeDcoH6FqGav3dMmPGh5sT6bY3h7jtuxBtb3J/jlYw3D77GN96q3f6d8YvDmECDxLlD6KL4j+bq6oD5HrXqmc=
X-Received: by 2002:a05:6512:1114:b0:53e:335e:774d with SMTP id
 2adb3069b0e04-5422957afc9mr4939338e87.56.1735057462100; Tue, 24 Dec 2024
 08:24:22 -0800 (PST)
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
 <CA+icZUV0HEF_hwr-eSovntfcT0++FBrQN-HbFL+oZtnKjJzLtA@mail.gmail.com>
 <698f48a0-b674-4d7f-9c47-f1f8bf86379e@citrix.com> <CA+icZUW454ND85nbjqAoMg42=i+aGht8Z=iG2wKj=Un7Ot0y6Q@mail.gmail.com>
In-Reply-To: <CA+icZUW454ND85nbjqAoMg42=i+aGht8Z=iG2wKj=Un7Ot0y6Q@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 24 Dec 2024 17:23:45 +0100
Message-ID: <CA+icZUUnbY7eRZtN-pMNn0jhYKLLEWEDNmJjhGQ3auPuS9_+MQ@mail.gmail.com>
Subject: Re: [Linux-6.12.y] XEN: CVE-2024-53241 / XSA-466 and Clang-kCFI
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Jan Beulich <jbeulich@suse.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev, 
	xen-devel <xen-devel@lists.xenproject.org>, 1091360@bugs.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 22, 2024 at 11:37=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com=
> wrote:
>
> On Sat, Dec 21, 2024 at 10:31=E2=80=AFPM Andrew Cooper
> <andrew.cooper3@citrix.com> wrote:
> >
> > On 21/12/2024 6:25 pm, Sedat Dilek wrote:
> > > With...
> > >
> > > dileks@iniza:~/src/xtf/git$ mv tests/xsa-454 ../
> > > dileks@iniza:~/src/xtf/git$ mv tests/xsa-consoleio-write ../
> >
> > That's completely bizzare.   There's nothing interestingly different
> > with those two tests vs the others.
> >
> > I take it the crash is repeatable when using either of these?
> >
> > ~Andrew
>
> This time I stopped SDDM and thus KDE-6/Wayland session.
>
> Tested with Debian's officially 6.12.6-amd64 kernel in VT-3.
>
> test-hvm32pae-xsa-consoleio-write SUCCESS <--- 1st time I tried, never
> said this is not OK
>
> test-hvm64-xsa-454 leads to FROZEN system and DATA LOSS (here: ext4).
> Reproducibly as told many times.- in Debian and selfmade kernels version =
6.12.6.
>
> Stolen from the picture I took with my smartphone:
>
> sudo ./xft-runner test-hvm64-xsa-454
>
> Executing 'xl create -p tests/xsa-454/test-hvm64-xsa-454.cfg'
> Executing 'xl console test-hvm64-xsa-454'
> Executing 'xl unpause test-hvm64-xsa-454'
>
> ^^ System does NOT react!
>
> I can send you the picture on request.
>
> -Sedat-

[ CC 1091360@bugs.debian.org ]

I upgraded to Xen version 4.19.1 in Debian/unstable AMD64.

# xl info | egrep 'release|version|commandline|caps'
release                : 6.12.6-amd64
version                : #1 SMP PREEMPT_DYNAMIC Debian 6.12.6-1 (2024-12-21=
)
hw_caps                :
bfebfbff:17bae3bf:28100800:00000001:00000001:00000000:00000000:00000100
virt_caps              : pv hvm hap shadow gnttab-v1 gnttab-v2
xen_version            : 4.19.1
xen_caps               : xen-3.0-x86_64 hvm-3.0-x86_32 hvm-3.0-x86_32p
hvm-3.0-x86_64
xen_commandline        : placeholder

dileks@iniza:~/src/xtf/git$ sudo ./xtf-runner --host test-hvm64-xsa-454
Executing 'xl create -p tests/xsa-454/test-hvm64-xsa-454.cfg'
Executing 'xl console test-hvm64-xsa-454'
Executing 'xl unpause test-hvm64-xsa-454'
--- Xen Test Framework ---
Environment: HVM 64bit (Long mode 4 levels)
XSA-454 PoC
Success: Not vulnerable to XSA-454
Test result: SUCCESS

Combined test results:
test-hvm64-xsa-454                       SUCCESS

root@iniza:~# LC_ALL=3DC ll /var/log/xen/*xsa-454*.log
-rw-r--r-- 1 root adm 232 Dec 24 17:11
/var/log/xen/qemu-dm-test-hvm64-xsa-454.log
-rw-r--r-- 1 root adm 232 Dec 24 17:11 /var/log/xen/xl-test-hvm64-xsa-454.l=
og

root@iniza:~# cat /var/log/xen/qemu-dm-test-hvm64-xsa-454.log
VNC server running on 127.0.0.1:5900
xen-qemu-system-i386: failed to create 'console' device '0': declining
to handle console type 'xenconsoled'
xen-qemu-system-i386: terminating on signal 1 from pid 6302
(/usr/lib/xen-4.19/bin/xl)

root@iniza:~# cat /var/log/xen/xl-test-hvm64-xsa-454.log
Waiting for domain test-hvm64-xsa-454 (domid 144) to die [pid 6302]
Domain 144 has shut down, reason code 0 0x0
Action for shutdown reason code 0 is destroy
Domain 144 needs to be cleaned up: destroying the domain
Done. Exiting now

Due to Debian-Bug #1091360 ("qemu-system-xen: Build against libxen-dev
version 4.19.1-1") I am not able to do the full XFT tests.

-Sedat-

Link: https://bugs.debian.org/1091360

