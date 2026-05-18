Return-Path: <stable+bounces-249280-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIECLUcSC2pN/gQAu9opvQ
	(envelope-from <stable+bounces-249280-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:21:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BB21856D886
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36F1D3018313
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0C7480978;
	Mon, 18 May 2026 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="me6+H4cd"
X-Original-To: stable@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3243F88A2;
	Mon, 18 May 2026 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109675; cv=none; b=ZbMkMZrqwOTAQfiOB3kIqBvSbNM3UJLFTjArGnTgkfZ+YrA8fnGqLfIrAaXtO52FGrAYWiGSkstFwJnT+XiBKJ5flmZQapS4BCKrBWNrAEQJ49kieDSLy1XZ/8dV1Hgx2fi0lgltfQx9mUUmFO33GzXWUICY8ouwaZfZAC3OWWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109675; c=relaxed/simple;
	bh=AvfNu9jlJpGJlIYpoRUZdi7XLgJYXd2+WaQoIFSPags=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ho2b441HX5+lxEmo7KiN1mwkAIc/p3RYLNIWfdsirN12bq8sJHmsAuOt+8K/JtZdAlq3gqN8unEvuUtlAi57BC31UUOc99ueMp6DPKY5We7qxgV7EpETDP3/B4xckeD/faTgzbCwiB3tN8eHirypcSeqFA7fllHt8QZ24sqdK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=me6+H4cd; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779109670; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EJLJnuLqOMpH68dERtbj6mGH23tk8aFZAhB97rCiwEA=;
	b=me6+H4cdD+qGgp6CNGpt5U4F358alrLrvPmuriAXeJJQD5fSa08isxlXBXvrQSNiOaWOnb5DeR9/Hz0hw2DURxFdip/mTw92YJqWheq4e2RGJykuzw5yj/7obA+y/pZnL7AEQ/xgNavTvVQ2giyjrVYa8vm6UIYhABTnIDF5mo0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X399IwA_1779109668;
Received: from 30.120.66.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X399IwA_1779109668 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 21:07:49 +0800
Message-ID: <5a4afec4-fe39-419e-8b2b-4e9901eb93be@linux.alibaba.com>
Date: Mon, 18 May 2026 21:07:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "erofs: verify metadata accesses for file-backed mounts"
 has been added to the 6.18-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org, xiang@kernel.org
Cc: Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>
References: <20260518124317.897115-1-sashal@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260518124317.897115-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BB21856D886
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249280-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,vivo.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Action: no action

Hi,

On 2026/5/18 20:43, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      erofs: verify metadata accesses for file-backed mounts
> 
> to the 6.18-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       erofs-verify-metadata-accesses-for-file-backed-mount.patch
> and it can be found in the queue-6.18 subdirectory.
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
> commit f4178da1373dec03d01f1044acb0ff49a4c7f6a9
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
> index 8ca29962a3dde..58aea2b48580c 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -29,6 +29,20 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
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


