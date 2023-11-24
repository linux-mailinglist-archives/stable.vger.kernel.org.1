Return-Path: <stable+bounces-177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697647F7488
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A92281EDF
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1EC249E0;
	Fri, 24 Nov 2023 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RS9lmVeP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54302286B1;
	Fri, 24 Nov 2023 13:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAA9C433C9;
	Fri, 24 Nov 2023 13:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700831117;
	bh=gHslPrCptnwdn3oC+vz7EhLUeTjbHXiOmST977Cv03c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RS9lmVePw1mp/uxFPOGJ/9reUlYKEgqjb7V3a6RHa018Q7L8unFQ3pmmCm5sbk/dH
	 8KPFJSgFxJ2SXqr89yKgvhGyXLnJrr59l2g+0jf+xxIUVE2vbRK5V4th6dbTSbaF/A
	 Nm5NF2WuCoQLimA8lKqZd2j9wGAgmCQxncpRzGvQ=
Date: Fri, 24 Nov 2023 13:05:14 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Petr Tesarik <petr@tesarici.cz>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	workflows@vger.kernel.org
Subject: Re: [REGRESSION] USB ports do not work after suspend/resume cycle
 with v6.6.2
Message-ID: <2023112436-guru-repent-e1ff@gregkh>
References: <5993222.lOV4Wx5bFT@natalenko.name>
 <2023112421-brisket-starless-c20d@gregkh>
 <bfc4259e-c293-1e53-a787-4131e8bacc21@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfc4259e-c293-1e53-a787-4131e8bacc21@suse.cz>

On Fri, Nov 24, 2023 at 01:59:24PM +0100, Vlastimil Babka wrote:
> +Cc workflows
> 
> On 11/24/23 12:43, Greg Kroah-Hartman wrote:
> > On Thu, Nov 23, 2023 at 07:20:46PM +0100, Oleksandr Natalenko wrote:
> >> Hello.
> >> 
> >> Since v6.6.2 kernel release I'm experiencing a regression with regard
> >> to USB ports behaviour after a suspend/resume cycle.
> >> 
> >> If a USB port is empty before suspending, after resuming the machine
> >> the port doesn't work. After a device insertion there's no reaction in
> >> the kernel log whatsoever, although I do see that the device gets
> >> powered up physically. If the machine is suspended with a device
> >> inserted into the USB port, the port works fine after resume.
> >> 
> >> This is an AMD-based machine with hci version 0x110 reported. As per
> >> the changelog between v6.6.1 and v6.6.2, 603 commits were backported
> >> into v6.6.2, and one of the commits was as follows:
> >> 
> >> $ git log --oneline v6.6.1..v6.6.2 -- drivers/usb/host/xhci-pci.c 
> >> 14a51fa544225 xhci: Loosen RPM as default policy to cover for AMD xHC
> >> 1.1
> >> 
> >> It seems that this commit explicitly enables runtime PM specifically
> >> for my platform. As per dmesg:
> >> 
> >> v6.6.1: quirks 0x0000000000000410 v6.6.2: quirks 0x0000000200000410
> >> 
> >> Here, bit 33 gets set, which, as expected, corresponds to:
> >> 
> >> drivers/usb/host/xhci.h 1895:#define XHCI_DEFAULT_PM_RUNTIME_ALLOW
> >> BIT_ULL(33)
> >> 
> >> This commit is backported from the upstream commit 4baf12181509, which
> >> is one of 16 commits of the following series named "xhci features":
> >> 
> >> https://lore.kernel.org/all/20231019102924.2797346-1-mathias.nyman@linux.intel.com/
> >>
> >>  It appears that there was another commit in this series, also from
> >> Basavaraj (in Cc), a5d6264b638e, which was not picked for v6.6.2, but
> >> which stated the following:
> >> 
> >> Use the low-power states of the underlying platform to enable runtime
> >> PM. If the platform doesn't support runtime D3, then enabling default
> >> RPM will result in the controller malfunctioning, as in the case of
> >> hotplug devices not being detected because of a failed interrupt
> >> generation.
> >> 
> >> It felt like this was exactly my case. So, I've conducted two tests:
> >> 
> >> 1. Reverted 14a51fa544225 from v6.6.2. With this revert the USB ports
> >> started to work fine, just as they did in v6.6.1. 2. Left 14a51fa544225
> >> in place, but also applied upstream a5d6264b638e on top of v6.6.2. With
> >> this patch added the USB ports also work after a suspend/resume cycle.
> >> 
> >> This runtime PM enablement did also impact my AX200 Bluetooth device,
> >> resulting in long delays before headphones/speaker can connect, but
> >> I've solved this with btusb.enable_autosuspend=N. I think this has
> >> nothing to do with the original issue, and I'm OK with this workaround
> >> unless someone has got a different idea.
> >> 
> >> With that, please consider either reverting 14a51fa544225 from the
> >> stable kernel, or applying a5d6264b638e in addition to it. Given the
> >> mainline kernel has got both of them, I'm in favour of applying
> >> additional commit to the stable kernel.
> > 
> > I've applied this other commit as well to all of the affected branches, 
> > thanks for letting us know.
> > 
> >> I'm also Cc'ing all the people from our Mastodon discussion where I
> >> initially complained about the issue as well as about stable kernel
> >> branch stability:
> >> 
> >> https://activitypub.natalenko.name/@oleksandr/statuses/01HFRXBYWMXF9G4KYPE3XHH0S8
> >>
> >>  I'm not going to expand more on that in this email, especially given
> >> Greg indicated he read the conversation, but I'm open to continuing
> >> this discussion as I still think that current workflow brings visible
> >> issues to ordinary users, and hence some adjustments should be made.
> > 
> > What type of adjustments exactly?  Testing on wide ranges of systems is
> > pretty hard, and this patch explicitly was set to be backported when it
> > hit Linus's tree,
> 
> Are you sure about that "explicitly was set to be backported" part?
> According to Documentation/process/stable-kernel-rules.rst:
> 
> > There are three options to submit a change to -stable trees:
> > 
> >  1. Add a 'stable tag' to the description of a patch you then submit for
> >     mainline inclusion.
> >  2. Ask the stable team to pick up a patch already mainlined.
> >  3. Submit a patch to the stable team that is equivalent to a change already
> >     mainlined.
> 
> I don't see a stable tag in 4baf12181509 ("xhci: Loosen RPM as default
> policy to cover for AMD xHC 1.1"), was it option 2 or 3 then?
> 
> Do you mean the Fixes: tag? the docs only say that can replace the "# 3.3.x"
> part to determine where backporting should stop, but is not itself an
> explicit marking for stable backport?

No, I mean the "The subsystem maintainer knew this needed to be added to
the stable trees so they told the stable maintainer to do so."  Now the
fact that I am both people at once, and did so in my own head instead of
writing myself a public email, might not have made this all that obvious :)

thanks,

gre gk-h

