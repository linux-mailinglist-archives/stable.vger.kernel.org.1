Return-Path: <stable+bounces-54731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55620910A1D
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 17:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783D81C22F26
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 15:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4201B010E;
	Thu, 20 Jun 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQvYqHcG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DD52770B
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897996; cv=none; b=XBGfmRWti8BUqt/f2PicAnpkxYnFzxGVQzdxhjlFOV3fgogGHa4IlZcbAjCRKMAPyiw4bEYZ5RyoKOIwHk7wbil95cPSbMsLAd6Ph/N9Z8ExFQ5M4HysE+otLHAvAyp9Qz+leNb7qH00B/c6dw7BRg2XAQgY6JgzC9LV8QwJ/Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897996; c=relaxed/simple;
	bh=SAbg+wVYqph3TL90xOL1oynPwf5bkeyQps0mBCaXQX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n31UoOLKIgzahjz57hKitmdg8EWadr8dR1l8NJAKXr2AkV+KaiaNJh9PHjvmd9ddjfcZavy8Dq9h0o4bt79aIxz6Sc+LylzxSQRCsJFbpV9uwfM/xsZQY9J019jxUiDpIjAN2JgSewi///8vruzBYos2EyUn4F1gPuumb4FA/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DQvYqHcG; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-80d61a602f2so311115241.2
        for <stable@vger.kernel.org>; Thu, 20 Jun 2024 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718897994; x=1719502794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5GUJPV8yOp4RRoYY7LVY9TGkg0HQmwQOmVMKijpbR4g=;
        b=DQvYqHcGu0hkpsU/dhS7E3LvMSbkBUnhrCSoJeS+ObyDgwHH7cJqOPtlEg7AHXI3wb
         OtOdUalvFRJ58h5/r8Dr6JwD7HcASMlkVD0xzeGGW6+8UDE77sLAW7Kw2NUsradpfXci
         Uo0OeaKaOfiRBptmQWlFVJiu9vVSMcUMVplONMqsYd3/TuDOpLBum46hTUHH8lQSKVx/
         jdRvpKkFvsMGehmsnVZr1XeKtC/GKeFCjXIbyxBCEHjsIf79Hta+s+V3yA6l12tagDR7
         YM23z2bTc8V1xgBAm0dT1aNaGfeiwSgU/F3JNQ/VLrN9q6tLW4Ana5D+AppVZQTklxXj
         99nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718897994; x=1719502794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GUJPV8yOp4RRoYY7LVY9TGkg0HQmwQOmVMKijpbR4g=;
        b=XwKgE85mHlwch/ueOYq0yMMbkv6FshEa9jAy92QWCvo2VGJ/OUsavRLe+WAspbCKfa
         7Il2xs8HXG7WpUUjYrtJnIbEo5U8HVJo/afeBstrAGPYu+MA/wYtaQCGF8Lg4TivP2JA
         6DIaRK1y8bwBg00GU1GF6bYkN8ck5fSwqQzfxyJG/iJk4u1Fw1QcymeSN7/pBxHAaweW
         OoXjKfPKBjoFjuSIpUgi0NVrcBtMpr64WhwgwLu92MnM5LtimOspGMFI0P3JNM1g22c/
         cYOwoZbG7PlScx6ZXSvx4NUjPB0RUMdP89QUuzNwjJcKrV6zbznyunCQCuzF6CSmwYgP
         Ffqg==
X-Forwarded-Encrypted: i=1; AJvYcCVyKrXQFzz86qoh6PkmD57JlGImGcWPp89q4MSqjUA6Uz2FS7fMfBrqjviutr+nTBoDaK3zVa7R1hNlhSWCGtUI6N5FL9Aw
X-Gm-Message-State: AOJu0YxT00nbLTJzEeFo4xO9tEQ72HwK/QtBkx2YnnuI7gxrtDTIPbSk
	hJ03ktZ6CyW15RMJajcBhdvvX3KMS1ArVr653uCPbbH8BZ/kKIqYsvR5dgQjDds5uUHhhINDgQk
	bAtNBtbPnEE1sTtAEEDrs+8S4rxBr5O6TW6AudQ==
