Return-Path: <stable+bounces-267086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c/s6Ee7IM2oPGQYAu9opvQ
	(envelope-from <stable+bounces-267086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 12:31:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E58469F56E
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 12:31:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267086-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267086-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 106DC3064451
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 10:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A283BFE41;
	Thu, 18 Jun 2026 10:26:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC93750CB;
	Thu, 18 Jun 2026 10:26:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778394; cv=none; b=DjbnPaLNKlEYodWIcAH3xQ9sMWBuHDv9Ufh/Igd6PTz4hvhTK4T2f8zIdkBzyCfKi+I6f3U3QzvoUvbx7aD+e+ZJpTY5Qx8dICXH4ZLtAcbcYzaqsikY23SFQ85KzwyCIJ+eRfBCOWefRZn0OkzYPdC7xrgN8JtXxbZD2HgpSKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778394; c=relaxed/simple;
	bh=QAXjP5J/sFCMInq4Fej3S6aSdguM9eBOQ61FbMRR4s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qi3rra8sMgRoV2FRVnCxVO8noOsAP+6Z46ClQ0mogT+mhsFW4UZtnLlD1bHuO4+1rD+d6gYJ+J6JkqavOJN6ugMr0OpF9WymYQCCteM3+hkEV+EnoRXh8tabF3E+ocCZ7Rr6z/v+8BV2k6yFd3YL/B/CSfBbFvpZkf4YiWslJnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8508A68C7B; Thu, 18 Jun 2026 12:26:27 +0200 (CEST)
Date: Thu, 18 Jun 2026 12:26:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dm-devel@lists.linux.dev, hch@lst.de, axboe@kernel.dk,
	brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
	Keith Busch <kbusch@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] block: validate user space vectors during
 extraction
Message-ID: <20260618102627.GA23200@lst.de>
References: <20260617233235.1016063-1-kbusch@meta.com> <20260617233235.1016063-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617233235.1016063-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267086-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lst.de:mid,lst.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E58469F56E

On Wed, Jun 17, 2026 at 04:32:35PM -0700, Keith Busch wrote:
> @@ -1242,7 +1242,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
>   * is returned only if 0 pages could be pinned.
>   */
>  int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
> -			   unsigned len_align_mask)
> +			   unsigned len_align_mask, unsigned vec_align_mask)

vec_align_mask needs to be documented in the kernel doc.  And I find
the vec_align_mask name a bit confusing.  This is all about the physical
address (really the dma address, but the page aligned offset map 1:1),
so maybe phys_align_mask or dma_align_mask might be better names?

Also wouldn't it be more natural to pass the start alignment requirement
before the length alignment paramter?

> @@ -1251,6 +1251,11 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
>  
>  	if (iov_iter_is_bvec(iter)) {
>  		bio_iov_bvec_set(bio, iter);
> +
> +		if (mp_bvec_iter_offset(bio->bi_io_vec, bio->bi_iter) &
> +							vec_align_mask)
> +			return -EINVAL;

Can you add a comment here?  Especially as the bvec iter doesn't actually
require all individual bvecs to be aligned and I'm not entirely sure this
handles all case - writing down the rules might help a bit with that.

>  		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
>  				BIO_MAX_SIZE - bio->bi_iter.bi_size,
> -				&bio->bi_vcnt, bio->bi_max_vecs, flags);
> +				&bio->bi_vcnt, bio->bi_max_vecs,
> +				vec_align_mask, flags);
>  		if (ret <= 0) {
> +			if (ret == -EINVAL) {
> +				bio_release_pages(bio, false);
> +				bio_clear_flag(bio, BIO_PAGE_PINNED);
> +				bio->bi_iter.bi_size = 0;
> +				bio->bi_vcnt = 0;
> +				return ret;
> +			}

Do we need all this cleanups beyoned the bio_release_pages()?  Most
callers just free the bio, so should not care about it, and the error
handling in __blkdev_direct_IO that calls bio_endio looks buggy for
other reasons..

> + * @align_mask:	reject with -EINVAL if the source address or length is not
> + *		aligned to this mask

Maybe use the same paramater name as on the bio side here?

And not for this patch, but this makes me wonder if we should handle the
len alignment in iov_iter_extract_bvecs as well, as that should simplify
it quite a bit.


