Return-Path: <stable+bounces-111239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95593A2261C
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 23:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 158037A2A6B
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 22:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F0619D89B;
	Wed, 29 Jan 2025 22:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETeONXr6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2956EB4C;
	Wed, 29 Jan 2025 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738188941; cv=none; b=QRiei4Z59X6LyEPeW1tJorg+8Ue8oUQeuOL0sRmYZiBA69tO/H//i6qZW2l4TXC5cNioNHjCU7zKW9KM2pG8E9vABlLOZWErYjwaNdTUeFjWFxoUEL6LtA1Vd0MQIzCPPhLVEvY4fmdm52WjJK5WZbrrQLLsjOxtG4vTF0stYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738188941; c=relaxed/simple;
	bh=RPavOd8t3Kyawfx8CcRUx3BDMzYq0crkVMTo5lpewjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXyPhcGuG+Q5/bW5ken6PbtxgZ0SirsX96w31Lfr/BK61lYMtOeOxn1ujltnFB33u19TA2yqx11Zzt9JmT2aguCDz5Q4c3JZL20hRAtvtBxEcs0Lck2R3/kcMQrAJLhaa/1elNu+iyfwRulQAPvhQWcyyCzFWNwrB09rjU43tak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETeONXr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54759C4CEE4;
	Wed, 29 Jan 2025 22:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738188940;
	bh=RPavOd8t3Kyawfx8CcRUx3BDMzYq0crkVMTo5lpewjo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ETeONXr6vwGcP1j+G9hjGfq02SDCGYTGBcP2GW8EOm0Ov4cueku2SO1VMDxvDz1d8
	 xj2nsffwIevv3xGKfzKhCVAIspQtxzWef37DGhMRz34x0Y1rwnmzOwh4eFZAJJRlQ5
	 xiVOn2pyoTk7ZI0QLNkfJpsCCjPgIhxWNtNgUQzkISQzC82dlw9usYaSIlay4OI2Ti
	 9PGxH43EKPxIIyxtQYP9X09db2OARghMiCuUj7ayILx0q/kCYy0tT9D6shCAJJrqOM
	 sSa7Ed1oRt610IgtHY2bqVmDB6BpuVI05HjjjsmCwZBHJ+XQr1izmkCfK/opeW/Jrk
	 es8q9mjZFZO4w==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-543e47e93a3so131773e87.2;
        Wed, 29 Jan 2025 14:15:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUi6EtoXngeT2Q4dO2UwDGHYWHyVVfD/D2v6GikXWKB10exdd0W52wEmX0LGPbkGdGSn/CDo23k@vger.kernel.org, AJvYcCWKnK6RxY7sZi36vtXnHvaS9ULPwZVU3k9/RWuQLpY/x6Mcxo9ep5xZwGXl6fpihe5nF6ZVbQtvEwChMBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzevh6SjeUJvrkT6+VD75ftKFjnrgblYPM6YIVR1OOzvWlVCJSq
	DiKOtvfjDnMyuSYl/1jadqS+VOIOsOBO1PXo5WjI6/9ZEt68iY0CDOyUOOzquKW+ST5mmXxxgQf
	vd4DAOSzSSKc6NFv6RSP4zkcO5s4=
X-Google-Smtp-Source: AGHT+IGaCUKHbvJW3S9WSJWNmDOASM3Me66IQ2/gDDjXjOkZIPD/y+t8vRg5ptZi+7CrZUA+zeTMBveEdT+OYJk1Ze8=
X-Received: by 2002:a05:6512:1089:b0:542:6d01:f54d with SMTP id
 2adb3069b0e04-543e4be0064mr1902751e87.3.1738188938666; Wed, 29 Jan 2025
 14:15:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109165419.1623683-1-florian.fainelli@broadcom.com>
 <20250109165419.1623683-2-florian.fainelli@broadcom.com> <62786457-d4a1-4861-8bec-7e478626f4db@broadcom.com>
 <2025011247-enable-freezing-ffa2@gregkh> <27bbea11-61fa-4f41-8b39-8508f2d2e385@broadcom.com>
 <2025012002-tactics-murky-aaab@gregkh> <41550c7f-1313-41b4-aa2e-cb4809ad68c2@broadcom.com>
 <2025012938-abreast-explain-f5f7@gregkh> <1fc6d5c8-80ec-4d6b-bc14-c584d89c15b4@broadcom.com>
