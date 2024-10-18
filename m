Return-Path: <stable+bounces-86794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBA39A3920
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F24F2847A9
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C3118F2DA;
	Fri, 18 Oct 2024 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hsqJscs0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676C18E028
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241495; cv=none; b=lEFaUD8azQP54ct5OiNg1/VhfnMpDtYWQW/xNoqS1OpKUdBvFJwWiAgvV6lCJb1NzViTcU1nyhLcodZI2WchF0Zo1K5b1iIVaf9TwIgLEqon5qQzUKyZcdS4XxIEkdyni3x4BmQeafT5lqGDFhuiki+76ZOOCh0yD9mUAgdixUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241495; c=relaxed/simple;
	bh=WOWNRVdsuEOQOnhBsh295Biz4P8Acd/nVMwn4wyQX8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NN+I+LSCR+Tjn3/2kbB92EXKhJjdUZajOpDb8POw48JHunRPDzeztRTNFWb/lSu0Q/Guc9A9WamM2I/dSLnMH8+Dn5Iol8wJrNsy4kZetSEAXn4Z5NwEIjHaA8OuP8iY5yGrEq2qtNC/BX5pKljjeo9rYWvQMoZ9Mlo+6Ydn1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hsqJscs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136D3C4CEC3;
	Fri, 18 Oct 2024 08:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729241493;
	bh=WOWNRVdsuEOQOnhBsh295Biz4P8Acd/nVMwn4wyQX8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsqJscs0ABThIzisyUQhT6lcvfWTUbbz/B7w+svnUJGHNFUpKoonWToqoE0eg9d+P
	 SD3SgyVbgtEmbdCTD/HsmMgnk+avW2goLL1k3fArGyG94AX2FkTKG9wc3eeKMoAiQf
	 sxblsqpgHxsKn4YuM6U05+oTm1vasLHlUhFCWdOs=
Date: Fri, 18 Oct 2024 10:51:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	yangge <yangge1116@126.com>, Yu Zhao <yuzhao@google.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>, baolin.wang@linux.alibaba.com,
	Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCH 6.11.y] mm: vmscan.c: fix OOM on swap stress test
Message-ID: <2024101800-resurface-edginess-1fcf@gregkh>
References: <20241016-stable-oom-fix-v1-1-ca604a36a2b6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-stable-oom-fix-v1-1-ca604a36a2b6@kernel.org>

On Wed, Oct 16, 2024 at 09:49:49AM -0700, Chris Li wrote:
> [ Upstream commit 0885ef4705607936fc36a38fd74356e1c465b023 ]
> 
> I found a regression on mm-unstable during my swap stress test, using
> tmpfs to compile linux.  The test OOM very soon after the make spawns many
> cc processes.
> 
> It bisects down to this change: 33dfe9204f29b415bbc0abb1a50642d1ba94f5e9
> (mm/gup: clear the LRU flag of a page before adding to LRU batch)
> 
> Yu Zhao propose the fix: "I think this is one of the potential side
> effects -- Huge mentioned earlier about isolate_lru_folios():"
> 
> I test that with it the swap stress test no longer OOM.
> 
> Link: https://lore.kernel.org/r/CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZUmErNAXoXmw@mail.gmail.com/
> Link: https://lkml.kernel.org/r/20240905-lru-flag-v2-1-8a2d9046c594@kernel.org
> Fixes: 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before adding to LRU batch")
> Signed-off-by: Chris Li <chrisl@kernel.org>
> Suggested-by: Yu Zhao <yuzhao@google.com>
> Suggested-by: Hugh Dickins <hughd@google.com>
> Closes: https://lore.kernel.org/all/CAF8kJuNP5iTj2p07QgHSGOJsiUfYpJ2f4R1Q5-3BN9JiD9W_KA@mail.gmail.com/
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Again, for mm changes, we need an explicit ack from the mm maintainers
before we can take them.  I'll wait for that.

thanks,

greg k-h

