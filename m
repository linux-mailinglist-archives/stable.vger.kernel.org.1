Return-Path: <stable+bounces-4837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B5C80703D
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 13:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454E0281BC7
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 12:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087B2358A2;
	Wed,  6 Dec 2023 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="2TGgnzKk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D97FA
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 04:52:12 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d9d0d0e083so105803a34.2
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 04:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1701867132; x=1702471932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2u6Xixa1YAjeH/4C/qasYXYlNm9UNg6+7+FVH6S5Jo=;
        b=2TGgnzKkW6nN0nLX+kf0jFILnoeRb3I5NTqsr0TNr1BB9w9aptrxo7OgcieLBY7TMD
         i03gNEZ+UnYllLb2pC9onzspa1i1814/75dPO3CIUl8ewV3S+ZRZnnKmkI1DAw7GOrCq
         lPA3kZhfH1kQpA2ABPT/a4M5gQUcH8pCwI2M1CdkkLutD4b40SHZELvAswQ38X++8H5l
         5/VKb8aHHd8Hl/IDyuKKQ468UuBmxOY/ObHA+gCak3UwP0bop+nM397ycdRplenersvd
         x0jSTuhhusGYWIt+KifETJJN2QZ5siOvq3ZtN8J3N0m56oNALDIilBFSXZH/u94EuI4M
         qpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701867132; x=1702471932;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2u6Xixa1YAjeH/4C/qasYXYlNm9UNg6+7+FVH6S5Jo=;
        b=ILqUegL/Rjvpj2uEDjw1xXXwAcD4VyC6YKQ0o36CT8MDl27Ds09w+vN0QqBaZ3CcxC
         T8Ta8OZql8gUBb34A8RC1RW8DFq4e6liF2AsJjaFmIoCLk691FszyhD5DvGuy+JTd4p3
         UDD9cq+UjwVbOiRAmo30s0KIl6CkPe//MRtl0Ztf5gcgL5Com99S9bCMfLw7ZtBrnC+c
         +icgzL1LDJh7RdxlfKxrDPrMROU1+I7AVhXorOwxi33BS3wTOT5ArMVTTA8/j6JQQ+kS
         kw3yFR8QtneHrg1qVkbT3sTYFq7MgUzEmD3fjy9sLGvaCB64kIulrLHw8JLHg4TlfHeh
         3owQ==
X-Gm-Message-State: AOJu0YyJXVzM2IQw+M8fbJQ3puYqKPULTEHSV00/HVOhQYgkl9xfCzcq
	/LkBmwCf4xp4MS4PtxfW9LXzSA==
X-Google-Smtp-Source: AGHT+IFo8cQfWhV8swbKEf3islhCo6malnup6YNIbLn5q10GsK1yfkvEG2E/lOLG+1vPBZPzBrA2sA==
X-Received: by 2002:a9d:7358:0:b0:6d9:cec2:aa66 with SMTP id l24-20020a9d7358000000b006d9cec2aa66mr283337otk.30.1701867131750;
        Wed, 06 Dec 2023 04:52:11 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id az15-20020a056830458f00b006d94fa88156sm1459097otb.14.2023.12.06.04.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 04:52:11 -0800 (PST)
Date: Wed, 06 Dec 2023 04:52:11 -0800 (PST)
X-Google-Original-Date: Wed, 06 Dec 2023 04:52:08 PST (-0800)
Subject:     Re: [RFT 1/2] RISC-V: handle missing "no-map" properties for OpenSBI's PMP protected regions
In-Reply-To: <20230810-crewless-pampers-6f51aafb8cff@wendy>
CC: Atish Patra <atishp@rivosinc.com>, Conor Dooley <conor@kernel.org>,
  Paul Walmsley <paul.walmsley@sifive.com>, apatel@ventanamicro.com, alexghiti@rivosinc.com,
  Bjorn Topel <bjorn@rivosinc.com>, suagrfillet@gmail.com, jeeheng.sia@starfivetech.com,
  petrtesarik@huaweicloud.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor.dooley@microchip.com>, geert+renesas@glider.be
