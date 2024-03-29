Return-Path: <stable+bounces-33149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCB4891803
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 12:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C7A2865C2
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 11:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA137D411;
	Fri, 29 Mar 2024 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TerKJJFt"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13686A8BA
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712543; cv=none; b=jJImiXa0ckM1KaRjQRK2Wz6EIVdH3d2dFn6zZFV7xKRp6kdsVttI6q+pztrJuIA+RlSVp15FEljjddPIOpjXUr0xTnbIifVE1iGCIV2XUK9YUMg0O6fVjIJYYD/+iae8iLYoEvQSeluJDatfEK7dQgaK+9OYXGpERf9IcOv7skQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712543; c=relaxed/simple;
	bh=WaaGmfrCfvmo41kPSPcJACagDkKm6fW/rS/52E6I0L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYqS8QlOhCyXzhRoN9iWSqOFHGE1TrwaBRnMvxZJxm3SNHqJSGmfTpdliaNY7j+HdqhErscBMA+wTRY/S8AbMO7ouT32RriBC6jzhrBh6wtK/CDzmQR/3ickZoVSH2wTyUF1FfjWSbkAgY/3kyXUHhaFHxulWG0PqmAF20o3Jcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TerKJJFt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711712538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVsQN3Zk8ipIbAfYFaXzUSsaC7YIpBAit4ps9CQ+HwM=;
	b=TerKJJFt4tNSPTUxR2Xb7sg8UjbHqPUvho3SscaoGilMFPN+Ltk4hwjuYEzoHPZC8Ez9ZR
	BcDos4K6wF0m9k25NS2LGDD21p/t//zdexGtMvqqBDAdNHdy7hn+Win8cfEB3+zBzS51s4
	l0utK7AiOx5EyKLlzl3neY7YrgXoRrU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-j1fRPzqrNMevYApUPpLKJw-1; Fri, 29 Mar 2024 07:42:17 -0400
X-MC-Unique: j1fRPzqrNMevYApUPpLKJw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a4943e972d1so301319266b.0
        for <stable@vger.kernel.org>; Fri, 29 Mar 2024 04:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711712536; x=1712317336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVsQN3Zk8ipIbAfYFaXzUSsaC7YIpBAit4ps9CQ+HwM=;
        b=iN11qwbue+gdj1Zszjv0Z35Lf0QfDnoA6BCP1AhISC0KbOlToBcRAWxXckAZ1bpj0N
         iG3bksk12+0wwqqHdxUrHUpkNPx65h5pRPFQV35CkGCWvi1xLEhIBiQE5pn027mme9Fp
         YkFBi5RzccQ5zMnqkahmgjDTkc1nNS9VkrAex4g9xcBsSPzuW962h5kBDADTpogrWYCQ
         z9FAxuHb5J/GjUCjw/FI0tC07l5Rnwk5FYah2MgKTC/jZsU0BPUkWLZT93yoizYPV6bA
         CqGFmCrdge8GS8ezqfJ8OrW+gmOTYFnp1qNTq6Q/IN1GNLdGBtjckcR2zuy/Rg+wLum0
         KBZA==
X-Forwarded-Encrypted: i=1; AJvYcCXfpZx67E1UTfNFfq+TmwE8jIx4RyELccLno4Fi2+9VG80WKN3012LRQsb8VKSKnsLKlkjsryYeGgX+F6os0/q1dUths4DP
X-Gm-Message-State: AOJu0YxcpkxDlMl9eekGTKLKEtVxndMseAPXGfcGL6M13QTLomIadeRa
	j6MuBqlIM0siXWTnjirKUWCTPyT2KSJ8mLz5DDwtzHiNdxeerj8X5Vy2DvTNO1Kba842ULRBx1G
	FFWvz9GuZOmxNXaZg+l//FU4VEavTmXfUROMpsanxAl8/UAXm8cp5vw==
