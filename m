Return-Path: <stable+bounces-112129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB957A26F41
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 11:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C581887657
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98386207DF6;
	Tue,  4 Feb 2025 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bitkx4R7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CA413C9D4
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664569; cv=none; b=Qfc8FCu4ecey9i616ORW2d1t56vSVJxvCKVI+NR/NfhV48o8oKkJpA2ZfjkU6nIC7GV1190P0UFVKZfK9UzrbPTX2kBDn/txIK+xYpg/8TzRVDwRzI72AAOfnepaDPfVKQnkZHPC1OtnaF5vlFLR3gxnsmH+bSjGtZxq9svXu2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664569; c=relaxed/simple;
	bh=gJ4o45DrQ6UM53CuzLLDKfz5ptWwJJHOyJCxE7cr04k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIAVaL7y6IzZHESF7Mhb0tbRBeRbbklagAoaObidAJDm/hiWt30j7lM//PChZFWMGysHbiVVfSJ1aOZofrKmDsxffVrMLn0S4M5sItE7qZf9+kMB4Jky+KxfzoXRQMQh3sYntVFRwoQAoEwp36DlHLid9+2q/OySwY3gMGfMHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bitkx4R7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464DEC4CEDF;
	Tue,  4 Feb 2025 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738664568;
	bh=gJ4o45DrQ6UM53CuzLLDKfz5ptWwJJHOyJCxE7cr04k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bitkx4R7lVZNmviJGnsDZFCKj5L/94jH6TLm/07+K92+81RpvqsiNJOcwsBKLA6Tb
	 yMGz+2d5FHngQOgKbA5SE0tJwDYagwqhxAmAvnXe1MZTd6NxkFC6wSARLEMQGiUum5
	 RZG2ykO+e54bO5Vc1YVUSlA72bObnd3gr6T0ACZA=
Date: Tue, 4 Feb 2025 11:22:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wayne Lin <Wayne.Lin@amd.com>
Cc: stable@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: Re: [PATCH 6.12.y] drm/amd/display: Reduce accessing remote DPCD
 overhead
Message-ID: <2025020403-conjoined-murky-f8e5@gregkh>
References: <2025012032-phoenix-crushing-da7a@gregkh>
 <20250204101336.2029586-1-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204101336.2029586-1-Wayne.Lin@amd.com>

On Tue, Feb 04, 2025 at 06:13:36PM +0800, Wayne Lin wrote:
> [Why]
> Observed frame rate get dropped by tool like glxgear. Even though the
> output to monitor is 60Hz, the rendered frame rate drops to 30Hz lower.
> 
> It's due to code path in some cases will trigger
> dm_dp_mst_is_port_support_mode() to read out remote Link status to
> assess the available bandwidth for dsc maniplation. Overhead of keep
> reading remote DPCD is considerable.
> 
> [How]
> Store the remote link BW in mst_local_bw and use end-to-end full_pbn
> as an indicator to decide whether update the remote link bw or not.
> 
> Whenever we need the info to assess the BW, visit the stored one first.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3720
> Fixes: fa57924c76d9 ("drm/amd/display: Refactor function dm_dp_mst_is_port_support_mode()")
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 4a9a918545455a5979c6232fcf61ed3d8f0db3ae)
> Cc: stable@vger.kernel.org
> (cherry picked from commit adb4998f4928a17d91be054218a902ba9f8c1f93)

I'm confused, which commit is this exactly?  Both of these seem to be
the same, and you can't have 2 "cherry picked from" lines in a commit,
right?

thanks,

greg k-h

