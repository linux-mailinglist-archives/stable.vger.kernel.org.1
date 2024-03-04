Return-Path: <stable+bounces-25887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6CB86FF80
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 11:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18771F264BC
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3018D364CF;
	Mon,  4 Mar 2024 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mZW0xvOU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B0720B27;
	Mon,  4 Mar 2024 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549556; cv=none; b=XEMjM7DhzGMq+mW+/ALZ8oA8GjR3e1brcZ1MxmBe5Nn0yKKnr1P3c007AtmGoE7dFOF7RujhboeJENH4dfxdwlKjQ1sfLCUe7yxce+WCD9SywiMLsjnyqR+pssJLXDxZbIY55HtoibO0rboHiOp80eXWO8mvMCGYpnAxaDtZAmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549556; c=relaxed/simple;
	bh=jyX89aDVSEYtaj6kbA78kpRmGgpNRc44wI4hO8W7sAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfmK1s49sdOr6afTLmFBZvtoseGvsxVIBUyBkLl/zRCiAOmBXt6FQDSSoDJCZRb6hSwUR/OtxHDOClevy9MyUCoHqpxfmCtX62hDs/WLIXiwYYpYHRgSMQ0zYCaUsb1tskaLs0A3Abu5LNa3ke+jeN7HJQzQj4dB4nzyxOK3pD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mZW0xvOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070EDC43394;
	Mon,  4 Mar 2024 10:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709549555;
	bh=jyX89aDVSEYtaj6kbA78kpRmGgpNRc44wI4hO8W7sAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mZW0xvOUF9nTJ5Ay0udStvD7g7KyS8fQgiqFCMHv2GOhdkccC41Ak9PBb8RTlOC5h
	 AdiqBVlTXkQZL+Dfrg08Cqe0tCl67FaQJPqKwMxuEYYUWz8c45i2T5KkJ7nuPyhVH/
	 rE9wV71agiNn329EhIrbsHnjX+iVkHBQi6HntrVE=
Date: Mon, 4 Mar 2024 11:52:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: max.oss.09@gmail.com
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, sam@ravnborg.org,
	maxime@cerno.tech, sashal@kernel.org,
	Max Krummenacher <max.krummenacher@toradex.com>
Subject: Re: [REGRESSION][PATCH 5.15 v1] Revert "drm/bridge: lt8912b:
 Register and attach our DSI device at probe"
Message-ID: <2024030418-clinic-cardboard-bec8@gregkh>
References: <20240228145945.2499754-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228145945.2499754-1-max.oss.09@gmail.com>

On Wed, Feb 28, 2024 at 03:59:45PM +0100, max.oss.09@gmail.com wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> This reverts commit ef4a40953c8076626875ff91c41e210fcee7a6fd.
> 
> The commit was applied to make further commits apply cleanly, but the
> commit depends on other commits in the same patchset. I.e. the
> controlling DSI host would need a change too. Thus one would need to
> backport the full patchset changing the DSI hosts and all downstream
> DSI device drivers.
> 
> Revert the commit and fix up the conflicts with the backported fixes
> to the lt8912b driver.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> 
> Conflicts:
> 	drivers/gpu/drm/bridge/lontium-lt8912b.c

No need for the "conflicts" section...

now queued up, thanks.

greg k-h

