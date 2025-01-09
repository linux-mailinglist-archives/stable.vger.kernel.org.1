Return-Path: <stable+bounces-108066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27063A07118
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 10:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FFB1670DF
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBA12144DD;
	Thu,  9 Jan 2025 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QWvk1mlP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A21680B;
	Thu,  9 Jan 2025 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414044; cv=none; b=JrpVmNkL3l8z1LG+nnL09gcokkvO0/ntQSXIEEQEonlk0Rp8tZa9r376vhWFcihp5YEMmOsfkjnveIumvsM62HnIybzUOFEhm6RnXsKLB+qWNMF6IntZ7nMinxfGAj+CTIK6Ud4dUknP1ePngNd30DF/X9WfS+a41hE/pGnQgxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414044; c=relaxed/simple;
	bh=6nraa1AIt5qTIZdA0dJ8ryLv/h+s9bT279up+4Q35iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9TsDvCZ8PUGrvdQEzJ1SwNjLBCS6OGSlMg3TQfCNXmkI8ZR8jpfSC8ojlMz7Lxk8e04/gElQkAwoT5+1T1qad/aufBiYHMsbs/DfhK/VSGaEzqqxFzvUowGsi6t26p/swhnC41GJka5BV3ZGiaxNR4V3eeSXk2fGXxfQMqdJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QWvk1mlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B19C4CED2;
	Thu,  9 Jan 2025 09:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736414044;
	bh=6nraa1AIt5qTIZdA0dJ8ryLv/h+s9bT279up+4Q35iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWvk1mlPxhWAAcU0mEyKXgTfkRPR2SQob3nlGp0MMwUZTeTva+Crvx538Mhnu0KQJ
	 TrF8PcjGM41vOaD9NJ5ye6+tN1yzMjHqlaPkQ0nCKU+9MOO2LHrWNR7UIAs5l7iOwx
	 BiHggRDNb4OxnCesevZTu1NnUluoUXuWG1OGrv3M=
Date: Thu, 9 Jan 2025 10:14:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yufeng Wang <wangyufeng@kylinos.cn>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Uros Bizjak <ubizjak@gmail.com>, Shunsuke Mie <mie@igel.co.jp>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tools: fixed compile tools/virtio error "__user"
 redefined [-Werror]
Message-ID: <2025010943-chess-affluent-1bb5@gregkh>
References: <20250109084341.477226-1-wangyufeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109084341.477226-1-wangyufeng@kylinos.cn>

On Thu, Jan 09, 2025 at 04:43:41PM +0800, Yufeng Wang wrote:
> we use -Werror now, and warnings break the build so let's fixed it.
> 
> from virtio_test.c:17:
> ./linux/../../../include/linux/compiler_types.h:48: error: "__user" redefined [-Werror]
> 48 | # define __user BTF_TYPE_TAG(user)
> |
> In file included from ../../usr/include/linux/stat.h:5,
> from /usr/include/x86_64-linux-gnu/bits/statx.h:31,
> from /usr/include/x86_64-linux-gnu/sys/stat.h:465,
> from virtio_test.c:12:
> ../include/linux/types.h:56: note: this is the location of the previous definition
> 56 | #define __user
> 
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
> ---
>  include/linux/compiler_types.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 5d6544545658..3316e56140d6 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -54,6 +54,7 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
>  # ifdef STRUCTLEAK_PLUGIN
>  #  define __user	__attribute__((user))
>  # else
> +#  undef __user
>  #  define __user	BTF_TYPE_TAG(user)
>  # endif
>  # define __iomem
> -- 
> 2.34.1

What commit does this fix?  Why is this suddenly showing up now?

thanks,

greg k-h

