Return-Path: <stable+bounces-96191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB5D9E13C0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 08:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3BBB21084
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 07:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63071188701;
	Tue,  3 Dec 2024 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mu3vCexX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110D942AA3
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733209908; cv=none; b=ZmDRN/Nm0+xz3QGIfRl96fQ+Oculg0Ad4o9P/838lY3qttZhzx+/gDrvSttSvbB943aLakbd95HYEkGx//gZoTLr6iCF1e5A3wST2qU/7zLsBu9SVVaBNsASzo1m+qTF4kaYkZuaaISDuxBRtFd8M+glwxOqHqeLYS5m1ordlI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733209908; c=relaxed/simple;
	bh=vZ1/HNXM1CfGlTvWAcErD3NgUGfBtkHSMwimy237IdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGoTQqvGoSsyavs/oLvQjlbKSHyiOwjxYyFbzH1C02MWkH+NQxxlijgUD7+HRJzlx8BflG9KNfeFLTdpOjGJhW3nDRxHjsZLj60FBAVt5C+2Qe+P+QSbODNN0MAzlJSTrj2VhfkSST0LvTuyzJAY9Y8OKUqZynprU/v2cIp5Dio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mu3vCexX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F11C4CECF;
	Tue,  3 Dec 2024 07:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733209907;
	bh=vZ1/HNXM1CfGlTvWAcErD3NgUGfBtkHSMwimy237IdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mu3vCexXeEFZ91y96puVK0L0n7bChWmf5YYtBADi4w5VjDWYiG3jQ3UPGkprjFUlz
	 UHigNfawAq+Bb28QqeZh470pwJ/4YHmM4mi+sLN1GzuFHNtRVl6LJ/V7kLKZdxP7Hc
	 rDZzdeWMyAx2aq/8jtiggCyF8Qd05lQH0LVEexRI=
Date: Tue, 3 Dec 2024 08:11:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Skip Invalid Streams from DSC Policy
Message-ID: <2024120301-starring-pruning-efe3@gregkh>
References: <20241202172833.985253-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202172833.985253-1-alexander.deucher@amd.com>

On Mon, Dec 02, 2024 at 12:28:32PM -0500, Alex Deucher wrote:
> From: Fangzhi Zuo <Jerry.Zuo@amd.com>
> 
> Streams with invalid new connector state should be elimiated from
> dsc policy.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3405
> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 9afeda04964281e9f708b92c2a9c4f8a1387b46e)
> Cc: stable@vger.kernel.org
> ---
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

What kernel tree(s) is this series for?

thanks,

greg k-h

