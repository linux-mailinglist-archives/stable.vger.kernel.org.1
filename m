Return-Path: <stable+bounces-180945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 161CDB91133
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 14:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 089994E21B0
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 12:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AFB305E3A;
	Mon, 22 Sep 2025 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SIbB47RU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA24A1E;
	Mon, 22 Sep 2025 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543265; cv=none; b=thTvLKYa2jFhygvQjCoAyblFQqvM9Bng8CthKH0guZs0AnjLa/Y6jjr+3bUSkHy92nVUZycO9auFhCSX0PKJzmLPAuNnSrRCCZfaQ+IhpG+8IEiEpW/s8UcX7SuXlUI8MuChZqGpCptzPl3bMd2f4eefAYNUAu1p8kfpsdZUliE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543265; c=relaxed/simple;
	bh=TDTFZJj2QTvyW4Hbg4G/kP6ud3sGTvtQVt8ZwaMK08E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEFuDgHGpgJk1p3A7qUToakkHMmcrhvQi7OSM4roPL9vjNGBCGVDa7EiBnCyqCZuw/gBFKMHWbTOARkBGYWx1OCgot1qomY1lny2pIKI+qPBYFUNxy5BcsITnnQNEIbDI02RyNkyKiABkUMfUMfu2v/iVaTTo2mHqRYAcVkMaBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SIbB47RU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE04C4CEF0;
	Mon, 22 Sep 2025 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758543264;
	bh=TDTFZJj2QTvyW4Hbg4G/kP6ud3sGTvtQVt8ZwaMK08E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SIbB47RULrzNJvE7CoV2xMQnfr2wUQBd3k+l/7mzrBPRCpsENPr9BSuYb4F1IVcYE
	 ZhMInUV4rtwFb5jKrga7EdfZYIOgiBRzBT24UK2O17wk8PjJ4XWBjUamuAjUg3yw/y
	 yGIenUzgJEJ+p55JZxHRJa/qBzLExbOmwj/aKlq0=
Date: Mon, 22 Sep 2025 14:14:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eliav Farber <farbere@amazon.com>
Cc: akpm@linux-foundation.org, David.Laight@aculab.com, arnd@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jens Axboe <axboe@kernel.dk>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: Re: [PATCH 5/7 6.12.y] minmax.h: move all the clamp() definitions
 after the min/max() ones
Message-ID: <2025092204-reoccupy-fax-6b7a@gregkh>
References: <20250922103123.14538-1-farbere@amazon.com>
 <20250922103123.14538-6-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922103123.14538-6-farbere@amazon.com>

On Mon, Sep 22, 2025 at 10:31:21AM +0000, Eliav Farber wrote:
> From: David Laight <David.Laight@ACULAB.COM>
> 
> [ Upstream commit c3939872ee4a6b8bdcd0e813c66823b31e6e26f7 ]
> 
> At some point the definitions for clamp() got added in the middle of the
> ones for min() and max().  Re-order the definitions so they are more
> sensibly grouped.
> 
> Link: https://lkml.kernel.org/r/8bb285818e4846469121c8abc3dfb6e2@AcuMS.aculab.com
> Signed-off-by: David Laight <david.laight@aculab.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Pedro Falcato <pedro.falcato@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  include/linux/minmax.h | 109 +++++++++++++++++++----------------------
>  1 file changed, 51 insertions(+), 58 deletions(-)

This diff looks odd.  The upstream commit diffstat is:

include/linux/minmax.h |  131 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------
1 file changed, 62 insertions(+), 69 deletions(-)

which does not match this diffstat, nor the diff itself.

But, if I backport the original commit myself, it matches up exactly
with what you show here, which is odd.

diff is "fun", ugh...

Anyway, not a complaint, just something that others might note if they
are comparing diffs here like I do.

thanks,

greg k-h

