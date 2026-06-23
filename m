Return-Path: <stable+bounces-267960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eErqDzmjOmpoCQgAu9opvQ
	(envelope-from <stable+bounces-267960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 17:16:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC416B83D1
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 17:16:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267960-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267960-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 741593133E9B
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495733D7D67;
	Tue, 23 Jun 2026 15:10:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734825F99F;
	Tue, 23 Jun 2026 15:10:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227426; cv=none; b=TeFLtVRpDDWL/0TNMMLkg4GV7LaPvofBNDdjm5lFjU12Te2Si0rYBsPbhB3K1feHHivRa1RGAJRHog0vGvrSvKkA9Haf1S4jAihC7zCc/plfzjoyuTeKwP9Ic2YMg6F3J9mqCf/zE6wtGflhjheUYlnAwLQHfxqhf2HDo+kbmqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227426; c=relaxed/simple;
	bh=+T/B/tZ+woy91IHFHED5KB3IAl+8s0Wv7O1/PBcwXuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gw+3V6Y/J8miFwpIwkMKquZ/RJQLzHgE0ZYfhLfBbBhcbq/uCra3XHW+6tbkK1HhFyZzmeARX4NOJTTLRBEZ4trxX4FzofIuCmKqMvabq8kwyioqVDXnQ6IwRQjlPcLuRhHW7X4mklooja92A4vH17IknkSJ/Bh42VpI2H2hAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 81F1C68C4E; Tue, 23 Jun 2026 17:10:21 +0200 (CEST)
Date: Tue, 23 Jun 2026 17:10:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dm-devel@lists.linux.dev, hch@lst.de, axboe@kernel.dk,
	brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
	Keith Busch <kbusch@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCHv2 6/6] block: validate user space vectors during
 extraction
Message-ID: <20260623151021.GA14919@lst.de>
References: <20260622174241.2299563-1-kbusch@meta.com> <20260622174241.2299563-7-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622174241.2299563-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267960-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kbusch@meta.com,m:linux-block@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:dm-devel@lists.linux.dev,m:hch@lst.de,m:axboe@kernel.dk,m:brauner@kernel.org,m:djwong@kernel.org,m:viro@zeniv.linux.org.uk,m:kbusch@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lst.de:mid,lst.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBC416B83D1

> +#ifdef CONFIG_DEBUG_KERNEL

That's a pretty broad option.  Not that I have any better idea off the
bat.

> +static inline bool bio_iov_bvec_aligned(const struct bio *bio,
> +					unsigned mem_align_mask)
> +{
> +	/*
> +	 * The vectors are owned and laid out by the caller; we only forward
> +	 * them. Most callers are already aligned, but io_uring can place a
> +	 * user chosen offset through a registered buffer, where only the first
> +	 * vector may be unaligned.
> +	 */
> +	return !(mp_bvec_iter_offset(bio->bi_io_vec, bio->bi_iter) &
> +							mem_align_mask);

I don't fully understand the comment.  I guess this is to say ITER_BVEC
users better don't create any alignment gaps?  Maybe we should also
clearly document that in uio.h?

>  	return bio_iov_iter_get_pages(bio, iter,
> +			bdev_dma_alignment(bdev),

Nit: this easily fits onto the previous line.

Otherwise this looks good.