X-Google-Smtp-Source: AGHT+IHACjMP5RzFgepii/qD9qtk0+p5mwa6jnpfKmdaSdmp8lLICvVkXdDPSiF9XM3Dus6YHP7t5X5+bwf7WLuWK+4=
X-Received: by 2002:a05:6122:1346:b0:4ec:f27b:ee9c with SMTP id
 71dfb90a1353d-4ef276c041bmr6506472e0c.5.1718897992229; Thu, 20 Jun 2024
 08:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619125609.836313103@linuxfoundation.org> <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
 <2024062028-caloric-cost-2ab9@gregkh> <CA+G9fYsr0=_Yzew1uyUtrZ7ayZFYqmaNzAwFZJPjFnDXZEwYcQ@mail.gmail.com>
 <36a38846-0250-4ac2-b2d0-c72e00d6898d@redhat.com> <CA+G9fYv4fZiB-pL7=4SNfudh2Aqknf5+OXo1RFAFRhJFZMsEsg@mail.gmail.com>
 <3cd2cdca-5c89-447e-b6f1-f68112cf3f7b@redhat.com>
In-Reply-To: <3cd2cdca-5c89-447e-b6f1-f68112cf3f7b@redhat.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Jun 2024 21:09:40 +0530
Message-ID: <CA+G9fYutNa9ziuj7aayhukaMdxKFU9+81qKAjZbQ=dQa3fwYYg@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
To: David Hildenbrand <david@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org, 
	Miaohe Lin <linmiaohe@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Cgroups <cgroups@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, jbeulich@suse.com, 
	LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 19:50, David Hildenbrand <david@redhat.com> wrote:
>
> On 20.06.24 16:02, Naresh Kamboju wrote:
> > On Thu, 20 Jun 2024 at 19:23, David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 20.06.24 15:14, Naresh Kamboju wrote:
> >>> On Thu, 20 Jun 2024 at 17:59, Greg Kroah-Hartman
> >>> <gregkh@linuxfoundation.org> wrote:
> >>>>
> >>>> On Thu, Jun 20, 2024 at 05:21:09PM +0530, Naresh Kamboju wrote:
> >>>>> On Wed, 19 Jun 2024 at 18:41, Greg Kroah-Hartman
> >>>>> <gregkh@linuxfoundation.org> wrote:
> >>>>>>
> >>>>>> This is the start of the stable review cycle for the 6.9.6 release.
> >>>>>> There are 281 patches in this series, all will be posted as a response
> >>>>>> to this one.  If anyone has any issues with these being applied, please
> >>>>>> let me know.
> >>>>>>
> >>>>>> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> >>>>>> Anything received after that time might be too late.
> >>>>>>
> >>>>>> The whole patch series can be found in one patch at:
> >>>>>>           https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
> >>>>>> or in the git tree and branch at:
> >>>>>>           git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> >>>>>> and the diffstat can be found below.
> >>>>>>
> >>>>>> thanks,
> >>>>>>
> >>>>>> greg k-h
> >>>>>
> >>>>> There are two major issues on arm64 Juno-r2 on Linux stable-rc 6.9.6-rc1
> >>>>>
> >>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >>>>>
> >>>>> 1)
> >>>>> The LTP controllers cgroup_fj_stress test cases causing kernel crash
> >>>>> on arm64 Juno-r2 with
> >>>>> compat mode testing with stable-rc 6.9 kernel.
> >>>>>
> >>>>> In the recent past I have reported this issues on Linux mainline.
> >>>>>
> >>>>> LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline 6.10.rc3
> >>>>>     - https://lore.kernel.org/all/CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com/
> >>>>>
> >>>>> it goes like this,
> >>>>>     Unable to handle kernel NULL pointer dereference at virtual address
> >>>>>     ...
> >>>>>     Insufficient stack space to handle exception!
> >>>>>     end Kernel panic - not syncing: kernel stack overflow
> >>>>>
> >>
> >> How is that related to 6.9.6-rc1? That report is from mainline (6.10.rc3).
> >>
> >> Can you share a similar kernel dmesg output from  the issue on 6.9.6-rc1?
> >
> > I request you to use this link for detailed boot log, test log and crash log.
> >   - https://lkft.validation.linaro.org/scheduler/job/7687060#L23314
> >
> > Few more logs related to build artifacts links provided in the original
> > email thread and bottom of this email.
> >
> > crash log:
> > ---
> >

Thanks for investigating this crash report.

> Thanks, so this is something different than the
>
> "BUG: Bad page map in process fork13
>   BUG: Bad rss-counter state mm:"
>
> stuff on mainline you referenced.
>
> Looks like some recursive exception until we exhausted the stack.

