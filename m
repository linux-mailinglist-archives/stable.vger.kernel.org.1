Return-Path: <stable+bounces-210177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8393BD38FB9
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 17:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C794300BBCB
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4229C1DFE22;
	Sat, 17 Jan 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9fwXDjf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041B18632B;
	Sat, 17 Jan 2026 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768666852; cv=none; b=Jo7DVR4rBVkeMTVk4d1Sx5NkqnqRUv6B7AIZhPoThTjQDo1fDgsaV6KM9xeEU8/WYth0mktq+Jbpm0TcprGOnZNMhV3i+dSr9JqEu6dw5MhXIKTg0rvlviCsmnMxSeUnxwehV9k2eZEIJ7/0r4AxknHb9v+N69811ImlbAanhV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768666852; c=relaxed/simple;
	bh=8HeLDf3dAi+qsSsvexy4LmzN3Gw30UVRs6eXgKQ8R0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lA7VI1zBrIZDi8KJkwBIPZbG6jAllK8HIbZ8rxHqW5ceeGXbYqPVNx5ty9rNGygcXGlzNGu3F7AO9NJPLV52y1Ypoz6SjExCIbd4e7cXVutFKCMcp4meRYr3urj5pyTvmDgX1OROIvF3NZmgEJc66i4Ts3DIhcQ0VhQmg+9N/IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9fwXDjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65695C4CEF7;
	Sat, 17 Jan 2026 16:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768666851;
	bh=8HeLDf3dAi+qsSsvexy4LmzN3Gw30UVRs6eXgKQ8R0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9fwXDjfj8VwHel7iJo7Ntd7//J/jOeiJpnS9hAUcMhX9iuqSG/5pUzvhJ9nRx6G3
	 XKdx9mUxFgC551skWnkgR4WTtCBrr2wS3w5xaa4/ej33o0IPCcyf/oh0QfEcDChl1X
	 /pctRPklHtaiHkWjv1KFYmdBW9trNaI7IdKnjkoTF5EuiiLSqH9Q6TCwELsMTVAmeh
	 6DvM11/l1na5juTtd75B8kO+RN0t5MkmQS7isaFPGBrLXLdWVYHq0KB+MJwI+Yk/2B
	 snKJ6+TNiMnaA/RMZzIgPiOfUA6qvun7SsYCTiR5FcWB/Z5vt84/WbmWOvfXCYQd2p
	 cx6568AB7pgdg==
Date: Sat, 17 Jan 2026 10:20:50 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Weigang He <geoffreyhe2@gmail.com>
Cc: stable@vger.kernel.org, shawn.guo@linaro.org, grant.likely@secretlab.ca,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	saravanak@google.com
Subject: Re: [PATCH] of: fix reference count leak in of_alias_scan()
Message-ID: <176866684353.2536773.12026289389990774200.robh@kernel.org>
References: <20260117091238.481243-1-geoffreyhe2@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117091238.481243-1-geoffreyhe2@gmail.com>


On Sat, 17 Jan 2026 09:12:38 +0000, Weigang He wrote:
> of_find_node_by_path() returns a device_node with its refcount
> incremented. When kstrtoint() fails or dt_alloc() fails, the function
> continues to the next iteration without calling of_node_put(), causing
> a reference count leak.
> 
> Add of_node_put(np) before continue on both error paths to properly
> release the device_node reference.
> 
> Fixes: 611cad720148 ("dt: add of_alias_scan and of_alias_get_id")
> Cc: stable@vger.kernel.org
> Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
> ---
>  drivers/of/base.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Applied, thanks!