In-Reply-To: <1fc6d5c8-80ec-4d6b-bc14-c584d89c15b4@broadcom.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 29 Jan 2025 23:15:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHheRQYHddgehLbZot6o-xAxkbeHBUq7nS8npyB9A0FvQ@mail.gmail.com>
X-Gm-Features: AWEUYZmguNMBHYqDLTE-pge9VsEnOuLpnCbKTSU94q87N2KbUgEEwIpw0fehwsE
Message-ID: <CAMj1kXHheRQYHddgehLbZot6o-xAxkbeHBUq7nS8npyB9A0FvQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: account for hotplug memory when randomizing
 the linear region
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Will Deacon <will@kernel.org>, 
	Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Baruch Siach <baruch@tkos.co.il>, 
	Petr Tesarik <ptesarik@suse.com>, Mark Rutland <mark.rutland@arm.com>, 
	Joey Gouly <joey.gouly@arm.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Yang Shi <yang@os.amperecomputing.com>, 
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 18:45, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 1/29/25 01:17, Greg KH wrote:
> > On Mon, Jan 20, 2025 at 08:33:12AM -0800, Florian Fainelli wrote:
> >>
> >>
> >> On 1/20/2025 5:59 AM, Greg KH wrote:
> >>> On Mon, Jan 13, 2025 at 07:44:50AM -0800, Florian Fainelli wrote:
> >>>>
> >>>>
> >>>> On 1/12/2025 3:54 AM, Greg KH wrote:
> >>>>> On Thu, Jan 09, 2025 at 09:01:13AM -0800, Florian Fainelli wrote:
> >>>>>> On 1/9/25 08:54, Florian Fainelli wrote:
> >>>>>>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>>>>>
> >>>>>>> commit 97d6786e0669daa5c2f2d07a057f574e849dfd3e upstream
> >>>>>>>
> >>>>>>> As a hardening measure, we currently randomize the placement of
> >>>>>>> physical memory inside the linear region when KASLR is in effect.
> >>>>>>> Since the random offset at which to place the available physical
> >>>>>>> memory inside the linear region is chosen early at boot, it is
> >>>>>>> based on the memblock description of memory, which does not cover
> >>>>>>> hotplug memory. The consequence of this is that the randomization
> >>>>>>> offset may be chosen such that any hotplugged memory located above
> >>>>>>> memblock_end_of_DRAM() that appears later is pushed off the end of
> >>>>>>> the linear region, where it cannot be accessed.
> >>>>>>>
> >>>>>>> So let's limit this randomization of the linear region to ensure
> >>>>>>> that this can no longer happen, by using the CPU's addressable PA
> >>>>>>> range instead. As it is guaranteed that no hotpluggable memory will
> >>>>>>> appear that falls outside of that range, we can safely put this PA
> >>>>>>> range sized window anywhere in the linear region.
> >>>>>>>
> >>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>>>>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> >>>>>>> Cc: Will Deacon <will@kernel.org>
> >>>>>>> Cc: Steven Price <steven.price@arm.com>
> >>>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
> >>>>>>> Link: https://lore.kernel.org/r/20201014081857.3288-1-ardb@kernel.org
> >>>>>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> >>>>>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> >>>>>>
> >>>>>> Forgot to update the patch subject, but this one is for 5.10.
> >>>>>
> >>>>> You also forgot to tell us _why_ this is needed :(
> >>>>
> >>>> This is explained in the second part of the first paragraph:
> >>>>
> >>>> The consequence of this is that the randomization offset may be chosen such
> >>>> that any hotplugged memory located above memblock_end_of_DRAM() that appears
> >>>> later is pushed off the end of the linear region, where it cannot be
> >>>> accessed.
> >>>>
> >>>> We use both memory hotplug and KASLR on our systems and that's how we
> >>>> eventually found out about the bug.
> >>>
> >>> And you still have 5.10.y ARM64 systems that need this?  Why not move to
> >>> a newer kernel version already?
> >>
> >> We still have ARM64 systems running 5.4 that need this, and the same bug
> >> applies to 5.10 that we used to support but dropped in favor of 5.15/6.1.
> >> Those are the kernel versions used by Android, and Android TV in particular,
> >> so it's kind of the way it goes for us.
> >>
> >>>
> >>> Anyway, I need an ack from the ARM64 maintainers that this is ok to
> >>> apply here before I can take it.
> >>
> >> Just out of curiosity, the change is pretty innocuous and simple to review,
> >> why the extra scrutiny needed here?
> >
> > Why shouldn't the maintainers review a proposed backport patch for core
> > kernel code that affects everyone who uses that arch?
>
> They should, but they are not, we can keep sending messages like those
> in the hope that someone does, but clearly that is not working at the
> moment.
>
> This patch cherry picked cleanly into 5.4 and 5.10 maybe they just trust
> whoever submit stable bugfixes to have done their due diligence, too, I
> don't know how to get that moving now but it fixes a real problem we
> observed.
>

FWIW, I understand why this might be useful when running under a
non-KVM hypervisor that relies on memory hotplug to perform resource
balancing between VMs. But the upshot of this change is that existing
systems that do not rely on memory hotplug at all will suddenly lose
any randomization of the linear map if its CPU happens to be able to
address more than ~40 bits of physical memory. So I'm not convinced
this is a change we should make for these older kernels.

