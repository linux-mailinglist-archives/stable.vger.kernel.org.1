Return-Path: <stable+bounces-225353-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAZiJJ86tGk4jQAAu9opvQ
	(envelope-from <stable+bounces-225353-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:26:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B17286F8B
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFC4F3043D31
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A3B3A256A;
	Fri, 13 Mar 2026 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNhdfnFC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB4371CF9;
	Fri, 13 Mar 2026 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418897; cv=none; b=ekWlxEnB6t0dhZjNnITiQxO9L9lEqWBDwXnqPCN/sFNRGuQXJ9dau3WYOht5kfbWCWo9bDwkDuJ34/bu3g59iWl8MK62zPMx8j8dsJvGOfWP3M6Yt2wM/A772iTqBm9cEN47rjkEI/dbSgCsAEIhcs3TUWEQAMwEDR/J+EHS4pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418897; c=relaxed/simple;
	bh=Cp8x8Bv0sxIKPeMyGLBJaZhu+zViKlpdZD/FAbUs4cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZGcYbYdcjz6E85RzvkZGTTYM9lTWCD9Ch/RQBswmm3lnFwj02zsxgJAr9qU/gGXIqlAptN04yudFX1SABj0+Zl92hA+AATd6UEd9jREdCN+iBfCxzSKZl9VUAQ2J4yik1kp7cBL91wnLYrYwwHafh6RTVoOzjyI3J1u9cgAvB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNhdfnFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6EBC19421;
	Fri, 13 Mar 2026 16:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773418897;
	bh=Cp8x8Bv0sxIKPeMyGLBJaZhu+zViKlpdZD/FAbUs4cI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nNhdfnFCIoNU4XkA8fVhSHYP4g9k/hEJErZ4cTYsWhwAPhRnG+G/KMAs0ftrbuNJn
	 RwdjaeCPXgCJxjQhS/5WaG0GJ3VAvSyGNOfuSCPnlomMf34fT+j1ctc1a4c5BM+Mwb
	 JHi4Gq6c31f/m9fDlltiDdKiq+2CHVE68c7WR0OyfA9ZRBh4oulgpzklQPJF3ujPG/
	 FC4SICizdRuslF+pAUcJb9spBRd6yxx8c5arDHQ7cZ812fgREcxHaH/75eQwuS2oxM
	 RV5tUhJMvf9rX8kh/IiWo/hbbDx+juUVHxSUv1lCqUxVwpDneMKy0+dl4O1FMIr5/H
	 5wW4em+i3bLYg==
Message-ID: <22c94dd0-7bef-4682-acdb-905dd81f8083@kernel.org>
Date: Fri, 13 Mar 2026 17:21:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: fusb302: Switch to threaded IRQ handler
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Alexey Charkov <alchark@flipper.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yongbo Zhang <giraffesnn123@gmail.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260311-fusb302-irq-v1-1-7e7105706629@flipper.net>
 <abKDG8wHJ-19c3AD@kuha> <63dfd90a-d54d-4d87-8c62-61a3c24d76fd@kernel.org>
 <20260312120418.99U0NPWL@linutronix.de>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260312120418.99U0NPWL@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,flipper.net,linuxfoundation.org,collabora.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225353-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hansg@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06B17286F8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 12-Mar-26 13:04, Sebastian Andrzej Siewior wrote:
> On 2026-03-12 11:49:30 [+0100], Hans de Goede wrote:
>> Using a threaded interrupt handler should be ok, yes. This should
>> also fix the issue this patch tries to fix:
>>
>> https://lore.kernel.org/linux-usb/20260103083232.9510-4-linux.amoon@gmail.com
> 
> This issue went away with commit a7fb84ea70aae ("usb: typec: fusb302:
> Remove IRQF_ONESHOT").
> 
>> Normally an i2c device like this would use a threaded interrupt handler to
>> do all the work since I2C transfers can sleep combined with disabling the IRQ
>> on suspend to avoid the interrupt handler running while the parent i2c-adapter
>> may be suspended.
>>
>> The problem with the fusb302 is that it can be a wakeup source so we cannot
>> disable the IRQ. I worked around this in commit 207338ec5a2 ("usb: typec: fusb302:
>> Improve suspend/resume handling") by moving the actual work to a workqueue
>> and have a hard (non threaded) interrupt handler which disables the IRQ and
>> queues the work, with the work re-enabling the IRQ when done + special
>> handling for the suspended case. Basically our own manual oneshot.
>>
>> If we move the IRQ disabling to a threaded handler, which appears to be
>> necessary for some IRQ controllers (arguably a IRQ controller driver issue,
>> but this seems to be a re-occuring issue), then I wonder if we need
>> the ONESHOT flag again to avoid a level type IRQ re-triggering before
>> the threaded handler gets a chance to disable it (with the workqueue
>> item eventually re-enabling it).
>>
>> I think we need to re-add the ONESHOT flag, but maybe that is the default
>> with a primary NULL handler ?
>>
>> Sebastian Siewior I think you now the IRQ subsystem better then me,
>> any advice / remarks ?

Sebastian, Thank you for your input.

> You could do
> 	request_threaded_irq(chip->gpio_int_n_irq, NULL, fusb302_irq_intn,
> 			     IRQF_ONESHOT | IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);

Ok, that is good to know.

> which would ensure that the handler runs as a thread and the interrupt
> line is disable while it is active.

That is what we want, thank you.

> Then you could let fusb302_irq_intn() do what fusb302_irq_work() does.
> Since it is a thread, mutex_lock() works here.

Right, but the resume handler needs to also schedule the work when the
IRQ is initially ignored if the IRQ triggers before the i2c_client's
resume-handler is called to ensure that the parent i2c-adapter is
ready when the IRQ handling code does i2c accesses.

> Last step would be to replace fusb302_chip::irq_suspended with
> disable_irq() in fusb302_pm_suspend() and enable_irq() in
> fusb302_pm_resume().

That unfortunately is not possible because the fusb302 maybe
a wake-up source so it cannot be disabled unconditionally
and without the disable_irq() / enable_irq() pair the IRQ
may trigger before the parent i2c-adapter is resumed.

This is why the IRQ handling in this driver is as convoluted
as it is in the first place. With the IRQ handler setting
an irq_while_suspended flag if the IRQ runs before the
i2c_client resume and then with resume checking that flag
+ queuing the work do to the actual IRQ handling once the
parent i2c-adapter is ready (if we hit this race).

So as far as I can see the current state of fusb302 code
is good as is.

Except for the problem on case the IRQ line is connected to
the mentioned i2c GPIO expander in this email thread.

I think that proper handling of the sync mechanism for IRQ
chips attached to busses where IO to the IRQ chip may sleep
should fix this. But this seems to keep coming up, so I'm
tempted to just move the IRQ handler to a thread, to avoid
problems with disable_irq_nosync() not working from
"hard" IRQ handlers with some IRQ chip drivers.

TL;DR:

I think doing this:

 	request_threaded_irq(chip->gpio_int_n_irq, NULL, fusb302_irq_intn,
 			     IRQF_ONESHOT | IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);

as you suggest is the best way forward here.

This does what the original patch in this thread suggested,
with the modification that it re-adds the IRQF_ONESHOT flag.

Regards,

Hans



