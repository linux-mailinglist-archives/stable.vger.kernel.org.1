Return-Path: <stable+bounces-41629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 256668B55FF
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D519E281726
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FBF3B298;
	Mon, 29 Apr 2024 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="4eCUwqW6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O7hDUeMh"
X-Original-To: stable@vger.kernel.org
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD94219F0;
	Mon, 29 Apr 2024 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714388797; cv=none; b=RG9+4mW/OE0honbA+dZBFePlGGe+Ta63TTgx9TJbAphpcPhGYT0ZLy86zQYghfpQrMRFREkeZVXgJ1c1ernlSwcBFdcGK5He0AAN3/kgvA6TMDu+40fRvI3GXuVISioyuCQWSnOGPqzj39dVYAuV4+P8/+1ENHRkf8kViF7xALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714388797; c=relaxed/simple;
	bh=luM5/kXPZHQ9rDYrFQm9TZ+QNnxpv3bxwRI9IfGI6Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3R7t/mBPlExv3wKsrQIH/esftAbYruUU3VtiGzatJgKD9CwA+xM13jkeI78JAwFxQpvTMi0veL6I8RoxFZ5D4yeEchZdhu6ASCSkhTkeqSmxg4FdDNEUhu7yKp/PFnNDZ7tQ9wmKTbSi683MejtDLbLt+0tzad6Qt/twnU/wUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=4eCUwqW6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O7hDUeMh; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id D70221C0015E;
	Mon, 29 Apr 2024 07:06:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 29 Apr 2024 07:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714388793; x=1714475193; bh=BFh/0WAkDN
	inkgfHuz+GwnSA+D62BZHCAFUB8hxtigY=; b=4eCUwqW6u/48l8LqV0csmNS8oa
	whZA/uBnIxhHZDHrSvJxNGLS600/wNGdn++nYXsJhfyHtMODaW+cFrUcpr9K3u3+
	CXTcY0FacZpMFp8xoFGCgRXdHezrSYqmZp+lUN4eYsbxWwA8ygBS/MiHGZt87s33
	SpB6ns82lgwvTiuV1VRX8oEaAs6sOVCMttEk3H+apXIUxtJkottUsBvY2ut4nZUp
	yLpT3apH4MbQMP6bcx9UYgqzfSF1lYc0do0071Q/WJ0MjUcIJ5wMAxlgKRK4Xxa5
	ZfG1bV6HX6VXvznTGlaQFm1c/QLvUfLogzCOw8XAVLR5Y/NMrxXynQn0cy7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714388793; x=1714475193; bh=BFh/0WAkDNinkgfHuz+GwnSA+D62
	BZHCAFUB8hxtigY=; b=O7hDUeMh9B8i1lIPyAseVcz4l+6z+axaqdrJlJfpNDDu
	gX7Tfo0Hxn5KJYISsgkFFrsFu8t7TfETpMxvjD6Mt2ZxO8mmNKIv8/Mb8JStuAmK
	Ma5i6bqduwm9AIOUeO3Vfmh+O0ip2a1CD17TFrgX+qNI+C6ZiDOinRbdLo7YWleV
	ZxFfdPSoN4RWNRmgGEQriAYsfgnHXj3SWZDpGxT7HoJYkju7kpjzRkOEXwhuKoJk
	O2InexrfFqJX/0zFzic8+URTYGb6yCm43so/ylTosZFjxF1sjkoCXCfnYFLOEAka
	Nio0WGrkXGhxdZoAvwRLJT0oSEYsUq+YPEqqCX5cnQ==
X-ME-Sender: <xms:OX8vZqL4T8abPhSbQOdOd5uTOms0XKKTs2tyF7ShZBiNDD8mmGNmWg>
    <xme:OX8vZiKFvEL0AG1W3TVVfNdCJpqT3qIn7ankNbYj4itOiwQa5mRBaqT-Zxjrj0ZEy
    kKpZrauoATtMA>
X-ME-Received: <xmr:OX8vZquTmfgaN1ZV_nIboHUJ7bljFK-va7aE6GwVX7hPpDVW73mrh1gdypAfSu_NKwdRZeSHvl2K9MrorW8OdjC9WyLcAco7jFYZEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:OX8vZvbtloTDjl1tNNmhDKM-gdOt5GCrammvLuYf1LlVEJvquDb4tQ>
    <xmx:OX8vZhYaGv3yEeamcWY6UtWEwmqN59u8OaHF7ZiIMHLR_FxhKmkV5Q>
    <xmx:OX8vZrB7u9jAqMGmoPn7Y49qXv2y2ywx7dhN3BxanagteI9kRd9_6Q>
    <xmx:OX8vZnZb0dHt_5VZWi3jMw1wQaC8FKH8VOLK9AsipgIw_If4LuGfgw>
    <xmx:OX8vZvO8UJPNOIIpfhwEWzIsGlNI1NwpbUEIEl8hjHzLG8q69OAC4W-g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 07:06:32 -0400 (EDT)
Date: Mon, 29 Apr 2024 13:06:29 +0200
From: Greg KH <greg@kroah.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15,5.10,5.4,4.19 0/2] Fix warning when tracing with
 large filenames
Message-ID: <2024042923-attribute-brunt-15b5@gregkh>
References: <20240424222010.2547286-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424222010.2547286-1-cascardo@igalia.com>

On Wed, Apr 24, 2024 at 07:20:07PM -0300, Thadeu Lima de Souza Cascardo wrote:
> The warning described on patch "tracing: Increase PERF_MAX_TRACE_SIZE to
> handle Sentinel1 and docker together" can be triggered with a perf probe on
> do_execve with a large path. As PATH_MAX is larger than PERF_MAX_TRACE_SIZE
> (2048 before the patch), the warning will trigger.
> 
> The fix was included in 5.16, so backporting to 5.15 and earlier LTS
> kernels. Also included is a patch that better describes the attempted
> allocation size.

All now queued up, thanks.

greg k-h

