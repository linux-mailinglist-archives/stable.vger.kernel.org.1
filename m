Return-Path: <stable+bounces-226894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GcOIJywuWkkMQIAu9opvQ
	(envelope-from <stable+bounces-226894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:50:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8312B1C03
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92C62301E9A6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 19:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FED32F757;
	Tue, 17 Mar 2026 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOYH6QTs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8852D780C;
	Tue, 17 Mar 2026 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777049; cv=none; b=or0mhUXWdmHt7YfSv6iSj7qFAVWIbiVcjzs6gntVMAsOWviL7jRE8D7lEeJ7linGFsw3LRphNXep9wy3nknhQIqGFKcPJo/XrROtdEdzkBzpbI5+OmG8ZMRBB9wsnUxh4qBtV7RveTRF8mgKKZHlpxYllpmZDnzVeAxmVe7qLaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777049; c=relaxed/simple;
	bh=mQkLOI5TNoPpltWB54lOhE6wTEL1bBFRPzazbCe4zFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRsRe80HykhIpdDf63pxSyGgHAcO7QtGUx0rYn91+f45D23YhEe3um8TaP+F2v9OGpf0H9ed33upBd2KFlywri2N2YhO5BEMATmAJX2o85xLik+/LW6Oh8YNwVhf7ux0vnCg3aoN1RqnAWSCzIXgWdSJPOtFwla6fpXA0M5Ymyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOYH6QTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC24C4CEF7;
	Tue, 17 Mar 2026 19:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773777049;
	bh=mQkLOI5TNoPpltWB54lOhE6wTEL1bBFRPzazbCe4zFo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TOYH6QTsSCQjeS0CZwGG+P+Li9eIPCNObFoyP0H0YVjiMGTjAQYqps3LU0WZmpyM9
	 q0yb1ioqKvSMnkDb6wsWdmEVI2aIz81gE/A2aIjg3VrTZp/NgrczTlYhnz05hj/lU5
	 fzGK3NpBU1+cRXxH3tBxHY4/uOhPVHAyKsWk6fg2cwNlJQaPoOOQO+680YniAR5p1K
	 JD/asm4Cgqze5SA+Lmy3uZHGsUXqNPn/319O7ZPMq8gW+lgd53WplySRsUUqFu3A4C
	 YBrQ7dmT/lebDW0zM2Fk+rsINNWZX5rmipB0qXogmM/AoUR82nyIjh6DVd/bNNil9D
	 oikGW29bsvbtg==
Message-ID: <153de0ae-fd1f-41af-b44e-13a4e9dc6a0b@kernel.org>
Date: Tue, 17 Mar 2026 20:50:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: fusb302: Switch to threaded IRQ handler
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Alexey Charkov <alchark@flipper.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yongbo Zhang <giraffesnn123@gmail.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260311-fusb302-irq-v1-1-7e7105706629@flipper.net>
 <abKDG8wHJ-19c3AD@kuha> <63dfd90a-d54d-4d87-8c62-61a3c24d76fd@kernel.org>
 <20260312120418.99U0NPWL@linutronix.de>
 <22c94dd0-7bef-4682-acdb-905dd81f8083@kernel.org> <abmFHsVObD2GDquV@venus>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <abmFHsVObD2GDquV@venus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linutronix.de,linux.intel.com,flipper.net,linuxfoundation.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226894-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hansg@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D8312B1C03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 17-Mar-26 18:12, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Mar 13, 2026 at 05:21:33PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 12-Mar-26 13:04, Sebastian Andrzej Siewior wrote:
>>> On 2026-03-12 11:49:30 [+0100], Hans de Goede wrote:
>>>> Using a threaded interrupt handler should be ok, yes. This should
>>>> also fix the issue this patch tries to fix:
>>>>
>>>> https://lore.kernel.org/linux-usb/20260103083232.9510-4-linux.amoon@gmail.com
>>>
>>> This issue went away with commit a7fb84ea70aae ("usb: typec: fusb302:
>>> Remove IRQF_ONESHOT").
>>>
>>>> Normally an i2c device like this would use a threaded interrupt handler to
>>>> do all the work since I2C transfers can sleep combined with disabling the IRQ
>>>> on suspend to avoid the interrupt handler running while the parent i2c-adapter
>>>> may be suspended.
>>>>
>>>> The problem with the fusb302 is that it can be a wakeup source so we cannot
>>>> disable the IRQ. I worked around this in commit 207338ec5a2 ("usb: typec: fusb302:
>>>> Improve suspend/resume handling") by moving the actual work to a workqueue
>>>> and have a hard (non threaded) interrupt handler which disables the IRQ and
>>>> queues the work, with the work re-enabling the IRQ when done + special
>>>> handling for the suspended case. Basically our own manual oneshot.
>>>>
>>>> If we move the IRQ disabling to a threaded handler, which appears to be
>>>> necessary for some IRQ controllers (arguably a IRQ controller driver issue,
>>>> but this seems to be a re-occuring issue), then I wonder if we need
>>>> the ONESHOT flag again to avoid a level type IRQ re-triggering before
>>>> the threaded handler gets a chance to disable it (with the workqueue
>>>> item eventually re-enabling it).
>>>>
>>>> I think we need to re-add the ONESHOT flag, but maybe that is the default
>>>> with a primary NULL handler ?
>>>>
>>>> Sebastian Siewior I think you now the IRQ subsystem better then me,
>>>> any advice / remarks ?
>>
>> Sebastian, Thank you for your input.
>>
>>> You could do
>>> 	request_threaded_irq(chip->gpio_int_n_irq, NULL, fusb302_irq_intn,
>>> 			     IRQF_ONESHOT | IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);
>>
>> Ok, that is good to know.
>>
>>> which would ensure that the handler runs as a thread and the interrupt
>>> line is disable while it is active.
>>
>> That is what we want, thank you.
>>
>>> Then you could let fusb302_irq_intn() do what fusb302_irq_work() does.
>>> Since it is a thread, mutex_lock() works here.
>>
>> Right, but the resume handler needs to also schedule the work when the
>> IRQ is initially ignored if the IRQ triggers before the i2c_client's
>> resume-handler is called to ensure that the parent i2c-adapter is
>> ready when the IRQ handling code does i2c accesses.
>>
>>> Last step would be to replace fusb302_chip::irq_suspended with
>>> disable_irq() in fusb302_pm_suspend() and enable_irq() in
>>> fusb302_pm_resume().
>>
>> That unfortunately is not possible because the fusb302 maybe
>> a wake-up source so it cannot be disabled unconditionally
>> and without the disable_irq() / enable_irq() pair the IRQ
>> may trigger before the parent i2c-adapter is resumed.
>>
>> This is why the IRQ handling in this driver is as convoluted
>> as it is in the first place. With the IRQ handler setting
>> an irq_while_suspended flag if the IRQ runs before the
>> i2c_client resume and then with resume checking that flag
>> + queuing the work do to the actual IRQ handling once the
>> parent i2c-adapter is ready (if we hit this race).
> 
> After re-checking everything, I don't see anything special about the
> fusb302 and wondering a bit why this is not an issue with other
> devices like e.g. i2c-hid (which can also be wakeup sources, see
> e.g. HID devices on your Qualcomm T14s). Does that have the same
> issue and we are just not running into the race condition?

drivers/hid/i2c-hid/i2c-hid-core.c: i2c_hid_core_suspend()
does a disable_irq() AFAIK that is not really allowed for
a wakeup source. The wakeup source thingie likely still
works on x86 because x86 hw has a whole separate event
system in the hw for wakeup events.

The i2c-hid-core.c drivers also seems to miss calls
to enable_irq_wake() so they never configure the IRQ
as a wakeup source, further suggesting the handling there
is incomplete.

But on pure s2idle systems where there is only the 1 IRQ
mechanism disable_irq() will result in no wake-ups AFAIK
(as well as enable_irq_wake() being necessary to avoid the
IRQ getting disabled in the final stages of suspend).

Note I'm not very familiar with all this, so the above
could be very wrong ...

> In that case it might be sensible to move the logic for "interrupt
> function should only run after the device has been PM resumed" into
> the IRQ core behind a flag and simplify the drivers?

I do believe that having some sort of helpers for this,
either in the IRQ core, or in some drivers/base code
or some such, would be useful yes.

>> So as far as I can see the current state of fusb302 code
>> is good as is.
> 
> I think with the threaded irq handler, the code could be simplified
> to no longer use a worker thread. Instead the thread and the irq
> handler can be merged. It seems sensible to do this in a separate
> patch, though.

No that cannot be done, because the work will get scheduled
from fsusb302_resume() if the IRQ ran (and set a flag) before
fsusb302_resume() run and thus before the i2c-adapter parent
was ready.

One might be tempted to replace the queuing of the work
in fsusb302_resume() with a direct call to the threaded
interrupt handler. But the code relies on the workqueue
mechanism to also ensure that the threaded interrupt
handler does not run in parallel with itself.

If we drop the disable_irq() + queue-work + work does
enable_irq() pair currently done and instead bail early if
not resumed for the threaded handler and still set the flag
to redo the interrupt handling from the resume handler
then we may end up with 2 threads running the interrupt
handling in parallel.

I guess we could take some mutex for the entire run
of the threaded handler to deal with that but I'm not
sure if that would be an improvement.

Regards,

Hans



