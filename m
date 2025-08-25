Return-Path: <stable+bounces-172776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8B8B334FC
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 06:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DE818999BD
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 04:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E96B23C4FF;
	Mon, 25 Aug 2025 04:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="edNJNcl8"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87AF23CEF9
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 04:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756095758; cv=none; b=JKV5OM0vFzyM6o5ysj8Q8ph7lJsjnyg7CeD3DVMquGXWVMeWDWtEbVe4YvJB5jVooLJodJ0hBCpQEPLF/Hubq/eX1oSw0DoKwZuXPDLmkMaR4Up+gKSAQSqbnmJV+OwlYojkYUCqM7JSohPVAwKCqGIRwv3lftLVBgbDFprQsrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756095758; c=relaxed/simple;
	bh=90Ay3FzxdBxExIalj/Phg9rRIHq7K/ARzxTWgb9H8sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQOZ2qHyPL6e82lXve7ebbgIqgnB5xCcOoxKoCtpE2JNoULj/6Nw6835eUSwDQ3pTfU1g+7ivuf1kGqXGmw/9STew9J37zp5kZouS351pNIgOWptfINui4/aCx8Fpm5bSYi16sjoRAIm8w9bIFF1jPXG1PsBiJJK4sD2Wgeag7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=edNJNcl8; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b2f04105-da42-415d-a56a-8934c179d70c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756095741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfYZfOGDePFr773UW7HBaaSZxuqXtatsYFGe83KXVy0=;
	b=edNJNcl8V3uw7x6AdxceiD4Gx8J9UKHZ8NgVFDpyfd7WpEr2UIramy+4hUUr4OgQ3qn8zU
	elxZ1ck+SzrFGSVF7x6yA5srrldLXL0VKwSnDFMzTBE/w1rCB9CaARsvVW1y4OXP3yRMtm
	vxtAUCRrznlkgb/4VOi1RbtzjYUTDD0=
Date: Mon, 25 Aug 2025 12:22:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Content-Language: en-US
To: Finn Thain <fthain@linux-m68k.org>
Cc: akpm@linux-foundation.org, geert@linux-m68k.org,
 linux-kernel@vger.kernel.org, mhiramat@kernel.org, oak@helsinkinet.fi,
 peterz@infradead.org, stable@vger.kernel.org, will@kernel.org,
 Lance Yang <ioworker0@gmail.com>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <20250825032743.80641-1-ioworker0@gmail.com>
 <8ca84cf3-4e9c-6bb7-af3c-5ead372e8025@linux-m68k.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <8ca84cf3-4e9c-6bb7-af3c-5ead372e8025@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/25 11:59, Finn Thain wrote:
> 
> On Mon, 25 Aug 2025, Lance Yang wrote:
> 
>>
>> However, as we've seen from the kernel test robot's report on
>> mt6660_chip, this won't solve the cases where a lock is forced to be
>> unaligned by #pragma pack(1). That will still trigger warnings, IIUC.
>>
> 
> I think you've misunderstood the warning that your patch produced. (BTW, I
> have not seen any warnings from my own patch, so far.)
> 
> The mistake you made in your patch was to add an alignment attribute to a
> member of a packed struct. That's why I suggested that you should align
> the lock instead.

Apologies for the confusion. I was referring to the runtime warning from
WARN_ON_ONCE, not a compile-time warning.

