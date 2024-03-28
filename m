Return-Path: <stable+bounces-33052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA7988F869
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 08:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4191C2784C
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 07:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC15150276;
	Thu, 28 Mar 2024 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbnGkadD"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF283FB91
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609824; cv=none; b=UasdKyYSRBkB76DsDTVljHAyNlYVTrKTixpAWdSPP81VU5JYXolIbW+y+07WyoCkhn6hFn0EWhsPBFWdRaHeOkxmbesis53BiNjc4c37cXDzE3eUXB7nr9Py7AZ/olPmGyijb8k0J82DhtfYp7/tFVGdrYVCkt6zs6FRi3ZGkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609824; c=relaxed/simple;
	bh=eN0KMcovaLCDs7JFkx12oRSDUob9Ec9Yosaai64YV6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9AU1PLJ2XpvQjP8F+GUKy0JH8B05jBt0KPaKLN7HqlHMRUJv1zgwhWG8kF7cQiIWMgbjJ+XJNN0PKBVbj/ZQXGfo2NQFaX3uBDypJcNDn2/I1XnPyW2baXa8KCkPp615tbQtuMlLV07wb3rAzWEM4EjbFH7fes2+4xmM7r6Vok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbnGkadD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711609822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lgSimI4hav25dhLThjxtJ7D/H/iql96JVoMamhWdgA=;
	b=LbnGkadDesPpTyvxeSTkgSqQlJBYUVnel1C7kzhLyv88wat5l4qudDOCx5kq3PEhcpT+xS
	Q77rV5Gh2fkdaMIWwvI5ypzey7jpcUfuBUSPVtJ+zKttbPfhTZGKfjpJN3ujDeHlY5L25T
	hdKvXKN/w4amK2wlAb5TTnuBhAlwkNg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-4s9UB7xdP_ept4aSj-mHZg-1; Thu, 28 Mar 2024 03:10:20 -0400
X-MC-Unique: 4s9UB7xdP_ept4aSj-mHZg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5685d83ec51so268979a12.3
        for <stable@vger.kernel.org>; Thu, 28 Mar 2024 00:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711609819; x=1712214619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lgSimI4hav25dhLThjxtJ7D/H/iql96JVoMamhWdgA=;
        b=DWVD4N4vEOtXMNAnqF7JNvGVACYIkM0CumDFmNulYYip4AfPRuTIXQ8O5TD8jAOFhl
         W3pShWdRb2W6DRJLVtpd+Fns9o1Eynn3lLEKsl6DyL/f8jYotPNRG2NiMbJXZ26BTBeN
         XvwZ+Q0WLfiZyq+mZTd15a6lX6PIBj7Qk/ewHzIGvvVeKMPte+Md1R/KU+SEEYM/WHXi
         rBvOkK4ZCL9/+1CaSX7jAM4q5duXwlpWlWCLY/hu3S38YkAiCeROTcuF/sTWjwPFfha2
         QV2j/ZJ7i+Nn/2ZiCNNd2qgzP/n3tis8U9mB1+5Q0mp2NVHtbF40ahFT/21T0FpBgYmv
         cC+w==
X-Forwarded-Encrypted: i=1; AJvYcCXlboiOS9ZHZZJoBpnRWAyvmZJ4XWE8ycNbWzHEQBMISxvy3IidBOU3eIaWD7q5L+VlqR0SI/3XWGxmi7jk9EYJyouk/3/z
X-Gm-Message-State: AOJu0YzvDI1MWYauhSYcFWJhYQ6zcQDHZ3YDxBV/r9KGzX5EOa5kRVGJ
	vNZGlDf8eUPUswRMcXtqIbzLPbP2bssnAP03BL9rBRrW21TGuo1wbKOVhp8Xzu28HVUDST6X4Iy
	dmeuILDzVmlY4mTDNv07UbNimQEyInE7zk+ysfFy24Ivv5NnKPaIOdw==
X-Received: by 2002:a17:906:abc3:b0:a4e:7c4:486d with SMTP id kq3-20020a170906abc300b00a4e07c4486dmr1141114ejb.2.1711609819218;
        Thu, 28 Mar 2024 00:10:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaHscAS1oLsitpJZOCppAoO58unZ6Qw2zDta4kqgT+AHaubLLTXiTf9rmuibrxkOVTw06KWQ==
X-Received: by 2002:a17:906:abc3:b0:a4e:7c4:486d with SMTP id kq3-20020a170906abc300b00a4e07c4486dmr1141101ejb.2.1711609818873;
        Thu, 28 Mar 2024 00:10:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id jx2-20020a170906ca4200b00a46d9966ff8sm408218ejb.147.2024.03.28.00.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:10:18 -0700 (PDT)
