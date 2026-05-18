Return-Path: <stable+bounces-249330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM+oKewzC2qgEgUAu9opvQ
	(envelope-from <stable+bounces-249330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:44:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A75E9570394
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DA05301AF10
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBE3451044;
	Mon, 18 May 2026 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxRSy6EQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9744D6B2;
	Mon, 18 May 2026 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118999; cv=none; b=pxbNAACydpcRNyjUWGj6lxewMu8Omk92u/t5poOwEAgZO92DoVm3Ej6Q3LBwBaGfPWdeIM0tAEp8sTZPdpctbsE26d9IGPFYwzri9sV1cq2X2YHvIYYwSsKcq+anrG4/27jOvJMekunkWlL3vZtdtOAD2FnqDVpyAlGSxHV/YDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118999; c=relaxed/simple;
	bh=zk+PSPTETilcVCur56maJngwO4zTT9pKXV18BZNJjLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ug2GBq5j4Ib3hXZ2uZCLleNE6L/jzem7jv9OWiTUJbhag0ze69qIQtnsziGa4ikuH6fENr15km0Gc+lHIb6PHoeHVawBRc/xpmsSJtr+cEcZwb3AymMpXnWZ/1YxKobVmWsGFbn8DSvPh42UV3tuW+AiIhSAQAzalZ+Fi/fPRME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxRSy6EQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C842FC2BCB8;
	Mon, 18 May 2026 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779118998;
	bh=zk+PSPTETilcVCur56maJngwO4zTT9pKXV18BZNJjLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NxRSy6EQWSMXC0LJVE64L98ulAktP2pabm5M/0nbsMWuSX/d6YvBQ2kYvoATZwEGs
	 ek1LVBIBmU8+FN3IyExTgWuqMifTesTuR1Ef1QdzysbdkyVOf6j+X8aDmkksqFJmfb
	 fuIdsznGkBKEkANxMCca9aqj1bcNIWgTJQVHkqo+rAd6c9HXefK6T32K0Z/IqTKO59
	 6LFGxxlvSSiZ0g35BMrcfFCKvnHzb1szLswVbdLb5/uDUOjlnfHQuaq4KsaKFGZVix
	 ErpuRVw8YFJU+Ph6HDMiGQvwqgApNMo8x/EN2vp4Uwl1r2xuE/eg1mHQlXwXZ8+eJs
	 QPovE+J+1LHnQ==
Date: Mon, 18 May 2026 16:43:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 hcazarim@yahoo.com, joshua.crofts1@gmail.com, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: tsl2591: return actual error from probe
 IRQ failure
Message-ID: <20260518164309.04ed238f@jic23-huawei>
In-Reply-To: <20260518163647.3b4966fb@jic23-huawei>
References: <20260517181042.668-1-sozdayvek@gmail.com>
	<20260518094311.2000-1-sozdayvek@gmail.com>
	<20260518163647.3b4966fb@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249330-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[baylibre.com,analog.com,kernel.org,yahoo.com,gmail.com,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A75E9570394
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 16:40:48 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 18 May 2026 14:43:11 +0500
> Stepan Ionichev <sozdayvek@gmail.com> wrote:
> 
> > When devm_request_threaded_irq() fails, probe logs the error and
> > then returns -EINVAL, dropping the real error code and breaking the
> > deferred-probe flow for -EPROBE_DEFER.
> > 
> > Return ret directly; the IRQ subsystem already prints on failure.
> > 
> > Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")  
> 
> Hmm. To me borderline on whether it's a fix.  In theory a board may exist
> where the defer is a possibility.  In practice probably not given I don't
> think we've ever had a report of this.
> 
> Meh, it's harmless enough and maybe helps someone.
> 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>  
> New series versions should never be in reply to older series.
> 
> It tends to hide them in people's inboxes and brings little nor no benefit.
> > ---
> > v2:
> > - Drop dev_err_probe(); just return ret (Andy)
> > - Add Cc: stable@ as suggested by Joshua  
> Mostly for IIO I add those to patches that I think need it but don't object
> if people feel strongly enough and add them themselves.
> 
> Applied to the iio-fixes branch of iio.git.
> 
Actually dropped again.  I forgot to check sashiko and it raises a reasonable
question:
https://sashiko.dev/#/patchset/20260518094311.2000-1-sozdayvek%40gmail.com

Does completely removing dev_err_probe() here drop the deferred probe reason
tracking?
While this patch successfully fixes the return code, dev_err_probe() also
records the deferral reason in debugfs via device_set_deferred_probe_reason()
when ret is -EPROBE_DEFER.
Could we keep the diagnostic tracking by returning the result of
dev_err_probe() directly instead?
        if (ret)
                return dev_err_probe(&client->dev, ret, "IRQ request error\n");

Andy, what do you think?

> > 
> > v1: https://lore.kernel.org/all/20260517181042.668-1-sozdayvek@gmail.com/
> > 
> >  drivers/iio/light/tsl2591.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
> > index c5557867e..c5ccd833d 100644
> > --- a/drivers/iio/light/tsl2591.c
> > +++ b/drivers/iio/light/tsl2591.c
> > @@ -1137,10 +1137,8 @@ static int tsl2591_probe(struct i2c_client *client)
> >  						NULL, tsl2591_event_handler,
> >  						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> >  						"tsl2591_irq", indio_dev);
> > -		if (ret) {
> > -			dev_err_probe(&client->dev, ret, "IRQ request error\n");
> > -			return -EINVAL;
> > -		}
> > +		if (ret)
> > +			return ret;
> >  		indio_dev->info = &tsl2591_info;
> >  	} else {
> >  		indio_dev->info = &tsl2591_info_no_irq;  
> 


