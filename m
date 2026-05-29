Return-Path: <stable+bounces-256546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E8jJMBMGWqSuggAu9opvQ
	(envelope-from <stable+bounces-256546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:22:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE595FF1A3
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4432E3012C42
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D7434F259;
	Fri, 29 May 2026 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe/QHZn0"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B13382C9
	for <stable@vger.kernel.org>; Fri, 29 May 2026 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780042906; cv=none; b=q0PyYQMI7bjfYEbXK2MvloFKIF5zJReE00yOCHc1PJFAoqrWm99KFhkMqLZeqBcTvIi+Pv85TqfgZtJ3QQligg88h5PqeuJ+eq8uZQsNkUJuHtrZW6gHAEsdPwrPlCFqtaB5G2YZKIMxR9TW9CoyVpyrT/ggGewaBJqhjpo+pFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780042906; c=relaxed/simple;
	bh=zLVQlrGFYnOCUGHoSDP+O1fB+fDE6or0cutO5YbR/Bw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A7Zqmfk00A6hwDsLYU55GoAFyoJKSdk1PvjTb597CcBw1PIIEBGJONDzg7m+tGaB/8EPDnBGI7+RXdq+LQUTxMng44uAP4yPf5p3h0CShg4AkOkXrw4cmRMMhv6fK3uYrdjSaKv+FhAPl1GwRVkAYGcYD5Ca+/cjTK2zgUGqUgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pe/QHZn0; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38e7b0903cdso110232351fa.3
        for <stable@vger.kernel.org>; Fri, 29 May 2026 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780042903; x=1780647703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nMYAYoPG5h2LdAR8d80xh1GBZQs0rqJKLSYJYOXAPPE=;
        b=pe/QHZn0a8pK9Fwp5EJFZPccjmkxbiqHDJognITZWGYMPpIIQLgzexJhm8PQxaWArd
         tuQQsR3WB6T1L62DJhUAFyJD5nIimPr2ToZ3okNnpuv/IRowm3t8QaCnWQuFSVsMbyR8
         9qjCb+eS1r08ZFZglRkLxhwOiEZ/EjAdruiNaMZlA5Zsv4K04AX/J8OLVcZR8zEHUxCr
         q/HRqvhyKzmE1LQUV/IBLxW1za3MUkxVeauk6r7PdZeQhdG9SwmVkN8KULwBw7nRLoq9
         ik9e3d2JeeIKMAPik7X2zVQEECCmd0ZDZwURtcgeK1g/cW1V4wvSS47WkN5NCVFaQDKn
         QDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780042903; x=1780647703;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMYAYoPG5h2LdAR8d80xh1GBZQs0rqJKLSYJYOXAPPE=;
        b=FKiuIWyiWn5igSAFMcXD28AylKdjZPCun3RRk3zg3V9R0lstwBGk63mUcnKuCPJbEr
         U65BQVJTkH38J2upAYLsMnH2P3TAlC2pwzSTL2mRdgFjy6E1wSXJPWdtFh/YtAKh8ZHy
         NtwZQ/t03/18WV0eb/LhoXPRPnKUWtE3nK6QrZbMgdHBc9HSWT6t+7Um8Hb47omG1AWl
         jlGVXwz+OwzalsNeysayXETXVjpMZZMB4twHP/IpI4y30vwSMXE5PyGjI3ZvflItBnOa
         u4V8tw71EoNKX5hHMXUG/CV8XOfm15/M/MyB2hXI7lSXcCzejICtCilLiDUzH1a5WoYy
         MsZg==
X-Forwarded-Encrypted: i=1; AFNElJ+ffOTuXkNh4z7bItMi6GyQiepVGyQfnhvPwl1Pg786EVnsa2w8Hw6VURMdwTIopO89d/kGfJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9TS5blXGUol2VZChVyiOxo7iSOCB05eRmBHU8oa1MFA5S4Pmh
	JFbFX59JiVK64eoa506TvzAO5ac//QgzqyBBz9gKUbS7t+QmOnNeZBs0
X-Gm-Gg: Acq92OF3Jc509v4KoOBMOSFyYvXMwtdg6FIV5pVqdIDGvP+1x6EuozvIZwv/SOit+KW
	NrqiAGR1/gQtwHHqq3AsBoJpDix9zW/BxgTMTwCSVjjK/a/aMXa0ub1oyEmc190NIOhxzEsJ+LE
	bb6ykwtnQfXoxaiBzgBCUU0bDSGf8OE7ibQ6RAnpk9/BrLrxk0OEsr/hIXnXRVS4PJrg0Z7IZU4
	lPtT7kVljTm7RsEFjiQd5YSRvp3RVjhk80bdyhTA6rlWOh+z/Du9K1xYn99BjPXxe1QJS4wrWtY
	gt6kx/o9D2Tw1IXrm5K4QiFR6x+htDjGWJR/tN2APL2EddNaDJkn+y4qbJ+DlLn67U39RnEccno
	sSO3IwfPPpZ2u7amaC+sKmG5z4grtlW9aiirzprd8wCtd9Wa8wPieA+DMj0d6yxOD5TfeOLhmxs
	tkFzaN2oBoYg4QJzwHiLlw+rFyC0rqiVXjrFC9yIumhBG44AQ7d+Lbsg==
X-Received: by 2002:a2e:a80c:0:b0:38e:a883:6303 with SMTP id 38308e7fff4ca-396536a0e3amr5603501fa.9.1780042902277;
        Fri, 29 May 2026 01:21:42 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39659c45a51sm972001fa.3.2026.05.29.01.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 01:21:41 -0700 (PDT)
Message-ID: <aa2c2f98-454d-489c-a652-b8023b0773bf@gmail.com>
Date: Fri, 29 May 2026 11:21:40 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: pressure: rohm-bm1390: notify trigger on all
 error paths
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <20260518094238.1986-1-sozdayvek@gmail.com>
 <20260518161516.53f21777@jic23-huawei>
 <61d9cec3-6aed-416f-9604-94fe94cb2e3b@gmail.com>
 <20260520120822.351aa58f@jic23-huawei>
 <0d58842a-aa5c-4d12-9435-3264070038cc@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
In-Reply-To: <0d58842a-aa5c-4d12-9435-3264070038cc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,baylibre.com,analog.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-256546-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mazziesaccount@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,arm:email]
X-Rspamd-Queue-Id: 7EE595FF1A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 22/05/2026 15:38, Matti Vaittinen wrote:
> On 20/05/2026 14:08, Jonathan Cameron wrote:
>> On Tue, 19 May 2026 08:48:13 +0300
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>>> Thanks Jonathan,
>>>
>>> Your post give me something to think about ;)
>>
>> This is a can of worms.  More below.
>>
>> I'm unconcerned as long as (and ideally someone should check it)
>> we can get of being stuck by unbind/rebind of driver.  Anything
>> else is best effort.
>>
>>
>>>
>>> On 18/05/2026 18:15, Jonathan Cameron wrote:
>>>> On Mon, 18 May 2026 14:42:38 +0500
>>>> Stepan Ionichev <sozdayvek@gmail.com> wrote:
>>>>> bm1390_trigger_handler() returns from three error paths without
>>>>> calling iio_trigger_notify_done(). The success path at the end
>>>>> does, so on a single transient regmap or read failure the trigger
>>>>> use_count is never decremented, and the !atomic_read(&trig->use_count)
>>>>> guard in iio_trigger_poll_chained() drops every subsequent dispatch.
>>>>> The buffered-data flow stays wedged until the trigger is detached.
>>>>>
>>>>> Funnel all returns through a single done label that calls
>>>>> iio_trigger_notify_done() and reports the outcome via IRQ_RETVAL().
>>>>>
>>>>> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
>>>>
>>>> These error path 'fixes' are fixes for hardware failure - so if 
>>>> anything
>>>> they are hardending  against a possible error condition. I don't mind
>>>> that bit it's not a bug to not do this so fixes tag an stable are not
>>>> appropriate for any of these.
>>>>
>>>> Note however that hardening against these conditions is not this 
>>>> simple.
>>>> It takes careful analysis of exactly how the hardware behaves and what
>>>> each error condition 'might' mean.  Whilst they are probably harmless
>>>> I'm also very dubious about taking them without comprehensive testing
>>>> on the particular device.
>>>>> ---
> 
> //snip
> 
>>>>> @@ -639,7 +642,8 @@ static irqreturn_t bm1390_trigger_handler(int 
>>>>> irq, void *p)
>>>>>            ret = bm1390_pressure_read(data, &data->buf.pressure);
>>>>>            if (ret) {
>>>>>                dev_warn(data->dev, "sample read failed %d\n", ret);
>>>>> -            return IRQ_NONE;
>>>>> +            handled = false;
>>>>> +            goto done;
>>>>
>>>> Hopefully all this stuff is unrelated to the trigger.  For these it 
>>>> is fair to
>>>> ack the trigger and the interrupt.  Curiously the driver does it 
>>>> partly for the
>>>> next one (IRQ_HANDLED).
>>>
>>> I would keep the IRQ_NONE here because, if we keep constantly failing
>>> the reads, then the bus is likely to be unerliable - and disabling the
>>> useless IRQ is probably very sane thing to do. It should help debugging.
>>> What comes to acking the trigger - I am starting to agree with Stepan,
>>> we should probably ack the trigger in any case. If we don't ack the
>>> trigger, then the IRQ_NONE does not serve the purpose it is intended 
>>> for.
>>
>> The interrupt that we'd get spurious detection on here would not be 
>> the device
>> one it would be the software emulated one deep in the iio trigger stuff.
>>
>> Might still be useful for debug. Anyone fancy hacking an error in and 
>> reporting
>> back what we actually get from the debug hardware?  (with that trigger 
>> acked
>> as you suggest?)
> 
> No promises but I'll see if I can try out something next week...

The week has been horrible... I only had around half an hour for this 
(just now). Quick:

+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -621,6 +621,16 @@ static const struct iio_buffer_setup_ops 
bm1390_buffer_ops = {
         .predisable = bm1390_buffer_predisable,
  };

+/*
+ * Test case where IRQ status is nopt read (acked). Useful for 
evaluating the
+ * impact of returning the IRQ_NONE from the trigger handler. define 
also the
+ * TEST_FORCE_IRQ_NOTIFY if you wish to cause the trigger to be notified.
+ *
+ * Note, in case it is not obvious, this will cause IRQ storm.
+ */
+#define TEST_FORCE_IRQ_NONE
+#define TEST_FORCE_IRQ_NOTIFY
+
  static irqreturn_t bm1390_trigger_handler(int irq, void *p)
  {
         struct iio_poll_func *pf = p;
@@ -628,12 +638,27 @@ static irqreturn_t bm1390_trigger_handler(int irq, 
void *p)
         struct bm1390_data *data = iio_priv(idev);
         int ret, status;

+#ifdef TEST_FORCE_IRQ_NONE
+       static unsigned long int first = 1, first2 = 0;
+       ret = 0;
+
+       if (first) {
+               pr_info("Skip read\n");
+               first = 0;
+       }
+       #ifdef TEST_FORCE_IRQ_NOTIFY
+       status = BIT(BM1390_CHAN_PRESSURE);
+       #else
+       status = 0;
+       #endif
+#else
         /* DRDY is acked by reading status reg */
         ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
         if (ret || !status)
                 return IRQ_NONE;
+#endif

-       dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
+//     dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);

         if (test_bit(BM1390_CHAN_PRESSURE, idev->active_scan_mask)) {
                 ret = bm1390_pressure_read(data, &data->buf.pressure);
@@ -656,7 +681,17 @@ static irqreturn_t bm1390_trigger_handler(int irq, 
void *p)
                                     data->timestamp);
         iio_trigger_notify_done(idev->trig);

+#ifdef TEST_FORCE_IRQ_NONE
+       /* HACK, return IRQ_NONE and see if IRQ gets disabled */
+       if (!(first2 % 1000))
+               pr_info("Hack, return IRQ_NONE (%lu th)\n", first2);
+
+       first2++;
+
+       return IRQ_NONE;
+#else
         return IRQ_HANDLED;
+#endif
  }

  /* Get timestamps and wake the thread if we need to read data */



resulted:
root@arm:/home/debian# /iio_generic_buffer -a -c1000000 --device-name 
bm1390 -T0 > /dev/null
Enabling all channels
[  115.098819] Skip read
[  115.102442] Hack, return IRQ_NONE (0 th)
[  116.459049] Hack, return IRQ_NONE (1000 th)
[  117.851037] Hack, return IRQ_NONE (2000 th)
[  119.214843] Hack, return IRQ_NONE (3000 th)
[  120.598114] Hack, return IRQ_NONE (4000 th)
[  121.960255] Hack, return IRQ_NONE (5000 th)
[  123.322424] Hack, return IRQ_NONE (6000 th)

//snip

[  237.726666] Hack, return IRQ_NONE (90000 th)
[  239.095910] Hack, return IRQ_NONE (91000 th)
[  240.481233] Hack, return IRQ_NONE (92000 th)
[  241.846072] Hack, return IRQ_NONE (93000 th)
[  243.206432] Hack, return IRQ_NONE (94000 th)
[  244.570636] Hack, return IRQ_NONE (95000 th)
[  245.928964] Hack, return IRQ_NONE (96000 th)
[  247.286839] Hack, return IRQ_NONE (97000 th)
[  248.647986] Hack, return IRQ_NONE (98000 th)
[  250.011214] Hack, return IRQ_NONE (99000 th)
[  251.368583] irq 64: nobody cared (try booting with the "irqpoll" option)
[  251.375463] CPU: 0 UID: 0 PID: 835 Comm: irq/63-2-005d-b Tainted: G 
         O        7.1.0-rc1-00002-g3b459deb7222-dirty #249 VOLUNTARY
[  251.375501] Tainted: [O]=OOT_MODULE
[  251.375511] Hardware name: Generic AM33XX (Flattened Device Tree)
[  251.375525] Call trace:
[  251.375545]  unwind_backtrace from show_stack+0x10/0x14
[  251.375607]  show_stack from dump_stack_lvl+0x50/0x64
[  251.375646]  dump_stack_lvl from __report_bad_irq+0x30/0xbc
[  251.375680]  __report_bad_irq from note_interrupt+0x2b4/0x32c
[  251.375722]  note_interrupt from handle_nested_irq+0x13c/0x14c
[  251.375758]  handle_nested_irq from iio_trigger_poll_nested+0x4c/0x68 
[industrialio]
[  251.375917]  iio_trigger_poll_nested [industrialio] from 
bm1390_irq_thread_handler+0x54/0x7c [rohm_bm1390]
[  251.375994]  bm1390_irq_thread_handler [rohm_bm1390] from 
irq_thread_fn+0x1c/0x78
[  251.376028]  irq_thread_fn from irq_thread+0x18c/0x324
[  251.376057]  irq_thread from kthread+0xf8/0x130
[  251.376091]  kthread from ret_from_fork+0x14/0x20
[  251.376114] Exception stack(0xe0355fb0 to 0xe0355ff8)
[  251.376136] 5fa0:                                     00000000 
00000000 00000000 00000000
[  251.376156] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[  251.376175] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  251.376189] handlers:
[  251.498714] [<2ec7a5d9>] iio_pollfunc_store_time [industrialio] 
threaded [<7f4268a2>] bm1390_trigger_handler [rohm_bm1390]
[  251.509974] Disabling IRQ #64

Message from syslogd@arm at Jan  1 01:17:33 ...
  kernel:[  251.509974] Disabling IRQ #64
[  252.822500] sched: RT throttling activated


Things I very hastly picked up:

1. The throttling mechanism works even though the handling is invoked 
via iio_trigger_poll_nested(), Probably because this propagates the call 
to the handle_nested_irq() - which does bookkeeping.

2. For some reason (which I didn't have time to check yet), the 
beaglebone black which I used to run this, was not completely blocked by 
the IRQ. We can see the "Hack, return IRQ_NONE (xxx th)" -prints 
emerging just fine.

And now I must run. I hope to be able to dig some more details next week.

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

