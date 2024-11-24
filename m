Return-Path: <stable+bounces-94695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B51D29D6DBA
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 11:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6837CB2101C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 10:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E671836D9;
	Sun, 24 Nov 2024 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="evH6d2ll"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED86BA38
	for <stable@vger.kernel.org>; Sun, 24 Nov 2024 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732445270; cv=none; b=SAlQstLT4v26ZmAZURgztAnz2NuTK16+/+k+Y0EwVEdUWdGCcmWNKvG7qe/ktyM/jkgZ71QHA0KZmMQSIbtR7rOMXrKp1dcKIS/biv10BGmqzP0EUR33WCbpXt7j8YRfl6cf4U/dK0MkHRJvOsN2opY1Z4tilOhnncyaP9CkG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732445270; c=relaxed/simple;
	bh=NKcvrgQblVhpCWvZpJql03YBkg3PZMqQ1bsWOZP46cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y2dQ+xf6MZqNclS9B9doWQPTX4vd4IV/HvqKMU5taB4qhZWTD8gPJiyAfKE87lO1O5MqHzXhLl2QF3eEszuAKpGqG5ID53fPvnnCB5Gp61NKZ5cZXssoKHpipvIMtwP1ysopgoDgO43JUkO/YPuHelfcPUXGwUMM13Z9Sij2kkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=evH6d2ll; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 76D11A037C;
	Sun, 24 Nov 2024 11:47:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=90GNKDec0+zVp9FDEDmd
	gu4rNvbDtjbCT/v8UZRI17I=; b=evH6d2llLG6+aSi8GoLgAeyz1uMmTJZmUcDB
	g9bUF3Oxb/0bIqRgtlV4XWAmNhty/qyJgyAf16R8YMTN1+xayKp4R4RIJ6wqbTOy
	omB4tan8/dEm4Tp6vRU1Hm6JH5+vGwt4DHF4vkAb6Xs87l8HPIgweStLNMr3zgeT
	3wMsGqPmS+E7v22QjfdCsnY6yXD2VYHWMWDzRQaRq8OkW5/WbN8CYhx5CwnStLxC
	Hs3YZZ6s/94yNqdXkfTb4Ek6T/SVMCtiXzdT2+IRCowuLmXypBj/SlpZcdCHy6hv
	sjoBJHNFMj6NQMyMcSemzJF7JaPACSpWljLh8VNGWPr9AP1y5d6CC0pbp5a0OXDs
	jXze449nSVHW7Rs58ithJpLhCh9rGzVKVt8t6dJYF6SP4MkWW5WMEblBEyUSsCSo
	9yBcv7+l7y4htCBoJ0dJrjLs2Aznge11+jEYWviQSFMfAR6Dp64/yrq9KNumwzkA
	C3jWWhVQF5lwr5ZxJFvJctL0+OPjdbFgGylRra101vxFyklbo1P9jfqUvoxoY42v
	zIJXxJnla2Y+elmoJLYoWwfHrXOANv6vQv7e6LMB6LM9hfjNSx+NCnTzXb6i8wWn
	hJxf1xSBEM0BQNSJgXGKyB3zjOH9+jbg1BWr09UQP7LW0dOils098zCRk/Wgw6xf
	lgkXNqM=
Message-ID: <fa9bdf83-cfbc-4d80-b4c3-dc04d2e89857@prolan.hu>
Date: Sun, 24 Nov 2024 11:47:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 1/3] net: fec: Move `fec_ptp_read()` to the top of the
 file
To: Sasha Levin <sashal@kernel.org>
CC: <stable@vger.kernel.org>
References: <20241122083920-54de22158a92c75d@stable.kernel.org>
 <30b031c5-b3f4-44e4-9217-c364651ab28e@prolan.hu> <Z0HoasOBIo1y_vjc@sashalap>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <Z0HoasOBIo1y_vjc@sashalap>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855607D67

On 2024. 11. 23. 15:36, Sasha Levin wrote:
> On Fri, Nov 22, 2024 at 02:56:40PM +0100, Csókás Bence wrote:
>> Hi,
>>
>> On 2024. 11. 22. 14:51, Sasha Levin wrote:
>>> [ Sasha's backport helper bot ]
>>>
>>> Hi,
>>>
>>> Found matching upstream commit: 4374a1fe580a14f6152752390c678d90311df247
>>>
>>> WARNING: Author mismatch between patch and found commit:
>>> Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= 
>>> <csokas.bence@prolan.hu>
>>> Commit author: Csókás, Bence <csokas.bence@prolan.hu>
>>>
>>>
>>> Status in newer kernel trees:
>>> 6.12.y | Present (exact SHA1)
>>> 6.11.y | Present (different SHA1: 97f35652e0e8)
>>> 6.6.y | Present (different SHA1: 1e1eb62c40e1)
>>
>> 1/3 and 2/3 of this series was already applied by Greg, only 3/3 was not.
>>
>> commit: bf8ca67e2167 ("net: fec: refactor PPS channel configuration")
> 
> Dare I ask why we need it to begin with? Commit message says:
> 
>      Preparation patch to allow for PPS channel configuration, no 
> functional
>      change intended.

We have patches that depend on it, that we need to maintain on top of 6.6.y.

Bence


