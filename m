Return-Path: <stable+bounces-62822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823E69413BD
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6AE283DF2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 13:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E58B1A08B0;
	Tue, 30 Jul 2024 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4VbyxtD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7761A08A2;
	Tue, 30 Jul 2024 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347915; cv=none; b=V6muXu0+ZcZNzAkskwve8AJRdNkuq8Yz7LzAdP39DhLzIWD7JN4mkpySen2Kbbu31SwTo0Oa7Ohz31sp1zDXLVRTt2dw3OC3XefhObtq/nV7tksVlRP3FemcHXyEw+TAc01sW57HWZZhAUkDk9/2Jw2rF2RCmc/nu8JDVZBRvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347915; c=relaxed/simple;
	bh=9EO7TUH4/VTKpZhDgd/3YXj2w5rnSczeLLp/LyDG7eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9v9Vo3TMd5x4yaXWaOM7FId9Dpz6eyA994VayqJaBe/IzXsoYUJdHSCLfP2O2A0CXb+lDjN037CbHWl9wvh7FWLJKQfSFyq7LT2yZjzan6L+3jzq3kHRufjohFSA32/TQiHVNIAuUWQprp4cWPZrZpfjG5f6XTqgPS1hQeD14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4VbyxtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99D3C4AF0A;
	Tue, 30 Jul 2024 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722347915;
	bh=9EO7TUH4/VTKpZhDgd/3YXj2w5rnSczeLLp/LyDG7eY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4VbyxtDGRowP/v5PLTeChQGb74svdLb9Vl71UdrnNjZYi6o5n+6XAaktPoXAUfrk
	 mSZWrFsYqZ/KrftRhv/rrEFl+bngpNHOsst5pYcObrQ799olMmm6NjfOZxlThZ8UbX
	 +v45cx4IznLrzIZhxheZWF9N6VQFAX//7j8T3/plw7IYY7nLmGaHCRXa+URvKoZqXV
	 0pxjAQgES1neFQbw/PBRQ2y9Q7ygrlOQS5H4hgaZJ+rMwkFPFbrOTz/uy4JT/M+L12
	 8GVo8SfQgofXr3q9famSBB7kIGnC0PLpcON5LMrFW7B2CKxxoemWKfLskzNhF8OGtf
	 Jwe4rOeYrEdgg==
Date: Tue, 30 Jul 2024 09:58:33 -0400
From: Sasha Levin <sashal@kernel.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Patch "cpufreq/amd-pstate-ut: Convert nominal_freq to khz during
 comparisons" has been added to the 6.6-stable tree
Message-ID: <ZqjxiW_Q5WLkEHOB@sashalap>
References: <20240727143801.959573-1-sashal@kernel.org>
 <dc46a633-f19b-4216-8747-e0511e7d8503@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <dc46a633-f19b-4216-8747-e0511e7d8503@amd.com>

On Sat, Jul 27, 2024 at 08:25:53PM +0530, Dhananjay Ugwekar wrote:
>Hello,
>
>Please note that, this specific commit causes a regression in kernels older than 6.9.y,
>it is only needed after "cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear}_freq"
>got merged, so please do not port it back to kernels older than that.

I'll drop it from <6.10. Thanks!

-- 
Thanks,
Sasha