Message-ID: <35cdaf7e-ef32-470f-ab61-e5f4a3b35238@redhat.com>
Date: Thu, 28 Mar 2024 08:10:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_dw: Revert: Do not reclock if already at
 correct rate
To: Peter Collingbourne <pcc@google.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
 stable@vger.kernel.org
References: <20240317214123.34482-1-hdegoede@redhat.com>
 <ZfgZEcg2RXSz08Gd@smile.fi.intel.com>
 <CAMn1gO4zPpwVDcv5FFiimG0MkGdni_0QRMoJH9SSA3LJAk7JqQ@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMn1gO4zPpwVDcv5FFiimG0MkGdni_0QRMoJH9SSA3LJAk7JqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/18/24 7:52 PM, Peter Collingbourne wrote:
> On Mon, Mar 18, 2024 at 3:36 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> On Sun, Mar 17, 2024 at 10:41:23PM +0100, Hans de Goede wrote:
>>> Commit e5d6bd25f93d ("serial: 8250_dw: Do not reclock if already at
>>> correct rate") breaks the dw UARTs on Intel Bay Trail (BYT) and
>>> Cherry Trail (CHT) SoCs.
>>>
>>> Before this change the RTL8732BS Bluetooth HCI which is found
>>> connected over the dw UART on both BYT and CHT boards works properly:
>>>
>>> Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000b lmp_ver=06 lmp_subver=8723
>>> Bluetooth: hci0: RTL: rom_version status=0 version=1
>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
>>> Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
>>> Bluetooth: hci0: RTL: fw version 0x365d462e
>>>
>>> where as after this change probing it fails:
>>>
>>> Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000b lmp_ver=06 lmp_subver=8723
>>> Bluetooth: hci0: RTL: rom_version status=0 version=1
>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
>>> Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
>>> Bluetooth: hci0: command 0xfc20 tx timeout
>>> Bluetooth: hci0: RTL: download fw command failed (-110)
>>>
>>> Revert the changes to fix this regression.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>>> Note it is not entirely clear to me why this commit is causing
>>> this issue. Maybe probe() needs to explicitly set the clk rate
>>> which it just got (that feels like a clk driver issue) or maybe
>>> the issue is that unless setup before hand by firmware /
>>> the bootloader serial8250_update_uartclk() needs to be called
>>> at least once to setup things ?  Note that probe() does not call
>>> serial8250_update_uartclk(), this is only called from the
>>> dw8250_clk_notifier_cb()
>>>
>>> This requires more debugging which is why I'm proposing
>>> a straight revert to fix the regression ASAP and then this
>>> can be investigated further.
>>
>> Yep. When I reviewed the original submission I was got puzzled with
>> the CLK APIs. Now I might remember that ->set_rate() can't be called
>> on prepared/enabled clocks and it's possible the same limitation
>> is applied to ->round_rate().
>>
>> I also tried to find documentation about the requirements for those
>> APIs, but failed (maybe was not pursuing enough, dunno). If you happen
>> to know the one, can you point on it?
> 
> To me it seems to be unlikely to be related to round_rate(). It seems
> more likely that my patch causes us to never actually set the clock
> rate (e.g. because uartclk was initialized to the intended clock rate
> instead of the current actual clock rate).

I agree that the likely cause is that we never set the clk-rate. I'm not
sure if the issue is us never actually calling clk_set_rate() or if
the issue is that by never calling clk_set_rate() dw8250_clk_notifier_cb()
never gets called and thus we never call serial8250_update_uartclk()

> It should be possible to
> confirm by checking the behavior with my patch with `&& p->uartclk !=
> rate` removed, which I would expect to unbreak Hans's scenario. If my
> hypothesis is correct, the fix might involve querying the clock with
> clk_get_rate() in the if instead of reading from uartclk.

Querying the clk with clk_get_rate() instead of reading it from
uartclk will not help as uartclk gets initialized with clk_get_rate()
in dw8250_probe(). So I believe that in my scenario clk_get_rate()
already returns the desired rate causing us to never call clk_set_rate()
at all which leaves 2 possible root causes for the regressions:

1. The clk generator has non readable registers and the returned
rate from clk_get_rate() is a default rate and the actual hw is
programmed differently, iow we need to call clk_set_rate() at
least once on this hw to ensure that the clk generator is prggrammed
properly.

2. The 8250 code is not working as it should because
serial8250_update_uartclk() has never been called.


I would be happy to test patches to try and fix this. But in the mean
time 6.8 has been released with dw_uart-s on Intel Bay Trail and
Cherry Trail SoCs completely broken, so can we please move forward
with this revert to unbreak 6.8 now ?

Regards,

Hans



> 
> Peter
> 


