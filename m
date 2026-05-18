Return-Path: <stable+bounces-249279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cElDKyMSC2pN/gQAu9opvQ
	(envelope-from <stable+bounces-249279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:20:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0EB56D832
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD85E301259C
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6DA4508E0;
	Mon, 18 May 2026 13:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i1BWv6GQ"
X-Original-To: stable@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7FF37474E;
	Mon, 18 May 2026 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109635; cv=none; b=Ky3ci9gg8LHjlu0b8XGN6y27TnU7AMeJUKdtZgBPNtwyYYlf5Dkdey2RaJbpkADvxNU8XAaX/OLCXXZ7Cl0gBCqfdQ2KBhHu6vX56mIxhgFLdvNZQTHl80wn668Ef7ZfnQ6JLZIIo27eScT8ukEidAeinKlxvezLxgPdl4EY5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109635; c=relaxed/simple;
	bh=NV+93vQoKpA9U/awOT8CQeVPCZuqz/UwSizp/WHd7oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2gvt9ADi7Z9QxAGchpseV6K1je6a5/yOG4uwG6a8H9MBD7GopYRZSJQ3pGGkIU6EbILsNdB0ZJ4orGsb00XzEcwduN+pt3fdmrxLCGaJV816xwZJzSRrRubmkmTTFAP6EOn/WImgLP8zzfOmPmMX7Qn8cJCs7Kd5FVL11OiAgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i1BWv6GQ; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779109629; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3vCNvWacL+e/LDKgucGikS1k2qctpCgD6CiKueHAwNs=;
	b=i1BWv6GQl9GJ1Rq9+adoH3ImjgaLPzoKEV5tYepsm3CmP+Go/LWwrkhB3spUBHCTNhTWuSkMvMIs0zQyHugDT2UEJsamHRue78ULNSVvYYOLPgSgWClSEGufN1m4rXDbngkZMX+NbRkQkwhjNr1VzpZQocRO0vkiCG7WD9/XVPY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X39EDrw_1779109628;
Received: from 30.120.66.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X39EDrw_1779109628 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 21:07:09 +0800
Message-ID: <75e6d1c8-e989-4eb7-aca3-37a40318e888@linux.alibaba.com>
Date: Mon, 18 May 2026 21:07:08 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "erofs: verify metadata accesses for file-backed mounts"
 has been added to the 7.0-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org, xiang@kernel.org
Cc: Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>
References: <20260518115230.832200-1-sashal@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260518115230.832200-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AE0EB56D832
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249279-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vivo.com:email]
X-Rspamd-Action: no action

Hi,

On 2026/5/18 19:52, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      erofs: verify metadata accesses for file-backed mounts
> 
> to the 7.0-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       erofs-verify-metadata-accesses-for-file-backed-mount.patch
> and it can be found in the queue-7.0 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop it from the stable tree, since it will introduce
a permission issue on Android and an ongoing fix is under very
slow discussion.  I will address this commit manually instead.

Thanks,
Gao Xiang

> 
> 
> 
> commit 4c99f30a9b495a26c4a94db9f74cbe202eded2ea
> Author: Gao Xiang <xiang@kernel.org>
> Date:   Mon Mar 30 10:29:29 2026 +0800
> 
>      erofs: verify metadata accesses for file-backed mounts
>      
>      [ Upstream commit 307210c262a29f41d7177851295ea1703bd04175 ]
>      
>      For file-backed mounts, metadata is fetched via the page cache of
>      backing inodes to avoid double caching and redundant copy ops out
>      of RO uptodate folios, which is used by Android APEXes, ComposeFS,
>      containerd.  However, rw_verify_area() was missing prior to
>      metadata accesses.
>      
>      Similar to vfs_iocb_iter_read(), fix this by:
>       - Enabling fanotify pre-content hooks on metadata accesses;
>       - security_file_permission() for security modules.
>      
>      Verified that fanotify pre-content hooks now works correctly.
>      
>      Fixes: fb176750266a ("erofs: add file-backed mount support")
>      Acked-by: Amir Goldstein <amir73il@gmail.com>
>      Reviewed-by: Chunhai Guo <guochunhai@vivo.com>
>      Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index f79ee80627d95..132a27deb2f3b 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -30,6 +30,20 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
>   {
>   	pgoff_t index = (buf->off + offset) >> PAGE_SHIFT;
>   	struct folio *folio = NULL;
> +	loff_t fpos;
> +	int err;
> +
> +	/*
> +	 * Metadata access for file-backed mounts reuses page cache of backing
> +	 * fs inodes (only folio data will be needed) to prevent double caching.
> +	 * However, the data access range must be verified here in advance.
> +	 */
> +	if (buf->file) {
> +		fpos = index << PAGE_SHIFT;
> +		err = rw_verify_area(READ, buf->file, &fpos, PAGE_SIZE);
> +		if (err < 0)
> +			return ERR_PTR(err);
> +	}
>   
>   	if (buf->page) {
>   		folio = page_folio(buf->page);


