Return-Path: <stable+bounces-148308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DAEAC91C3
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 16:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1854A3E3E
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068C01891AB;
	Fri, 30 May 2025 14:45:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18467166F1A
	for <stable@vger.kernel.org>; Fri, 30 May 2025 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616322; cv=none; b=mq54sKqSvH0uNP62Bba4jfycKpnwj4cq99cRtaLml8rSl/JR29WBVpY22VPIAu2jtOA7qWI3JSpgiV2DzDhrSdVAyYLPCTQ5ZFF3ihOXT69F4bYWqwKz72H+5kU8wZY5EYGE+PBNVgkOsw5GsAK2qvlfFuEeTyHpxvVAHUnRbDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616322; c=relaxed/simple;
	bh=DvUL8n06MN2k85u0+bgKnP3Sl7mp+YGvZ/Kcrz3+cjE=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:Cc:In-Reply-To; b=hxOfQXim10PO0i7wFiVHCOKBP8H76GqJ0RflpfXaIT/dqM9HjU2CoGsvPpN0pBgD6RZ34G+D4lcsZnl/ScKuVuaq4DBzG299rGsSF+sPb4awnoktKrwXjG/gEZ+2NfYqZEwTc+boebqS7DBjBdGEDKkfMcrL/rBx50I3zsWh59s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glks-stable4@m.gmane-mx.org>)
	id 1uL0z1-0003pm-1X
	for stable@vger.kernel.org; Fri, 30 May 2025 16:45:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: stable@vger.kernel.org
From: =?UTF-8?Q?J=C3=B6rg-Volker_Peetz?= <jvpeetz@web.de>
Subject: Re: [PATCH 6.14 645/783] HID: Kconfig: Add LEDS_CLASS_MULTICOLOR
 dependency to HID_LOGITECH
Date: Fri, 30 May 2025 16:45:13 +0200
Message-ID: <f2e2eb44-ea55-46ef-83b4-207b5906f887@web.de>
References: <20250527162513.035720581@linuxfoundation.org>
 <20250527162539.405868106@linuxfoundation.org>
 <27b9765e-c757-41c7-9cbe-fe1c915fdf2b@web.de>
 <2025053022-crudeness-coasting-4a35@gregkh>
 <2025053000-theatrics-sleep-5c2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla Thunderbird
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 kernel test robot <lkp@intel.com>, Kate Hsuan <hpa@redhat.com>,
 Jiri Kosina <jkosina@suse.com>, Sasha Levin <sashal@kernel.org>
Content-Language: en-US
In-Reply-To: <2025053000-theatrics-sleep-5c2e@gregkh>

Thanks for looking into this.
I should have asked more specific:

Greg Kroah-Hartman wrote on 30/05/2025 16:09:
> On Fri, May 30, 2025 at 04:08:40PM +0200, Greg Kroah-Hartman wrote:
>> On Fri, May 30, 2025 at 03:44:22PM +0200, Jörg-Volker Peetz wrote:
>>> With 6.14.9 (maybe patch "HID: Kconfig: Add LEDS_CLASS_MULTICOLOR dependency
>>> to HID_LOGITECH") something with the configuration of "Special HID drivers"
>>> for "Logitech devices" goes wrong:
>>>
>>> using the attached kernel config from 6.14.8 an doing a `make oldconfig` all
>>> configuration for Logitech devices is removed from the new `.config`. Also,
>>> in `make nconfig` the entry "Logitech devices" vanished from `Device Drivers
>>> -> HID bus support -> Special HID drivers`.
>>
>> Did you enable LEDS_CLASS and LEDS_CLASS_MULTICOLOR?
> 
> To answer my own question, based on the .config file, no:
> 	# CONFIG_LEDS_CLASS_MULTICOLOR is not set
> 
> Try changing that.

Yes, enabling these makes the "Logitech devices" entry appear again.

My concern is more about the selection logic. The "Logitech devices" entry 
should not vanish.
How would one know that "LEDS_CLASS_MULTICOLOR" is required to configure 
Logitech devices, e.g., a wireless keyboard?
I think, it should be possible to select a Logitech device which in turn 
automatically selects LEDS_CLASS_MULTICOLOR.

Regards,
Jörg.
> 
> thanks,
> 
> greg k-h
> 
> 



