Return-Path: <stable+bounces-176483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCB4B37EE6
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB457C7CF7
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4E23469FD;
	Wed, 27 Aug 2025 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YphDKQo9"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA9F34574F
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287279; cv=none; b=s+/pLh7NghANe/AWBU5JyfwedkmDYy8NVrSpTyl0FZlThfYjooT8Z02IauWXocGohNQSPuPilXSE/eFyUrcs1lSfyt53R8+f10/4UxCGwF035wyROrwomU6J+xSVk5BjgwDgf9lLKjhA5rwTU/uPjEFNEJqmOtsVFtkxs05sdP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287279; c=relaxed/simple;
	bh=u3J1TLK8kFDzptK8CWJHRZ8TxdCzowQEdeLZwKHMyWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tp56E+vzSgz0TeE7C/wIIEpRAkargDyEzO3tZyYAKbgCoqtgVEUal4YrhClC0XFBcRMA0oQ/xVqixon9bZoxdpzCeC9YZPRG9Tj+8oDlSZ7EOTREJWlNVAzT7i7txndPr+OtQTej0S1beAi9pqEQea/S0aYYgtZpW7lAyrOw2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YphDKQo9; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c7e8123c-7acb-4444-ae0d-83cdee0bfb85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756287274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHxIfUpE71HXlOhxuSB1LXolrmZAklp/1sSXRGfAxs8=;
	b=YphDKQo9vCDeGhDRYD0GfF/B/C53iCFBEDOpfrBELN3ImEt8O+0ZvHe4qV5lv7eCsDG0gd
	/+vTKsQbBIHiOmwEVkufV0jvEaDESsiwX6Qr4RcJn1/9uB1yVMKm8p3yDKigrz7dY6/w5u
	Go4vMMWho4sd7irm+TPoiNx1/iWbPzI=
Date: Wed, 27 Aug 2025 17:34:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Content-Language: en-US
To: Finn Thain <fthain@linux-m68k.org>
Cc: David Laight <david.laight.linux@gmail.com>, akpm@linux-foundation.org,
 geert@linux-m68k.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
 oak@helsinkinet.fi, peterz@infradead.org, stable@vger.kernel.org,
 will@kernel.org, Lance Yang <ioworker0@gmail.com>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <20250825032743.80641-1-ioworker0@gmail.com>
 <c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org>
 <96ae7afc-c882-4c3d-9dea-3e2ae2789caf@linux.dev>
 <5a44c60b-650a-1f8a-d5cb-abf9f0716817@linux-m68k.org>
 <4e7e7292-338d-4a57-84ec-ae7427f6ad7c@linux.dev>
 <20250825130715.3a1141ed@pumpkin>
 <b199a90c-4a7f-42bf-9d17-d96f63bb5e62@linux.dev>
 <312ba353-6b4e-c3ef-40ce-a9dddf3275a3@linux-m68k.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <312ba353-6b4e-c3ef-40ce-a9dddf3275a3@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/27 16:00, Finn Thain wrote:
> 
> On Mon, 25 Aug 2025, Lance Yang wrote:
> 
>>>
>>> More problematic is that, IIRC, m68k kmalloc() allocates 16bit aligned
>>> memory. This has broken other things in the past. I doubt that
>>> increasing the alignment to 32bits would make much difference to the
>>> kernel memory footprint.
>>
>> @Finn Given this new information, how about we just apply the runtime
>> check fix for now?
> 
> New information? No, that's just hear-say.

Emm... I jumped the gun there ;p

> 
>> Since we plan to remove the entire pointer-encoding scheme later anyway,
>> a minimal and targeted change could be the logical choice. It's easy and
>> safe to backport, and it cleanly stops the warnings from all sources
>> without introducing new risks - exactly what we need for stable kernels.
>>
> 
> Well, that's up to you, of course. If you want my comment, I'd only ask
> whether or not the bug is theoretical (outside of m68k).

Well, let's apply both this fix and the runtime check fix[1] as Masami
suggested ;)

[1] https://lore.kernel.org/lkml/20250823050036.7748-1-lance.yang@linux.dev/

