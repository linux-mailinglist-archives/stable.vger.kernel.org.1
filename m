Return-Path: <stable+bounces-110897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73231A1DCB6
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 20:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C668F3A1EC8
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 19:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0289A190685;
	Mon, 27 Jan 2025 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="q+DrTscQ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FA117B50A
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738005920; cv=none; b=NvQrVp5gmAlT7Qdl2LIpZP7NyUHzn4gAvDiUuBKPpKetuIuAeYDD0cNGUhOyvxSNY2LiJLi0szfzra1Zvco04hNPRJ/FTzAr5SPICkEiohMfe/v0b2ShQO9nZljUB57F0qFsofmjlvpMwst+dCx3m1hz8ZyTv782fWzT8+08n2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738005920; c=relaxed/simple;
	bh=nIY/E7PR6zJCCzcySPENn91dQ+tXsRO5a+VwTfXsLbA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U2fmNJtcX1sH9ExM7h8y+l7twhDsNurGO1sm/4GH70+7ikquxKSU+2gvngV6CQmulN4shR4IlCkxx9Uw8TM2EiA7SLl5sgvYOya5SfdPGXvh1ZTdOhb1MAumurbzO0e/HeHXYaU8PkY1MAZueb2JqJqNvYu7wil4/BguHG3y3ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=q+DrTscQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-73-59-8-18.hsd1.wa.comcast.net [73.59.8.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 437382037161;
	Mon, 27 Jan 2025 11:25:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 437382037161
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738005918;
	bh=GH9GKL/4SckqtQ5TRyF+iLq1IzOr7zOqzFgZdaS0rvY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=q+DrTscQ9OYeiWNCDKOxRG1E2Vlk5rWXug140I4BNP62zfHneC1OYR4VgCHzrjQwO
	 jcriap7+fFA5XV+/xfgJZmrolHglZ9FlgKP+3cBoUrKvPukB4bGjwanzI0E9rWB/Vh
	 yl43D+euwJGjFRPdJWQpjJvRS/BvlmfUv1B0LRyU=
Message-ID: <2d31d777-6732-4075-aedc-a832c9713bdb@linux.microsoft.com>
Date: Mon, 27 Jan 2025 11:25:17 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Michael Kelley <mhklinux@outlook.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 6.6.y] scsi: storvsc: Ratelimit warning logs to prevent VM
 denial of service
To: stable@vger.kernel.org
References: <20250127182908.66971-1-eahariha@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250127182908.66971-1-eahariha@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/2025 10:29 AM, Easwar Hariharan wrote:
> commit d2138eab8cde61e0e6f62d0713e45202e8457d6d upstream
> 
> If there's a persistent error in the hypervisor, the SCSI warning for
> failed I/O can flood the kernel log and max out CPU utilization,
> preventing troubleshooting from the VM side. Ratelimit the warning so
> it doesn't DoS the VM.
> 
> Closes: https://github.com/microsoft/WSL/issues/9173
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

I just remembered that we should wait for Linus to tag the rc before
sending backports, so apologies for sending this (and its 6.1 and 6.12
friends) out before rc1 was tagged.

- Easwar (he/him)



