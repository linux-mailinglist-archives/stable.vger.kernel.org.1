Return-Path: <stable+bounces-116796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50AFA3A0B5
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 16:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190B816F4C2
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C401626BD97;
	Tue, 18 Feb 2025 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GScR1vpm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4A726B0B4
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890772; cv=none; b=J/fCcp/iEdttxSkfvW9C/QlRC7L1PI6PxGWd/OIQTNT5O00VPEj44bNyQcQAo64KqoVa8wdNB7ah8V+w9tCbJZDxcBz0lg5MoiLKr4dGQ2tQYyuwDhEepZXOdsAj1YJ9Zn+G3t1W6yQW1KIJXrJ/3KoMmFJqZaivxAZ+XRJjhSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890772; c=relaxed/simple;
	bh=kjijBquFcQ9E7jRbRk6TEYeBtZKOsAJWKO43KZtP7PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiWpFpMKHVGAJNxelZQhq4CvDD6/4dCUMzKvH2eNxn4wEHJfkshz+AQOdpnNzz0okAapguk7/rSq7n3gkEFYnst3dDD4lS+yoDMznd4xV+ngxZ/3V3DsWaYr7GAZeR4rpT1OwwN7muV+SqYjGLQ8n89msno2EStdrYt0GrPQizM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GScR1vpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7C6C4CEE2;
	Tue, 18 Feb 2025 14:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739890770;
	bh=kjijBquFcQ9E7jRbRk6TEYeBtZKOsAJWKO43KZtP7PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GScR1vpm/e64ZVQbklfs3lU04h+1OMKiO81ckCco/VSLAaXqxfgYAjDSme86NX4LF
	 COHHmuNMZ+Ly01lHbRMd5PRvgfG1K8zsyCz9GKAlANexcAz5iHThmKTR0b9s1NNJ7s
	 m+hvPwYNuRUURX6zL2sYFV+ZZffDa2CUPCHF8j34=
Date: Tue, 18 Feb 2025 15:59:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Cc: rodrigo.siqueira@amd.com, jerry.zuo@amd.com, alex.hung@amd.com,
	daniel.wheeler@amd.com, alexander.deucher@amd.com,
	stable@vger.kernel.org, zhe.he@windriver.com
Subject: Re: [PATCH 6.6.y] drm/amd/display: Pass non-null to
 dcn20_validate_apply_pipe_split_flags
Message-ID: <2025021814-powdery-jokester-dba1@gregkh>
References: <20250218071659.3696692-1-xiangyu.chen@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218071659.3696692-1-xiangyu.chen@eng.windriver.com>

On Tue, Feb 18, 2025 at 03:16:59PM +0800, Xiangyu Chen wrote:
> From: Alex Hung <alex.hung@amd.com>
> 
> [ upstream commit 5559598742fb4538e4c51c48ef70563c49c2af23 ]
> 
> [WHAT & HOW]
> "dcn20_validate_apply_pipe_split_flags" dereferences merge, and thus it
> cannot be a null pointer. Let's pass a valid pointer to avoid null
> dereference.
> 
> This fixes 2 FORWARD_NULL issues reported by Coverity.
> 
> Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> [dcn20 and dcn21 were moved from drivers/gpu/drm/amd/display/dc to
> drivers/gpu/drm/amd/display/dc/resource since
> 8b8eed05a1c6 ("drm/amd/display: Refactor resource into component directory").
> The path is changed accordingly to apply the patch on 6.6.y.]
> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> Verified the build test only due to we don't have dcn20/dcn21 device.

Again, as you don't have this device, why do you want it backported?

thanks,

greg k-h

