Return-Path: <stable+bounces-93076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 687409CD618
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 05:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06A98B21513
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 04:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD30155A2F;
	Fri, 15 Nov 2024 04:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IRhspYM9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721FE2F37
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 04:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731643353; cv=none; b=MBJi13AL4v7OqCLNFu7y5glzaBEGhtf8Vs2KnyEWbslCGg5lUt2Oaw4H9CoAKN6OqUCMMtqZe1LzvGGr0Ev/2sO0jk0jNIWgnloC8qdR6QV75UGqout/8MB5pR1/crzIi+n0nOXQscMJl4z4bSFLtas6u1NBd5jW+mUfa4Q5gGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731643353; c=relaxed/simple;
	bh=Fz49gNKIk8Om1M/HtOKmsQFktoNpTBF0qNlUd7Jzyhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8HvpLuVrxCeTC48TNKokRzuerN2p9tPKOO2Sn4+0B6Z+vEg+LrguJonj9bgwCyOdL0LrXZPc/+xk3IRPgn59GWpMnBf/N8zC5XtB0zWm7GCyziWmWLExwgkPuyfeXQ/qXIxrySARpKsFBeUUMbI+ymbCQQjF3iPv3+p6U9Hm24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IRhspYM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EAEC4CECF;
	Fri, 15 Nov 2024 04:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731643353;
	bh=Fz49gNKIk8Om1M/HtOKmsQFktoNpTBF0qNlUd7Jzyhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IRhspYM9Vbvm155d8z3op7Vdy73WJTDvQvHNm/T7UaD/o5kCy4U+uHJJOtB0HpSLQ
	 qXqQXJGJCb+HpOLr4Ui438KS7GvdlpqUm9M0EjAzo63wVh7TNDXbp8iqesEylr3cKI
	 WmYU69HpPWMlhXQ1UdZl2ZNnWE6wJlgx38+bym0Q=
Date: Fri, 15 Nov 2024 05:02:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: stable@vger.kernel.org, Jann Horn <jannh@google.com>,
	stable <stable@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 6.6.y] mm: refactor map_deny_write_exec()
Message-ID: <2024111540-vegan-discard-a481@gregkh>
References: <2024111110-dubbed-hydration-c1be@gregkh>
 <20241114183615.849150-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114183615.849150-1-lorenzo.stoakes@oracle.com>

On Thu, Nov 14, 2024 at 06:36:15PM +0000, Lorenzo Stoakes wrote:
> Refactor the map_deny_write_exec() to not unnecessarily require a VMA
> parameter but rather to accept VMA flags parameters, which allows us to use
> this function early in mmap_region() in a subsequent commit.
> 
> While we're here, we refactor the function to be more readable and add some
> additional documentation.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> Cc: stable <stable@kernel.org>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mman.h | 21 ++++++++++++++++++---
>  mm/mmap.c            |  2 +-
>  mm/mprotect.c        |  2 +-
>  3 files changed, 20 insertions(+), 5 deletions(-)

There's no clue here as to what the upstream git id is :(

Also, you sent lots of patches for each branch, but not as a series, so
we have no idea what order these go in :(

Can you resend all of these, with the upstream git id in it, and as a
patch series, so we know to apply them correctly?

thanks,

greg k-h