You are right !
I see only one common case is, exhaust the stack.

>
>
> Trying to connect the dots here, can you enlighten me how this is
> related to the fork13 mainline report?

I am not sure about the relation between these two reports.
But as a common practice I have shared that report information.

> > [ 0.000000] Booting Linux on physical CPU 0x0000000100 [0x410fd033]
> > [ 0.000000] Linux version 6.9.6-rc1 (tuxmake@tuxmake)
> > (aarch64-linux-gnu-gcc (Debian 13.2.0-12) 13.2.0, GNU ld (GNU Binutils
> > for Debian) 2.42) #1 SMP PREEMPT @1718817000
> > ...
> > [ 1786.336761] Unable to handle kernel NULL pointer dereference at
> > virtual address 0000000000000070
> > [ 1786.345564] Mem abort info:
> > [ 1786.348359]   ESR = 0x0000000096000004
> > [ 1786.352112]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [ 1786.357434]   SET = 0, FnV = 0
> > [ 1786.360492]   EA = 0, S1PTW = 0
> > [ 1786.363637]   FSC = 0x04: level 0 translation fault
> > [ 1786.368523] Data abort info:
> > [ 1786.371405]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> > [ 1786.376900]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > [ 1786.381960]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [ 1786.387284] Unable to handle kernel NULL pointer dereference at
> > virtual address 0000000000000070
> > [ 1786.387293] Insufficient stack space to handle exception!
> > [ 1786.387296] ESR: 0x0000000096000047 -- DABT (current EL)
> > [ 1786.387302] FAR: 0xffff80008399ffe0
> > [ 1786.387306] Task stack:     [0xffff8000839a0000..0xffff8000839a4000]
> > [ 1786.387312] IRQ stack:      [0xffff8000837f8000..0xffff8000837fc000]
> > [ 1786.387319] Overflow stack: [0xffff00097ec95320..0xffff00097ec96320]
> > [ 1786.387327] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 6.9.6-rc1 #1
> > [ 1786.387338] Hardware name: ARM Juno development board (r2) (DT)
> > [ 1786.387344] pstate: a00003c5 (NzCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [ 1786.387355] pc : _prb_read_valid (kernel/printk/printk_ringbuffer.c:2109)
> > [ 1786.387374] lr : prb_read_valid (kernel/printk/printk_ringbuffer.c:2183)
> > [ 1786.387385] sp : ffff80008399ffe0
> > [ 1786.387390] x29: ffff8000839a0030 x28: ffff000800365f00 x27: ffff800082530008
> > [ 1786.387407] x26: ffff8000834e33b8 x25: ffff8000839a00b0 x24: 0000000000000001
> > [ 1786.387423] x23: ffff8000839a00a8 x22: ffff8000830e3e40 x21: 0000000000001e9e
> > [ 1786.387438] x20: 0000000000000000 x19: ffff8000839a01c8 x18: 0000000000000010
> > [ 1786.387453] x17: 72646461206c6175 x16: 7472697620746120 x15: 65636e6572656665
> > [ 1786.387468] x14: 726564207265746e x13: 3037303030303030 x12: 3030303030303030
> > [ 1786.387483] x11: 2073736572646461 x10: ffff800083151ea0 x9 : ffff80008014273c
> > [ 1786.387498] x8 : ffff8000839a0120 x7 : 0000000000000000 x6 : 0000000000000e9f
> > [ 1786.387512] x5 : ffff8000839a00c8 x4 : ffff8000837157c0 x3 : 0000000000000000
> > [ 1786.387526] x2 : ffff8000839a00b0 x1 : 0000000000000000 x0 : ffff8000830e3f58
> > [ 1786.387542] Kernel panic - not syncing: kernel stack overflow
> > [ 1786.387549] SMP: stopping secondary CPUs
> > [ 1787.510055] SMP: failed to stop secondary CPUs 0,4
> > [ 1787.510065] Kernel Offset: disabled
> > [ 1787.510068] CPU features: 0x4,00001061,e0100000,0200421b
> > [ 1787.510076] Memory Limit: none
> > [ 1787.680436] ---[ end Kernel panic - not syncing: kernel stack overflow ]---
>
>
> --
> Cheers,
>
> David / dhildenb

- Naresh

