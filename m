Return-Path: <stable+bounces-78606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF9798D0A1
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 11:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F4D1C20F69
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFF41E411D;
	Wed,  2 Oct 2024 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C8bdbUDN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2231E4116
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863127; cv=none; b=rk6jVQJ9xmucb8taRLzi+lGepNfa/Kuz0HmmxuvUQt1J1ti7+Su8UGjoWAXbG0jlq9Ba9xsi9MJaD0vawDJtCKe+OhijeUQV+8xf6M4GPwIRPzvJ7y8jjbYCb4ovemH/AZlUN6ESD9xTUGGN8bKsdQ9+zKzzxvix1bb8oEA19Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863127; c=relaxed/simple;
	bh=cuMzkmqZysjLeeekrImJ7Rv2kbdlAp/6ce9A0Cm28tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU46AepSYxg7rUp+i0K8B2UoXMSUiINzS/CV9B5XdR4tguN+HvY3OcUnFRx7Iwn9QTvZkJY3+wtvZ39Yvk/EzgVKLmDjokJA2ZRJWdzo/7WxBqzEmOh1ncdXZuuTZ2FjwgL9OBIQCKMaWWnCRw8U4LV1v9rhthTZq+UMtE+A9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C8bdbUDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE15C4CEC5;
	Wed,  2 Oct 2024 09:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727863127;
	bh=cuMzkmqZysjLeeekrImJ7Rv2kbdlAp/6ce9A0Cm28tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C8bdbUDNiIxUXuZLzB30tLxxuWanjJZk3/VMeiSVgartCbEJLjF4RBViHDuHrUfYm
	 F6nQcvJVizUhQwnAbs6mLvrHTjo8tSrKVnEApvgMqaW7FDjJ0T9EostK7T/NWMU3np
	 /kptpglzTlLlUn4JEVnCstc4Cs7N1rv7dgsDhUs8=
Date: Wed, 2 Oct 2024 11:58:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kairui Song <kasong@tencent.com>
Cc: stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Christian Theune <ct@flyingcircus.io>,
	Christian Brauner <brauner@kernel.org>, Chris Mason <clm@meta.com>,
	Sam James <sam@gentoo.org>, Daniel Dao <dqminh@cloudflare.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6.1.y 6.6.y 0/3] mm/filemap: fix page cache corruption
 with large folios
Message-ID: <2024100229-hedging-stalling-c3c2@gregkh>
References: <20241001210625.95825-1-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001210625.95825-1-ryncsn@gmail.com>

On Wed, Oct 02, 2024 at 05:06:22AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> This series fixes the page cache corruption issue reported by Christian
> Theune [1]. The issue was reported affects kernels back to 5.19.
> Current maintained effected branches includes 6.1 and 6.6 and the fix
> was included in 6.10 already.
> 
> This series can be applied for both 6.1 and 6.6.
> 
> Patch 3/3 is the fixing patch. It was initially submitted and merge as
> an optimization but found to have fixed the corruption by handling race
> correctly.
> 
> Patch 1/3 and 2/3 is required for 3/3.
> 
> Patch 3/3 included some unit test code, making the LOC of the backport a
> bit higher, but should be OK to be kept, since they are just test code.
> 
> Note there seems still some unresolved problem in Link [1] but that
> should be a different issue, and the commits being backported have been
> well tested, they fix the corruption issue just fine.
> 
> Link: https://lore.kernel.org/linux-mm/A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io/ [1]
> 
> Kairui Song (3):
>   mm/filemap: return early if failed to allocate memory for split
>   lib/xarray: introduce a new helper xas_get_order
>   mm/filemap: optimize filemap folio adding
> 
>  include/linux/xarray.h |  6 +++
>  lib/test_xarray.c      | 93 ++++++++++++++++++++++++++++++++++++++++++
>  lib/xarray.c           | 49 ++++++++++++++--------
>  mm/filemap.c           | 50 ++++++++++++++++++-----
>  4 files changed, 169 insertions(+), 29 deletions(-)
> 
> -- 
> 2.46.1
> 
> 

All now queued up, thanks.

greg k-h

