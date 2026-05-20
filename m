Return-Path: <stable+bounces-249811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ4qDrSWDWoMzwUAu9opvQ
	(envelope-from <stable+bounces-249811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:10:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9141458C213
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F12FF303A935
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B893DA7D3;
	Wed, 20 May 2026 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh6GDSVo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A983D3A4520;
	Wed, 20 May 2026 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275313; cv=none; b=ABv9KgDV9pIayg8B3/dnorx6wEVEm0iMX2O+s6LhRbSea1uqZa5OSeqDeICn8DWGGIncqjXWm3Fn4b/BWU1ktzUechuaz3gJVAOH95RFxA7R7PChV9/FuhdcDK+7QWTo1smODs2Sos0t3K6k79t30jMYV7bzJvuDuPcQ0m/94DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275313; c=relaxed/simple;
	bh=s9gIFjuqSq7HcN7GhoLjSkrZcGPyBmjz7TS5KGEoZWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkfWsRy09/eRA1T4G5tYyiX8iXBsxbqhHST2g75Fb0Rl9MStsjvYBX6NQtvtuXa3Rlt420AIjIGCJXJolbcn0yksJT/6PdG63a5Clx+ggKS+LBXVlNc8TX3gas63wK0SAxpqeknI9SYJ+1YdNEZb3PoIsc0PYXv/PkM2EttHj5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh6GDSVo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5798A1F000E9;
	Wed, 20 May 2026 11:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779275311;
	bh=DZDmUbfH2zCPIuRupE0bKTHndS0jrMizmuFeowVAL0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eh6GDSVoeFK1YXqKcBXJP141Rwf3EB8VYyCLvgVPBVSPfTlGMPde6eb7WilvdECex
	 S/WhoWkMcOEPTp+0J0ImXLGSamjj1goxKhhMI88+3aKOEKvAZDcWVMVXNmBr+Zrubu
	 T/fnT5gPBybspdMjxhl63PJqt3iDAcSU+GMF3R9W8b/zZ0oOQBjyRUePSYaj0TCe4x
	 JXB4SErdDWPuQdPJ/tCaG7dzWKKplWedSUHcdLOhOcKZ+6TSxjOuUhko6HcehRuwC8
	 b8tkJTWDGtT3MahpUYLgCn2n176qv934GHjNB6270MOPZnePd3l7Hk0Hh0DITRmGlU
	 x3d9yY6g4ebSQ==
Date: Wed, 20 May 2026 12:08:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: rohm-bm1390: notify trigger on all
 error paths
Message-ID: <20260520120822.351aa58f@jic23-huawei>
In-Reply-To: <61d9cec3-6aed-416f-9604-94fe94cb2e3b@gmail.com>
References: <20260517160801.269-1-sozdayvek@gmail.com>
	<20260518094238.1986-1-sozdayvek@gmail.com>
	<20260518161516.53f21777@jic23-huawei>
	<61d9cec3-6aed-416f-9604-94fe94cb2e3b@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249811-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,baylibre.com,analog.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9141458C213
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 08:48:13 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Thanks Jonathan,
> 
> Your post give me something to think about ;)

This is a can of worms.  More below.

I'm unconcerned as long as (and ideally someone should check it)
we can get of being stuck by unbind/rebind of driver.  Anything
else is best effort.


