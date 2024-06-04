Return-Path: <stable+bounces-47923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 966238FB25C
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 14:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336BFB24F57
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 12:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69B714659C;
	Tue,  4 Jun 2024 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tN6vvnbe"
X-Original-To: stable@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941C1487D8;
	Tue,  4 Jun 2024 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504397; cv=none; b=MMFmSqjN+RzciP5/ddjxG+opza81AvPihi/kUkyQFetdTgLxksNSwfTpT5LiTz37+Ft3xIWTyKmDxQz3FYIwnM8KQl5/TN3hRKOOUyQkCE/NA/8Lu0oeex03cqqJ26v+YQStr79vIN5TLd6ZF97RVSlbD52K7iEHfVpmdHSuqGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504397; c=relaxed/simple;
	bh=Tqd5JjQ0cpaE1LM5RMkd63Pif/b7Ua6b/h681tKehrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OADGH+ETA+Nd6OP4RYHVMwDxRDYekMmnnE1LbG0phaHheg42ULBtY8q5ItCZneQDUMMURaMK5Nxws6sgvw0Kc1F2B17zdrgwQPird21pItNMmBj2HmjC1+2BH0RjOolNhWc9BFGemlzwHwmRxaNr50jlYeQmRKyK2zVcSsI/gkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tN6vvnbe; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717504387; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vxIG2R55s4yY7prg9Nc5naXQ08DlMj845U2a75WllnY=;
	b=tN6vvnbeKhz7OWKqB6Pt79i0BkbnctNzo7XpaI7npJf51kE6BCPAu+QSwb7/zyRa5NyZf/eZBVW42e3zqjtvC+lnNaXiQWe1Su6xNARg+yznB43YtIRhSPwqS5fNf/EPnzPp5jR743LCAu+zNWq9iip9ZW4j8aRYInd//p9svJw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W7r6a2G_1717504385;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7r6a2G_1717504385)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 20:33:06 +0800
Message-ID: <2911d7ae-1724-49e1-9ac3-3cc0801fdbcb@linux.alibaba.com>
Date: Tue, 4 Jun 2024 20:33:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9.y] erofs: avoid allocating DEFLATE streams before
 mounting
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, Baokun Li <libaokun1@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Sandeep Dhavale <dhavale@google.com>,
 stable@vger.kernel.org
References: <20240530092201.16873-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240530092201.16873-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

ping? Do these backport fixes miss the 6.6, 6.8, 6.9 queues..

Thanks,
Gao XIang

On 2024/5/30 17:21, Gao Xiang wrote:
> commit 80eb4f62056d6ae709bdd0636ab96ce660f494b2 upstream.
> 
> Currently, each DEFLATE stream takes one 32 KiB permanent internal
> window buffer even if there is no running instance which uses DEFLATE
> algorithm.
> 
> It's unexpected and wasteful on embedded devices with limited resources
> and servers with hundreds of CPU cores if DEFLATE is enabled but unused.
> 
> Fixes: ffa09b3bd024 ("erofs: DEFLATE compression support")
> Cc: <stable@vger.kernel.org> # 6.6+
> Reviewed-by: Sandeep Dhavale <dhavale@google.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Link: https://lore.kernel.org/r/20240520090106.2898681-1-hsiangkao@linux.alibaba.com
> ---
>   fs/erofs/decompressor_deflate.c | 55 +++++++++++++++++----------------
>   1 file changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
> index 81e65c453ef0..3a3461561a3c 100644
> --- a/fs/erofs/decompressor_deflate.c
> +++ b/fs/erofs/decompressor_deflate.c
> @@ -46,39 +46,15 @@ int __init z_erofs_deflate_init(void)
>   	/* by default, use # of possible CPUs instead */
>   	if (!z_erofs_deflate_nstrms)
>   		z_erofs_deflate_nstrms = num_possible_cpus();
> -
> -	for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstrms;
> -	     ++z_erofs_deflate_avail_strms) {
> -		struct z_erofs_deflate *strm;
> -
> -		strm = kzalloc(sizeof(*strm), GFP_KERNEL);
> -		if (!strm)
> -			goto out_failed;
> -
> -		/* XXX: in-kernel zlib cannot shrink windowbits currently */
> -		strm->z.workspace = vmalloc(zlib_inflate_workspacesize());
> -		if (!strm->z.workspace) {
> -			kfree(strm);
> -			goto out_failed;
> -		}
> -
> -		spin_lock(&z_erofs_deflate_lock);
> -		strm->next = z_erofs_deflate_head;
> -		z_erofs_deflate_head = strm;
> -		spin_unlock(&z_erofs_deflate_lock);
> -	}
>   	return 0;
> -
> -out_failed:
> -	erofs_err(NULL, "failed to allocate zlib workspace");
> -	z_erofs_deflate_exit();
> -	return -ENOMEM;
>   }
>   
>   int z_erofs_load_deflate_config(struct super_block *sb,
>   			struct erofs_super_block *dsb, void *data, int size)
>   {
>   	struct z_erofs_deflate_cfgs *dfl = data;
> +	static DEFINE_MUTEX(deflate_resize_mutex);
> +	static bool inited;
>   
>   	if (!dfl || size < sizeof(struct z_erofs_deflate_cfgs)) {
>   		erofs_err(sb, "invalid deflate cfgs, size=%u", size);
> @@ -89,9 +65,36 @@ int z_erofs_load_deflate_config(struct super_block *sb,
>   		erofs_err(sb, "unsupported windowbits %u", dfl->windowbits);
>   		return -EOPNOTSUPP;
>   	}
> +	mutex_lock(&deflate_resize_mutex);
> +	if (!inited) {
> +		for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstrms;
> +		     ++z_erofs_deflate_avail_strms) {
> +			struct z_erofs_deflate *strm;
> +
> +			strm = kzalloc(sizeof(*strm), GFP_KERNEL);
> +			if (!strm)
> +				goto failed;
> +			/* XXX: in-kernel zlib cannot customize windowbits */
> +			strm->z.workspace = vmalloc(zlib_inflate_workspacesize());
> +			if (!strm->z.workspace) {
> +				kfree(strm);
> +				goto failed;
> +			}
>   
> +			spin_lock(&z_erofs_deflate_lock);
> +			strm->next = z_erofs_deflate_head;
> +			z_erofs_deflate_head = strm;
> +			spin_unlock(&z_erofs_deflate_lock);
> +		}
> +		inited = true;
> +	}
> +	mutex_unlock(&deflate_resize_mutex);
>   	erofs_info(sb, "EXPERIMENTAL DEFLATE feature in use. Use at your own risk!");
>   	return 0;
> +failed:
> +	mutex_unlock(&deflate_resize_mutex);
> +	z_erofs_deflate_exit();
> +	return -ENOMEM;
>   }
>   
>   int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,

