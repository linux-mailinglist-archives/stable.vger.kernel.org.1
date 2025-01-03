Return-Path: <stable+bounces-106696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B597A00AB9
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 15:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED48D3A43F6
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 14:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7413F1FA24E;
	Fri,  3 Jan 2025 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iw5fs5xS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C101FA170
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915254; cv=none; b=bo9MwgKnPop94IVNpvC6W5zUy7o0gTSC7FhTcPuaHXLHa46ba0jIDJ1JBLJjcZXTd/xHnDC4Laj5I3wgF+5Pd5R3wZcIIKhDEuZLu0E7yB+g6VcNzsjGXbTl4Vrgqv2TMcSCiwutFPWxjhU3fGiEDiBRmz0dZM9gYspU3lsBAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915254; c=relaxed/simple;
	bh=nyhNWla+74IjM7AdBU5oXcvPssKRNy74fqjYxYI30D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3s0q8AJh8TvpXROYfMqhhkV5h4PUebzJT+TyxJ7cM+Q6FX4FsuLsVlm+mzAaIrwaVRb1w1cGwV6bW41TYi2RTiMPMn2ioih4YlrJm7tRQE0DHdFsbdcsGBuBRqNLB0redN1xZ0mZbXcXsYXsP9DPedws9uOgd/DHJ0N6mcBdQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iw5fs5xS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEFAC4CECE;
	Fri,  3 Jan 2025 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735915253;
	bh=nyhNWla+74IjM7AdBU5oXcvPssKRNy74fqjYxYI30D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iw5fs5xShYeqt4f1ig8qaLpcwmS3hwefkDB3ENyfG97h2+K3YNiKY+fEWNpcPWvDp
	 Vng63lkUHirSyyhHFygtWNsD2kC6oOIl5F/5tHYr4LHTz3Se5JLTHLPYfq+aL0ytv9
	 Z8KGdenKv4hZsqqYSNGVhxciWKhyt4wPVbNbW4AY=
Date: Fri, 3 Jan 2025 15:40:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"sashal@kernel.org" <sashal@kernel.org>
Subject: Re: [PATCH] drm/amdgpu: fix backport of commit 73dae652dcac
Message-ID: <2025010334-deniable-hurled-4f0c@gregkh>
References: <20241227073700.3102801-1-alexander.deucher@amd.com>
 <2024122742-chili-unvarying-2e32@gregkh>
 <BL1PR12MB5144159BC2B99D673908BB88F7142@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5144159BC2B99D673908BB88F7142@BL1PR12MB5144.namprd12.prod.outlook.com>

On Thu, Jan 02, 2025 at 06:08:38PM +0000, Deucher, Alexander wrote:
> [Public]
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, December 27, 2024 2:50 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: stable@vger.kernel.org; sashal@kernel.org
> > Subject: Re: [PATCH] drm/amdgpu: fix backport of commit 73dae652dcac
> >
> > On Fri, Dec 27, 2024 at 02:37:00AM -0500, Alex Deucher wrote:
> > > Commit 73dae652dcac ("drm/amdgpu: rework resume handling for display
> > > (v2)") missed a small code change when it was backported resulting in
> > > an automatic backlight control breakage.  Fix the backport.
> > >
> > > Note that this patch is not in Linus' tree as it is not required
> > > there; the bug was introduced in the backport.
> > >
> > > Fixes: 99a02eab8251 ("drm/amdgpu: rework resume handling for display
> > > (v2)")
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3853
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: stable@vger.kernel.org # 6.11.x
> >
> > So the 6.12.y backport is ok?  What exact trees is this fix for?
> 
> Everything older than 6.13 needs this fix.  The code changed between 6.12 and 6.13 which required a backport of the patch for 6.12 and older kernels.  All kernels older than 6.13 need this fix.  The original backported patch targeted 6.11 and newer stable kernels.  6.11 is EOL so probably just 6.12 unless someone pulled the patch back to some older kernel as well.

The commit has been backported to the following kernels:
	5.15.174 6.1.120 6.6.66 6.12.5
so can you also send proper fixes for 5.15.y, 6.1.y and 6.6.y as well?

thanks,

greg k-h

