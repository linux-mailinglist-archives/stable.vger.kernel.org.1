Return-Path: <stable+bounces-56334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C4C923996
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 11:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36298285C3F
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2497C15445D;
	Tue,  2 Jul 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lRTvJGdV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08CC14C5BF;
	Tue,  2 Jul 2024 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911718; cv=none; b=Y++qEm9C/LuPcYz8yZcwO7f6x1O1HiS2qzZp+teerVvvx4ImhSIKrIs6YetG/0fOKuBGySTnQ62lz7y04/SJpksYa4Wa2I/+ek2UAMt1TYr5a7kJZh0HvAciG2mWiW8jgA40TOPgnZ38S/Z05v8LOPivuK8rVOqXtDMcEBUXLkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911718; c=relaxed/simple;
	bh=Lq3sO/Wy+R/QvnuciHAaMqkpIYbriM1cPWTRpf8kyzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXVAoaBZ0KWdKzP56XUYBthsVqTssgD5S5Q+MA+JwakoqfF1f3MAF2CEpdzMV78x65MdpJONynBBTRgX7gqb4LTvJ+3Xvoty0c1IOx+mW6ifPvb8k/Z3VqUWyHEAq2kwhLpgDK96An/RNY7Y1D6XumDj9g/bVOQMwvArspjIp3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lRTvJGdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4826CC4E698;
	Tue,  2 Jul 2024 09:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719911717;
	bh=Lq3sO/Wy+R/QvnuciHAaMqkpIYbriM1cPWTRpf8kyzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRTvJGdVEvrWNn1b0W+9l6ivWjxtKxTcL2mzcAYzU6RM/VgVnZWQ7DrjIxqy8jRBJ
	 qY0A3afGjvf6FoIq3Qo5kDxwiw2AAzhFygbxa//+4ynGjAlVYhgFOC4xfh0mcOvzAu
	 K7P5N/uT4lynSKOERLdIpOQbGtxCGCgRiBY1vx5k=
Date: Tue, 2 Jul 2024 11:15:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Lars Wendler <wendler.lars@web.de>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	"Huang, Ray" <Ray.Huang@amd.com>,
	"Yuan, Perry" <Perry.Yuan@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: linux-6.6.y: Regression in amd-pstate cpufreq driver since 6.6.34
Message-ID: <2024070251-victory-evacuate-1b56@gregkh>
References: <20240701112944.14de816f@chagall.paradoxon.rec>
 <SJ2PR12MB8690E3E2477CA9F558849835ECD32@SJ2PR12MB8690.namprd12.prod.outlook.com>
 <7f1aaa11-2c08-4f33-b531-331e50bd578e@amd.com>
 <20240701174539.4d479d56@chagall.paradoxon.rec>
 <fd892ad7-7bf9-4135-ba59-6b70e593df4e@amd.com>
 <20240701181349.5e8e76b8@chagall.paradoxon.rec>
 <18882bfe-4ca5-495c-ace5-b9bcab796ae5@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18882bfe-4ca5-495c-ace5-b9bcab796ae5@amd.com>

On Mon, Jul 01, 2024 at 04:53:20PM -0500, Mario Limonciello wrote:
> On 7/1/2024 11:13, Lars Wendler wrote:
> > Hello Mario,
> > 
> > Am Mon, 1 Jul 2024 10:58:17 -0500
> > schrieb Mario Limonciello <mario.limonciello@amd.com>:
> > 
> > > > I've tested both, 6.9.7 and 6.10-rc6 and they both don't have that
> > > > issue. I can disable CPU boost with both kernel versions.
> > > 
> > > Thanks for checking those.  That's good to hear it's only an issue in
> > > the LTS series.
> > > 
> > > It means we have the option to either drop that patch from LTS kernel
> > > series or identify the other commit(s) that helped it.
> > > 
> > > Can you see if adding this commit to 6.6.y helps you?
> > > 
> > > https://git.kernel.org/superm1/c/8164f743326404fbe00a721a12efd86b2a8d74d2
> > 
> > that commit does not fix the regression.
> > 
> 
> I think I might have found the issue.
> 
> With that commit backported on 6.6.y in amd_pstate_set_boost() the policy
> max frequency is nominal  *1000 [1].
> 
> However amd_get_nominal_freq() already returns nominal *1000 [2].
> 
> If you compare on 6.9 get_nominal_freq() doesn't return * 1000 [3].
> 
> So the patch only makes sense on 6.9 and later.
> 
> We should revert it in 6.6.y.
> 
> 
> 
> Greg,
> 
> 
> Can you please revert 8f893e52b9e0 ("cpufreq: amd-pstate: Fix the
> inconsistency in max frequency units") in 6.6.y?

Sure, but why only 6.6.y?  What about 6.1.y, should it be reverted from
there as well?

thanks,

greg k-h

