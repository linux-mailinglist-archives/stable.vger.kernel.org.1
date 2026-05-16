Return-Path: <stable+bounces-248989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIoDABFGCGq8hQMAu9opvQ
	(envelope-from <stable+bounces-248989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 12:25:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 873DD55B213
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 12:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD39E3016018
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 10:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B463CFF57;
	Sat, 16 May 2026 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQxG81WK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858FA405C46;
	Sat, 16 May 2026 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778927115; cv=none; b=FpFgY1FCSdrdRSf/3OXA+rDWNKUd6Z1w81Yc/fBLKccQBVw2DWUegxaXdttyVGYCh+eLZKtDsJh9Qg7XDl8KxuU6hgtra5rXV3jL5haFB1xacZq1fRgyTtH/mFwXkghn0bMkAhNzvumqw2T5jnLz3POVYIRuY9eaf6zpmgW5IYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778927115; c=relaxed/simple;
	bh=VLC9qWYGOWlwCVpkDc6zgYScIMbIFTywNpmcWF4hU94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GATqdPuPGpFjlP0xoY5UZNNqrYgVreoigSEzruizC147x7QA7iVdZOh/QT0gnNbXoKuRcUwUyA0+LmrDGUh1jF7movf99fE2GiP1P6MNSwOtvBseeQ1gNqP4l67lx1NwESai7MDGwwxH78d1e6giO4L+jUir5qIk8vBrz7rJWzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQxG81WK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1E1C19425;
	Sat, 16 May 2026 10:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778927115;
	bh=VLC9qWYGOWlwCVpkDc6zgYScIMbIFTywNpmcWF4hU94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LQxG81WK2bTuVlhmcnlVL015Q7qfArA9HFOXB1svN6+HQER3KdOJ3tppM38UinJep
	 PME2BL55hpAt0o+8O59BYMzPHXD+A2tgc1rHLIq8V4ksuzBtvKtj9WyZShQr5Akdb6
	 uKVKDxySzZLXkkrKjvUTwQ9MUSzgn+YhIOeRIu8nZ2eF2EVKPtYX7oHKivz9ACqlqY
	 MA33poHLpYj0cEBkbt/NI/0B3Psb4wWIi6kBZPliE+bdZ3yQCgKaRvWuFUl+v/aMp9
	 r8CrkNRvqlhHPVAPOkpXW6UA3FffYYtSuPZqUNyxADLlTs3RMtbJVdelsMDbIxTaQ/
	 Tld19JJ2EC9fw==
Date: Sat, 16 May 2026 11:25:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Carlier <devnexen@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: zero-init bmp580 trigger handler
 buffer
Message-ID: <20260516112506.34bf411e@jic23-huawei>
In-Reply-To: <afsGZOxaJFvgLKgw@ashevche-desk.local>
References: <20260505173455.181358-1-devnexen@gmail.com>
	<afsGZOxaJFvgLKgw@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 873DD55B213
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248989-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,baylibre.com,analog.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, 6 May 2026 12:14:12 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, May 05, 2026 at 06:34:55PM +0100, David Carlier wrote:
> > bmp580_trigger_handler() builds an on-stack scan buffer containing
> > two __le32 fields and an aligned_s64 timestamp, and pushes it to
> > userspace via iio_push_to_buffers_with_ts(). However, only the low
> > 3 bytes of each __le32 field are populated by the device data:
> > 
> > 	memcpy(&buffer.comp_press, &data->buf[3], 3);
> > 	memcpy(&buffer.comp_temp,  &data->buf[0], 3);
> > 
> > The high byte of each field is left uninitialised on the stack.
> > The bmp580 channels declare storagebits = 32, so the IIO core
> > transports all four bytes per sample to userspace as part of the
> > scan element, leaking two bytes of kernel stack per scan.
> > 
> > Zero-initialise the buffer before populating it, mirroring the fix
> > applied to bme280_trigger_handler() in commit 018f50909e66 ("iio:
> > bmp280: zero-init buffer").  
> 
> Same Q, is any part of the above, including the initial report/analysis
> AI assisted? If so, you have to mentioned this in the respective
> Reported-by:/Closes:/et cetera tags.

David, these questions are outstanding if you have time to look at them.
I might be ok adding tags.

Rather than risk losing the fix I've applied it with the tweak
as Andy suggests below.

Thanks,

Jonathan

> 
> ...
> 
> >  	} buffer;  
> 
>  	} buffer = { };
> 
> will suffice.
> 
> >  	int ret;
> >  
> > +	memset(&buffer, 0, sizeof(buffer));  
> 


