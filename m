Return-Path: <stable+bounces-116795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEBFA3A0AD
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 16:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76862188AF67
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4680426A0C9;
	Tue, 18 Feb 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VY66Yczj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0514526B09F
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890754; cv=none; b=DhZmHvvpGytXr0G2+FQ5Xvh267Do7zroM6nbjnq7VczrZwsHfDPoL5JyTbj0bYqf/wSwMqncZRTrJKCOeEBkkjUE3yuJZkdzlUmMTJQNdwikL0jbuLk/OYpVWmYtXZx+egDCySpZ/igrbP7sQTsHVBDB0tRRqr5JeARMRC3PXSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890754; c=relaxed/simple;
	bh=YfDRkK+ADMpH8GMovmr0mB5kHZDnSb4mpPr/Pa0+5j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U45B4FCgeRgYkWB0jaKH1wBIufjPOLVkxf9+SQSr8zzZrcxiYtPcd/ELMNlVd81PYL5BN4YX330pXbFLH+9Fm4DK7WDbhIPVTh+m2dxZ2It+7trQgJ+lghEkUNa3GqLyt200HWLml0invnpr2NWegiqy3DeiLo1EEY1rqrkVT70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VY66Yczj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8E5C4CEE2;
	Tue, 18 Feb 2025 14:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739890753;
	bh=YfDRkK+ADMpH8GMovmr0mB5kHZDnSb4mpPr/Pa0+5j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VY66YczjmGezi5CEBe9ojyPoNlBkIogIqxDsfETrLXTwqftoUg2YV22rWlOJC33Cu
	 lcAb5oorJG0kNzfGtT/rOwo2WMMHbs5OtBtvGtyJhi6JI1TwSTDAYrfsR1+YCiWTn9
	 j+v7vpRrym2S0URJsV1i7kuTJ/mL5q/XA3EQ60GA=
Date: Tue, 18 Feb 2025 15:59:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Cc: chiahsuan.chung@amd.com, Rodrigo.Siqueira@amd.com, alex.hung@amd.com,
	roman.li@amd.com, aurabindo.pillai@amd.com, harry.wentland@amd.com,
	hamza.mahfooz@amd.com, srinivasan.shanmugam@amd.com,
	alexander.deucher@amd.com, stable@vger.kernel.org,
	zhe.he@windriver.com
Subject: Re: [PATCH 6.6.y] drm/amd/display: Add null check for head_pipe in
 dcn201_acquire_free_pipe_for_layer
Message-ID: <2025021846-blubber-trophy-b77b@gregkh>
References: <20250218061818.3002289-1-xiangyu.chen@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218061818.3002289-1-xiangyu.chen@eng.windriver.com>

On Tue, Feb 18, 2025 at 02:18:18PM +0800, Xiangyu Chen wrote:
> From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> 
> [ Upstream commit f22f4754aaa47d8c59f166ba3042182859e5dff7 ]
> 
> This commit addresses a potential null pointer dereference issue in the
> `dcn201_acquire_free_pipe_for_layer` function. The issue could occur
> when `head_pipe` is null.
> 
> The fix adds a check to ensure `head_pipe` is not null before asserting
> it. If `head_pipe` is null, the function returns NULL to prevent a
> potential null pointer dereference.
> 
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn201/dcn201_resource.c:1016 dcn201_acquire_free_pipe_for_layer() error: we previously assumed 'head_pipe' could be null (see line 1010)
> 
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> [dcn201 was moved from drivers/gpu/drm/amd/display/dc to
> drivers/gpu/drm/amd/display/dc/resource since
> 8b8eed05a1c6 ("drm/amd/display: Refactor resource into component directory").
> The path is changed accordingly to apply the patch on 6.6.y.]
> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> Verified the build test only due to we don't have DCN201 device.

If you don't have this, why do you need or want it backported to
different stable kernels?

confused,

greg k-h

