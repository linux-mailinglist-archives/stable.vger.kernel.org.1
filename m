Return-Path: <stable+bounces-260160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yh/uBIxlIGqr2gAAu9opvQ
	(envelope-from <stable+bounces-260160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 19:34:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 451B763A2EB
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 19:34:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PtfUdzTN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260160-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260160-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C9B8304E6BF
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 17:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1AE40B6DC;
	Wed,  3 Jun 2026 17:23:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15B1D5AD4;
	Wed,  3 Jun 2026 17:23:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507436; cv=none; b=H1oYPXQ339YTIBTb45EKwAjA5d0o+oxe2+wzj92eXgpqFSsMsURB3D0/FYrbLYNLnbQmE+FkSeaD8/KaBfDHXzpKyH6V2G0ExYhV6XzPXMutvTRJzJ9CARLhAOennvtizz7IlxGYIe2bUZh8eDv3AwWNQmf//xNqmoyEwQEFW8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507436; c=relaxed/simple;
	bh=L0ztGsG26Vg4Ee9vhR2Uk0Aq1MMIhTmOzV0SGtPy2oU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8tLS62d8Mt5XQUMdxJNDKKNTyje+G14AAR9N/M3nHFdZ1MYrQdbTCX2FQaHXmTFSOlTjW56bdB1V5yI1SnLIhWAkG45+Gvb+WsSkHpEP+AJz+w5dAHZXwrRPB4LzyAmd4hO4Lziye5I6p6sFTS7ZfzAMJSe+QDvGZ+H3cuG9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtfUdzTN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670101F00893;
	Wed,  3 Jun 2026 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780507435;
	bh=7HrtUdDVGF6UfKCIYxU95uwLTmXLUTfuBIpJ9Qf5KPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PtfUdzTNTaiIb1SxNCVt2hJGyvm1qTfPv7Bvml3jPIAk1NVd0OnJWyvXb2fU2yqNW
	 Nwyswvk5tHbzG8Ye6m8WBthdUR/l2jNj+0LApGtYlaYEUvnwmq5t3+ElzPLQFi5GHV
	 zJxj8TaLJ+hlipaO0OSgESuhHQEgFOboBH9YUEcU9hbRn9LnPuKxBtagigtltZb6aS
	 tRqtvF2pjv28rq5cz6qBCLuSZS8FogefeiXLUVIACIDmpA3fLgKWdzXGF5dzDs+iOl
	 3EtNQCToh8HLPdy9Y4KQmcVMfC+JN926zDCioQ1VG9YfazEAtE/LocCchKLPE9bT+t
	 iEHO5PJuUDi3g==
Date: Wed, 3 Jun 2026 18:23:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 hcazarim@yahoo.com, joshua.crofts1@gmail.com, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: tsl2591: return actual error from probe
 IRQ failure
Message-ID: <20260603182345.5fdb66b5@jic23-huawei>
In-Reply-To: <20260518164309.04ed238f@jic23-huawei>
References: <20260517181042.668-1-sozdayvek@gmail.com>
	<20260518094311.2000-1-sozdayvek@gmail.com>
	<20260518163647.3b4966fb@jic23-huawei>
	<20260518164309.04ed238f@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260160-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sozdayvek@gmail.com,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:hcazarim@yahoo.com,m:joshua.crofts1@gmail.com,m:gregkh@linuxfoundation.org,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:joshuacrofts1@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[baylibre.com,analog.com,kernel.org,yahoo.com,gmail.com,linuxfoundation.org,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,jic23-huawei:mid,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 451B763A2EB

On Mon, 18 May 2026 16:43:09 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 18 May 2026 16:40:48 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Mon, 18 May 2026 14:43:11 +0500
> > Stepan Ionichev <sozdayvek@gmail.com> wrote:
> >   
> > > When devm_request_threaded_irq() fails, probe logs the error and
> > > then returns -EINVAL, dropping the real error code and breaking the
> > > deferred-probe flow for -EPROBE_DEFER.
> > > 
> > > Return ret directly; the IRQ subsystem already prints on failure.
> > > 
> > > Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")    
> > 
> > Hmm. To me borderline on whether it's a fix.  In theory a board may exist
> > where the defer is a possibility.  In practice probably not given I don't
> > think we've ever had a report of this.
> > 
> > Meh, it's harmless enough and maybe helps someone.
> >   
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>    
> > New series versions should never be in reply to older series.
> > 
> > It tends to hide them in people's inboxes and brings little nor no benefit.  
> > > ---
> > > v2:
> > > - Drop dev_err_probe(); just return ret (Andy)
> > > - Add Cc: stable@ as suggested by Joshua    
> > Mostly for IIO I add those to patches that I think need it but don't object
> > if people feel strongly enough and add them themselves.
> > 
> > Applied to the iio-fixes branch of iio.git.
> >   
> Actually dropped again.  I forgot to check sashiko and it raises a reasonable
> question:
> https://sashiko.dev/#/patchset/20260518094311.2000-1-sozdayvek%40gmail.com
> 
> Does completely removing dev_err_probe() here drop the deferred probe reason
> tracking?
> While this patch successfully fixes the return code, dev_err_probe() also
> records the deferral reason in debugfs via device_set_deferred_probe_reason()
> when ret is -EPROBE_DEFER.
> Could we keep the diagnostic tracking by returning the result of
> dev_err_probe() directly instead?
>         if (ret)
>                 return dev_err_probe(&client->dev, ret, "IRQ request error\n");
> 
> Andy, what do you think?
Andy?

This is a change you might have asked for, but sashiko is correctly noting
that we might loose a deferred reason even if the print is otherwise useless.

Jonathan

> 
> > > 
> > > v1: https://lore.kernel.org/all/20260517181042.668-1-sozdayvek@gmail.com/
> > > 
> > >  drivers/iio/light/tsl2591.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
> > > index c5557867e..c5ccd833d 100644
> > > --- a/drivers/iio/light/tsl2591.c
> > > +++ b/drivers/iio/light/tsl2591.c
> > > @@ -1137,10 +1137,8 @@ static int tsl2591_probe(struct i2c_client *client)
> > >  						NULL, tsl2591_event_handler,
> > >  						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > >  						"tsl2591_irq", indio_dev);
> > > -		if (ret) {
> > > -			dev_err_probe(&client->dev, ret, "IRQ request error\n");
> > > -			return -EINVAL;
> > > -		}
> > > +		if (ret)
> > > +			return ret;
> > >  		indio_dev->info = &tsl2591_info;
> > >  	} else {
> > >  		indio_dev->info = &tsl2591_info_no_irq;    
> >   
> 
> 


