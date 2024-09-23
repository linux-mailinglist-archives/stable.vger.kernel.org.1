Return-Path: <stable+bounces-76885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE8597E7E3
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 10:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D953DB20AB5
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F451946BC;
	Mon, 23 Sep 2024 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tP++fyBn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75851946B8
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081374; cv=none; b=A9+lr9J8m6xKu8nPMqJ5U3vBYx0RqWEw8iu1enO2HxgfgpupLM7/D+GylNpcJerGPti1bQXeL9KHLGuBcy3n1LwytE44n/O+wlgVFHjReRlcAy21jJVvQm79sl1lI+vQIyvC9/b7JpWPUqLBuYZc/gStGMd8u6aPoGGOLcxQZ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081374; c=relaxed/simple;
	bh=zUH3z6qaydtCoYdaiEykUPq59vpVXbOx5vIo9EjYHEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0jQYpu493LqqRh3w9O9xvJV38qhmt0yC6NjnRWJK2yg2DJ99yE80zDlDTs9bIpzUdCnuqynz9+hcQcxntQCJ3gIqIcGkDmY1JReTC1LUQ4kbzlDCKfGTjfOCAty34S0+k0cVoea/TV7WJ90MScXKRzomXvFQioQS46ERJ3TcgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tP++fyBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1449CC4CEC4;
	Mon, 23 Sep 2024 08:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727081374;
	bh=zUH3z6qaydtCoYdaiEykUPq59vpVXbOx5vIo9EjYHEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tP++fyBnaBCNQ/0bpEC1BFAUPm+dLSjChdyxhJBubcGOreAsa2GXdH6FTZx86TVpJ
	 1og/atkPqredwzKrTM2IuR0EW5YajY4O0Pot1nNpGxP10i53EEQFVdc/dd+ADyZHUE
	 h2mKHLO53DG19PSeM3X0/wPXQ+ylkz6ejOt46xxkFahB0FJImxJOjQQ5AcTrS6wNBG
	 Ys2IqFTD7GPjO00DSDBUifTbqi1PGHs+mWvn1TOaXlzWBZylianTNkfRNVVAwJwAcT
	 nbefLDlRKhGsT+JKcMejFXEFn/j2tvmjJCCFVT9f3yssT58ZGWMDacUU0+GwBuMcVY
	 F0bgRDvCxh1QQ==
Date: Mon, 23 Sep 2024 04:49:32 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Fixes for DRM node limits
Message-ID: <ZvErnBAL7LKWR0LR@sashalap>
References: <286c7953-2bdd-4d8a-918d-e31de8120d7a@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <286c7953-2bdd-4d8a-918d-e31de8120d7a@amd.com>

On Thu, Sep 19, 2024 at 09:04:39AM -0500, Mario Limonciello wrote:
>Hi,
>
>With systems that have 8 GPUs nodes + an integrated BMC, the BMC can't 
>work properly because of limits of DRM nodes in the kernel.
>
>This is fixed in Linus tree with these commits:
>
>Can you please backport to 6.6.y and later?
>
>commit 5fbca8b48b30 ("drm: Use XArray instead of IDR for minors")
>commit 45c4d994b82b ("accel: Use XArray instead of IDR for minors")
>commit 071d583e01c8 ("drm: Expand max DRM device number to full MINORBITS")

Queued up, thanks!

-- 
Thanks,
Sasha

