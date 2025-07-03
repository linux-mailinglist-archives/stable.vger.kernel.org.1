Return-Path: <stable+bounces-159279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498F8AF695B
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 07:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1332A4E1FC9
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 05:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1311722FE18;
	Thu,  3 Jul 2025 05:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u93A6cgc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50F22AE99
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519648; cv=none; b=OA3T/35q1eped821uiN6ISy07Wkin3dsB1JbVnf9wJOMNiNGXpiFyM+75/MAExC15TmI3AxPG5VW3uV6uaGgUpmitqdTWCh/QQmzTx6PBSeyu001g8dO/BpI7iv3gNXM4Ew0HgaPqA/0vrFloslcXNl5HH4QabbYC/4zVukluEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519648; c=relaxed/simple;
	bh=zRWowIqei5BLjZgzSWJOXGb8chmox8VOxR0I13OMjY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPx/jW/WwWB2g+vGj58V0wxXGZWbx9i+cuBbrVsUZsaCMiKSziWXCCtzvd65zpmMwi+nfD3BTqjSFVHI1OcaleAfR9Rl+trGQyu2aVwx7N0UK568DYLz1t749PIBPXm/kTqLKbgMFfjDm/Hkez99TX65TETdDObcXYDBhQD8Fd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u93A6cgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1238CC4CEE3;
	Thu,  3 Jul 2025 05:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751519648;
	bh=zRWowIqei5BLjZgzSWJOXGb8chmox8VOxR0I13OMjY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u93A6cgccaCDW6MMPq3lRg+rCO65tijHzbHwXWi12SyVsgw+sZqYPsAVIuNe60/7U
	 cVDWITRD/nwbjaYo9A/zf5PlaJKoJjc8tJSkXLXOY+2Rd42nyPLUutLzQYSrPhNdRx
	 bLiuPbrccNzXJoTgMCR/3dky2v9FVXK1UFToLvIc=
Date: Thu, 3 Jul 2025 07:14:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: Stable <stable@vger.kernel.org>, Long Li <longli@microsoft.com>
Subject: Re: [EXTERNAL] Re: Please cherry-pick this commit to v5.15.y, 5.10.y
 and 5.4.y: 23e118a48acf ("PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce
 VM boot time")
Message-ID: <2025070345-viral-never-921c@gregkh>
References: <BL1PR21MB31155E1FE608F61CFC279B2DBF7BA@BL1PR21MB3115.namprd21.prod.outlook.com>
 <2025070245-monogamy-taekwondo-3c95@gregkh>
 <BL1PR21MB311511454704263AF04C53B8BF43A@BL1PR21MB3115.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR21MB311511454704263AF04C53B8BF43A@BL1PR21MB3115.namprd21.prod.outlook.com>

On Thu, Jul 03, 2025 at 01:15:47AM +0000, Dexuan Cui wrote:
> 
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Wednesday, July 2, 2025 1:08 AM
> > To: Dexuan Cui <decui@microsoft.com>
> > Cc: Stable <stable@vger.kernel.org>; Long Li <longli@microsoft.com>
> > Subject: [EXTERNAL] Re: Please cherry-pick this commit to v5.15.y, 5.10.y and
> > 5.4.y: 23e118a48acf ("PCI: hv: Do not set PCI_COMMAND_MEMORY to
> > reduce VM boot time")
> > 
> > On Wed, Jun 25, 2025 at 06:05:26AM +0000, Dexuan Cui wrote:
> > > Hi,
> > > The commit has been in v6.1.y for 3+ years (but not in the 5.x stable
> > > branches):
> > >         23e118a48acf ("PCI: hv: Do not set PCI_COMMAND_MEMORY to
> > > reduce VM boot time")
> > >
> > > The commit can be cherry-picked cleanly to the latest 5.x stable branches,
> > > i.e. 5.15.185, 5.10.238 and 5.4.294.
> > 
> > It adds a new build warning on 5.4.y, so I will not apply it there,
> > sorry.  Will go apply it to 5.10.y and 5.15.y for now.
> 
> Out of curiosity, I built 5.4.y plus the commit and got this warning:
> 
> drivers/pci/controller//pci-hyperv.c: In function 'prepopulate_bars':
> drivers/pci/controller//pci-hyperv.c:1731:13: warning: unused variable 'command' [-Wunused-variable]
> 
> I think 5.4.y lacks another commit made in 2019:
> ac82fc832708 ("PCI: hv: Add hibernation support")
> but definitely we don't want to pull this commit into 5.4.y.
> 
> > thanks,
> > 
> > greg k-h
> 
> I guess this requested commit doesn't really need to go into 5.4.y,
> which I suppose isn't used widely any more. I listed it just for
> completeness :-)

If you really want it in 5.4.y, please provide a version that doesn't
add the warning :)


