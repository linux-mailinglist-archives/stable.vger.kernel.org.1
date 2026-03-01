Return-Path: <stable+bounces-222451-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PW7DUsjpGmMYAUAu9opvQ
	(envelope-from <stable+bounces-222451-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 12:30:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B6A1CF576
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 12:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95933301476D
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3082EDD7E;
	Sun,  1 Mar 2026 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQjonMJP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38D31FC0EF;
	Sun,  1 Mar 2026 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772364615; cv=none; b=TbfMhRf8ogjRRyp3goUMVJPEIDzz1yQvsI42m4wWiMvlu+Ten5gMSjodnBFwK3phr6QNt667tW+Dni4MLIUuCr6dHkIo9aZkiYiCPttzne8irJGmcul0Z27Uf3F+/M5yhZBR6uQIDl6Rt6cxjwcxgbmXeSLEJ7OkxbJGjEaWOHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772364615; c=relaxed/simple;
	bh=u+p0UmuTEdO0c/v9oX5OAyz3hCwhKypKchQNPZWM0F8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdA0PLH38TjFx8YSWDawSTgTCqeQoi4cwf3kS8/ofrQQdjVZEADH/wcJMgz6RB8n6eSi/58VI8yw0aSfcJx++20QfWLVmtxTsm0w3JWk7DdPNSROYCSXZpjZ2iFh/s0BPBvYxcVXZfY/JsixfvWwksLcalyUR8vzxooBO4EMUU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQjonMJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EFAC116C6;
	Sun,  1 Mar 2026 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772364614;
	bh=u+p0UmuTEdO0c/v9oX5OAyz3hCwhKypKchQNPZWM0F8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aQjonMJP0XsEzmPTwHdxSMhhBHIcp3Wi9sW5d68IoFWXbb6Mwn3PA97uTSl95B2CN
	 bYXGamEzrbjDW5IPHzi4OJwGW+D5wMNMu0iaDmxA+C+cwMMWSfK5HZz1OLE4ID68AF
	 /wMbzIndTrG2phaEDM7r+SGoIrLZyw8KWWwnZYYoRvBbFGfpbkB3Dj2oQdoEIB2z3R
	 Fc/bUVhQGFHMxCG3BtxMl960LL0+mArL+IwUHc8JD7PmGL0GSQvwlaz/HOz/vy7vvX
	 ZySu35mHwQtANHmbfjlyUeNAS1aYG695qUvdH8tMkEB3HAPA68Ta2wDFA4xOrSk/h8
	 7N5DmyNxGUYTQ==
Date: Sun, 1 Mar 2026 11:30:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: st_sensors: fix trigger allocation
Message-ID: <20260301113006.41af67bb@jic23-huawei>
In-Reply-To: <4FQ68Smsz_F43-ks0XkXrc7KG3Ngp1kNuSerbAMvDFkgsR_p6MyzTvFB6_pozp-R2WrQqvB2NsKhaDBXjcjAEL8uLeiiyl0tWGGpaHCFYKQ=@vinarskis.com>
References: <20260228-st-iio-trigger-v1-1-abf5909e547f@vinarskis.com>
	<20195663-2091-41eb-b4b3-e8542d29ae32@baylibre.com>
	<4FQ68Smsz_F43-ks0XkXrc7KG3Ngp1kNuSerbAMvDFkgsR_p6MyzTvFB6_pozp-R2WrQqvB2NsKhaDBXjcjAEL8uLeiiyl0tWGGpaHCFYKQ=@vinarskis.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222451-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3B6A1CF576
X-Rspamd-Action: no action

On Sun, 01 Mar 2026 10:50:10 +0000
Aleksandrs Vinarskis <alex@vinarskis.com> wrote:

> On Saturday, February 28th, 2026 at 20:22, David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 2/28/26 11:11 AM, Aleksandrs Vinarskis wrote:  
> > > Current hardcoded name prevents adding multiple st-sensors devices
> > > on the same platform. Fix by aligning trigger name with other drivers.
> > >
> > > Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
> > > ---
> > > Some platforms such as Dell XPS 9345 contains multiple accelerometers.
> > > Fix st_sensors that currently only allows one device at the time.
> > > ---
> > >  drivers/iio/common/st_sensors/st_sensors_trigger.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > index 8a8ab688d7980f6dd43c660f90a0eba32c38388b..3b5615d1b6dd66ee0af6ccc83eb2fbd7b2c64d29 100644
> > > --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > @@ -124,8 +124,9 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
> > >  	unsigned long irq_trig;
> > >  	int err;
> > >
> > > -	sdata->trig = devm_iio_trigger_alloc(parent, "%s-trigger",
> > > -					     indio_dev->name);
> > > +	sdata->trig = devm_iio_trigger_alloc(parent, "%s-dev%d",
> > > +					     indio_dev->name,
> > > +					     iio_device_id(indio_dev));  
> > 
> > Is this something that could potentially break userspace? Or are all of these
> > just "always there" triggers that userspace doesn't have to touch?  
> 
> I don't see why it would. This simply makes the name of the registered
> trigger globally unique, the same way like other drivers already do.
> Userspace does care about these but it relies on capabilities as per
> my understanding to figure what sensor it is. I have tested it with
> `monitor-sensors`, which relies on `iio-sensor-proxy`: in both cases
> accelerator device was detected.

Most userspace hopefully relies on the relationship between the trigger
and the device (basically that they have the same parent) rather than the
explicit name, but it is always possible someone does have a script using
this name.  I don't think these drivers are setting a default (which is
reasonable as IIRC they have always supported other triggers and people
have a habit of not wiring the interrupts up).

So David's right that this could cause a user visible regression. 
We might get away with it though.

Today, iio_trigger_acquire_by_name() just matches the first one with a
given string.   This isn't a fast path so we could be a little cleverer
and add a heuristic that first tries to find a trigger with that name
and a common parent device.  If that fails, it just falls back to the
current approach?  That way it would do the right thing in cases like
the one seen here, but we'd not be able to have one ST sensor trigger
off a specific other on - not sure that's a big loss however as it
is fairly unusual to do that for similar sensor types.

What do people think?  Alex, would that work for your case?

Jonathan



> 
> Alex
> 
> >   
> > >  	if (sdata->trig == NULL) {
> > >  		dev_err(parent, "failed to allocate iio trigger.\n");
> > >  		return -ENOMEM;
> > >
> > > ---
> > > base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
> > > change-id: 20260228-st-iio-trigger-8ee1f219b566
> > >
> > > Best regards,  
> > 
> >   


