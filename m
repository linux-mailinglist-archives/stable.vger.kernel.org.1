Return-Path: <stable+bounces-203052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B10BCCEC97
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 08:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8312302F6B3
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 07:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8112C29293D;
	Fri, 19 Dec 2025 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nhiQQqdb"
X-Original-To: stable@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A6725EFAE;
	Fri, 19 Dec 2025 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766129605; cv=none; b=QJ9uMPGcqe8VszGcZj5UF0zwc5/YkfjQiAMgQ1SAhyM8JwckpwcKvMFPGWULGm5n2hU8ZnOC3QyjzPQIFIyF16ISygb4UQH6nxc+YZ6NMYtFZajUaeD12DASPjKO6v0tgAsYLFc+7rcYfiySNyZqZx+bRDQlyqDEb0CLu/5qoaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766129605; c=relaxed/simple;
	bh=BXSpOGK7rDa/XW0UwO4qPIvXM3lgNA2Nv4O2jWU4fSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+Q5gKvz7YZQbTv4f+tl1U4oSt1CM/iIF12i6ua+i/xmyUb/1jRJsVxpPuq1TtWPlymiY+TjL50CCBHN7hnxZaTEF0bgie+UFd6WRT0kQEL7WbmsQ8czHzpIRKuUyK1mFivQlxeL656g0zjRZvDnbUqylXWGslx7UMGBSfAyzuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nhiQQqdb; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766129599; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=w7YttiFvJJocA6qjJEuECPgS5jDT+Qm/G1px0Bn12Hs=;
	b=nhiQQqdb/Yx8/5NUAcQ3qZGs+OBqw7o/fwr8oDCvJw/J3YcBaMSNv/KEnPsguXmP6U99oNQmaB+yl1JKUFxzzOcwoV4NACm2Mi1nk/MOhewX+FqpUdJIYHAkvd2Er1KpXvhnIpVtYWkx24v3hwBdV3yLofChqbITsn/lQzsb+pI=
Received: from 30.221.131.220(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvBrV2S_1766129598 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Dec 2025 15:33:18 +0800
Message-ID: <6a9737d3-1ecd-4105-ad8d-8379cb35bfc7@linux.alibaba.com>
Date: Fri, 19 Dec 2025 15:33:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix unexpected EIO under memory pressure
To: Junbeom Yeom <junbeom.yeom@samsung.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jaewook Kim <jw5454.kim@samsung.com>,
 Sungjong Seo <sj1557.seo@samsung.com>
References: <CGME20251219071140epcas1p35856372483a973806c5445fa3d2d260b@epcas1p3.samsung.com>
 <20251219071034.2399153-1-junbeom.yeom@samsung.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251219071034.2399153-1-junbeom.yeom@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junbeom,

On 2025/12/19 15:10, Junbeom Yeom wrote:
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
>    . pread(fd, buf, count, offset)
>    . readahead(fd, offset, count)
> - Thread A tries to read the last 4K
> - Thread B tries to do readahead 8K from 4K
> - RA, besteffort == false
> - R, besteffort == true
> 
>          <process A>                   <process B>
> 
> pread(FileA, buf, 4K, 12K)
>    do readahead(page3) // failed with ENOMEM
>    wait_lock(page3)
>      if (!uptodate(page3))
>        goto do_read
>                                 readahead(FileA, 4K, 8K)
>                                 // Here create PCL-chain like below:
>                                 // [null, page1] [page2, null]
>                                 //   [PCL0:RA]-----[PCL1:RA]
> ...
>    do read(page3)        // found [PCL1:RA] and add page3 into it,
>                          // and then, change PCL1 from RA to R
> ...
>                                 // Now, PCL-chain is as below:
>                                 // [null, page1] [page2, page3]
>                                 //   [PCL0:RA]-----[PCL1:R]
> 
>                                   // try to decompress PCL-chain...
>                                   z_erofs_decompress_queue
>                                     err = 0;
> 
>                                     // failed with ENOMEM, so page 1
>                                     // only for RA will not be uptodated.
>                                     // it's okay.
>                                     err = decompress([PCL0:RA], err)
> 
>                                     // However, ENOMEM propagated to next
>                                     // PCL, even though PCL is not only
>                                     // for RA but also for R. As a result,
>                                     // it just failed with ENOMEM without
>                                     // trying any decompression, so page2
>                                     // and page3 will not be uptodated.
>                  ** BUG HERE ** --> err = decompress([PCL1:R], err)
> 
>                                     return err as ENOMEM
> ...
>      wait_lock(page3)
>        if (!uptodate(page3))
>          return EIO      <-- Return an unexpected EIO!
> ...

Many thanks for the report!
It's indeed a new issue to me.

> 
> Fixes: 2349d2fa02db ("erofs: sunset unneeded NOFAILs")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jaewook Kim <jw5454.kim@samsung.com>
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>
> ---
>   fs/erofs/zdata.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 27b1f44d10ce..86bf6e087d34 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1414,11 +1414,15 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
>   	};
>   	struct z_erofs_pcluster *next;
>   	int err = io->eio ? -EIO : 0;
> +	int io_err = err;
>   
>   	for (; be.pcl != Z_EROFS_PCLUSTER_TAIL; be.pcl = next) {
> +		int propagate_err;
> +
>   		DBG_BUGON(!be.pcl);
>   		next = READ_ONCE(be.pcl->next);
> -		err = z_erofs_decompress_pcluster(&be, err) ?: err;
> +		propagate_err = READ_ONCE(be.pcl->besteffort) ? io_err : err;
> +		err = z_erofs_decompress_pcluster(&be, propagate_err) ?: err;

I wonder if it's just possible to decompress each pcluster
according to io status only (but don't bother with previous
pcluster status), like:

		err = z_erofs_decompress_pcluster(&be, io->eio) ?: err;

and change the second argument of
z_erofs_decompress_pcluster() to bool.

So that we could leverage the successful i/o as much as
possible.

Thanks,
Gao Xiang

>   	}
>   	return err;
>   }


