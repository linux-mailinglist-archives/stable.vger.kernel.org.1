Return-Path: <stable+bounces-208440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C589DD244E2
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 12:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC423301B8A8
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 11:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6073876CB;
	Thu, 15 Jan 2026 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NriN95Jl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD938735A;
	Thu, 15 Jan 2026 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477447; cv=none; b=Ho3Zi8tNhXGzv1R7skiDmvthFjWHP+VnFfJh2zS/4lV3nU/EZAl786jVUbb4c+7wKw1IslsfYUR8UE1hZKpKv+2cjL18MR6xt2ng0v8pEOUCJA79LEQPpZS5+cY6CpFmGJ21Vrknf5D4F8/EmLHgwy2l1VHkkgVHDdsL1SdRI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477447; c=relaxed/simple;
	bh=Sg9yjAKca5xeJX+l5IxzWwh8gr5ENluZ0vFtAY3xM4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1DogdJsZ/hXEBH6bAc7ggeQpGhfrn2g1C15yLITPt+sZ1KYQyp9hnznLw1I11qvxm0V5dH9W/1SJIDfJLASTkkIC00My5MTrGEefAE+3wuDAOnykGyHnhCcrr+to6LKt5LN9u2GbfmAcq96KrDd3H1iIM4AGRB2zmplcMe9jWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NriN95Jl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7D5C116D0;
	Thu, 15 Jan 2026 11:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768477446;
	bh=Sg9yjAKca5xeJX+l5IxzWwh8gr5ENluZ0vFtAY3xM4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NriN95Jl93QBNW3qXlWQvzSUfODyzGex7iM4pozMVguXTNeoEwoNQS8Byeof6uGVz
	 aKL2LPpQlVd1w8JzFLGzyKLcNbPu1bpgHpmqSZkA2qwz+poOg/9B2NzgAXQhunTx3S
	 U42JPt9k6UdFjdamRReAqHPoZrgAomahCeZn3mZ0=
Date: Thu, 15 Jan 2026 12:44:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rahul Sharma <black.hawk@163.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Hung <alex.hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: Re: [PATCH v6.1] drm/amd/display: Check dce_hwseq before
 dereferencing it
Message-ID: <2026011525-occupier-hangout-ac24@gregkh>
References: <20260115041919.825845-1-black.hawk@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115041919.825845-1-black.hawk@163.com>

On Thu, Jan 15, 2026 at 12:19:19PM +0800, Rahul Sharma wrote:
> From: Alex Hung <alex.hung@amd.com>
> 
> [ Upstream b669507b637eb6b1aaecf347f193efccc65d756e commit ]
> 
> [WHAT]
> 
> hws was checked for null earlier in dce110_blank_stream, indicating hws
> can be null, and should be checked whenever it is used.
> 
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 79db43611ff61280b6de58ce1305e0b2ecf675ad)
> Cc: stable@vger.kernel.org
> [ The context change is due to the commit 8e7b3f5435b3
> ("drm/amd/display: Add control flag to dc_stream_state to skip eDP BL off/link off")
> and the commit a8728dbb4ba2 ("drm/amd/display: Refactor edp power
> control") and the proper adoption is done. ]
> Signed-off-by: Rahul Sharma <black.hawk@163.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

We need 6.6.y backport first, before we can take this one, for obvious
reasons (i.e. you do not want to have a regression).  Can you submit
that one first and then this again?

thanks,

greg k-h

