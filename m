Return-Path: <stable+bounces-197654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0431CC9483F
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 21:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2EE54E2631
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 20:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889322F39B4;
	Sat, 29 Nov 2025 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHLCVDf9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4F228CBC;
	Sat, 29 Nov 2025 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764449852; cv=none; b=g7B1oFhwoTvRVsgWJTt+WZ7jGkMf2xjQZDbTRTW0crzTK1KRzskt8r6gc5vy3QUFjGOm7Pp9GaBnU7fvzSK2+vBarcFXMRxcDw3soG2csDQEGefOPc17QnkflliEduteIolq1VyXxL8vUX9OZAc3t2IusLTuTyVEs6bFmYqAFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764449852; c=relaxed/simple;
	bh=fZLvR0oZtDWbs/CDM40d7aJpMbVl5dOQfD1z5VRuXlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eweris4icWDHV50b3oDkzKatTaS/zoWWe/GGY8NkLdnEw0kjAmicAZVMx6QMHb+RXsNyrOS1P8Xkzz6XJ0jL2jLPHklcqlKxZHzt39a8J2V2E9MYNTeoko+5f5yXZN9JEreMF8+jbGkcFc5eZE8O2yvkP1zFD3KU0KXGJdyS7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHLCVDf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89242C4CEF7;
	Sat, 29 Nov 2025 20:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764449851;
	bh=fZLvR0oZtDWbs/CDM40d7aJpMbVl5dOQfD1z5VRuXlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHLCVDf9A8Xs6BzNSUnPBRhd0n1/Mun4RLN1H1J7isfhhMEM1k88wumOzssm6EuwS
	 pbatLn9UcWXtFXTC3GzOXT8wRJpDK1ya17kymMX+YyCsnYmz4fhq+qFMKjoegRDxNE
	 cUn9CChV2qlw3euLrtAnDoSiIEDgH/fEUZjnCvzvNTi+aj7SUFYqO+7BEukwah65Sl
	 I60oPe53uZEex9QoJGllc6kTu//G4pK9PTQL5uwHy2DJIXWzMYIVVqja5tRnjefU1S
	 5TJxU9jwH2kS8inrovpDota1fXNzj/xW3Wm7oYlYLidsDRFJ4lw9TDPI6V/stbW7aW
	 3oeHuBz+wQo0Q==
Date: Sat, 29 Nov 2025 15:57:29 -0500
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: gregkh@linuxfoundation.org, jiayuan.chen@linux.dev,
	stable-commits@vger.kernel.org,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	jakub@cloudflare.com, martin.lau@kernel.org
Subject: Re: Patch "mptcp: Fix proto fallback detection with BPF" has been
 added to the 6.1-stable tree
Message-ID: <aSteOTB6pHeXuXiF@laps>
References: <2025112711-frigidly-unruly-4a72@gregkh>
 <9e6ef98f-12eb-4608-aece-cf321e0a38d7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9e6ef98f-12eb-4608-aece-cf321e0a38d7@kernel.org>

On Fri, Nov 28, 2025 at 06:03:38PM +0100, Matthieu Baerts wrote:
>Hi Greg, Sasha, Jiayuan,
>
>On 27/11/2025 14:41, gregkh@linuxfoundation.org wrote:
>>
>> This is a note to let you know that I've just added the patch titled
>>
>>     mptcp: Fix proto fallback detection with BPF
>>
>> to the 6.1-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      mptcp-fix-proto-fallback-detection-with-bpf.patch
>> and it can be found in the queue-6.1 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>@Sasha: thank you for having resolved the conflicts for this patch (and
>many others related to MPTCP recently). Sadly, it is causing troubles.
>
>@Greg/Sasha: is it possible to remove it from 6.1, 5.15 and 5.10 queues
>please?
>(The related patch in 6.6 and above is OK)

Dropped it from the older trees, thanks!

-- 
Thanks,
Sasha

