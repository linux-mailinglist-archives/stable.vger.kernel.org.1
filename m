Return-Path: <stable+bounces-86810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 254BA9A3B86
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 12:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549D91C210CA
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43876201260;
	Fri, 18 Oct 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cQiL5YnY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02156168C3F
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247339; cv=none; b=syQZiVXWO34+k8mGXIGDfcMYuCYzJmbg+cxdFFpHlmX1m439Q6FeUFKVjHnI84TTi1TZBBFOYRoWHMxFVp6qeOivlJdTy4jEpzPAASeU8o74VJBOmE+fVz3/MxOYYwuCg/D4BniMg0b2z9jD0pnEmyq1CumPyM2vJ+wzQKV99OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247339; c=relaxed/simple;
	bh=REWg+DJcLyxWQwSgmCkjX3Xts0CxpAY3QlIkvgz2udE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSnU62MZaaQ9zESeMVyb8ybZT4bLc8psaYdOtZwMmawpz+/bQsfu9JvvWkrBnutn8dDBzgGI1A8/m+PcqzAHHZs116HaG1CxDzFalPx+iRjk7VkbYJ80SkA5cwFT0XkiqUUdfY9ub9UWC1yjxPPpc7PBfT+kLS3/OCOMqHC9Khw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cQiL5YnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D37C4CECF;
	Fri, 18 Oct 2024 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729247338;
	bh=REWg+DJcLyxWQwSgmCkjX3Xts0CxpAY3QlIkvgz2udE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQiL5YnYYObn8WGM1v2tkJTEgXR5mPsX4C3ph5p4orSVsOzOqDj44vgXhLdX8C6mv
	 ZKm99uxHdyLWb9pjjk4OySF0c7Ab8L19FNCVl8s+sbGScKUPVRnkesxthRYDO5sx/w
	 YWrPb44Bpp2A9U57VUfsOci3Ow6tBBg0sym3VtNw=
Date: Fri, 18 Oct 2024 12:28:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sherry Yang <sherry.yang@oracle.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	eric@anholt.net, robh@kernel.org, noralf@tronnes.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 6.1.y 5.15.y] drm/shmem-helper: Fix BUG_ON() on
 mmap(PROT_WRITE, MAP_PRIVATE)
Message-ID: <2024101845-dictator-contusion-bf29@gregkh>
References: <20241017171829.2040531-1-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017171829.2040531-1-sherry.yang@oracle.com>

On Thu, Oct 17, 2024 at 10:18:29AM -0700, Sherry Yang wrote:
> From: "Wachowski, Karol" <karol.wachowski@intel.com>
> 
> commit 39bc27bd688066a63e56f7f64ad34fae03fbe3b8 upstream.

Now queued up, thanks.

greg k-h

