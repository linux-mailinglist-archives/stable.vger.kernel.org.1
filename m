Return-Path: <stable+bounces-182075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B891FBAD23C
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 16:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B0177A61B2
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF3F2D73A9;
	Tue, 30 Sep 2025 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V+7M1xV7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9A61F03C5;
	Tue, 30 Sep 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759241096; cv=none; b=qJtduwi9pYIweKv3l3BPzD4p1wCA+MFZHBdMvSsW7jjHUv56n2IzkqP8HBgcRnPwFsVxXj+AEAd1xYHev+DCFC1XaTLB8LANkZF6CElQzCtarPONk2k2x+4bcjA7qS7wyD/RGQvI7h5LqJ8yZLWnU/newpHzaDl2EKngawwXIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759241096; c=relaxed/simple;
	bh=f7N+70T3x95vSuISr61gZtk7HM/xw1BAP57RlU7XytE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fesnEWV3lGKeGGBl05rhm6qKHFGILlivWbj9lQe3sjVqinvI2/5/yUjR380eugZJGWtRSm89sVPHbRMrkTQIunI7sY6VXwBiRmhQE0Zx6pdUhcPSdcxzeAXicblbAu/QzS3AJFAMmOo2Nhpc4NRGL4ZCDEW5FILNKozqe6HlSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V+7M1xV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C16C4CEF0;
	Tue, 30 Sep 2025 14:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759241095;
	bh=f7N+70T3x95vSuISr61gZtk7HM/xw1BAP57RlU7XytE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+7M1xV7nxHAbdlFAPdgRoWhoz4ogdTagL/h9So8Shu6f5mR5mEMF+xoQSakOTPos
	 7/suf3HCf6+1cCRVg/1gHfWCUYywb1Z81MEj/bYsaha+iNXzqk3gzMR4a1gXq3czdD
	 i654X9MXbNatJkZAQHBodi7bqPpTK5iKfIYRtjUA=
Date: Tue, 30 Sep 2025 16:04:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eliav Farber <farbere@amazon.com>
Cc: sashal@kernel.org, mario.limonciello@amd.com, lijo.lazar@amd.com,
	David.Laight@aculab.com, arnd@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 00/12 6.6.y] Backport minmax.h updates from v6.17-rc7
Message-ID: <2025093045-proclaim-backwash-3b41@gregkh>
References: <20250929171733.20671-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929171733.20671-1-farbere@amazon.com>

On Mon, Sep 29, 2025 at 05:17:21PM +0000, Eliav Farber wrote:
> This series backports 15 patches to update minmax.h in the 6.6.y branch,
> aligning it with v6.17-rc7.
> 
> The ultimate goal is to synchronize all longterm branches so that they
> include the full set of minmax.h changes.
> 
> The key motivation is to bring in commit d03eba99f5bf ("minmax: allow
> min()/max()/clamp() if the arguments have the same signedness"), which
> is missing in older kernels.
> 
> In mainline, this change enables min()/max()/clamp() to accept mixed
> argument types, provided both have the same signedness. Without it,
> backported patches that use these forms may trigger compiler warnings,
> which escalate to build failures when -Werror is enabled.

All now queued up, thanks!

greg k-h

