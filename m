Return-Path: <stable+bounces-164924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34650B13A43
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E53189BC1F
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3616D262FFF;
	Mon, 28 Jul 2025 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="VKBXSBzY"
X-Original-To: stable@vger.kernel.org
Received: from smtp78.iad3a.emailsrvr.com (smtp78.iad3a.emailsrvr.com [173.203.187.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598E0262FF5
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753704808; cv=none; b=Zv2XwpbUDwqcoJDQtPgLncOgoHm7w2NXKxA7CKrVIFFhV1Jgy9CBypugzH+H2kykdljQlg/NjAvW4V4KM6j/6bR988FVeuazqvBeLx5fhzw+S60JwZ7zKqdRPxSRWSKq/noccVfHTZY/6nqYrbdS5jG9rDJn6xd/akOWJmPlP8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753704808; c=relaxed/simple;
	bh=ZNcLB43ecNQ451Cu3SWF0vnF0bAwcBPnAtSLJpPB3vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ao1aWqAcPB4I64kj+nvtuZIe0AwqJI5zej73TXw7TgFHHFuwbF7C7nDf5GoiRKeIO0qChBimyyG/ls5WVJ2bx9jtRXd6cRVN8Rrl8j6szg31+TakvHL6cERUV6JEcw1DcbNZPGoykxbDGXJeBFuzb0izZlmHDeoOLtFPnRAY/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=VKBXSBzY; arc=none smtp.client-ip=173.203.187.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753704799;
	bh=ZNcLB43ecNQ451Cu3SWF0vnF0bAwcBPnAtSLJpPB3vk=;
	h=Date:Subject:To:From:From;
	b=VKBXSBzY9j9T/ww1tYofJMoFGtwBOUNrZlFqU0gqq/weC8c27iEkB7ehQl/aQqnDF
	 wynJ5F/hi6ehcfcSwRGWiOTtaX9h7HqFDPjGOU5m7Ncxi3yvyKTZA4wJZoqu8Wl51e
	 vv5YV1g3dHP7aK2MncYUiZt/XO1TEThk5TuINZt0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp2.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id D8A5F282A;
	Mon, 28 Jul 2025 08:13:18 -0400 (EDT)
Message-ID: <18b32659-8d7c-4b39-8fc9-8d83f46f02e2@mev.co.uk>
Date: Mon, 28 Jul 2025 13:13:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4.y] comedi: Fail COMEDI_INSNLIST ioctl if n_insns is
 too large
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <1753465192-da4c3231@stable.kernel.org>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <1753465192-da4c3231@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Classification-ID: 81567772-9193-4ea6-b970-7582e9014cc1-1-1

On 26/07/2025 00:26, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ❌ Build failures detected
> 
> The upstream commit SHA1 provided is correct: 08ae4b20f5e82101d77326ecab9089e110f224cc
> 
> Status in newer kernel trees:
> 6.15.y | Not found
> 6.12.y | Not found
> 6.6.y | Not found
> 6.1.y | Not found
> 5.15.y | Not found
> 5.10.y | Not found
> 
> Note: The patch differs from the upstream commit:
> ---
> 1:  08ae4b20f5e8 < -:  ------------ comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
> -:  ------------ > 1:  480e150b6535 comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
> 
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | origin/linux-5.4.y        | Success     | Failed     |
> 
> Build Errors:
> origin/linux-5.4.y:
>      Build error: Building current HEAD with log output
>      Build x86: exited with code 2
>      Cleaning up worktrees...
>      Cleaning up worktrees...
>      Cleaning up worktrees...
>      Cleaning up worktrees...
> 

Sorry about that. I was building a list of patches at the same time and 
applied a fixup to the wrong one.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

