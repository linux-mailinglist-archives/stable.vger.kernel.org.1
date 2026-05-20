Return-Path: <stable+bounces-249805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLi5EWyPDWoIzQUAu9opvQ
	(envelope-from <stable+bounces-249805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:39:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B43BB58BDF0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA564300821F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5066C3D904C;
	Wed, 20 May 2026 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9goHgLp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546463D8117;
	Wed, 20 May 2026 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273567; cv=none; b=rHEBvPcUBw/1HEBYu5jdxYNfmLPehmdBwuMvMTMNygeZ+FFsid/oJamLvqo/8M9MbVcmqx6EcT2fs5+ACYn70Kqzdx/3COYFzD2oCM/TXu+Qadp7zKMsI9DC0S7xTqVqa6CCSqOvLJwW20dIMBV+2t3tgusD1aPYYifEYE3qlww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273567; c=relaxed/simple;
	bh=5JJDNR+dZSYvqZY2l3m6GIwe+YErFLstimjoZfOAABI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=reoOhkVn0mLhWIA1JCJh/8JypQJNH8Y34vvJHqf+0r9s/M+hE75g/8htOfkd6zU2GVv4M0PNIH3e1Dy7fA5/UnUgQbw3mqd4P0bUnCBuvmp7jyYvXxN92LDNn/TdEZ+VooWJdHKQqb2RMW6KzQG/0itt+90GiVeF++Bsd+AIrBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9goHgLp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6321F000E9;
	Wed, 20 May 2026 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779273560;
	bh=8kFn9W05qyL1k/0OdwAdZn7KvbzCgH579qyEY6ai480=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z9goHgLpSpjaUCEYm71hbEKdr1WxNNGkPRC5VJxaCIG0wP/wWzInzAT2uhCxeQzcN
	 6ByUkJTvWawtcB7uxLMVB+W/aBCxbh+rUgMJxH+1SS9gJ0bceN9H5AfrkgvxcsSkO0
	 kA3JOFB2A0lR+KhKK9ket29iYSiIk8MBLDw1lkvfIJ/XT5DmhVFCeB5T9OoHtVEbjK
	 LN58gFfVD7bZM7L8AkZoS8qVaeFHVBDCJ27uJnRS80HPPpCf2KkHBPJ3ssdgNIXSUu
	 ZvG5NsyIpx0lKc9sLnQsfqSeqfPkkhMPSIavxITWhzx5UuapLgtwC6rJO2S/odkPa/
	 ktCFczP1/GOaQ==
Date: Wed, 20 May 2026 11:39:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Stepan Ionichev <sozdayvek@gmail.com>,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error
 paths
Message-ID: <20260520113914.7af0bdf7@jic23-huawei>
In-Reply-To: <agtbFDbw2m9ptEua@ashevche-desk.local>
References: <20260517160801.269-1-sozdayvek@gmail.com>
	<54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
	<3cb30f12-8b4f-415f-9a1d-823d8ff8c33b@gmail.com>
	<agq4zER5Tv2LErZV@ashevche-desk.local>
	<20260518155521.6c61504d@jic23-huawei>
	<agtbFDbw2m9ptEua@ashevche-desk.local>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249805-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,baylibre.com,analog.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B43BB58BDF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 21:31:48 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, May 18, 2026 at 03:55:21PM +0100, Jonathan Cameron wrote:
> > On Mon, 18 May 2026 09:59:24 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Mon, May 18, 2026 at 08:21:17AM +0300, Matti Vaittinen wrote:  
> > > > On 17/05/2026 20:12, David Lechner wrote:    
> > > > > On 5/17/26 11:08 AM, Stepan Ionichev wrote:    
> 
> ...
> 
> > > > Maybe it would be better to do something like:
> > > > 
> > > > void iio_trigger_poll_nested(struct iio_trigger *trig)
> > > > {
> > > >         int i;
> > > > 
> > > >         if (!atomic_read(&trig->use_count)) {
> > > >                 atomic_set(&trig->use_count,
> > > > CONFIG_IIO_CONSUMERS_PER_TRIGGER);    
> > > 
> > > Just in case somebody is going to do that, avoid doing atomic_read() followed
> > > by atomic_set(). This is typical TOCTOU issue. This should be something like
> > > atomic_xchg() or atomic_add_return() or something like this in a single atomic
> > > operation.  
> > 
> > Just to clarify - the current code is fine.  This got reported a few years
> > back and I did the analysis to prove it. From what I recall the key is
> > that the state space isn't as complex as it immediately looks.
> > That counter is either non 0 at the start (we don't use it here and we
> > skip an interrupt - that's actually the desired behaviour if the trigger is running
> > too fast - triggers must survive that - reenable() callback is there to make that
> > all work).
> > 
> > Otherwise there is a single path that sets it and we know any decrement until after
> > that happens would have undeflowed (and hence was a bug). The rest are decrement
> > only and it can never go to less than 0.
> > 
> > Hence it is fine.
> > 
> > Agreed things get messy if we make this alg any more complex though!  
> 
> Perhaps we need a good comment just on top of this atomic_read()/atomic_set()
> pair. Because it's really the code no one should take as an example how to do
> atomics :-) Logical question, why do we even have atomics there? Shouldn't
> be that READ_ONCE()/WRITE_ONCE() to have an integrity in place? (This I believe
> even mentioned in the documentation for atomics.)

There are atomic decrements elsewhere that need to be (multiple drivers
can decrement at the same time) and mixing and matching between atomic accessors
and non atomic is a mess.

Comment wise. I'd like to say I'll get to it, but unlikely it'll be soon.

Jonathan


> 
> > > >                 for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
> > > >                         if (trig->subirqs[i].enabled)
> > > >                                 handle_nested_irq(trig->subirq_base + i);
> > > >                         else
> > > >                                 iio_trigger_notify_done(trig);
> > > >                 }
> > > > 		atomic_set(&trig->use_count, 0); /* Clear the use_count if drivers didn't
> > > > */
> > > >         }
> > > > }
> > > > 
> > > > to prevent this class of problems once and for all. But yeah, wiser minds
> > > > have designed this - so let's hear some other opinions as well :)    
> 


