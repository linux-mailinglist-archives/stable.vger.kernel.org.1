Return-Path: <stable+bounces-136987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A4DAA0027
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 05:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729663B9945
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 03:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D8A1F3BAC;
	Tue, 29 Apr 2025 03:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPGkMOG/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB6D2AEE1;
	Tue, 29 Apr 2025 03:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745896022; cv=none; b=AuAG12nNk5q/8KPvYJueatfeMqCB9Z7WnAjD0Boq7JQjA1Aere6nHrElPT0UfRG5ZBd6jUw8nuNM1zfdy4ha6N2mM+TkJUbFKnJG4HkSBDv68RkMwe/eUcXtbgIgn+mSDmWHYifzKlgzHD+fIMJS7vSiTa3ceR7NAYD7FICVnnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745896022; c=relaxed/simple;
	bh=Q670eReyAtJoadARUJrI2RpbKjr3KWV2o+ElngikDiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B01Pxwuo0eQdGmG81yaLFB2zN5cRrytK3odRGt6RMWv2ccp9/Stj3WsJBKfrDOdIZ83xXhJ33e0bAQSLoIvDivFrDpnu/zJSPHTofwo+LLLAt6LxyqSQfA8SsMyfAuYy+gSp6guvMujZvhpRqQInOjDwm+ZUFNtXO8gkVvSy08k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPGkMOG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDFFC4CEE4;
	Tue, 29 Apr 2025 03:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745896021;
	bh=Q670eReyAtJoadARUJrI2RpbKjr3KWV2o+ElngikDiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPGkMOG/bb287fpr0RQ0Bf7QJgyDzWisVOWqcRgnvLQRaciyvwDt/JwqkkQNDq4hX
	 iTajprmqF/tiZlcv0e/D2FMUZNuFmhlMm7gOu0subQR1B03+6VKUGm16jvhLPq9pQo
	 Ii45Fw2NTfj0vQQ+CvUsq7TYIQXIoVJ92H+UbhhOpOFwA2fI9gDQmcIZa9evO2L9Bg
	 3eiaKq+Fw/L8ZDr3tIZMdPxF3XzL/L0yO13IVGGXTYqnfLqerYmwYU3nZxHDdRgrQr
	 l+TSPqq/42wZgvmfkoMnZkOeYMbf41are0G8eJmbEX8WloWYC2L4j4A3x3hS0j/5DC
	 Jb1QyLjrGeFEw==
Date: Tue, 29 Apr 2025 11:06:52 +0800
From: Gao Xiang <xiang@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: xiang@kernel.org, chao@kernel.org, zbestahu@gmail.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fs/erofs/fileio: call erofs_onlinefolio_split() after
 bio_add_folio()
Message-ID: <aBBCTGo7I4OHyVAH@debian>
Mail-Followup-To: Max Kellermann <max.kellermann@ionos.com>,
	xiang@kernel.org, chao@kernel.org, zbestahu@gmail.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20250428230933.3422273-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428230933.3422273-1-max.kellermann@ionos.com>

On Tue, Apr 29, 2025 at 01:09:33AM +0200, Max Kellermann wrote:
> If bio_add_folio() fails (because it is full),
> erofs_fileio_scan_folio() needs to submit the I/O request via
> erofs_fileio_rq_submit() and allocate a new I/O request with an empty
> `struct bio`.  Then it retries the bio_add_folio() call.
> 
> However, at this point, erofs_onlinefolio_split() has already been
> called which increments `folio->private`; the retry will call
> erofs_onlinefolio_split() again, but there will never be a matching
> erofs_onlinefolio_end() call.  This leaves the folio locked forever
> and all waiters will be stuck in folio_wait_bit_common().
> 
> This bug has been added by commit ce63cb62d794 ("erofs: support
> unencoded inodes for fileio"), but was practically unreachable because
> there was room for 256 folios in the `struct bio` - until commit
> 9f74ae8c9ac9 ("erofs: shorten bvecs[] for file-backed mounts") which
> reduced the array capacity to 16 folios.
> 
> It was now trivial to trigger the bug by manually invoking readahead
> from userspace, e.g.:
> 
>  posix_fadvise(fd, 0, st.st_size, POSIX_FADV_WILLNEED);
> 
> This should be fixed by invoking erofs_onlinefolio_split() only after
> bio_add_folio() has succeeded.  This is safe: asynchronous completions
> invoking erofs_onlinefolio_end() will not unlock the folio because
> erofs_fileio_scan_folio() is still holding a reference to be released
> by erofs_onlinefolio_end() at the end.
> 
> Fixes: ce63cb62d794 ("erofs: support unencoded inodes for fileio")
> Fixes: 9f74ae8c9ac9 ("erofs: shorten bvecs[] for file-backed mounts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Thanks for catching this! LGTM:
Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

