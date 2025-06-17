Return-Path: <stable+bounces-152855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF2AADCDDE
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35DE37ACBFA
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854632E4253;
	Tue, 17 Jun 2025 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wHOMpdiD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4015F2E3B18;
	Tue, 17 Jun 2025 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167911; cv=none; b=JLSZ166ATz9cK4So5nbHquO2L53U0axGFhGlwRfQblU7D8Sls9T1aKaqYc7nDrpTIZcEBLy3z+Ouio3ohcW2ExQDQXBTpKMoyBMmzVOiU3NP+zjyrt57alcNBdEbzXzhX0VVbnpUrZ8wkhc8X0n5dHYWB9Cyzpzd7dTDzK7OOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167911; c=relaxed/simple;
	bh=u/01orxSXm8L9RA0ECQD66pDHqc2EtBeQ/EmM9xHYoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akTQRbQNirRQToyhQ4qz4yyZsQiw+jTTFBFp39Jw3gKRAewbbtExxNR6lxxSa6hQuhR3D8RmvToZld5uGvF4hHw6PZBlovGkveLAFqCev5fJJ5MsTZ/xtIHq+w4W0anp0bMs0S/0SoNkFiBnme+Ch9HVZLF0uPPbcsS0Oj7i4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wHOMpdiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519FBC4CEEE;
	Tue, 17 Jun 2025 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750167910;
	bh=u/01orxSXm8L9RA0ECQD66pDHqc2EtBeQ/EmM9xHYoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wHOMpdiDHgY3CTbhKIK50BtL1QILlz6Lh1KI5QFdildMt9A8ZFdjD09bnQyJWRySg
	 EatQPWnu+iwN+quPknRdR6opvZySMs/j4iI8ijRYIyYnxiNpjH8NjBlRUOSKF24ZA1
	 FMLUQsBToJs3Aoyh9REjX5GSrd5pEzqCGmFOR4xo=
Date: Tue, 17 Jun 2025 15:45:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: Patch "Drivers: hv: Always select CONFIG_SYSFB for Hyper-V
 guests" has been added to the 6.15-stable tree
Message-ID: <2025061758-reunite-cathedral-0b04@gregkh>
References: <20250610121439.1555063-1-sashal@kernel.org>
 <SN6PR02MB4157B1CBF121FF4BB19631AAD46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157B1CBF121FF4BB19631AAD46AA@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Jun 10, 2025 at 03:50:33PM +0000, Michael Kelley wrote:
> From: Sasha Levin <sashal@kernel.org>
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests
> >
> > to the 6.15-stable tree which can be found at:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
> >
> > The filename of the patch is:
> >      drivers-hv-always-select-config_sysfb-for-hyper-v-gu.patch
> > and it can be found in the queue-6.15 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Please DO NOT backport this patch to ANY stable trees, at least
> not at the moment. It is causing a config problem that we're trying
> to work out. Once the resolution is decided upon, we can figure out
> what to backport.

Now dropped from all queues.

thanks,

greg k-h

