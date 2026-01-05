Return-Path: <stable+bounces-204802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE6FCF4061
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 15:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAF1230124C3
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6BC32ED45;
	Mon,  5 Jan 2026 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NSv2eP/K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A294330320
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621392; cv=none; b=n8RLq8dyHL9xoo5RJ/76tFGAJ7HPPCAYkCN3tAvzhPD+aZbwJh9AEEcjSmN9XUHIsqv01fTmZCNGXyN9vpZ8s2n6qBV/RkpZNflbsuh+DDNcT055K4CB4CTlIjk2imxAFd56i0OD8+9tHOhtwXrt1n9JWPiqlzgjgdyXl9hMcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621392; c=relaxed/simple;
	bh=exf/ch0MIW7+QupHXcxhIWfeHbtq+6PKpQdBxOEUCvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3J4DEzuqQoziNyjtdiUrJkhvmCs/AhxsCdlYgP6KELVB0XoVR97Kj6HFv7WEhjRgX2fqBhbn7ory0cnInviSX7kTua1SzpOoXD4Na3ERwmZ9hHygD0gPb2O07LoVOAII+cUc4SPVkDo7YsaefzvhMbwsRz2htS5qpeZOw8N61Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NSv2eP/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB79C116D0;
	Mon,  5 Jan 2026 13:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767621391;
	bh=exf/ch0MIW7+QupHXcxhIWfeHbtq+6PKpQdBxOEUCvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSv2eP/K6FmZx7gH9HYHTTslJS5KltgSZCPtDXLo/ScMY7RNyD5w7v7b3KBSdPWWW
	 e+btA5pYqNmFlJkBUOQOlTb3Fixa0xcHfgewYzajUZNVLInnDdCCBptlDdXFj2MkC/
	 06s4qhSRmh4XXdyFV4scC7M22WsASXQ18Ct91IFk=
Date: Mon, 5 Jan 2026 14:56:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	linux-erofs@lists.ozlabs.org,
	Junbeom Yeom <junbeom.yeom@samsung.com>,
	Jaewook Kim <jw5454.kim@samsung.com>,
	Sungjong Seo <sj1557.seo@samsung.com>
Subject: Re: [PATCH 6.18.y v2] erofs: fix unexpected EIO under memory pressure
Message-ID: <2026010521-snout-handheld-98f3@gregkh>
References: <20251229185432.1616355-2-sashal@kernel.org>
 <20251230023053.3682970-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230023053.3682970-1-hsiangkao@linux.alibaba.com>

On Tue, Dec 30, 2025 at 10:30:53AM +0800, Gao Xiang wrote:
> From: Junbeom Yeom <junbeom.yeom@samsung.com>
> 
> erofs readahead could fail with ENOMEM under the memory pressure because
> it tries to alloc_page with GFP_NOWAIT | GFP_NORETRY, while GFP_KERNEL
> for a regular read. And if readahead fails (with non-uptodate folios),
> the original request will then fall back to synchronous read, and
> `.read_folio()` should return appropriate errnos.
> 
> However, in scenarios where readahead and read operations compete,
> read operation could return an unintended EIO because of an incorrect
> error propagation.
> 
> To resolve this, this patch modifies the behavior so that, when the
> PCL is for read(which means pcl.besteffort is true), it attempts actual
> decompression instead of propagating the privios error except initial EIO.
> 
> - Page size: 4K
> - The original size of FileA: 16K
> - Compress-ratio per PCL: 50% (Uncompressed 8K -> Compressed 4K)
> [page0, page1] [page2, page3]
> [PCL0]---------[PCL1]
> 
> - functions declaration:
>   . pread(fd, buf, count, offset)
>   . readahead(fd, offset, count)
> - Thread A tries to read the last 4K
> - Thread B tries to do readahead 8K from 4K
> - RA, besteffort == false
> - R, besteffort == true
> 
>         <process A>                   <process B>
> 
> pread(FileA, buf, 4K, 12K)
>   do readahead(page3) // failed with ENOMEM
>   wait_lock(page3)
>     if (!uptodate(page3))
>       goto do_read
>                                readahead(FileA, 4K, 8K)
>                                // Here create PCL-chain like below:
>                                // [null, page1] [page2, null]
>                                //   [PCL0:RA]-----[PCL1:RA]
> ...
>   do read(page3)        // found [PCL1:RA] and add page3 into it,
>                         // and then, change PCL1 from RA to R
> ...
>                                // Now, PCL-chain is as below:
>                                // [null, page1] [page2, page3]
>                                //   [PCL0:RA]-----[PCL1:R]
> 
>                                  // try to decompress PCL-chain...
>                                  z_erofs_decompress_queue
>                                    err = 0;
> 
>                                    // failed with ENOMEM, so page 1
>                                    // only for RA will not be uptodated.
>                                    // it's okay.
>                                    err = decompress([PCL0:RA], err)
> 
>                                    // However, ENOMEM propagated to next
>                                    // PCL, even though PCL is not only
>                                    // for RA but also for R. As a result,
>                                    // it just failed with ENOMEM without
>                                    // trying any decompression, so page2
>                                    // and page3 will not be uptodated.
>                 ** BUG HERE ** --> err = decompress([PCL1:R], err)
> 
>                                    return err as ENOMEM
> ...
>     wait_lock(page3)
>       if (!uptodate(page3))
>         return EIO      <-- Return an unexpected EIO!
> ...
> 
> Fixes: 2349d2fa02db ("erofs: sunset unneeded NOFAILs")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jaewook Kim <jw5454.kim@samsung.com>
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> Hi Greg and Sasha,
> 
> Let's just merge this directly.
> No need to backport commit 831faabed812 ("erofs: improve decompression error reporting")
> for now.

Now taken, thanks!

greg k-h

