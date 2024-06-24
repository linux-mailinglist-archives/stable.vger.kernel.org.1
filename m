Return-Path: <stable+bounces-55023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91701915107
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467421F25DBB
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 14:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FFE19B5A0;
	Mon, 24 Jun 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QrA/xD0z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87274148849;
	Mon, 24 Jun 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240587; cv=none; b=Kvqf4CQ1J9D8D6m6//fFm3yYpJcKebrxqUfHlCifr67T9W48TKJ1t2PAwXhfp9gD+lwkBOctHic1dGNgDMRgb4UDblbpUh46eP0OXhJxWFZGVXUx0DkwoIb+CKlHY7wAE6hG5o49Ibe7y1gGY9IWfCNVQebIk+aKzOCQ14nJf68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240587; c=relaxed/simple;
	bh=Iw2dfeccChJL2VRQAEeXMFSg5sHAFNGJ3xH5VJs5vwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNFmINnQPvyfYO2GcJsFh+wVM4BkpnvrFiVYN28nJn6MNnhHyezQYo5W2Efv5aT9lyurJ3n6rZcK3koDrzS2gMB3/S5xLt857FFoImcEJhIXIZhglr0VuuJYwlJAl9y15IjHuVQffx4Bw8OKLHVxBXAtTzxtDGcm7eocMSGwAZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QrA/xD0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B99C2BBFC;
	Mon, 24 Jun 2024 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719240587;
	bh=Iw2dfeccChJL2VRQAEeXMFSg5sHAFNGJ3xH5VJs5vwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrA/xD0zVXFl16Z/zgwTYhIKhnPeM8dtxPMOU14Mf6ZOe4udcqFLqLZRWl7mDWhTa
	 zVCEzp63MR9Ioe1hPqytI9Qu02sUM9bceY99Vp1tGTBKiNYvEvALeGEYn76jB4ru4q
	 JncTzJMPj9mXcxJtwd6ruFvSyD72s2ncSkx3b9nk=
Date: Mon, 24 Jun 2024 16:49:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	brent.lu@intel.com, Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: Patch "ASoC: Intel: sof_cs42l42: rename BT offload quirk" has
 been added to the 6.9-stable tree
Message-ID: <2024062434-footing-enjoyment-0c4b@gregkh>
References: <20240621154202.4147700-1-sashal@kernel.org>
 <c26034e7-194c-4b9c-9f2d-d25f7ca987ca@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26034e7-194c-4b9c-9f2d-d25f7ca987ca@sirena.org.uk>

On Fri, Jun 21, 2024 at 04:49:16PM +0100, Mark Brown wrote:
> On Fri, Jun 21, 2024 at 11:42:01AM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     ASoC: Intel: sof_cs42l42: rename BT offload quirk
> 
> This is not obvious stable material.
> 
> >     
> >     Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> >     Signed-off-by: Brent Lu <brent.lu@intel.com>
> >     Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >     Link: https://msgid.link/r/20240325221059.206042-7-pierre-louis.bossart@linux.intel.com
> >     Signed-off-by: Mark Brown <broonie@kernel.org>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> I'm also not seeing any stable-dep-of r anything in here.


Now deleted, thanks.


