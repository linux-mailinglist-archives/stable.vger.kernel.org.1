Return-Path: <stable+bounces-23852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAACB868B69
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581381F26680
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE6813329C;
	Tue, 27 Feb 2024 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OU43DSzV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1142E132C17
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024168; cv=none; b=RpAtc1BEQIOXlYj3RVWtDbrI0yhxsP/nj1RKPQnR/y4Bm6KVw+nt+qqUwN/PY8egFr5G9dCfF8D1glVXFDf0Wj9Cbvy0jxDkMPW9tn0yMwRv1ZttwlYOlcFr5+6x0IJfJR52khtvBbT29Nvosl4K92W0Zqtb67xb02jN3O8PYWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024168; c=relaxed/simple;
	bh=Rkq9kkMj5bZqil5rLJrYrUxy/pufBH77rfyT9S4vZ6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWww3OaMp3+sxPQKIebjQ4UEhSTtCOOc1GYjmFcz91Z1qET3N9KqlFXsg/x+vn7nVsxzQVDbpAOSmz1oxu8MLtW5yda1sS3UOs88+rvhQddI0iw4EsCy8/PsbzZCi4XnaaWmapAj4HMHKVVJWKpUMdfmV3BGHnTVGGr5npohjAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OU43DSzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FD6C433C7;
	Tue, 27 Feb 2024 08:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709024167;
	bh=Rkq9kkMj5bZqil5rLJrYrUxy/pufBH77rfyT9S4vZ6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OU43DSzV8/ENk7OjR/D6cCN1XmKsHabF+QLG2r4f7sr/s9SjNgI1CcB6VpiCgPyu8
	 0cuEyZ49yrtxbNe3NYOOXw4TcQenh45tyb8LAjbHXmfKLqFD2lkRAqyx+kJiTHhCJz
	 lCDtLmFgJwMl9jJ+mw2VyDqPW3fjBV9SELfdi23E=
Date: Tue, 27 Feb 2024 09:56:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: stable@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm: zswap: fix missing folio cleanup in writeback
 race path
Message-ID: <2024022740-affidavit-conjoined-cbfe@gregkh>
References: <2024022612-uncloak-pretext-f4a2@gregkh>
 <20240226220340.1238261-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226220340.1238261-1-yosryahmed@google.com>

On Mon, Feb 26, 2024 at 10:03:40PM +0000, Yosry Ahmed wrote:
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
> 
> Change-Id: I0aef4c659c6a29b45d78bf6a7e8330c7ab246f15

Why is Change-Id: in here?  checkpatch.pl should have warned you of that :(

Please fix and resend.

thanks,

greg k-h

