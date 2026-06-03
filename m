Return-Path: <stable+bounces-260091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KeTeGEUyIGrZyQAAu9opvQ
	(envelope-from <stable+bounces-260091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 15:55:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 074316384A0
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 15:55:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X3lpzVzN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260091-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260091-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CD3F3081182
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 13:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03283330652;
	Wed,  3 Jun 2026 13:46:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F83329E6C;
	Wed,  3 Jun 2026 13:46:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494380; cv=none; b=KFiLYpQ2mqqPcoDjlohI7rOJONVjH6vnWNqkB02fFQq1YEkA1RX2FPl6pkQqwiO9Rd9AqduKHKqGDRdXhFq+7IBzoThhyuWYwDPbCwBHDs7k08hGonEaotecQ3i5oD9LfU3V8PEP4juL53mjpFHtxL0GQ7BTN1d7VGgduPe7jb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494380; c=relaxed/simple;
	bh=YFNAqFDxk/MEMEUnwOMbFmzvs+j1ZkGZaJGTjzFOkMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9Fe2pnxhV7dj7njZ9Mzj3X9ngZGXMo+0NPBUb1o7nizmz+O2VmDNA3WFclleUdRlUsLRezq2ZZxIDDhcjvsQq1R6ziitF2NcKAKvWgeJ8/1yRQqsRz3c+3yu1J7mkkOVC8if9VWxTT6REXYGtI3H6jkDfKgYUMchC8NmGKLxt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3lpzVzN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92741F00893;
	Wed,  3 Jun 2026 13:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780494379;
	bh=SM1cKq9SfWufKuIA+3YVCEbGbuxmG5CEwN2ohUYgVxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X3lpzVzNsmzUvBWgrJY/p4bH8g7VDsT822kjq9ZTydis6zw7/CngVyU7LjFVwcqVp
	 PEuYKLUGDIRYvv/9CdXuFr+/WK+OPzpdDRSAENljYuFyvoTpyyHiFzmexKqJvSvlSL
	 iAyp3Pu6EJZhVkSMowL5zHx8L3AKv8HL3Zys4IVIGtV5axAC0EXnNNqfaXLXUcG2N6
	 Neh+iezmCtZmXO+5sIQLR3/K/rkoxTi/JFVHEdANmw15bE2mOgeVIYj2zQLQg5v7Xv
	 Wwl2ZMeN/qHLyQbPp74H6ZAZUxdXdv+S5qQjPXop4bC3FZrEMH1x/d44Ae3uQo0OvH
	 bvrwIEVjAmhgw==
Date: Wed, 3 Jun 2026 14:46:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, nuno.sa@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 benato.denis96@gmail.com, martin@martingkelly.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: adis: add IRQF_NO_THREAD to non-FIFO
 trigger IRQ
Message-ID: <20260603144612.0102a336@jic23-huawei>
In-Reply-To: <ah997ABzoOb0cFq3@ashevche-desk.local>
References: <20260602091727.2406720-1-runyu.xiao@seu.edu.cn>
	<20260602091727.2406720-2-runyu.xiao@seu.edu.cn>
	<ah997ABzoOb0cFq3@ashevche-desk.local>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@intel.com,m:runyu.xiao@seu.edu.cn,m:nuno.sa@analog.com,m:lars@metafoo.de,m:Michael.Hennerich@analog.com,m:dlechner@baylibre.com,m:andy@kernel.org,m:benato.denis96@gmail.com,m:martin@martingkelly.com,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,m:benatodenis96@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-260091-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[seu.edu.cn,analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,martingkelly.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,jic23-huawei:mid,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 074316384A0

On Wed, 3 Jun 2026 04:05:48 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jun 02, 2026 at 05:17:26PM +0800, Runyu Xiao wrote:
> > devm_adis_probe_trigger() registers iio_trigger_generic_data_rdy_poll()
> > through devm_request_irq() on the non-FIFO path, but it does not add
> > IRQF_NO_THREAD to the IRQ flags.
> > 
> > When the kernel is booted with forced IRQ threading, the parent IRQ can
> > otherwise be threaded by the IRQ core and the subsequent IIO trigger
> > child IRQ is then dispatched from irq/... thread context instead of
> > hardirq context. Because iio_trigger_generic_data_rdy_poll()
> > immediately drives iio_trigger_poll(), this violates the hardirq-only
> > IIO trigger helper contract and can push downstream trigger consumers
> > through the wrong execution context.
> > 
> > Add IRQF_NO_THREAD on top of the existing adis->irq_flag value for the
> > non-FIFO request_irq() path, while preserving the current trigger
> > polarity and IRQF_NO_AUTOEN behavior.  
> 
> > Build-tested by compiling adis_trigger.o.
> > 
> > No ADIS hardware was available for end-to-end runtime testing on this
> > submission branch.  
> 
> These two paragraphs are unneeded details and can go to the cover letter.
> 
> ...
> 
> Code wise IIRC another approach was discussed. But Jonathan may know better.
> 

Whilst I dislike the necessity of marking these, I'm not aware of another
solution.  Maybe the discussion Andy refers to what the one around
papering over ONESHOT where if that flag is set and there isn't a thread
handler it's a driver bug.

For this we might be able to on day do something cleverer but that would
first mean fixing up how we run top halfs when only the thread is called.

So with a patch descriptions tweaked as Andy suggests I'll pick these up.

