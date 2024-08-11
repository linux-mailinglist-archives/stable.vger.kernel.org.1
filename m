Return-Path: <stable+bounces-66365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E868794E1C1
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 17:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9111B2813E9
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 15:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B33214A4DC;
	Sun, 11 Aug 2024 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=holm.dev header.i=@holm.dev header.b="MC1Zo6U1"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1DFB64E
	for <stable@vger.kernel.org>; Sun, 11 Aug 2024 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723388776; cv=none; b=CAb4TAeZa39CwfnVnHhq56X9CrczMNuP0KzNYnplQ7fXNaE/EcIPdriBJUJoA6gSJtQl5N5PmNzg94KuDcKKFiLzutCy48S9KHQlU/uPor2xPynzL+ZGXV2PQR8EaNNQS853PvwtEUSEwMy8zUjPGLPlDSwAAPlgE7q8epfmHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723388776; c=relaxed/simple;
	bh=nTDus+CUuN/IzDJPi1CLwtMKPNcdqehB37J69lNznQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8dTkOcytq75Cwx88wrifYJK9u0K6bJ5WEONWRTkBtBlKV3KqbU+cf4eBsjMoZO4TFiGWS6k2q12XjeuKxAtbQ+RPjiLGBQjWZuqiknN8kB3UY3PuFN2RiTQT/8CJLMhoJmznnwjXqHkE52km7zjrvDtCok6pmrJOtEjgiirzgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=holm.dev; spf=pass smtp.mailfrom=holm.dev; dkim=pass (2048-bit key) header.d=holm.dev header.i=@holm.dev header.b=MC1Zo6U1; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=holm.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holm.dev
Message-ID: <f9528a9e-7d25-4f56-8117-463bb0306ba1@holm.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=holm.dev; s=key1;
	t=1723388769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfE5UGXfZ6DfqfciykKLXYsSsTb4vbpzZ/jcUdeRuiw=;
	b=MC1Zo6U1nLBzzaY58aoCx3LEDtJKDTcsMxV/5nyqlW0i2WtOYv2gRNW83Owax0B1dLJ8P9
	KSGOJVuH+TBhCmibTin3mkQScC24FGNoQ2+k/GlWpAB9kE38byWVlfu12o/AjGNlRUAqhq
	1sHk7Xk9v8FrHlihmEv1F5L/uvRCydN7MWhnQkLhb67tTQ2mKMaPM1xLiLsGRrLXYocSrt
	TEj1L6krGBRv57/d2uezK+w1UzUwVkNXCWXMK4vZxGx5Ag/jMGNwdvHSgBYNlz0UM/R5RP
	3nXMoe7YVmrrPgk2pd4PbXbkFT0DRoub/v7bwE4sZnvn39ZVH5OgvYUfyc83Bw==
Date: Sun, 11 Aug 2024 17:06:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.10 001/123] mm/huge_memory: mark racy access
 onhuge_anon_orders_always
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <20240807150020.790615758@linuxfoundation.org>
 <20240807150020.834416694@linuxfoundation.org>
 <27a85289-1fe4-4131-b5d6-6608ef699632@holm.dev>
 <2024081124-clothes-dazzling-c257@gregkh>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kevin Holm <kevin@holm.dev>
Content-Language: en-US
In-Reply-To: <2024081124-clothes-dazzling-c257@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11.08.24 12:56, Greg Kroah-Hartman wrote:
> On Wed, Aug 07, 2024 at 05:06:54PM +0200, Kevin Holm wrote:
>> On 8/7/24 16:58, Greg Kroah-Hartman wrote:
>>> 6.10-stable review patch.  If anyone has any objections, please let me know.
>> Did the back port [1] I submit just get missed? It fixes a regression I
>> reported [2] with high resolution displays on a dp link after a hub in the
>> amdgpu driver.
>>
>> [1] https://lore.kernel.org/stable/20240730185339.543359-1-kevin@holm.dev/
>> [2] https://lore.kernel.org/stable/d74a7768e957e6ce88c27a5bece0c64dff132e24@holm.dev/T/#u
> 
> It's in the queue to apply, and has nothing to do with this specific
> commit oddly...  I'll get to it this week, hopefully.
Yes, sorry about that, I only noticed after sending this message that I 
didn't reply to the initial message, but to an individual patch.
> 
> thanks,
> 
> greg k-h

And sorry again for causing you more work having to respond to my 
additional emails.

Thanks for your amazing work!

~kevin


