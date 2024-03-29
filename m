Return-Path: <stable+bounces-33130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D6D89160D
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 10:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDCE1F22D50
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800AD48792;
	Fri, 29 Mar 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Cbcd9DP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD647F47;
	Fri, 29 Mar 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704632; cv=none; b=fxsG0VX/boxtxby2ABvjOEyfLacCgzqzdF9g7BKv1im+FQWuIZBgd4M0OePwqQ2Qg/951aCNsMOnr7tk3SOTGg3tVfRue3UjaaW3I8zPho4Jt5nhQQhQCu6jaCihuzceJnGq8egcc5mzIlWq77KSSBJBkD6EnRoy0UQF7Kt2Qi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704632; c=relaxed/simple;
	bh=5aAN4jOiEFoIaZBQwLAA8Fc6rgsjCmq/3EA8ps1cDz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQlZ1g0FmAz94xOD/hk9X/snH7SkscUB7w3JiPWbFDUHFXRXswdKUZhXuhzb8/wIpsjOv4CShPxYLKmFB2hnkQnU6AueSD0eQ2UoQEC/nMsW+WlP+bRQhzj1WQm+24JiIEVKVGtYTTow7slrYPHW68Bl0QYyhla08OOmI0U+pPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Cbcd9DP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1A6C433F1;
	Fri, 29 Mar 2024 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711704630;
	bh=5aAN4jOiEFoIaZBQwLAA8Fc6rgsjCmq/3EA8ps1cDz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2Cbcd9DPUqJyporETyS5OQercffaPHnV4sZXr8TfC+3B1ajwJI8Lz1Twv/6N7SJxG
	 xK4soTG6+pHsLSik5hJabgwXxuBshwLUlk8b6D4ye7bLT62tLZgGeTh+2A53UCUKTO
	 8O8EhYWNU2Bqi2fzq79KTlR9QvuHgwvXo0VavmTM=
Date: Fri, 29 Mar 2024 10:30:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Sasha Levin <sashal@kernel.org>, Jiawei Wang <me@jwang.link>,
	Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] Revert "ASoC: amd: yc: add new YC platform variant
 (0x63) support"
Message-ID: <2024032911-elephant-shy-0284@gregkh>
References: <20240312023326.224504-1-me@jwang.link>
 <bc0c1a15-ba31-44ba-85be-273147472240@gmail.com>
 <2024032722-transpose-unable-65d0@gregkh>
 <465c52a1-2f61-4585-9622-80b8a30c715a@amd.com>
 <2024032853-drainage-deflator-5bae@gregkh>
 <8e5127ff-0ffa-495a-bd6a-ca452375f5f6@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e5127ff-0ffa-495a-bd6a-ca452375f5f6@amd.com>

On Thu, Mar 28, 2024 at 05:27:58PM +0530, Mukunda,Vijendar wrote:
> On 28/03/24 17:04, Greg KH wrote:
> > On Thu, Mar 28, 2024 at 04:10:38PM +0530, Mukunda,Vijendar wrote:
> >> On 27/03/24 23:39, Greg KH wrote:
> >>> On Wed, Mar 27, 2024 at 06:56:18PM +0100, Luca Stefani wrote:
> >>>> Hello everyone,
> >>>>
> >>>> Can those changes be pulled in stable? They're currently breaking mic input
> >>>> on my 21K9CTO1WW, ThinkPad P16s Gen 2, and probably more devices in the
> >>>> wild.
> >>> <formletter>
> >>>
> >>> This is not the correct way to submit patches for inclusion in the
> >>> stable kernel tree.  Please read:
> >>>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> >>> for how to do this properly.
> >>>
> >>> </formletter>
> >> These patches already got merged in V6.9-rc1 release.
> >> Need to be cherry-picked for stable release.
> >>
> > What changes exactly?  I do not see any git ids here.
> >
> > confused,
> >
> > greg k-h
> 
> Below are the commits.
> 
> 37bee1855d0e ASoC: amd: yc: Revert "add new YC platform variant (0x63) support"
> 861b3415e4de ASoC: amd: yc: Revert "Fix non-functional mic on Lenovo 21J2"
> 
> 
> 

Already asked for here:
	https://lore.kernel.org/r/1b8a991b-ad82-44e6-a76d-a2f81880d549@gmail.com