X-Received: by 2002:a17:906:ca57:b0:a46:852e:2a63 with SMTP id jx23-20020a170906ca5700b00a46852e2a63mr1895405ejb.29.1711712536269;
        Fri, 29 Mar 2024 04:42:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjkP79fJAghs7WuXNGgIV3COL88nKW4NyJUmHsGSjdpZmRFnbAq0oU5/JBjguIT5Q1pnOTWw==
X-Received: by 2002:a17:906:ca57:b0:a46:852e:2a63 with SMTP id jx23-20020a170906ca5700b00a46852e2a63mr1895385ejb.29.1711712535827;
        Fri, 29 Mar 2024 04:42:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id wk8-20020a170907054800b00a4e2d7dd2d8sm1054813ejb.182.2024.03.29.04.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 04:42:15 -0700 (PDT)
Message-ID: <8cbe0f5f-0672-4bca-b539-8bff254c7c97@redhat.com>
Date: Fri, 29 Mar 2024 12:42:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_dw: Revert: Do not reclock if already at
 correct rate
Content-Language: en-US, nl
To: Peter Collingbourne <pcc@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
 stable@vger.kernel.org, VAMSHI GAJJELA <vamshigajjela@google.com>
References: <20240317214123.34482-1-hdegoede@redhat.com>
 <ZfgZEcg2RXSz08Gd@smile.fi.intel.com>
 <CAMn1gO4zPpwVDcv5FFiimG0MkGdni_0QRMoJH9SSA3LJAk7JqQ@mail.gmail.com>
 <35cdaf7e-ef32-470f-ab61-e5f4a3b35238@redhat.com>
 <33110d20-45d6-45b9-8af0-d3eac8c348b8@redhat.com>
 <CAMn1gO5-WD5wyPt+ZKDL-sRKhZvz1sUSPP-Mq59Do5kySpm=Sg@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMn1gO5-WD5wyPt+ZKDL-sRKhZvz1sUSPP-Mq59Do5kySpm=Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Peter,

