Return-Path: <stable+bounces-249320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIg0IWcoC2pAEAUAu9opvQ
	(envelope-from <stable+bounces-249320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:55:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2A856F51B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48AAD3009896
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7592701C4;
	Mon, 18 May 2026 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7jgX5ql"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0C64AA4;
	Mon, 18 May 2026 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116129; cv=none; b=Jd/iAK8r6l4O9IEZ33l4MYlFFdF1K81PD0DQjVXhRfllYGjXgODbRIqZOy0hdPfxE/TG+GpP/k1XaDcDlShBXrlM/StghYve+kaIRHZasnOiVEr9bPOqQw8UYzOPad4xQbdWU9NgYkR96Co2mpI9vM8S/ZgZURZnaK/f/ASKW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116129; c=relaxed/simple;
	bh=cVvZUFt7bQm/47LolnTjjJG3c5UnAt293fdrUItpQ0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/ZoiJ0o4aOXyYObTv/32BKTko+B597cA5WUoKv0O9ZyVAOruFkMbc2yBPAizqthLSGtqKHwbrGco5VeaUTyAH+wq6btMNTe5DlRLqZ/79JmzjYIZEpiHh/aWsnA0rglQxpH5PXwfkUj5fsO31hRcNsh2k8QxUNWm1nh4g8tlKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7jgX5ql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8D4C2BCB7;
	Mon, 18 May 2026 14:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779116129;
	bh=cVvZUFt7bQm/47LolnTjjJG3c5UnAt293fdrUItpQ0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S7jgX5qlcRjn4iPJi0XDQsvwT8lKS4HzGC4CM84jvIBGPt3OCIauP2oWv0WCTJ8qi
	 IwzIa1l/AFvf+Eq7w+bpgalWt19uv4a7cOQ05wJ4kvtimRevO2HDd25UefvLptv0mG
	 v69ropgbm+ZLeo7cd4A8E6tEVuN5EgAA3wnrrWjqidDTf1/3yVouoNdarH/uclL2sP
	 lbfw0nUN6lwbNgJ+L4I3yHPlpE/kV27jlkGRqvfRwR07T+oUD/4r27LF5nHcPJFayp
	 ZCYF44ERbkruiRm8NFDn5cADNDOmxjy/e3QGCrKbcf2/3ne3+Iq5MqCRJjRoQBC28U
	 Sir647hgzr5jg==
Date: Mon, 18 May 2026 15:55:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Stepan Ionichev <sozdayvek@gmail.com>,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error
 paths
Message-ID: <20260518155521.6c61504d@jic23-huawei>
In-Reply-To: <agq4zER5Tv2LErZV@ashevche-desk.local>
References: <20260517160801.269-1-sozdayvek@gmail.com>
	<54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
	<3cb30f12-8b4f-415f-9a1d-823d8ff8c33b@gmail.com>
	<agq4zER5Tv2LErZV@ashevche-desk.local>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249320-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,baylibre.com,analog.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2A2A856F51B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 09:59:24 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, May 18, 2026 at 08:21:17AM +0300, Matti Vaittinen wrote:
> > On 17/05/2026 20:12, David Lechner wrote:  
> > > On 5/17/26 11:08 AM, Stepan Ionichev wrote:  
> 
> ...
> 
> > Maybe it would be better to do something like:
> > 
> > void iio_trigger_poll_nested(struct iio_trigger *trig)
> > {
> >         int i;
> > 
> >         if (!atomic_read(&trig->use_count)) {
> >                 atomic_set(&trig->use_count,
> > CONFIG_IIO_CONSUMERS_PER_TRIGGER);  
> 
> Just in case somebody is going to do that, avoid doing atomic_read() followed
> by atomic_set(). This is typical TOCTOU issue. This should be something like
> atomic_xchg() or atomic_add_return() or something like this in a single atomic
> operation.

Just to clarify - the current code is fine.  This got reported a few years
back and I did the analysis to prove it. From what I recall the key is
that the state space isn't as complex as it immediately looks.
That counter is either non 0 at the start (we don't use it here and we
skip an interrupt - that's actually the desired behaviour if the trigger is running
too fast - triggers must survive that - reenable() callback is there to make that
all work).

Otherwise there is a single path that sets it and we know any decrement until after
that happens would have undeflowed (and hence was a bug). The rest are decrement
only and it can never go to less than 0.

Hence it is fine.

Agreed things get messy if we make this alg any more complex though!

J
> 
> >                 for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
> >                         if (trig->subirqs[i].enabled)
> >                                 handle_nested_irq(trig->subirq_base + i);
> >                         else
> >                                 iio_trigger_notify_done(trig);
> >                 }
> > 		atomic_set(&trig->use_count, 0); /* Clear the use_count if drivers didn't
> > */
> >         }
> > }
> > 
> > to prevent this class of problems once and for all. But yeah, wiser minds
> > have designed this - so let's hear some other opinions as well :)  
> 
> 


