Return-Path: <stable+bounces-196661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD474C7F7C7
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 10:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A39C84E3C61
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124242F4A00;
	Mon, 24 Nov 2025 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVkteaxM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A923184A;
	Mon, 24 Nov 2025 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975467; cv=none; b=K3iqrTEgVOp82+NqSrQLQTzlEZYK13eiDpDXGkmzQM1ky0gqvE9O8r8Szusv5+bBi4d0Hf+VxyivnSE2CDnl7Be9E7TovbyP30NeGzAqpbep6HIkEIziJkM78O96i4MNSvS5Z/bbfPCfbtHW//F3y60L6C/uTJbQvasS9lPYAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975467; c=relaxed/simple;
	bh=h3g4JxPmkSuzn4A+hRY+XWm3wVyIpSZX3Sy+tuWzeq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gS6iT77BlJ/KtOTcXxFP7Unx8ucoSUxmLOX6aaygSXwWTnKGgCm58rGEY/FO3R2EjNuK3EWyIbMeFtSNczhW2cfeNunIfonhsJQ+e4EskGG92mTDm+h8piwk3GL/ax24fUAQ5nSbd1bR3w2XkgqT7lCWAFBI4j66XsRPwlZKo1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVkteaxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1531FC4CEF1;
	Mon, 24 Nov 2025 09:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975467;
	bh=h3g4JxPmkSuzn4A+hRY+XWm3wVyIpSZX3Sy+tuWzeq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LVkteaxMddX1M3aC0bEsLu2/1lTKkED0KlkuA1s2zE6iuTreTG8vZt0FBYp0N2k/V
	 5Vj54xI6VQFpZ9u9voQPuctK9Ao+GrKD/+4O+c0ObWLrGZ0NhirnhOGqHujK4i8VOT
	 aRtG7cGdzl4bCnl0kDA65ePANeMZJt4gL2VhpCjvtFsEOMRMv3/7lfzi7ZKB8FJHFh
	 NFFCMPxr+amRLOchiWuNBT1Ykl1gZ/h8t7u22XR47X/mGudytA68lN0HEfEgp1+L+2
	 y6m5A/Oq2RmtPK9iZdrd+w+F7SdOtMeLV4zVTNwnlYQLmZXckTJV8t7e1WsbBlTkX3
	 CGSNnxT+iVuDA==
Message-ID: <e7ebc1da-1a94-4465-bc79-de9ad8ba1cb6@kernel.org>
Date: Mon, 24 Nov 2025 10:11:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xhci: dbgtty: fix device unregister
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
 =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org
References: <20251119212910.1245694-1-ukaszb@google.com>
 <2f05eedd-f152-4a4a-bf6c-09ca1ab7da40@kernel.org>
 <6171754f-1b84-47e0-a4da-0d045ea7546e@linux.intel.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <6171754f-1b84-47e0-a4da-0d045ea7546e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24. 11. 25, 8:48, Mathias Nyman wrote:
> On 11/24/25 08:42, Jiri Slaby wrote:
>> Hmm, CCing TTY MAINTAINERS entry would not hurt.
>>
>> On 19. 11. 25, 22:29, Łukasz Bartosik wrote:
>>> From: Łukasz Bartosik <ukaszb@chromium.org>
>>>
>>> When DbC is disconnected then xhci_dbc_tty_unregister_device()
>>> is called. However if there is any user space process blocked
>>> on write to DbC terminal device then it will never be signalled
>>> and thus stay blocked indifinitely.
>>
>> indefinitely
>>
>>> This fix adds a tty_vhangup() call in xhci_dbc_tty_unregister_device().
>>> The tty_vhangup() wakes up any blocked writers and causes subsequent
>>> write attempts to DbC terminal device to fail.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
>>> Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
>>> ---
>>> Changes in v2:
>>> - Replaced tty_hangup() with tty_vhangup()
>>
>> Why exactly?
> 
> I recommended using tty_vhangup(), well actually tty_port_tty_vhangup() 
> to solve
> issue '2' you pointed out.
> To me it looks like tty_vhangup() is synchronous so it won't schedule 
> hangup work
> and should be safe to call right before we destroy the port.

Oops, right, my cscope DB was old and lead me to tty_hangup() instead 
(that schedules).

>> 2) you schedule a tty hangup work and destroy the port right after:
>>>       tty_unregister_device(dbc_tty_driver, port->minor);
>>>       xhci_dbc_tty_exit_port(port);
>>>       port->registered = false;
>> You should to elaborate how this is supposed to work?
> 
> Does tty_port_tty_vhangup() work here? it
> 1. checks if tty is NULL
> 2. is synchronous and should be safe to call before tty_unregister_device()

Yes, this works for me.

thanks,
-- 
js
suse labs