On 3/29/24 3:35 AM, Peter Collingbourne wrote:
> On Thu, Mar 28, 2024 at 5:35 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 3/28/24 8:10 AM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 3/18/24 7:52 PM, Peter Collingbourne wrote:
>>>> On Mon, Mar 18, 2024 at 3:36 AM Andy Shevchenko
>>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>>
>>>>> On Sun, Mar 17, 2024 at 10:41:23PM +0100, Hans de Goede wrote:
>>>>>> Commit e5d6bd25f93d ("serial: 8250_dw: Do not reclock if already at
>>>>>> correct rate") breaks the dw UARTs on Intel Bay Trail (BYT) and
>>>>>> Cherry Trail (CHT) SoCs.
>>>>>>
>>>>>> Before this change the RTL8732BS Bluetooth HCI which is found
>>>>>> connected over the dw UART on both BYT and CHT boards works properly:
>>>>>>
>>>>>> Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000b lmp_ver=06 lmp_subver=8723
>>>>>> Bluetooth: hci0: RTL: rom_version status=0 version=1
>>>>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
>>>>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
>>>>>> Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
>>>>>> Bluetooth: hci0: RTL: fw version 0x365d462e
>>>>>>
>>>>>> where as after this change probing it fails:
>>>>>>
>>>>>> Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000b lmp_ver=06 lmp_subver=8723
>>>>>> Bluetooth: hci0: RTL: rom_version status=0 version=1
>>>>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
>>>>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
>>>>>> Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
>>>>>> Bluetooth: hci0: command 0xfc20 tx timeout
>>>>>> Bluetooth: hci0: RTL: download fw command failed (-110)
>>>>>>
>>>>>> Revert the changes to fix this regression.
>>>>>
>>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>>
>>>>>> Note it is not entirely clear to me why this commit is causing
>>>>>> this issue. Maybe probe() needs to explicitly set the clk rate
>>>>>> which it just got (that feels like a clk driver issue) or maybe
>>>>>> the issue is that unless setup before hand by firmware /
>>>>>> the bootloader serial8250_update_uartclk() needs to be called
>>>>>> at least once to setup things ?  Note that probe() does not call
>>>>>> serial8250_update_uartclk(), this is only called from the
>>>>>> dw8250_clk_notifier_cb()
>>>>>>
>>>>>> This requires more debugging which is why I'm proposing
>>>>>> a straight revert to fix the regression ASAP and then this
>>>>>> can be investigated further.
>>>>>
>>>>> Yep. When I reviewed the original submission I was got puzzled with
>>>>> the CLK APIs. Now I might remember that ->set_rate() can't be called
>>>>> on prepared/enabled clocks and it's possible the same limitation
>>>>> is applied to ->round_rate().
>>>>>
>>>>> I also tried to find documentation about the requirements for those
>>>>> APIs, but failed (maybe was not pursuing enough, dunno). If you happen
>>>>> to know the one, can you point on it?
>>>>
>>>> To me it seems to be unlikely to be related to round_rate(). It seems
>>>> more likely that my patch causes us to never actually set the clock
>>>> rate (e.g. because uartclk was initialized to the intended clock rate
>>>> instead of the current actual clock rate).
>>>
>>> I agree that the likely cause is that we never set the clk-rate. I'm not
>>> sure if the issue is us never actually calling clk_set_rate() or if
>>> the issue is that by never calling clk_set_rate() dw8250_clk_notifier_cb()
>>> never gets called and thus we never call serial8250_update_uartclk()
>>>
>>>> It should be possible to
>>>> confirm by checking the behavior with my patch with `&& p->uartclk !=
>>>> rate` removed, which I would expect to unbreak Hans's scenario. If my
>>>> hypothesis is correct, the fix might involve querying the clock with
>>>> clk_get_rate() in the if instead of reading from uartclk.
>>>
>>> Querying the clk with clk_get_rate() instead of reading it from
>>> uartclk will not help as uartclk gets initialized with clk_get_rate()
>>> in dw8250_probe(). So I believe that in my scenario clk_get_rate()
>>> already returns the desired rate causing us to never call clk_set_rate()
>>> at all which leaves 2 possible root causes for the regressions:
>>>
>>> 1. The clk generator has non readable registers and the returned
>>> rate from clk_get_rate() is a default rate and the actual hw is
>>> programmed differently, iow we need to call clk_set_rate() at
>>> least once on this hw to ensure that the clk generator is prggrammed
>>> properly.
>>>
>>> 2. The 8250 code is not working as it should because
>>> serial8250_update_uartclk() has never been called.
>>
>> Ok, so it looks like this actually is an issue with how clk_round_rate()
>> works on this hw (atm, maybe the clk driver needs fixing).
>>
>> I have added the following to debug this:
>>
>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
>> index a3acbf0f5da1..3152872e50b2 100644
>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -306,6 +306,8 @@ static void dw8250_clk_work_cb(struct work_struct *work)
>>         if (rate <= 0)
>>                 return;
>>
>> +       pr_info("uartclk work_cb clk_get_rate() returns: %ld\n", rate);
>> +
>>         up = serial8250_get_port(d->data.line);
>>
>>         serial8250_update_uartclk(&up->port, rate);
>> @@ -353,11 +355,15 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
>>  {
>>         unsigned long newrate = tty_termios_baud_rate(termios) * 16;
>>         struct dw8250_data *d = to_dw8250_data(p->private_data);
>> +       unsigned long currentrate = clk_get_rate(d->clk);
>>         long rate;
>>         int ret;
>>
>> +
>>         rate = clk_round_rate(d->clk, newrate);
>> -       if (rate > 0 && p->uartclk != rate) {
>> +       pr_info("uartclk set_termios new: %ld new-rounded: %ld current %ld cached %d\n",
>> +               newrate, rate, currentrate, p->uartclk);
>> +       if (rate > 0) {
>>                 clk_disable_unprepare(d->clk);
>>                 /*
>>                  * Note that any clock-notifer worker will block in
>> @@ -593,6 +599,8 @@ static int dw8250_probe(struct platform_device *pdev)
>>         if (!p->uartclk)
>>                 return dev_err_probe(dev, -EINVAL, "clock rate not defined\n");
>>
>> +       pr_info("uartclk initial cached %d\n", p->uartclk);
>> +
>>         data->pclk = devm_clk_get_optional_enabled(dev, "apb_pclk");
>>         if (IS_ERR(data->pclk))
>>                 return PTR_ERR(data->pclk);
>>
>> And then I get the following output:
>>
>> [    3.119182] uartclk initial cached 44236800
>> [    3.139923] uartclk work_cb clk_get_rate() returns: 44236800
>> [    3.152469] uartclk initial cached 44236800
>> [    3.172165] uartclk work_cb clk_get_rate() returns: 44236800
>> [   34.128257] uartclk set_termios new: 153600 new-rounded: 44236800 current 44236800 cached 44236800
>> [   34.130039] uartclk work_cb clk_get_rate() returns: 153600
>> [   34.131975] uartclk set_termios new: 153600 new-rounded: 153600 current 153600 cached 153600
>> [   34.132091] uartclk set_termios new: 153600 new-rounded: 153600 current 153600 cached 153600
>> [   34.132140] uartclk set_termios new: 153600 new-rounded: 153600 current 153600 cached 153600
>> [   34.132187] uartclk set_termios new: 1843200 new-rounded: 153600 current 153600 cached 153600
>> [   34.133536] uartclk work_cb clk_get_rate() returns: 1843200
>>
>> Notice how the new-rounded just returns the current rate of the clk,
>> rather then a rounded value of new.
>>
>> I'm not familiar enough with the clk framework to debug this further.
>>
>> Peter, IMHO we really must revert your commit since it is completely
>> breaking UARTs on many different Intel boards. Can you please give your
>> ack for reverting this for now ?
> 
> That's fine with me.

Great, thank you.

> I will try to dig into the code soon to figure
> out what is going on unless someone gets there first.

Thinking some more about this I think the following might
be going on (this is only a theory I have, not sure at all):

The 80860F0A:01-update clk itself does not allow
changing it rate, which is why clk_round_rate() is simply
returning the current rate of it.

But its parent, 80860F0A:01-div does allow changing its
rate and it has only 1 child / consumer,
the 80860F0A:01-update clk. So because of this
clk_set_rate() propagates the clk_set_rate() call
the 8250_dw code does on 80860F0A:01-update to
80860F0A:01-div, which is ok to do since there
are no competing conumers who would be affected
by the clk-rate change.

And then the propagated clk_set_rate() call on
80860F0A:01-div successfully updates the clk-rate
and a get_rate on 80860F0A:01-update (which AFAICT
is just a gate after the divider) now returns
the new rate.

Again just a theory but this would explain the weird
clk_get_rate() behavior.

In case it helps here is the clk chain for the
8250_dw clk:

lpss_clk (fixed 100MHz) ->
80860F0A:01 (gate only?) ->
80860F0A:01-div (working set_rate()) ->
80860F0A:01-update (gate only ?) ->
8500_dw-baudclk

> Acked-by: Peter Collingbourne <pcc@google.com>

Thanks. Greg can we get this merged please
(it is a regression fix for a 6.8 regression) ?


Regards,

Hans








>> p.s.
>>
>> For anyone who wants to dive into the clk_round_rate() issue deeper,
>> the code registering the involved clks is here:
>>
>> drivers/acpi/acpi_lpss.c: register_device_clock()
>>
>> And for the clocks in question fixed_clk_rate is 0 and both
>> the LPSS_CLK_GATE and LPSS_CLK_DIVIDER flags are set, so
>> for a single UART I get:
>>
>> [root@fedora ~]# ls -d /sys/kernel/debug/clk/80860F0A:01*
>> /sys/kernel/debug/clk/80860F0A:01      /sys/kernel/debug/clk/80860F0A:01-update
>> /sys/kernel/debug/clk/80860F0A:01-div
>>
>> With the 80860F0A:01-update clk being the clk which is
>> actually used / controlled by the 8250_dw.c code.
>>
> 


