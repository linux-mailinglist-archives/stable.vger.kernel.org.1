Return-Path: <stable+bounces-188838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2B5BF8ECA
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 23:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 485074E5AB6
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0956277011;
	Tue, 21 Oct 2025 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTdZ9btv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC9A27FB2D
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081586; cv=none; b=NgxnC0ph96gEt1MGUomZ1dRJqhToR0LX+oevVSMg/Sab1T5HFTZXKUiVuvv0qX9N9zPV7uOFTF8G7Q+xZZhpARD/92iZeQR7kTuweS8WY1RnCrq2RCUe1oJiisZjJMiaUw7NlOowquZ3a/mPCPk4iJ5YAiQqPTDeuLWSE/blaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081586; c=relaxed/simple;
	bh=DUS95MhFSqfsdvk2fUcY3ixxEHwgfQrCz8w8n29QEfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V1HXPM5Y/1bOku86QoV3C74EU/aqnm93f1skNW+i/n6WJa4IGjHWWVHJnHaVNQ2sOWdj05bCrG38LzE93TrrLRg9QPWXuCIv2ojVf7mmKRTFk1DeadzZcg8kloXWCmkNTcBdLCw/l0d6+PinPmQ5y944NfhUViCsB0ZXV1ez71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTdZ9btv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF1AC4CEF1;
	Tue, 21 Oct 2025 21:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761081586;
	bh=DUS95MhFSqfsdvk2fUcY3ixxEHwgfQrCz8w8n29QEfs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=eTdZ9btvxS4QJHr7TjvRd0Vm4lCmPKcu/rc8bPOxeONC63ZrZcJ3No7yXgdjriXz5
	 wk+8fR4xvW1pH1Yd1Ib0H+07TXY3w4SBBRoNHWWXcRNxV/jeHFS5J7g7DfCZgvvda2
	 mp9YPM1aG0Twr9OES5OR7OODFYvDxC9uh6W5e4cZACDnAgmtIpmWrdtz95uDfF+Jwa
	 5wWM5LhyDc8ie43aLwNmGUHttMghPVaHfWxoH0kB8tcR3N0CfrBTR+kJuUuvPJCxqa
	 epgzYNDKFGPHN7dvQXLNwTjEJtXuFaQcUmsU9yqXG7c+XujOn/wTkS+oQl11Rlmaq6
	 MKvUiQu8QgIug==
Message-ID: <1f15260b-684e-4b8c-807f-244bbfd31f1c@kernel.org>
Date: Tue, 21 Oct 2025 16:19:44 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "PM: hibernate: Add pm_hibernation_mode_is_suspend()" has
 been added to the 6.17-stable tree
To: Pascal Ernster <git@hardfalcon.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
References: <2025102032-crescent-acuteness-5060 () gregkh>
 <2745b827-b831-4964-8fc5-368f7446d73e@hardfalcon.net>
 <8c4d1326-512c-4b98-bac0-aa207b54aa2a@kernel.org>
 <19c7ba58-7300-4e10-bd81-367354f826db@hardfalcon.net>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <19c7ba58-7300-4e10-bd81-367354f826db@hardfalcon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/21/2025 4:08 PM, Pascal Ernster wrote:
> [2025-10-21 22:45] Mario Limonciello (AMD) (kernel.org):
>> Are you cleaning your tree between builds?
> 
> 
> Yes.
> 
> I'm building custom kernel packages in a clean chroot for my private package repo. The kernel config and the PKGBUILD can be found here:
> 
> https://remotehost.online/linux-6.17.4/debug2/config
> https://remotehost.online/linux-6.17.4/debug2/PKGBUILD
> 
> Here's a tarball that contains the PKGBUILD, the config, and all source files that I used:
> 
> https://remotehost.online/linux-6.17.4/debug2/linux-hardened-6.17.4.hardened0-0.src.tar.zst
> 
> Here's a log of stdout and stderr of the build process:
> 
> https://remotehost.online/linux-6.17.4/debug2/stdout_stderr_combined.log
> 
> 
> Here's a fixed PKGBUILD that I used successfully to build my kernel packages:
> 
> https://remotehost.online/linux-6.17.4/debug2/PKGBUILD.fixed
> 
> The only difference is that I've commented out the two patches from your patch set, and removed the corresponding sha256 sums.
> 
> 
> Regards
> Pascal

It looks to me that you have CONFIG_HIBERNATE_CALLBACKS set but not 
CONFIG_HIBERNATION set.

How does this happen?  HIBERNATE_CALLBACKS is hidden, and it's only 
selected by CONFIG_HIBERNATE.

The fix for now for you is to either turn off CONFIG_HIBERNATE_CALLBACKS 
or turn on CONFIG_HIBERNATION.

