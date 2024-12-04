Return-Path: <stable+bounces-98221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDE59E3246
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 04:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F47B26BA9
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 03:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B960814EC77;
	Wed,  4 Dec 2024 03:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bmokr1QK"
X-Original-To: stable@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCAC17BA1;
	Wed,  4 Dec 2024 03:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733284081; cv=none; b=sa2dbI+ZiM1Bu16NxRuCAVHK/5fAy584eyYyJFjhQPYzOgNOz9ZD4Yk+niQyUjrcYvr18bnobNCPuWZhmSb6GouWiqcVlKQ1iUuWBEHKa21oqW+Ss4v1eDmRhgceT74Q10j2MdwtXBHp98H5/LoIda8NxVI0M8ayRzvaBxMbMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733284081; c=relaxed/simple;
	bh=yLCGlJ1N1/GBNMtuCkIzGBcSOO79gvcY8Vg+NleXdlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbFYQ1gERI8ScBhEAPqtHSvaQ4ZOGF+8ZhK8oWgoCvU8/W3LXe5K23J+zk3zghS3myAN+5C1bapWgGdKnrHf96swgfK2hSd2ob4qJ/4m9FQrSwmwmR2JNpLXG2e20XEFR/c9vk0ae0R3HfSB8Ki+LLK8WkfVrJIG3cDczx1hdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bmokr1QK; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733284070; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RNn+AlnjbPZN6/wfvX/gSHfjWLTDt0n5gO20Q5PTBh8=;
	b=bmokr1QK2FIEkG5lFKxL+TWJ22nKXTAY/0Eu+loFb+9EQU3LJ+JF1sP79oRs7K3Drz5VEQwJSzoGfBgJnQbcmxPlr3GH/5KsOBrwy+EGA2x3bj6P6oJLxK/YUKKrHnoFZoA84LA423auVatSg3b0pgJqORSK4Z5h0fyx+bRJp2M=
Received: from 30.221.128.184(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WKohVzX_1733284068 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Dec 2024 11:47:49 +0800
Message-ID: <6c3e1f5a-916c-4959-a505-d3d3917e5c9c@linux.alibaba.com>
Date: Wed, 4 Dec 2024 11:47:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ocfs2: Revert "ocfs2: fix the la space leak when
 unmounting an ocfs2 volume"
To: Heming Zhao <heming.zhao@suse.com>, ocfs2-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org, Heming Zhao <heing.zhao@suse.com>,
 stable@vger.kernel.org
References: <20241204033243.8273-1-heming.zhao@suse.com>
 <20241204033243.8273-2-heming.zhao@suse.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20241204033243.8273-2-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/4/24 11:32 AM, Heming Zhao wrote:
> This reverts commit dfe6c5692fb5 ("ocfs2: fix the la space leak when
> unmounting an ocfs2 volume").
> 
> In commit dfe6c5692fb5, the commit log stating "This bug has existed
> since the initial OCFS2 code." is incorrect. The correct introduction
> commit is 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()").
> 

Could you please elaborate more how it happens?
And it seems no difference with the new version. So we may submit a
standalone revert patch to those backported stable kernels (< 6.10).

Thanks,
Joseph

> Fixes: dfe6c5692fb5 ("ocfs2: fix the la space leak when unmounting an ocfs2 volume")
> Signed-off-by: Heming Zhao <heing.zhao@suse.com>
> Cc: <stable@vger.kernel.org>
> ---
>  fs/ocfs2/localalloc.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
> index 8ac42ea81a17..5df34561c551 100644
> --- a/fs/ocfs2/localalloc.c
> +++ b/fs/ocfs2/localalloc.c
> @@ -1002,25 +1002,6 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
>  		start = bit_off + 1;
>  	}
>  
> -	/* clear the contiguous bits until the end boundary */
> -	if (count) {
> -		blkno = la_start_blk +
> -			ocfs2_clusters_to_blocks(osb->sb,
> -					start - count);
> -
> -		trace_ocfs2_sync_local_to_main_free(
> -				count, start - count,
> -				(unsigned long long)la_start_blk,
> -				(unsigned long long)blkno);
> -
> -		status = ocfs2_release_clusters(handle,
> -				main_bm_inode,
> -				main_bm_bh, blkno,
> -				count);
> -		if (status < 0)
> -			mlog_errno(status);
> -	}
> -
>  bail:
>  	if (status)
>  		mlog_errno(status);


