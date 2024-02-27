Return-Path: <stable+bounces-23848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71967868B53
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220351F2660D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5664E131734;
	Tue, 27 Feb 2024 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eDYK3cYX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52C6519E
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024095; cv=none; b=fnx16mL67YZ9NJb4CshR1XBIour+avoSqsKKJc4O66e6d6DLAVmbm3PJcpHtCVw5yEcv2pkDzVquG8aF0LB9sUvGA3CGPDMpyWFdNLxrNydmW/srbI+r3vgZQqVeBZwkJilC8x5kQ/ktu8y+6NHE5HEpIdv+7myJhf3//Qw2NHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024095; c=relaxed/simple;
	bh=YZh9hc7Qi9r8ooGPlJOmv8DHWnf3wmJp9YvfVIUSSo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcOsJngTn3jDrkxWgNDS5klOpp0yqUu29sL4LpoedlN8SYem2F2LJSgcjFOB7rkCaCVC1chiGqTHkcBqV7Tsls2I6x607mus5QmD/aKbZJEuRTeawb2W7HneLL0z1xFp0xCTxUk+gUeZS5l0ONJ7vEJDhAj81tzEHQLe0FJm/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eDYK3cYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C027C433C7;
	Tue, 27 Feb 2024 08:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709024094;
	bh=YZh9hc7Qi9r8ooGPlJOmv8DHWnf3wmJp9YvfVIUSSo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDYK3cYXg6+geOXVtIzVj9vkJPAbGdAzblJbiBIPygGHM9viXBiuo4JUKtntAd2J5
	 Na2jOksxuFkdCtbTE4BWzDoMVhU2ZowXtgJ4et5HkxFWfJVDMS5IcTmSLcDZ4nAI1d
	 Hd/nQfc9kUIWHhS833h7qQ7UEw+TUdxaOlS7B2iA=
Date: Tue, 27 Feb 2024 09:54:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: chengming.zhou@linux.dev
Cc: stable@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/zswap: invalidate duplicate entry when !zswap_enabled
Message-ID: <2024022743-rented-trembling-7797@gregkh>
References: <2024022622-agony-salvaging-5082@gregkh>
 <20240227022654.3442054-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227022654.3442054-1-chengming.zhou@linux.dev>

On Tue, Feb 27, 2024 at 02:26:54AM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> We have to invalidate any duplicate entry even when !zswap_enabled since
> zswap can be disabled anytime.  If the folio store success before, then
> got dirtied again but zswap disabled, we won't invalidate the old
> duplicate entry in the zswap_store().  So later lru writeback may
> overwrite the new data in swapfile.
> 
> Link: https://lkml.kernel.org/r/20240208023254.3873823-1-chengming.zhou@linux.dev
> Fixes: 42c06a0e8ebe ("mm: kill frontswap")
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 678e54d4bb9a4822f8ae99690ac131c5d490cdb1)

What tree is this for?

