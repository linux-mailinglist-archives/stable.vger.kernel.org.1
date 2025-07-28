Return-Path: <stable+bounces-164925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31C1B13A64
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1738616A6EA
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0B0263F36;
	Mon, 28 Jul 2025 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="yoqQc8p4"
X-Original-To: stable@vger.kernel.org
Received: from smtp112.iad3a.emailsrvr.com (smtp112.iad3a.emailsrvr.com [173.203.187.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090B4263F34
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753705309; cv=none; b=KkeWabAydTlIrHFZxX0qdHm3FQUYgUZTKy1KFIAUXMlMufJDv/N09ejairIFPQWl1wZbm/UqAPfmxS94HU/zGTAKvzTJQgfEXWkhN26STFVw7V4YtS1xnoxKVS+U1ENJNtcK6XkNEEo3a1bZzq0KetI3FRrAgVNO/Hd4PPBeUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753705309; c=relaxed/simple;
	bh=Jvuyxdj/z6Pf7YayYWn8CQHH8Khfy1+IOwbMy/KMtrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UusYSF/6Up23HLlXVd1WCtmofgOKXQR6+uYsrxCC9RK37umasAIZ+2m1WDORv4hkJTpQM1WSbtADHdYV7IDM3SEcKV8xfAGKGiVcWlrs3bLG1WxHkPxdoq+fMAIRSO6ZvkQOyfImbMuB5aHETWu9K5XKxTPnCr7repC6H773t18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=yoqQc8p4; arc=none smtp.client-ip=173.203.187.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753704778;
	bh=Jvuyxdj/z6Pf7YayYWn8CQHH8Khfy1+IOwbMy/KMtrI=;
	h=Date:Subject:To:From:From;
	b=yoqQc8p4FlAkHTfVPf1ny6hNJARKPo7KbidhUl0rg+GkCF2WKK1MxQmWUqWB/pw7u
	 TQcSVquZW+F4RIP9kXMNqI8K7tUpUhXXGSAOaJIQeK8OPDNJohKDJ+bBtcOzYzBr7X
	 jsHX1Tokg/cE8KHxh8Xy/rpOrDkIy7+F4c65Jso0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp39.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id B989557B3;
	Mon, 28 Jul 2025 08:12:57 -0400 (EDT)
Message-ID: <b8236e67-1be4-4e13-b1a9-8a36c854d9b2@mev.co.uk>
Date: Mon, 28 Jul 2025 13:12:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4.y] comedi: Fix initialization of data for instructions
 that write to subdevice
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <1753468023-5d115273@stable.kernel.org>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <1753468023-5d115273@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Classification-ID: 4c204c42-b1d2-40b4-80ae-a6d6d0f9b8bc-1-1

On 26/07/2025 00:24, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ❌ Patch application failures detected
> 
> The upstream commit SHA1 provided is correct: 46d8c744136ce2454aa4c35c138cc06817f92b8e
> 
> Status in newer kernel trees:
> 6.15.y | Not found
> 6.12.y | Not found
> 6.6.y | Not found
> 6.1.y | Not found
> 5.15.y | Not found
> 5.10.y | Not found
> 
> Note: Could not generate a diff with upstream commit:
> ---
> Note: Could not generate diff - patch failed to apply for comparison
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | origin/linux-5.4.y        | Failed      | N/A        |

Sorry about that. I was building a list of patches at the same time and 
applied a fixup to the wrong one.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

