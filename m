Return-Path: <stable+bounces-23854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B39A868B6F
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80179B23617
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10907131734;
	Tue, 27 Feb 2024 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bQGkKRfA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C867BAE7
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024217; cv=none; b=Rd6Y4OyjBDgIoz/ZR6caKXicaUo3e56JiIBAaC2wQekilMjUzMBp+2HN7xCjpXM8QNDjGCd+a4mWxfCKc6DOakjXYR107/CR6f9nROjb7KsTg3KMWSvrgQPZiqFz8sDAiHXGNYbln93zTjwoGEUJqkd9ZsI9kiQfTq7JkgQWz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024217; c=relaxed/simple;
	bh=9D2lP2tDOLhLBkb6M5ypcnnWedoVOA2dwbXQkn/2SOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLwjiAAMgkEzzHp53uYYERkxJSfvonn8gBBtuqHEwm3wSu6zK11vHKUzmixJIrGJIn2vr7q6UFKLHQUfk/1+IP5ZLS7iHi+gxXD2Pa8KhQ/rHaZlt39qqS1KIoaFOYCAZnkMZuA57LeDY7B3rT547RFfd6jI4FfWdVBZarFRT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bQGkKRfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A59FC433C7;
	Tue, 27 Feb 2024 08:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709024217;
	bh=9D2lP2tDOLhLBkb6M5ypcnnWedoVOA2dwbXQkn/2SOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQGkKRfAMSPq1i/DRGCN7GO1Jwk+MVMdfkWgIpyLMJc2NkhYQ+puFOYADaOKE8DEA
	 9ItHQfBiKElQhsc3+2ftsGCk0PsDNAXauiohvlFoOi35rTuD7fg22Naxm/4mfztWeQ
	 L5cbOBD+QM1k2o4g9lTwPRqLnLTHWKjCfNL+Fc1c=
Date: Tue, 27 Feb 2024 09:56:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: stable@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.7.y] mm: zswap: fix missing folio cleanup in writeback
 race path
Message-ID: <2024022746-uphold-valiant-26a2@gregkh>
References: <2024022610-amino-basically-add3@gregkh>
 <20240226221647.1425311-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226221647.1425311-1-yosryahmed@google.com>

On Mon, Feb 26, 2024 at 10:16:47PM +0000, Yosry Ahmed wrote:
> In zswap_writeback_entry(), after we get a folio from
> __read_swap_cache_async(), we grab the tree lock again to check that the
> swap entry was not invalidated and recycled.  If it was, we delete the
> folio we just added to the swap cache and exit.
> 
> However, __read_swap_cache_async() returns the folio locked when it is
> newly allocated, which is always true for this path, and the folio is
> ref'd.  Make sure to unlock and put the folio before returning.
> 
> This was discovered by code inspection, probably because this path handles
> a race condition that should not happen often, and the bug would not crash
> the system, it will only strand the folio indefinitely.
> 
> Link: https://lkml.kernel.org/r/20240125085127.1327013-1-yosryahmed@google.com
> Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit e3b63e966cac0bf78aaa1efede1827a252815a1d)
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/zswap.c | 2 ++
>  1 file changed, 2 insertions(+)

Now queued up, thanks.

greg k-h

