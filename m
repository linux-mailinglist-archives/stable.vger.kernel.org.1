Return-Path: <stable+bounces-110281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2105A1A582
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 15:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3B21883085
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1E320F064;
	Thu, 23 Jan 2025 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EJmdgH6D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1238F83;
	Thu, 23 Jan 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737641427; cv=none; b=nfqb4BqE+dgtR6s9kM2BJkhde2KySVZyjoG0sMxxunCdwpFV8Bq34Qj/LqGMVJB0zocmDcLH6rcVeSzjKZvV0PjI2tnFmuEoExEoCF60qozcTL5hFUQoQrX3CELEJjEt9CWErBv3997yLLdeUlJOj9hT+GQbZDLCi7BVXT+z4fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737641427; c=relaxed/simple;
	bh=bNh22GIQvj6gKM/LKOZdH8S/FO8DDQOjXGvCebJl7Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeYWokVpLlzw/PGYYORZfJ4ex0k/4AkidTDdnsruUn/0ofNjHKz3N1kqzp/lpMm8nkuuHfLB6qZ+M5GeVU+XJEIKZepMPNJokb7GD35orKtJXVkSvJr/0HKp4tra0HMcF6YvZVn9M7MJLTPdqwXy2t45mnwBbaDSzwbvxHoVRlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EJmdgH6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C522C4CED3;
	Thu, 23 Jan 2025 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737641426;
	bh=bNh22GIQvj6gKM/LKOZdH8S/FO8DDQOjXGvCebJl7Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJmdgH6DDWzQx5t9RbpIyxH/ZEXKXUQqUhgfNM7SDDLDEhJmLuDb8mZ9hQ2rqjBLX
	 WfyKJ4yAIgstny6yj23gyQ+0ymC6P2Xbt72nmovZhhw7GKk9WEWJt5D+YTgc0QtxbN
	 nfkSqhfLaQsF3Mp3ieSbfqiohG4HKpVkCdiPkCco=
Date: Thu, 23 Jan 2025 15:10:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shubham Pushpkar <spushpka@cisco.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	deeratho@cisco.com, Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: Re: [PATCH] drm/amd/display: Check link_index before accessing
 dc->links[]
Message-ID: <2025012309-chloride-foil-ad73@gregkh>
References: <20250123120822.1983325-1-spushpka@cisco.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123120822.1983325-1-spushpka@cisco.com>

On Thu, Jan 23, 2025 at 04:08:22AM -0800, Shubham Pushpkar wrote:
> From: Alex Hung <alex.hung@amd.com>
> 
> commit 8aa2864044b9d13e95fe224f32e808afbf79ecdf ("drm/amd/display:
> Check link_index before accessing dc->links[]")
> 
> [WHY & HOW]
> dc->links[] has max size of MAX_LINKS and NULL is return when trying to
> access with out-of-bound index.
> 
> This fixes 3 OVERRUN and 1 RESOURCE_LEAK issues reported by Coverity.
> 
> Fixes: CVE-2024-46813
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Acked-by: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 8aa2864044b9d13e95fe224f32e808afbf79ecdf)
> Signed-off-by: Shubham Pushpkar <spushpka@cisco.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c | 3 +++
>  1 file changed, 3 insertions(+)

What branch is this for?

thanks,

greg k-h

