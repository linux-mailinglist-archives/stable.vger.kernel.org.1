Return-Path: <stable+bounces-196635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BB2C7F3F0
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 08:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C81454E0722
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 07:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488A325524D;
	Mon, 24 Nov 2025 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsfEYrb3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1246B250C06;
	Mon, 24 Nov 2025 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970540; cv=none; b=qfElWm+XhkNcZNw/VfWrh9M1CAoRwonk3QB047kNRthIkVnxMfKYfp+6QVC6qPkt0z8iDOi5TkjCgn5ee1+lC8l/K7Nj+0ZDWg6WE24x9KbeC4mMyw4ChjJazPZOFaysNuVXXRxum+HImIUYKqonssGsQPf0Kx5hEAhz07OK+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970540; c=relaxed/simple;
	bh=bzzm7j/CRQ1ov40yD32ZDvETPu8kudHNwNmuesLjRNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3Hq+xI5Jo77Lnm2ycJ5kN8Uxe6huYNNSjvnqef3yi3DNea/sYEtYIwmvlRMrfIFCAsGbIdVegrDS4saVC5JGRmmnX9HMiqellmiPMQXpwtY0AkwcjhsZH9oTk1n19kbkVVzmOHZtu70FrXnni+YIHzdI5DCx1R30588pMel76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsfEYrb3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763970538; x=1795506538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bzzm7j/CRQ1ov40yD32ZDvETPu8kudHNwNmuesLjRNU=;
  b=hsfEYrb3BarI6pZtqOzhgEe6Sdid3F4iS+GcvIgCSqCV89ps+rPE714v
   nGQ+/CxFKBQViR3nMr0GCarqkE2CZeogAOa7JLW/qZlXkM1LOqtRlS3bI
   TD4ggT6ODSm1gDVnPb7gEJQaY1ywJJWjIZUqSES1TNrFqsDPMisvEN+qC
   Z6rzowxbS4Jbe7zcbOUXzickxm4qU6EkaPTJKOHKT3yZwVK9zxo7yZ3hd
   KR16BKd9pgUEasIptmFan2C5npJBO9N30MtRE8fXScynQtvcr48iVY982
   AVSxwurSon1kZ2SjubQMM0V+fBU99idY96dgI97f2NDRIK/868lFg/5Ez
   w==;
X-CSE-ConnectionGUID: x8w3VHWFTayAuF3xnc9wIg==
X-CSE-MsgGUID: AHoGgQuBSn6CJtBNoJFlcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="65856865"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="65856865"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 23:48:57 -0800
X-CSE-ConnectionGUID: 4LuOnMcLSkWPQzpr105OLQ==
X-CSE-MsgGUID: P1FT6eC9S3ewkEnnCChpRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="196429677"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.234]) ([10.245.245.234])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 23:48:55 -0800
Message-ID: <6171754f-1b84-47e0-a4da-0d045ea7546e@linux.intel.com>
Date: Mon, 24 Nov 2025 09:48:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xhci: dbgtty: fix device unregister
To: Jiri Slaby <jirislaby@kernel.org>, =?UTF-8?Q?=C5=81ukasz_Bartosik?=
 <ukaszb@chromium.org>, Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org
References: <20251119212910.1245694-1-ukaszb@google.com>
 <2f05eedd-f152-4a4a-bf6c-09ca1ab7da40@kernel.org>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <2f05eedd-f152-4a4a-bf6c-09ca1ab7da40@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/24/25 08:42, Jiri Slaby wrote:
> Hmm, CCing TTY MAINTAINERS entry would not hurt.
> 
> On 19. 11. 25, 22:29, Łukasz Bartosik wrote:
>> From: Łukasz Bartosik <ukaszb@chromium.org>
>>
>> When DbC is disconnected then xhci_dbc_tty_unregister_device()
>> is called. However if there is any user space process blocked
>> on write to DbC terminal device then it will never be signalled
>> and thus stay blocked indifinitely.
> 
> indefinitely
> 
>> This fix adds a tty_vhangup() call in xhci_dbc_tty_unregister_device().
>> The tty_vhangup() wakes up any blocked writers and causes subsequent
>> write attempts to DbC terminal device to fail.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
>> Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
>> ---
>> Changes in v2:
>> - Replaced tty_hangup() with tty_vhangup()
> 
> Why exactly?

I recommended using tty_vhangup(), well actually tty_port_tty_vhangup() to solve
issue '2' you pointed out.
To me it looks like tty_vhangup() is synchronous so it won't schedule hangup work
and should be safe to call right before we destroy the port.

> 
>> --- a/drivers/usb/host/xhci-dbgtty.c
>> +++ b/drivers/usb/host/xhci-dbgtty.c
>> @@ -535,6 +535,12 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
>>       if (!port->registered)
>>           return;
>> +    /*
>> +     * Hang up the TTY. This wakes up any blocked
>> +     * writers and causes subsequent writes to fail.
>> +     */
>> +    tty_vhangup(port->port.tty);
> 
> This is wrong IMO:
> 1) what if there is no tty currently open? Ie. tty is NULL.

v1 had the NULL check, I stated that tty_port_tty_vhangup() does the check for us
so no need for it here.

https://lore.kernel.org/linux-usb/d25feb0d-2ede-4722-a499-095139870c96@linux.intel.com/

looks like v2 removed the check but used tty_vhangup() instead of
tty_port_tty_vhangup()

> 2) you schedule a tty hangup work and destroy the port right after:
>>       tty_unregister_device(dbc_tty_driver, port->minor);
>>       xhci_dbc_tty_exit_port(port);
>>       port->registered = false;
> You should to elaborate how this is supposed to work?

Does tty_port_tty_vhangup() work here? it
1. checks if tty is NULL
2. is synchronous and should be safe to call before tty_unregister_device()

tty internals are still a bit of mystery to me

Thanks
Mathias


