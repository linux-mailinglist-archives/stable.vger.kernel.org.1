Return-Path: <stable+bounces-12195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F4E831D1F
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 17:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603EC1F22756
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 16:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7551424B40;
	Thu, 18 Jan 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="hUEZ8kij"
X-Original-To: stable@vger.kernel.org
Received: from smtp70.ord1d.emailsrvr.com (smtp70.ord1d.emailsrvr.com [184.106.54.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06B228DC5
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593709; cv=none; b=dXrIb0a0JgnEcNgcs64rpV1vMDLv5OBP8u1HS23d5zSsjjKnznzfUes86KWtxAIGM686UCAUdVwSOSWbwlEEiJmwIH2UdbjnebZlRt9OIkGU28nPIMiS+JeTm0mpAXrjU92w3bCwuazK0kavmvfXo3KbziikZLkoDio5UOS4BBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593709; c=relaxed/simple;
	bh=781GUzTrZR4lCWVjwiN2ZImuwJhWCk5byAoPzKtiyGE=;
	h=DKIM-Signature:X-Auth-ID:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Classification-ID; b=udRe9bfeZ/73XC3nzvEBM+zv+C7n5fcdDD5q2yDT9uTJqTPCreq6eXGdOfiTsEN1+FSnxpskWVheXWc+NvVOohGL0FS6kqY7YDkumlsscoL3jTsw70a2lVXSJV2NB8YyGHsvFXgHV0NarW3NAHzmuQX9njzLUj09AvnaGzYHAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=hUEZ8kij; arc=none smtp.client-ip=184.106.54.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1705591432;
	bh=781GUzTrZR4lCWVjwiN2ZImuwJhWCk5byAoPzKtiyGE=;
	h=Date:Subject:To:From:From;
	b=hUEZ8kijvooAGFa9qlCf3BydtAWS9IJUIAITwfdqlgCIzth6uo/EOmFlkATt0BwHV
	 2xx+eWgYTXOlgNKTwYDGLem1K5S+YR/eF6j7U/vhFC2XKtHq/C++kSrFnA0XRieWW+
	 QJ+zHeMoIqMT2mRhme7YFioRx9u0RZDfW5bHqUN0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp17.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id BF753200A8;
	Thu, 18 Jan 2024 10:23:51 -0500 (EST)
Message-ID: <02c0b221-9d4e-43fd-9dc8-40827698e947@mev.co.uk>
Date: Thu, 18 Jan 2024 15:23:50 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: drivers: ni_tio: Fix arithmetic expression
 overflow
Content-Language: en-GB
To: David Laight <David.Laight@ACULAB.COM>,
 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
 Denis Arefev <arefev@swemel.ru>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240118123747.45795-1-arefev@swemel.ru>
 <2024011842-groggy-badly-393c@gregkh>
 <3f8d1a69e3434d2085aa3564357fa31d@AcuMS.aculab.com>
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <3f8d1a69e3434d2085aa3564357fa31d@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 89e0e230-a6d3-467b-8623-55334269d420-1-1

On 2024-01-18 14:37, David Laight wrote:
>> -----Original Message-----
>> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Sent: 18 January 2024 14:14
>> To: Denis Arefev <arefev@swemel.ru>
>> Cc: Ian Abbott <abbotti@mev.co.uk>; H Hartley Sweeten <hsweeten@visionengravers.com>; linux-
>> kernel@vger.kernel.org; lvc-project@linuxtesting.org; stable@vger.kernel.org
>> Subject: Re: [PATCH] comedi: drivers: ni_tio: Fix arithmetic expression overflow
>>
>> On Thu, Jan 18, 2024 at 03:37:47PM +0300, Denis Arefev wrote:
>>> The value of an arithmetic expression period_ns * 1000 is subject
>>> to overflow due to a failure to cast operands to a larger data
>>> type before performing arithmetic
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Fixes: 3e90b1c7ebe9 ("staging: comedi: ni_tio: tidy up ni_tio_set_clock_src() and helpers")
>>> Cc: <stable@vger.kernel.org> # v5.15+
>>> Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
>>> Signed-off-by: Denis Arefev <arefev@swemel.ru>
>>> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
>>> ---
>>>   drivers/comedi/drivers/ni_tio.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/comedi/drivers/ni_tio.c b/drivers/comedi/drivers/ni_tio.c
>>> index da6826d77e60..acc914903c70 100644
>>> --- a/drivers/comedi/drivers/ni_tio.c
>>> +++ b/drivers/comedi/drivers/ni_tio.c
>>> @@ -800,7 +800,7 @@ static int ni_tio_set_clock_src(struct ni_gpct *counter,
>>>   				GI_PRESCALE_X2(counter_dev->variant) |
>>>   				GI_PRESCALE_X8(counter_dev->variant), bits);
>>>   	}
>>> -	counter->clock_period_ps = period_ns * 1000;
>>> +	counter->clock_period_ps = period_ns * 1000UL;
> 
> What about 32bit systems...

Oh, good point.  It should be 1000ULL.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

