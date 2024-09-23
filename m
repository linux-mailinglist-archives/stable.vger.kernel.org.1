Return-Path: <stable+bounces-76887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B91197E7E5
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 10:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDBB1C21356
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 08:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F3B1940B5;
	Mon, 23 Sep 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWQkW9sD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5F849649
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081475; cv=none; b=DKtfmzUyEhSqr0zZ2Z+A5DuE0JxUz6kjpQdw4OHjV1BNSIddiV0djEjw8/P59ullZ1Tuc/ebxzQyPb5Mlh1gTooGa4XiRr6rgtAjr+j/+MKBFys3bwkOCupzUo6UlIfSvCAqRVnlshRSueoSeOyMROAcQIZiOh8FjSZRg9o/Vi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081475; c=relaxed/simple;
	bh=TCLc6jBKJ0G4dd4mGnigzOJ0eLk/T9gSbvJg4p67H70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nbn813QO8lqbBEvED48CntzFbV2pxrfGnXb79YGyyHxvl2K+Zmu9rHQLR1yOJfBe8UZwqwtsegQaVy0c9k/V++nAG3gJCwAnEAndoG1CX1x2zfzAQzT030r7Nd9jJBks+OabwI5ptRzvMGLSyxWk2d/4SKmfEgr7t0PWXGiGZN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWQkW9sD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41727C4CEC4;
	Mon, 23 Sep 2024 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727081475;
	bh=TCLc6jBKJ0G4dd4mGnigzOJ0eLk/T9gSbvJg4p67H70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWQkW9sDGr9mHWI1zXHi+Rh0sOz1P94JTvNXvwVfgRKYxrLc8BBDoi7a53qNcYNeW
	 c8CWAeD6BtpMI5fn36t5Q9o4LMQ+f6Xqkt9hejqW1yNQpDrlgLOD1mIGIyrfoXk3wq
	 38pqSlao1qinUXfhWFieoXbhzAYvxp3dSMjmsiQyXOZNNUPxqT3GV3/Xvd1LHCeHIH
	 pOG2PgSNJskzYSiHdWRIeMbWx3htTVxw9SsIe8h2o6UP1U3u224g6OzprMJq6zdM6N
	 41EDy1HFRayjEGJc1gWJiV+sOkhalZtzLT2fM7+GZhZYBZIj92518/LhVxQiKMwOmO
	 HrWYCrINMAIWw==
Date: Mon, 23 Sep 2024 04:51:14 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org, Peter Jung <ptr1337@cachyos.org>
Subject: Re: Fix for kernel crash when changing amd-pstate modes
Message-ID: <ZvEsAiDVRFKlngdY@sashalap>
References: <ba9ebc80-301b-4058-988d-02988c54d965@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba9ebc80-301b-4058-988d-02988c54d965@kernel.org>

On Sun, Sep 22, 2024 at 02:35:37PM -0500, Mario Limonciello wrote:
>Hi,
>
>This commit from mainline fixes a crash found in kernel 6.11 if users 
>change modes with amd-pstate.
>
>commit 49243adc715e ("cpufreq/amd-pstate: Add the missing 
>cpufreq_cpu_put()")
>
>Please backport to 6.11.y.  Earlier kernels should not be affected.

Queue up, thanks!

-- 
Thanks,
Sasha

