Return-Path: <stable+bounces-100033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654039E7E8C
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 07:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCE22840E9
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 06:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7B913213E;
	Sat,  7 Dec 2024 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NTgAiYUu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD6126C02
	for <stable@vger.kernel.org>; Sat,  7 Dec 2024 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733553003; cv=none; b=JTh6hZi2H5tlfMxbOplrKLJXzZCYm8eCydxCoQ+YPPgi6lEO3fFbRicbNhvtgQKY/Se115O6MP0Zaqn98ZN5ceaUq9A1snyQ/51JzkHkS2uRRaiVs9fKHyh0HIQgxc+Cl7OYe98/g+xeAeBx6lLmfvSjTG4502v/FpGPO9G4zrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733553003; c=relaxed/simple;
	bh=mDg68pyG5KyMdtyfmdNj+L1j5lptgdp+Q3W4wlqooaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/OQLAk9Df5qO76Nk4R6yJg2WJxiK5qG7S4Me76vzak8oXV24/52cL+eyc3XKZraN5S8XhwsVTQ/+T61UvEYEGpBy7UpetUW9CW/L0FpryMnKH9Nu04JVCROxU3WhkLfTDxNGO1tguXR8yKt0N1JUBaRS/v3x6K/7rBEI37C68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NTgAiYUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB16C4CECD;
	Sat,  7 Dec 2024 06:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733553003;
	bh=mDg68pyG5KyMdtyfmdNj+L1j5lptgdp+Q3W4wlqooaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTgAiYUurkbUxIqtGOwwH9B6cv7Y4YexFdrKM/ul0UVLBIhBfwqtMo556xcjUQvxa
	 ufgR3vlNLGOi2tuPvAkEYewSDhFuZQgvNhYMmaKYp9NvIkC15TRFuVHBvsirOWMz00
	 CMS6B05zt7A759nVwKpFb7N17qajhuQ3L+Enociw=
Date: Sat, 7 Dec 2024 07:29:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"sashal@kernel.org" <sashal@kernel.org>,
	"Zuo, Jerry" <Jerry.Zuo@amd.com>,
	"Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
	"Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
	"Wheeler, Daniel" <Daniel.Wheeler@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Skip Invalid Streams from DSC Policy
Message-ID: <2024120738-colossal-acutely-c465@gregkh>
References: <20241202172833.985253-1-alexander.deucher@amd.com>
 <2024120301-starring-pruning-efe3@gregkh>
 <2024120610-depose-hatching-821c@gregkh>
 <BL1PR12MB5144F95DBC0D3EEE437F568BF7312@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5144F95DBC0D3EEE437F568BF7312@BL1PR12MB5144.namprd12.prod.outlook.com>

On Fri, Dec 06, 2024 at 04:17:58PM +0000, Deucher, Alexander wrote:
> [Public]
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, December 6, 2024 8:13 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: stable@vger.kernel.org; sashal@kernel.org; Zuo, Jerry
> > <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Siqueira,
> > Rodrigo <Rodrigo.Siqueira@amd.com>; Wheeler, Daniel
> > <Daniel.Wheeler@amd.com>
> > Subject: Re: [PATCH 1/2] drm/amd/display: Skip Invalid Streams from DSC Policy
> >
> > On Tue, Dec 03, 2024 at 08:11:14AM +0100, Greg KH wrote:
> > > On Mon, Dec 02, 2024 at 12:28:32PM -0500, Alex Deucher wrote:
> > > > From: Fangzhi Zuo <Jerry.Zuo@amd.com>
> > > >
> > > > Streams with invalid new connector state should be elimiated from
> > > > dsc policy.
> > > >
> > > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3405
> > > > Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > > > Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> > > > Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> > > > Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com> (cherry
> > > > picked from commit 9afeda04964281e9f708b92c2a9c4f8a1387b46e)
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 13
> > > > ++++++++++++-
> > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > What kernel tree(s) is this series for?
> >
> > Dropping from my queue due to lack of response :(
> >
> > Please resend if you need this, with a hint of what we are supposed to be applying it
> > to.
> 
> Sorry I just saw this now.  This landed in 6.13, but it was determined that it needed to go to stable.  Ideally at least 6.11 and 6.12.

But it's already in 6.11.11 and 6.12.2 so I guess all is ok :)

