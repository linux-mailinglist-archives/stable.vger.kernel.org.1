Return-Path: <stable+bounces-224644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIfIIQUMsWldqAIAu9opvQ
	(envelope-from <stable+bounces-224644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 07:30:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7B925CD8F
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 07:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F14B31798C7
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 06:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206682EB0F;
	Wed, 11 Mar 2026 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oViB3+5p"
X-Original-To: stable@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678EAA59
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773210626; cv=none; b=HEtOm60k6irvqSANFEWJSePEBB1FxO+U5P0SEK+X9/ytORrjsXiEBi4nMBGj6c10MdYcjKSvp7tlPklCvn34/pIXlv+pCqMioseC0l7W2xIek4Psa27FhrqioeYb2upGz0XxAXzE/RybiRPYwi9eJ+OymiT/Ii78TC/hD7IcGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773210626; c=relaxed/simple;
	bh=NODJ4LuIWGe3ldxttYy6nc99/ylGQnQADyH7UYSufoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2xMKxJLcOzYkdNnXxiz60JToZG8v+FtSNHL6Nyx3wZ4T+RqYpjS0WUp7Udzih4GdzX1yD4JcDXFcgzYpLgGyyJ/dW3EDgQnq1nRnXbnsDCclwO517FJeyU4CZTBs0qNqe7/wE4L09Bqn2GWIECGdJHTyuXm/M9MGCf4UPI8oLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oViB3+5p; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773210615; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BGRxTQz3bbCWd83NK2JDxvU/4ifWtTYyZfIixp/f1bQ=;
	b=oViB3+5pytghVUFPFPLVXwF7hvjKZ9z0q7Iqy+6kL+QWoSTTR5+TDW4TAQRqRPavcGdsYlWV0D1TPAT1mP8f2wcnjiATiLeJyBWRcK6cRoS/SDu98exNC7znkT1Skl1vrUxq8rxIm3apnRsBFsev+94PL+KnnBOG8JEp71fk14s=
Received: from 30.221.132.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-iu1ha_1773210614 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Mar 2026 14:30:15 +0800
Message-ID: <c70a77a2-bc29-4767-b4c2-c5ba12dae04e@linux.alibaba.com>
Date: Wed, 11 Mar 2026 14:30:14 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y] erofs: fix inline data read failure for
 ztailpacking pclusters
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, stable@vger.kernel.org
Cc: niuzhiguo84@gmail.com, ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com,
 linux-erofs@lists.ozlabs.org
References: <1773209614-1961-1-git-send-email-zhiguo.niu@unisoc.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1773209614-1961-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DB7B925CD8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224644-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,unisoc.com,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,unisoc.com:email]
X-Rspamd-Action: no action

Hi Zhiguo,

On 2026/3/11 14:13, Zhiguo Niu wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> [ Upstream commit c134a40f86efb8d6b5a949ef70e06d5752209be5 ]
> 
> Compressed folios for ztailpacking pclusters must be valid before adding
> these pclusters to I/O chains. Otherwise, z_erofs_decompress_pcluster()
> may assume they are already valid and then trigger a NULL pointer
> dereference.
> 
> It is somewhat hard to reproduce because the inline data is in the same
> block as the tail of the compressed indexes, which are usually read just
> before. However, it may still happen if a fatal signal arrives while
> read_mapping_folio() is running, as shown below:
> 
>   erofs: (device dm-1): z_erofs_pcluster_begin: failed to get inline data -4
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> 
>   ...
> 
>   pc : z_erofs_decompress_queue+0x4c8/0xa14
>   lr : z_erofs_decompress_queue+0x160/0xa14
>   sp : ffffffc08b3eb3a0
>   x29: ffffffc08b3eb570 x28: ffffffc08b3eb418 x27: 0000000000001000
>   x26: ffffff8086ebdbb8 x25: ffffff8086ebdbb8 x24: 0000000000000001
>   x23: 0000000000000008 x22: 00000000fffffffb x21: dead000000000700
>   x20: 00000000000015e7 x19: ffffff808babb400 x18: ffffffc089edc098
>   x17: 00000000c006287d x16: 00000000c006287d x15: 0000000000000004
>   x14: ffffff80ba8f8000 x13: 0000000000000004 x12: 00000006589a77c9
>   x11: 0000000000000015 x10: 0000000000000000 x9 : 0000000000000000
>   x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
>   x5 : 0000000000000040 x4 : ffffffffffffffe0 x3 : 0000000000000020
>   x2 : 0000000000000008 x1 : 0000000000000000 x0 : 0000000000000000
>   Call trace:
>    z_erofs_decompress_queue+0x4c8/0xa14
>    z_erofs_runqueue+0x908/0x97c
>    z_erofs_read_folio+0x128/0x228
>    filemap_read_folio+0x68/0x128
>    filemap_get_pages+0x44c/0x8b4
>    filemap_read+0x12c/0x5b8
>    generic_file_read_iter+0x4c/0x15c
>    do_iter_readv_writev+0x188/0x1e0
>    vfs_iter_read+0xac/0x1a4
>    backing_file_read_iter+0x170/0x34c
>    ovl_read_iter+0xf0/0x140
>    vfs_read+0x28c/0x344
>    ksys_read+0x80/0xf0
>    __arm64_sys_read+0x24/0x34
>    invoke_syscall+0x60/0x114
>    el0_svc_common+0x88/0xe4
>    do_el0_svc+0x24/0x30
>    el0_svc+0x40/0xa8
>    el0t_64_sync_handler+0x70/0xbc
>    el0t_64_sync+0x1bc/0x1c0
> 
> Fix this by reading the inline data before allocating and adding
> the pclusters to the I/O chains.
> 
> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Reviewed-and-tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/erofs/zdata.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 7116f20..0b3ca62 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -788,6 +788,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
>   	erofs_blk_t blknr = erofs_blknr(sb, map->m_pa);
>   	struct z_erofs_pcluster *pcl = NULL;
>   	int ret;
> +	void *mptr = NULL;

let's align with the upstream naming and ordering?

	void *ptr = NULL;
	int ret;

>   
>   	DBG_BUGON(fe->pcl);
>   	/* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous pcluster */
> @@ -807,6 +808,14 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
>   	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
>   		DBG_BUGON(1);
>   		return -EFSCORRUPTED;
> +	} else {
> +		mptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, EROFS_NO_KMAP);
> +		if (IS_ERR(mptr)) {
> +			ret = PTR_ERR(mptr);
> +			erofs_err(sb, "failed to get inline data %d", ret);

Could you retain the upstream error report? like:
			erofs_err(sb, "failed to read inline data %pe @ pa %llu of nid %llu",
				  mptr, map->m_pa, EROFS_I(fe->inode)->nid);

Otherwise it looks good to me.

When you send the next version, please send the patch
to Greg as well.

Thanks,
Gao Xiang

> +			return ret;
> +		}
> +		mptr = map->buf.page;
>   	}
>   
>   	if (pcl) {
> @@ -836,16 +845,8 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
>   		/* bind cache first when cached decompression is preferred */
>   		z_erofs_bind_cache(fe);
>   	} else {
> -		void *mptr;
> -
> -		mptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, EROFS_NO_KMAP);
> -		if (IS_ERR(mptr)) {
> -			ret = PTR_ERR(mptr);
> -			erofs_err(sb, "failed to get inline data %d", ret);
> -			return ret;
> -		}
> -		get_page(map->buf.page);
> -		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
> +		get_page((struct page *)mptr);
> +		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, mptr);
>   		fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
>   		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
>   	}


