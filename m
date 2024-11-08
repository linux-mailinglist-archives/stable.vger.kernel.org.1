Return-Path: <stable+bounces-91906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA259C185E
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 09:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1011A286162
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 08:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3301E0092;
	Fri,  8 Nov 2024 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h6zJ/Xvu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9BB1DEFEA;
	Fri,  8 Nov 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055764; cv=none; b=PMDQkA/SGjERvNyvLbTPfz7DMrAgOGtnOQ2CV0vW5Q5/0BCS1Li6P9q7upP4It3clcmU8oEleDA/ntr6h0LibFOYJZXDvrKJMCEgsCH7nXxSuTIhvcuaFYQQX7KVC6nRCKstRPdL+68Lt5XoBMVsshG1lSy7pKhfQGyzScwnCis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055764; c=relaxed/simple;
	bh=l9sY1OHDO8wFIDCdzrR2/15Yw7PfigB1KCl3QZf41FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ackmctKreuB32kSBwKiUUXKnYVxIgSxNbubWlD/cXz6RIK6F9m4CmlofBpn+ZiTHjzkepfFEjOk2LzfPOz/2HoR3lF+Xy087ExnNuRfYtcAHey4NYvPaL95BDdGc9UXtQrjKhCwZ2b3G9nq2IULSJhnxcLpNHsrFRYz6ynRbLAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h6zJ/Xvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B732C4CECD;
	Fri,  8 Nov 2024 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731055763;
	bh=l9sY1OHDO8wFIDCdzrR2/15Yw7PfigB1KCl3QZf41FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6zJ/XvuS7XXzK1Ct5OUSBE+f1pvTtZzKmi7E9ki5m3c0wZAT7xt5nOmJzLFRMGNY
	 Ld60VNZ7EaU6PNpU114MBwrJ7l5r3qTSh/g9uSENTzgWcRQMo2pXbdyqaP1hbYcSxV
	 lhRQqCJ8QApvyOAZUtineIyvF2vB32SnxBsUb//A=
Date: Fri, 8 Nov 2024 09:49:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>, Wayne Lin <wayne.lin@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jonathan Gray <jsg@jsg.id.au>
Subject: Re: [PATCH 0/1] On DRM -> stable process
Message-ID: <2024110803-undermine-viewable-2605@gregkh>
References: <20241029133141.45335-1-pchelkin@ispras.ru>
 <ZyDvOdEuxYh7jK5l@sashalap>
 <20241029-3ca95c1f41e96c39faf2e49a-pchelkin@ispras.ru>
 <20241104-61da90a19c561bb5ed63141b-pchelkin@ispras.ru>
 <2024110521-mummify-unloved-4f5d@gregkh>
 <20241108-267fb65587d32642092cea40-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108-267fb65587d32642092cea40-pchelkin@ispras.ru>

On Fri, Nov 08, 2024 at 11:41:18AM +0300, Fedor Pchelkin wrote:
> On Tue, 05. Nov 07:57, Greg Kroah-Hartman wrote:
> > On Mon, Nov 04, 2024 at 05:55:28PM +0300, Fedor Pchelkin wrote:
> > > It is just strange that the (exact same) change made by the commits is
> > > duplicated by backporting tools. As it is not the first case where DRM
> > > patches are involved per Greg's statement [1], I wonder if something can be
> > > done on stable-team's side to avoid such odd behavior in future.
> > 
> > No, all of this mess needs to be fixed up on the drm developer's side,
> > they are the ones doing this type of crazy "let's commit the same patch
> > to multiple branches and then reference a commit that will show up at an
> > unknown time in the future and hope for the best!" workflow.
> > 
> > I'm amazed it works at all, they get to keep fixing up this mess as this
> > is entirely self-inflicted.
> 
> Thanks for reply, I get your remark. DRM people are mostly CC'ed here,
> hopefully it won't be that difficult to tune their established workflow to
> make the stable process easier and more straightforward.
> 
> As of now, would you mind to take the revert for 6.1? It's [PATCH 1/1] in
> this thread. No point to keep it there, and the duplicated commits were
> already reverted from the fresher stable kernels.
> 

I don't see it in my review queue anymore, can you please resend it?

thanks,

greg k-h

