Return-Path: <stable+bounces-254102-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA2NADr+E2quIQcAu9opvQ
	(envelope-from <stable+bounces-254102-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 09:46:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1AF5C73E4
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 09:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BACAE300BC8E
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 07:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B033D3492;
	Mon, 25 May 2026 07:45:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7652367B8;
	Mon, 25 May 2026 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779695158; cv=none; b=UrdBIKgeqdQmrROgnIOHcyrPhnoIwUEbg+zSHYsAoOu9p1rtv+UwDnGWwfD5Ya9D7BiHn4Kryh5uKXgB+FwYtBQQeuJtbJ5xDyJcLcwKi+TBAyInf1uv7WRJyugpjxA1lcUK/1t7kozicOI7zI2rrL3DAPW2JA3aiPLVgsFuWA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779695158; c=relaxed/simple;
	bh=t/cYPrdwJNXzSep824CP+QR2P+HPjArNcs9iORgSGuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+0CUPparkAdjY6/Mm4EId8w2HeXpHABEr3SpR8BClzZVGBzzqbCbj0TegHjaa/VEVRYYEKhqQ77N1ex/e5yZOVfJBgPY1WQw/hV429Dfmq/zNkr6nUcDkdWLxRZc9xx7OhUMkBbsnnxljEP8v8tN5pwEZjjudG29jYZeRVK8Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C37968B05; Mon, 25 May 2026 09:45:52 +0200 (CEST)
Date: Mon, 25 May 2026 09:45:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Aaron Esau <aaron1esau@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: fix dio leak on integrity metadata mapping
 failure
Message-ID: <20260525074551.GA5432@lst.de>
References: <20260518074258.1600307-1-aaron1esau@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518074258.1600307-1-aaron1esau@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254102-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lst.de:mid]
X-Rspamd-Queue-Id: BD1AF5C73E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +			if (unlikely(ret)) {
> +				bio->bi_status = BLK_STS_IOERR;
> +				bio_endio(bio);
> +				break;
> +			}

AFAICS the same issue also exists for the other goto fail case,
so we should convert the code at that label to a bio_endio().

I think both this and the existing -EAGAIN case and even the
-EIOCBQUEUED case leak the reference on the original bio.  Or am
I missing something?

It might makes sense to stop playing games with that bio refcount
and just have a status field in struct blkdev_dio.

