Return-Path: <stable+bounces-109234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C06A13793
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817603A5837
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 10:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD93719AD48;
	Thu, 16 Jan 2025 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pyn0sTpg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E43D26AF6
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022548; cv=none; b=k672b0pSekHKMBE4M0yh4sDg5gLeB1ADJtiZCtXqn4vMCMg1Hr7bQBlXs4HswhrvMO3ON2gFfWPiWJjxIA3ZzjGCylGBwCzDvnBLqz24FdlpllI1APSLuCYWnDH6liajFFLp0wn4Mt2KDxezhbY6WzRKTLLiGDoadJ3Q6Sqo83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022548; c=relaxed/simple;
	bh=CVv+toSxGcIwMqZYQ2klGYhof2cJyGQ7/55HiUizLYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU2XRz88ZHEhxEGgPMskIWrlsHOUAG//7x2XNx9M6VXvDafyKkEyRmQahB3pxmbR7sOnloVDVIjNyQpY9wTQi8aLAXNhg1Pe+rNoHUmuArQIuCRFMYYAAb9KPE404BJJOuTUtk/W07nbUv0/5ekr0wn7hvb4QGnJOpVg0TMtKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pyn0sTpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72C3C4CED6;
	Thu, 16 Jan 2025 10:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737022548;
	bh=CVv+toSxGcIwMqZYQ2klGYhof2cJyGQ7/55HiUizLYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pyn0sTpgJxufPV/+TtQ0aP8L93gvKUUMOKOsicFyiHCpT5F2J4WAGnF0CTV/bq07D
	 KVqbqxP+oxoMu8QSUbodgKXQFjarkus/2vxytVQdFxu1cSv33Mdph+n+dyz8dJ5wyC
	 30whqO8GeCN9vOA6fc1esJDduPxc6gh3EzhafCf4=
Date: Thu, 16 Jan 2025 11:15:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Frank.C" <tom.and.jerry.official.mail@gmail.com>
Cc: stable@vger.kernel.org, srinivasan.shanmugam@amd.com,
	chiahsuan.chung@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
	alex.hung@amd.com, aurabindo.pillai@amd.com, harry.wentland@amd.com,
	hamza.mahfooz@amd.com
Subject: Re: [PATCH 6.1.y/6.6.y] drm/amd/display: Add null check for
 head_pipe in dcn32_acquire_idle_pipe_for_head_pipe_in_layer
Message-ID: <2025011632-swivel-obtain-67e1@gregkh>
References: <20250116061726.56117-1-tom.and.jerry.official.mail@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116061726.56117-1-tom.and.jerry.official.mail@gmail.com>

On Thu, Jan 16, 2025 at 02:17:26PM +0800, Frank.C wrote:
> From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> 
> [ Upstream commit ac2140449184a26eac99585b7f69814bd3ba8f2d ]
> 
> This commit addresses a potential null pointer dereference issue in the
> `dcn32_acquire_idle_pipe_for_head_pipe_in_layer` function. The issue
> could occur when `head_pipe` is null.
> 
> The fix adds a check to ensure `head_pipe` is not null before asserting
> it. If `head_pipe` is null, the function returns NULL to prevent a
> potential null pointer dereference.
> 
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn32/dcn32_resource.c:2690 dcn32_acquire_idle_pipe_for_head_pipe_in_layer() error: we previously assumed 'head_pipe' could be null (see line 2681)
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
> Signed-off-by: Frank.C <tom.and.jerry.official.mail@gmail.com>

I need a real name here, sorry.

greg k-h