> 
> On 18/05/2026 18:15, Jonathan Cameron wrote:
> > On Mon, 18 May 2026 14:42:38 +0500
> > Stepan Ionichev <sozdayvek@gmail.com> wrote:
> >   
> >> bm1390_trigger_handler() returns from three error paths without
> >> calling iio_trigger_notify_done(). The success path at the end
> >> does, so on a single transient regmap or read failure the trigger
> >> use_count is never decremented, and the !atomic_read(&trig->use_count)
> >> guard in iio_trigger_poll_chained() drops every subsequent dispatch.
> >> The buffered-data flow stays wedged until the trigger is detached.
> >>
> >> Funnel all returns through a single done label that calls
> >> iio_trigger_notify_done() and reports the outcome via IRQ_RETVAL().
> >>
> >> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>  
> > 
> > These error path 'fixes' are fixes for hardware failure - so if anything
> > they are hardending  against a possible error condition. I don't mind
> > that bit it's not a bug to not do this so fixes tag an stable are not
> > appropriate for any of these.
> > 
> > Note however that hardening against these conditions is not this simple.
> > It takes careful analysis of exactly how the hardware behaves and what
> > each error condition 'might' mean.  Whilst they are probably harmless
> > I'm also very dubious about taking them without comprehensive testing
> > on the particular device.
> >   
> >> ---
> >> v2:
> >> - Use a bool and IRQ_RETVAL() instead of irqreturn_t (Andy)
> >>
> >> v1: https://lore.kernel.org/all/20260517160801.269-1-sozdayvek@gmail.com/
> >>
> >>   drivers/iio/pressure/rohm-bm1390.c | 15 ++++++++++-----
> >>   1 file changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
> >> index 08146ca0f..81368e578 100644
> >> --- a/drivers/iio/pressure/rohm-bm1390.c
> >> +++ b/drivers/iio/pressure/rohm-bm1390.c
> >> @@ -626,12 +626,15 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
> >>   	struct iio_poll_func *pf = p;
> >>   	struct iio_dev *idev = pf->indio_dev;
> >>   	struct bm1390_data *data = iio_priv(idev);
> >> +	bool handled = true;
> >>   	int ret, status;
> >>   
> >>   	/* DRDY is acked by reading status reg */
> >>   	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);  
> > So question 1.
> > - What actually is device state if this read fails?  We have no idea.
> >    It might have failed on the 'to device' path in which case the device
> >    didn't see the read.  Or it might have failed on the 'from device path'.
> > 
> > Gets more complex...
> >   
> >> -	if (ret || !status)
> >> -		return IRQ_NONE;  
> > 
> > The trigger in use might well be the dataready trigger provided by this driver
> > (though I note this device has no validate callbacks so we do allow other
> > triggers - that may or may not be a bug!)  I really dislike read to clear
> > register designs as they make this stuff more complex.  
> 
> I have a strong feeling it should be the dataready. Still, I have no 
> idea about actual systems using this driver, so I am a bit cautious 
> adding new restrictions.

If we can show it is broken with any of the other triggers then
we can add the restriction without it being a potential regression. Not sure
if that is doable - easiest way would be to just try it and see.


> 
> > Anyhow question 2:
> > - What happens if we don't clear it and do acknowledge the interrupt plus
> > ack the trigger (which is what iio_trigger_done() is doing?
> >    Two obvious options - wedged device, it re interrupts immediately.
> > If we are wedged, then meh device dead. Without adding retry loops
> > (don't) recovery path is reset the driver by unbinding and rebinding.  
> 
> The BM1390 keeps the IRQ pin asserted.
> 
> > Fun follow up is what happens if having acked the data ready trigger
> > by this read, we get another read before getting to iio_trigger_notify_done()?
> > 
> > Quite possibly we wedge.  
> 
> I see. This isn't fun at all. Even more so if the trigger use-count now 
> prevents us from calling the handler, and returning further IRQ_NONEs, 
> preventing the safety-mechanism intended to disable the offending IRQ. I 
> have a feeling there is IRQF_ONESHOT set though, so perhaps we are safe 
> from this (when no error path is taken in the handler).

Good point.

You are right (I think!) that saves us if using the trigger in this driver
because the trigger is fired by iio_trigger_poll_nested()/handle_nested_irq()
which runs the thread_fn()s for (pollfunc threads) in the thread belonging
to the trigger interrupt.

If we had a trigger that was doing in the top half (iio_trigger_poll()) then
it would get messier but I think that could only slew the data by a sample
which isn't too bad (as we don't need this interrupt to happen). 

If we return an error because we know it's not our interrupt then we should
be fine anyway because our interrupt will turn up later (as long as that
is in the trigger itself).

> 
> > This drivers trigger may be missing a reenable() callback
> > (which would typically reread the status register to clear any such interrupt).  
> 
> Which works for case where we "get another read before getting to 
> iio_trigger_notify_done()" - but not for a case where we might have the 
> bus stuck, causing read errors.

If bus is stuck, I'm of the view recovery unlikely and if it really is a once
in a blue moon thing, unbind and rebind the driver.

> 
> > Whether it does is again a device implementation specific thing.
> > 
> >   
> >> +	if (ret || !status) {
> >> +		handled = false;
> >> +		goto done;
> >> +	}
> >>   
> >>   	dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
> >>   
> >> @@ -639,7 +642,8 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
> >>   		ret = bm1390_pressure_read(data, &data->buf.pressure);
> >>   		if (ret) {
> >>   			dev_warn(data->dev, "sample read failed %d\n", ret);
> >> -			return IRQ_NONE;
> >> +			handled = false;
> >> +			goto done;  
> > 
> > Hopefully all this stuff is unrelated to the trigger.  For these it is fair to
> > ack the trigger and the interrupt.  Curiously the driver does it partly for the
> > next one (IRQ_HANDLED).  
> 
> I would keep the IRQ_NONE here because, if we keep constantly failing 
> the reads, then the bus is likely to be unerliable - and disabling the 
> useless IRQ is probably very sane thing to do. It should help debugging. 
> What comes to acking the trigger - I am starting to agree with Stepan, 
> we should probably ack the trigger in any case. If we don't ack the 
> trigger, then the IRQ_NONE does not serve the purpose it is intended for.

The interrupt that we'd get spurious detection on here would not be the device
one it would be the software emulated one deep in the iio trigger stuff.

Might still be useful for debug. Anyone fancy hacking an error in and reporting
back what we actually get from the debug hardware?  (with that trigger acked
as you suggest?)


> 
> >>   		}
> >>   	}
> >>   
> >> @@ -648,15 +652,16 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
> >>   				       &data->buf.temp, sizeof(data->buf.temp));
> >>   		if (ret) {
> >>   			dev_warn(data->dev, "temp read failed %d\n", ret);
> >> -			return IRQ_HANDLED;
> >> +			goto done;
> >>   		}
> >>   	}
> >>   
> >>   	iio_push_to_buffers_with_ts(idev, &data->buf, sizeof(data->buf),
> >>   				    data->timestamp);
> >> +done:
> >>   	iio_trigger_notify_done(idev->trig);
> >>   
> >> -	return IRQ_HANDLED;
> >> +	return IRQ_RETVAL(handled);  
> > If we are doing this Andy's suggestion of a helper is neater.
> > 
> > Anyhow, upshot is to get this stuff right requires device specific knowledge.  
> 
> And time... :)

