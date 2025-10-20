Return-Path: <stable+bounces-188121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB8BF189B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1875318A3E25
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4A72E8B62;
	Mon, 20 Oct 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FdPaVTV3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846417A586;
	Mon, 20 Oct 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967054; cv=none; b=tCNnrt2RTzJLl0P2oqTRMGZkRQmKOEg+N+xu583N7KWwqZ3OVkRDC0wNk2kt8W1nK3PH1nNdJne7ngicpRHtfnK8GVkBmlCZ6R0oSobqj2f5qROC1oNRHaHj13GeMnGxLYYcHRDE+bHqk20GTQ2FFXdZiJe9oyMeOzVZwpMWmTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967054; c=relaxed/simple;
	bh=LEO1rZcjIJoUtq76htybn4CGCWnrxdjv0nwr9xfd54E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czJxTGGzjne0bn8GNyhipC26JAKth8rEpytwYxO7xEDEGzGqUJzK6BHf0jZG3uZnzaXsuHIigwT3bS0twSphSNUo7X46gsvnlxlBgs72URoRosIg3GqiOPVaXAri+fOVurk1oPhGPahECzju2S9Xs3GSpBOglARoCkinKzjz9Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FdPaVTV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C3AC4CEF9;
	Mon, 20 Oct 2025 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760967053;
	bh=LEO1rZcjIJoUtq76htybn4CGCWnrxdjv0nwr9xfd54E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FdPaVTV3edfZu0DTQQLNRiY10JM2H9XHxqUgu1DukMNwXJzSM36+ndJYsQLJd7UsY
	 vnaPV4XOyS6b2kJIWwO+sY53+iUcQrczqpdGvSNNNc+OQK2hqjXz95g46yQHSsa/2z
	 R1HAFTdxyZG7800vL4MlRspTQ9cR/s6FePZgqaBo=
Date: Mon, 20 Oct 2025 15:30:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5.15.y 2/3] arch: back to -std=gnu89 in < v5.18
Message-ID: <2025102015-alongside-kiwi-6f75@gregkh>
References: <20251017-v5-15-gcc-15-v1-0-da6c065049d7@kernel.org>
 <20251017-v5-15-gcc-15-v1-2-da6c065049d7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-v5-15-gcc-15-v1-2-da6c065049d7@kernel.org>

On Fri, Oct 17, 2025 at 06:24:01PM +0200, Matthieu Baerts (NGI0) wrote:
> Recent fixes have been backported to < v5.18 to fix build issues with
> GCC 5.15. They all force -std=gnu11 in the CFLAGS, "because [the kernel]
> requests the gnu11 standard via '-std=' in the main Makefile".
> 
> This is true for >= 5.18 versions, but not before. This switch to
> -std=gnu11 has been done in commit e8c07082a810 ("Kbuild: move to
> -std=gnu11").
> 
> For a question of uniformity, force -std=gnu89, similar to what is done
> in the main Makefile.
> 
> Note: the fixes tags below refers to upstream commits, but this fix is
> only for kernels not having commit e8c07082a810 ("Kbuild: move to
> -std=gnu11").
> 
> Fixes: 7cbb015e2d3d ("parisc: fix building with gcc-15")
> Fixes: 3b8b80e99376 ("s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS")
> Fixes: b3bee1e7c3f2 ("x86/boot: Compile boot code with -std=gnu11 too")
> Fixes: ee2ab467bddf ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")
> Fixes: 8ba14d9f490a ("efi: libstub: Use '-std=gnu11' to fix build with GCC 15")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Note:
>   An alternative is to backport commit e8c07082a810 ("Kbuild: move to
>   -std=gnu11"), but I guess we might not want to do that for stable, as
>   it might introduce new warnings.

I would rather do that, as that would allow us to make things align up
and be easier to support over the next two years that this kernel needs
to be alive for.  How much work would that entail?

thanks,

greg k-h

