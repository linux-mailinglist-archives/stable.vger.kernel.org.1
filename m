Return-Path: <stable+bounces-109613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF8A17EA6
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 14:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3A23A2615
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 13:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B771101EE;
	Tue, 21 Jan 2025 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M1/vz1yn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0A0196
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465371; cv=none; b=SsoWDCrPOKNTfE94fNrvYm1kB8HNnIDKJ1cV+WcGgEvjQkr5HalqmTP0cWJx+gmo2IPF+cf+LCer1NoTjVsBNytn3tNpf5+NyYlsZsppRDi6+92NxWyHVHMqIIFuLi7Hb0Ppd0y6PVFE8fV8t2O8x9jvwgUrY9CM9xRC5MdFh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465371; c=relaxed/simple;
	bh=+F/CgEE463HQs4bwJEGqzNphwP5lFS6tytSN30tJonI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=istr4C+4+PfNf6/bbB9SguwLrfzgmsMMoJNbX1ojeJUKR9jdZmNQ5eZIqflal+4Q09XQ0aawcejnM4BJS13VEszvoq9k7KlJ0SA0+rmUme2a+4WWyY29AG5cBd6VBTA5C3mnJVs2os/owAlTpTyO433FwCHepN9FQUDyTvktlu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M1/vz1yn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B126C4CEDF;
	Tue, 21 Jan 2025 13:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737465370;
	bh=+F/CgEE463HQs4bwJEGqzNphwP5lFS6tytSN30tJonI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1/vz1yn3KiKHq2b6RqKKKRh6axc9MyFZxHi5+VNseMTZ6BhJG0GO11uJYFLUCCUV
	 7y4bxccaWEmv17lwjQhrU8L7TDjJuUq5sStDQMtO1m0L8Lz58QzVtTV/GZv1f4Xdz9
	 YgXJTn/DWIUF4Fq57EKiK08qF1wTOi0I5kwTBlgg=
Date: Tue, 21 Jan 2025 14:16:08 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: Reverts for 6.6, 6.1, 5.15
Message-ID: <2025012102-enactment-violate-1cbf@gregkh>
References: <BL1PR12MB5144D5363FCE6F2FD3502534F7E72@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5144D5363FCE6F2FD3502534F7E72@BL1PR12MB5144.namprd12.prod.outlook.com>

On Mon, Jan 20, 2025 at 04:14:56PM +0000, Deucher, Alexander wrote:
> [Public]
> 
> Hi Greg, Sasha,
> 
> The original patch 73dae652dcac (drm/amdgpu: rework resume handling for display (v2)), was only targeted at kernels 6.11 and newer.  It did not apply cleanly to 6.12 so I backported it and it backport landed as 99a02eab8251 ("drm/amdgpu: rework resume handling for display (v2)"), however there was a bug in the backport that was subsequently fixed in 063d380ca28e ("drm/amdgpu: fix backport of commit 73dae652dcac").  None of this was intended for kernels older than 6.11, however the original backport eventually landed in 6.6, 6.1, and 5.15.  Please revert the change from kernels 6.6, 6.1, and 5.15.
> 
> 6.6.y:
> Please revert 2daba7d857e4 ("drm/amdgpu: rework resume handling for display (v2)").
> 
> 6.1.y:
> Please revert c807ab3a861f ("drm/amdgpu: rework resume handling for display (v2)").
> 
> 5.15.y:
> Please revert d897650c5897 ("drm/amdgpu: rework resume handling for display (v2)").

All now reverted, thanks.

greg k-h