Message-ID: <mhng-550dee8b-a2fb-485b-ad4d-2763e94191b4@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 10 Aug 2023 02:07:10 PDT (-0700), Conor Dooley wrote:
> On Wed, Aug 09, 2023 at 02:01:07AM -0700, Atish Kumar Patra wrote:
>> On Tue, Aug 8, 2023 at 6:39 AM Conor Dooley <conor@kernel.org> wrote:
>> >
>> > On Tue, Aug 08, 2023 at 12:54:11AM -0700, Atish Kumar Patra wrote:
>> > > On Wed, Aug 2, 2023 at 4:14 AM Conor Dooley <conor.dooley@microchip.com> wrote:
>> > > >
>> > > > Add an erratum for versions [v0.8 to v1.3) of OpenSBI which fail to add
>> > > > the "no-map" property to the reserved memory nodes for the regions it
>> > > > has protected using PMPs.
>> > > >
>> > > > Our existing fix sweeping hibernation under the carpet by marking it
>> > > > NONPORTABLE is insufficient as there are other ways to generate
>> > > > accesses to these reserved memory regions, as Petr discovered [1]
>> > > > while testing crash kernels & kdump.
>> > > >
>> > > > Intercede during the boot process when the afflicted versions of OpenSBI
>> > > > are present & set the "no-map" property in all "mmode_resv" nodes before
>> > > > the kernel does its reserved memory region initialisation.
>> > > >
>> > >
>> > > We have different mechanisms of DT being passed to the kernel.
>> > >
>> > > 1. A prior stage(e.g U-Boot SPL) to M-mode runtime firmware (e.g.
>> > > OpenSBI, rustSBI) passes the DT to M-mode runtime firmware and it
>> > > passes to the next stage.
>> > > In this case, M-mode runtime firmware gets a chance to update the
>> > > no-map property in DT that the kernel can parse.
>> > >
>> > > 2. User loads the DT from the boot loader (e.g EDK2, U-Boot proper).
>> > > Any DT patching done by the M-mode firmware is useless. If these DTBs
>> > > don't have the no-map
>> > > property, hibernation or EFI booting will have issues as well.
>> > >
>> >
>> > > We are trying to solve only one part of problem #1 in this patch.
>> >
>> > Correct.
>> >
>> > If someone's second stage is also providing an incorrect devicetree
>> > then, yeah, this approach would fall apart - but it's the firmware
>> > provided devicetree being incorrect that I am trying to account for
>> > here. If a person incorrectly constructed one, I am not really sure what
>> > we can do for them, they incorrect described their hardware /shrug
>> > My patch should of course help in some of the scenarios you mention above
>> > if the name of the reserved memory region from OpenSBI is propagated by
>> > the second-stage bootloader, but that is just an extension of case 1,
>> > not case 2.
>> >
>> > > I
>> > > don't think any other M-mode runtime firmware patches DT with no-map
>> > > property as well.
>> > > Please let me know if I am wrong about that. The problem is not
>> > > restricted to [v0.8 to v1.3) of OpenSBI.
>> >
>> > It comes down to Alex's question - do we want to fix this kind of
>> > firmware issue in the kernel? Ultimately this is a policy decision that
>> > "somebody" has to make. Maybe the list of firmwares that need this
>> 
>> IMO, we shouldn't as this is a slippery slope. Kernel can't fix every
>> firmware bug by having erratas.
>> I agree with your point below about firmware in shipping products. I
>> am not aware of any official products shipping anything other than
>> OpenSBI either.
>
>> However, I have seen users using other firmwares in their dev
>> environment.
>
> If someone's already changed their boards firmware, I have less sympathy
> for them, as they should be able to make further changes. Punters buying
> SBCs to install Fedora or Debian w/o having to consider their firmware
> are who I am more interested in helping.
>
>> IMHO, this approach sets a bad precedent for the future especially
>> when it only solves one part of the problem.
>
> Yeah, I'm certainly wary of setting an unwise precedent here.
> Inevitably we will need to have firmware-related errata and it'd be good
> to have a policy for what is (or more importantly what isn't
> acceptable). Certainly we have said that known-broken version of OpenSBI
> that T-Head puts in their SDK is not supported by the mainline kernel.
> On the latter part, I'm perfectly happy to expand the erratum to cover
> all affected firmwares, but I wasn't even sure if my fix worked
> properly, hence the request for testing from those who encountered the
> problem.
>
>> We shouldn't hide firmware bugs in the kernel when an upgraded
>> firmware is already available.
>
> Just to note, availability of an updated firmware upstream does not
> necessarily mean that corresponding update is possible for affected
> hardware.

Yep.  I think we're been in a very hobbist-centric world in RISC-V land, 
but in general trying to get people to update firmware is hard.  Part of 
the whole "kernel updates don't break users" thing is what's underneath 
the kernel, it's not just a uABI thing.

>> This bug is well documented in various threads and fixed in the latest
>> version of OpenSBI.
>> I am assuming other firmwares will follow it as well.
>> 
>> Anybody facing hibernation or efi related booting issues should just
>> upgrade to the latest version of firmware (e.g OpenSBI v1.3)
>> Latest version of Qemu will support(if not happened already) the
>> latest version of OpenSBI.
>> 
>> This issue will only manifest in kernels 6.4 or higher. Any user
>> facing these with the latest kernel can also upgrade the firmware.
>> Do you see any issue with that ?
>
> I don't think it is fair to compare the ease of upgrading the kernel
> to that required to upgrade a boards firmware, with the latter being
> far, far more inconvenient on pretty much all of the boards that I have.

IMO we're in the same spot as every other port here, and generally they 
work around firmware bugs when they've rolled out into production 
somewhere that firmware updates aren't likely to happen quickly.  I'm 
not sure if there's any sort of exact rules written down anywhere, but 
IMO if the bug is going to impact users then we should deal with it.

That applies for hardware bugs, but also firmware bugs (at a certain 
point we won't be able to tell the difference).  We're sort of doing 
this with the misaligned access handling, for example.

> I'm perfectly happy to drop this series though, if people generally are
> of the opinion that this sort of firmware workaround is ill-advised.
> We are unaffected by it, so I certainly have no pressure to have
> something working here. It's my desire not to be user-hostile that
> motivated this patch.

IIUC you guys and Reneas are the only ones who have hardware that might 
be in a spot where users aren't able to update the firmware (ie, it's 
out in production somewhere).  So I'm adding Geert, though he probably 
saw this months ago...

On that note: It's been ~4 months and it look like nobody's tested 
anything (and the comments aren't really things that would preculde 
testing).  So maybe we just pick that second patch up into for-next and 
see what happens?  IIUC that will result in broken systems for users who 
haven't updated their firmware.

I agree that's a user-hostile way to do things, which is generally a bad 
way to go, but if it's really true that there's no users then we're 
safe.  Probably also worth calling it out on sw-dev just to be safe.

