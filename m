Return-Path: <stable+bounces-76154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4039796CC
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 15:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EDF1F2179F
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3BC1C68A5;
	Sun, 15 Sep 2024 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ulfe+ng1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98E125DB;
	Sun, 15 Sep 2024 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726406629; cv=none; b=hOiN8n4YjcDGVI/02KL5R1ejS0GJkp+ej5VD1Rsa0KOTHRpwI3TqF/y17X/Ros5tlkxpkaXGHOy/Qw/SBCbbcBFF+Px1sbqxdHElm4c6lAQIT5dsUHqHGR5mkmQkEqVQq9Pi18afwYzCxwZfQomarnQEObg0ats56gW2S36VJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726406629; c=relaxed/simple;
	bh=errKGCtfl+LxTRb3ZVsaTPvbepT+cXQro3oA5WbinyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d89gmQTp88xI2mkK5gUjMjvstg2DBRf1ZR5SbkHlskHYOvzSzEPbdM9X1wDzv28H5RTTvEobSsZRCZ1HwklO8LjtG1WZJhMRn7vRRmyBqr1zECPnGJgb5e8kF3fLj2CeixN1QWYGb1UeIMyTQyXKT4Nygw3AvoR8aCVJqPALFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ulfe+ng1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54185C4CEC3;
	Sun, 15 Sep 2024 13:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726406629;
	bh=errKGCtfl+LxTRb3ZVsaTPvbepT+cXQro3oA5WbinyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ulfe+ng10PVo28zS1mPF+MCYhNocOIbmpT5ZL5/HqEeGF92dOVsr7itz4iz3OPfkc
	 AmKkpalgXM27a+EwtSeu38FUfrI7+IuvB7mvkoUXhZYFe+v2l8OXNAZqCtQqgNyjYw
	 r205TCEAVT+Fo6eWSSSVfCJS/eiy/bOKPjzLs1IA=
Date: Sun, 15 Sep 2024 15:23:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	krzysztof.kozlowski@linaro.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH stable-6.10 regression] Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
Message-ID: <2024091555-untitled-bunkbed-8151@gregkh>
References: <20240910124009.10183-1-peter.ujfalusi@linux.intel.com>
 <febaa630-7bf4-4bb8-8bcf-a185f1b2ed65@linux.intel.com>
 <2024091130-detail-remix-34f7@gregkh>
 <ZuQnPnRsXaUEBv6X@vaman>
 <ZuXgzRSPx7hN6ASO@vaman>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuXgzRSPx7hN6ASO@vaman>

On Sun, Sep 15, 2024 at 12:45:25AM +0530, Vinod Koul wrote:
> On 13-09-24, 17:21, Vinod Koul wrote:
> > On 11-09-24, 14:31, Greg KH wrote:
> > > On Tue, Sep 10, 2024 at 04:02:29PM +0300, Péter Ujfalusi wrote:
> > > > Hi,
> > > > 
> > > > On 10/09/2024 15:40, Peter Ujfalusi wrote:
> > > > > The prop->src_dpn_prop and prop.sink_dpn_prop is allocated for the _number_
> > > > > of ports and it is forced as 0 index based.
> > > > > 
> > > > > The original code was correct while the change to walk the bits and use
> > > > > their position as index into the arrays is not correct.
> > > > > 
> > > > > For exmple we can have the prop.source_ports=0x2, which means we have one
> > > > > port, but the prop.src_dpn_prop[1] is accessing outside of the allocated
> > > > > memory.
> > > > > 
> > > > > This reverts commit 6fa78e9c41471fe43052cd6feba6eae1b0277ae3.
> > > > 
> > > > I just noticed that Krzysztof already sent the revert patch but it is
> > > > not picked up for stable-6.10.y
> > > > 
> > > > https://lore.kernel.org/lkml/20240909164746.136629-1-krzysztof.kozlowski@linaro.org/
> > > 
> > > Is this in Linus's tree yet?  That's what we are waiting for.
> > 
> > Yes I was waiting for that as well, the pull request has been sent to
> > Linus, this should be in his tree, hopefully tomorow..
> 
> It is in Linus's tree now. Greg would you like to drop commit
> 6fa78e9c41471fe43052cd6feba6eae1b0277ae3 or carry it and the
> revert...?

I can not "drop" a commit that is already in a realease for obvious
reasons :(

> What is the usual process for you to handle reverts?

We just take them like normal.  What is the git id of the revert in
Linus's tree?

thanks,

greg k-h

