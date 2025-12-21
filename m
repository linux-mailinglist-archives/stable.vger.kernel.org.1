Return-Path: <stable+bounces-203164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9254FCD429C
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 17:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16F14300658E
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE5C2F6577;
	Sun, 21 Dec 2025 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="toO0U0F9"
X-Original-To: stable@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA2986352;
	Sun, 21 Dec 2025 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766332818; cv=none; b=TdCd0PYJnmlC9yyVGRaxAJ0NYrw7M40IP2jjSsV3szAc76fEh74l4heeLhem8FkQgZ8hl7EBUc9En/TJmqcaVnMSXDp57lor9YAJU1Om372z2Q/UqV3vrQzM8YQlxRh3hv+hpZX0vYpEdvHUQgnk79t60CegEnrWvnogAoPGc7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766332818; c=relaxed/simple;
	bh=HKpA2T0u4QqWlM8JmhrPuDVXGUGzQ6rfPmv7E1O9hy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhkKon0TgJuMaxktnACq1gfRIalH7Z/fRzrBG4iG1NIhuwr101eZSQTluhffCsoQZASDPqKmEIe0Zg8Txx0rRNUWyukSZSG1kDTVIZxzlxaccvOQqzoadQikcqUTVaclSuL33epqQ60gVFzgb5D7Y9xG/T11tKdFhKAG3BD4SmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=toO0U0F9; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766332810; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sK5t599nMi0FN+wbtrBnMxUfbuG0tOLHfE9SiH9PK3I=;
	b=toO0U0F98WoL9Hd8chUaFib8BXQKZLuPeC1gzrGFvAgH7uyeBfzErcC8Y24IVZkXLpRpAHPrVAtaYHDux7oIwl3Pl2aaVtAeg+7O5Un0LChnUCL8yXIyExzbjI7RJ9QUtuhDX+oqK4L1L5boIF7GJY2ljdl4CHKyLKI+fQYulWQ=
Received: from 30.69.38.206(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvJ9WZt_1766332801 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 00:00:09 +0800
Message-ID: <b0a8a71e-f232-4555-9e5b-e62e21b93b5d@linux.alibaba.com>
Date: Mon, 22 Dec 2025 00:00:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix unexpected EIO under memory pressure
To: Junbeom Yeom <junbeom.yeom@samsung.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jaewook Kim <jw5454.kim@samsung.com>,
 Sungjong Seo <sj1557.seo@samsung.com>
References: <CGME20251219124044epcas1p3df48558b10b0540c2ea1ec65779c261d@epcas1p3.samsung.com>
 <20251219124031.2731710-1-junbeom.yeom@samsung.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251219124031.2731710-1-junbeom.yeom@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/19 20:40, Junbeom Yeom wrote:
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
> 
> Fixes: 2349d2fa02db ("erofs: sunset unneeded NOFAILs")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jaewook Kim <jw5454.kim@samsung.com>
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