Absolutely - I see it as value add, so its a business decision to work
through all these or not.

> 
> > Ideally the author tests injecting errors at each point to verify if the
> > data capture survives.  However, it's up to a driver author to decide if they
> > care.  There are normally dozens of paths in a driver that will result in needing
> > a reset (unbind/bind for most IIO drivers) - that's expensive, complex, fragile
> > handling code to maintain, so personally I consider it optional.  
> 
> I am not going to try adding any such recovery code in driver. I am 
> afraid it would be way too complex for me to maintain (with my memory, 
> code I've seen last month is new Today) for the added benefit. If we 
> have such a delicate system where this type of 'failure recovery w/o 
> reset' is required, then such code should (in my opinion) be system 
> specific and not generic. Most of the device users will never benefit 
> from it, but will need to look at it...
> 
> What I DO care is the IRQ gets disabled (from host side) if it can't be 
> acked (from device side). That shouldn't be so complex (although, it 
> seems it is more complex I thought when I wrote this driver).
> 
> After all this babbling I've done - if I understood it right, omitting 
> the call to iio_trigger_notify_done() will prevent further returns of 
> the IRQ_NONE, even if the IRQ stays asserted. So yes, I would definitely 
> like to see this fix getting in.

I think you are right on this, but I'd kind of like someone to hammer
some hardware to verify it. I'm not set up to do that today (even in
emulation) but could get to it at some point. 

The bit that makes me a bit doubtful is if this is a level interrupt
and the clear is in the trigger handler I think we get an interrupt
storm anyway - even with IRQ_NONE because that IRQ_NONE is for the
nested interrupt.  We keep return IRQ_HANDLED from the main thread irq
despite not actually doing anything.

That's hard behavior to fix in the core as that skip is intended for
annoying free running edge triggers - which are only ones where this race
'should' happen. Those can run faster than we can actually read data
and so we want to drop a scan.   Maybe we could cap the number
that are skipped so we eventually report a problem from
iio_trigger_poll_nested() or push that decision up to the caller?
This would rely on not call iio_trigger_poll_done() in IRQ_NONE on
the 'software' interrupts in that pollfuncs come from.

bool iio_trigger_poll_nested(struct iio_trigger *trig)
{
	int i;

	if (!atomic_read(&trig->use_count)) {
		atomic_set(&trig->use_count, CONFIG_IIO_CONSUMERS_PER_TRIGGER);

		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
			if (trig->subirqs[i].enabled)
				handle_nested_irq(trig->subirq_base + i);
			else
				iio_trigger_notify_done(trig);
		}
	} else {
		return false;
	}
	return true;
}

Then check that in the caller. That will tell us someone didn't finish
the previous trigger. Note it's still not fun because if we let other consumers
use the trigger, one of those might be running slow and do we want to throttle
the capture to every other interrupt (which incidentally means the
clear should be in the trigger irq handler, not the one grabbing the data).
Ah - that's a good reason to add a validate_device to the trigger.  It is
broken anyway for other devices using this trigger.

This feels like yet another case where we need some docs on best
practice and acceptable options.

Gah. I hate analysing error paths in complex flows. Lunch time!

Jonathan

> 
> Thanks guys for giving me a lesson again!
> 
> >   
> >>   }
> >>   
> >>   /* Get timestamps and wake the thread if we need to read data */  
> >   
> 
> Yours,
> 	-- Matti
> 
> ---
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
> 
> ~~ When things go utterly wrong vim users can always type :help! ~~


