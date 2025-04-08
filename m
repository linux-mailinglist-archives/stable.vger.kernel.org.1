Return-Path: <stable+bounces-128823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAABA7F52E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 08:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF30D18876CF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 06:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04EC212B2D;
	Tue,  8 Apr 2025 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KNIFfw2T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109020C037
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744094806; cv=none; b=pryOYPMLDXqO5zXz2rsS3hWee7iJevM+sbpMPU7kl2j0kBD0ma+ZoJG1Y4yEU/79z5eZK2YrjR1OYjbwB4iMrnkVSZ22nRXyRhi6CzhBDYxwD4tuKDGpJM9L2SNdbqRZLc1ot37giO1CsJx5IDoHj9MrWYFDp47MlfyQJFu7/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744094806; c=relaxed/simple;
	bh=bf6YN/jksN8XTp2JCFKGODv+ldkFm4kJvDgT40OR6sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhAltJc2u+vq1loknDZnUnyklOS5sYDPizGfFYLIEY6TDVuFTMHwXA935tyIkeSfuFAuehJW3etnxGJsU2Q7VNkk+23Pf6ZSDXCpkAxCI2KUGhME4E1CHs8nlR/iSswTP6QU09ezg1K0vGDunWI6kZ8s8oq+9x4iRygCCEIxHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KNIFfw2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90FFC4CEE5;
	Tue,  8 Apr 2025 06:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744094806;
	bh=bf6YN/jksN8XTp2JCFKGODv+ldkFm4kJvDgT40OR6sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNIFfw2TGNhd40uAyae7m9oRHimM9IHEvTTedjBzukbomxZzPg3ZC4QAygwppXsXC
	 DoiQ7FDSkZYQRltZhC96hZMTr5hmfNwXJAMW7xIfBKrrgHgpkqp/4HmPD7fLiwgqeF
	 NTmo0lP81WgdbqvvOtITHmkwaQqkiAG4KGBD4dUc=
Date: Tue, 8 Apr 2025 08:45:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Sun peng Li <sunpeng.li@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: Re: [PATCH] drm/amd/display: Temporarily disable hostvm on DCN31
Message-ID: <2025040802-seltzer-pedigree-d053@gregkh>
References: <20250407234329.2347358-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407234329.2347358-1-alexander.deucher@amd.com>

On Mon, Apr 07, 2025 at 07:43:29PM -0400, Alex Deucher wrote:
> From: Aurabindo Pillai <aurabindo.pillai@amd.com>
> 
> With HostVM enabled, DCN31 fails to pass validation for 3x4k60. Some Linux
> userspace does not downgrade one of the monitors to 4k30, and the result
> is that the monitor does not light up. Disable it until the bandwidth
> calculation failure is resolved.
> 
> Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit ba93dddfc92084a1e28ea447ec4f8315f3d8d3fd)
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What tree(s) is this for?

