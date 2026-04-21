Return-Path: <stable+bounces-240061-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLXKDzUp52kf4wEAu9opvQ
	(envelope-from <stable+bounces-240061-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:37:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AA9437B1F
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4835300B8E1
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA4A37EFED;
	Tue, 21 Apr 2026 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNkqpQ+p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FABF260565;
	Tue, 21 Apr 2026 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756413; cv=none; b=tX32Nzb/bDiUlWRtqhrBMgf8qk5Nx8hZzDPfOymlGq7Y91mENC1sVQo4GPlx7mCb2LyqhQ+Ht4yAVs4VDKG9RE/qJpd/5StO9MIAtjuKEJ0Qfp3PMUw/OrfRzgkR1BtxxlHwVLOKTUEBEVRkx4HvGUgVI/rHiCYQZLrVCdkFEYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756413; c=relaxed/simple;
	bh=5zCagFjASgLa2FrIENVX5Yr4I78XpsHoo70zQSevNbc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mxK8QgYvq2BD4UyEAlElHK3AQxS6EebwwV9eJsr0xTFcZ6RlQRRiaVqnjB5ao1ec4YzwmEtZeflZ0pHbORI9/NleegZ1DX9Sv5VtFT7JCAq3Is146VfeqRL1pFwVlZPfcMWKcelhWHXj/60sVn9keCgWH8JUnmjvZTzwdYe7mvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNkqpQ+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7ABC2BCB0;
	Tue, 21 Apr 2026 07:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776756413;
	bh=5zCagFjASgLa2FrIENVX5Yr4I78XpsHoo70zQSevNbc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=XNkqpQ+pnZoqXioUQX0OuYCpQIO5IhgaGNanWqQ/+XNX+UJseMxcDWVSPoix7+cfw
	 qBiDghU2FgmGxCuWPtHP6Jjs9zoPzNgXzANdqmRnvTXfZtaeYMCSl2dRTP+23a9Wlj
	 AgRBHJF3YrMtb6rns/e4UF6L2SLDm/tuNjzxfqkERogUH5CAAfRqIlSRYwcMRJrEPn
	 ooTf8qRBehbnPCANef9PhdEtNQJdFnLE4rehe6POEyKX8gU7xtKfJ8E/w776WAy63r
	 TV0Kycd9afEV9xQFVP1qsZaJ3qfnjAK6jeO+7FSjdU4UZ9L2M9WfBLH196Qbjiz9LL
	 nxQgQmtBp7U8Q==
Message-ID: <b9d787ce-9020-4140-8d13-23a20809976d@kernel.org>
Date: Tue, 21 Apr 2026 15:26:50 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Yuhao Jiang <danisjiang@gmail.com>, Junrui Luo <moonafterrain@outlook.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] erofs: fix the out-of-bounds nameoff handling for
 trailing dirents
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20260416063511.3173774-1-hsiangkao@linux.alibaba.com>
 <20260416094408.3466613-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260416094408.3466613-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240061-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email,sashiko.dev:url,alibaba.com:email]
X-Rspamd-Queue-Id: 35AA9437B1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/2026 5:44 PM, Gao Xiang wrote:
> Currently we already have boundary-checks for nameoffs, but the trailing
> dirents are special since the namelens are calculated with strnlen()
> with unchecked nameoffs.
> 
> If a crafted EROFS has a trailing dirent with nameoff >= maxsize,
> maxsize - nameoff can underflow, causing strnlen() to read past the
> directory block.
> 
> nameoff0 should also be verified to be a multiple of
> `sizeof(struct erofs_dirent)` as well [1].
> 
> [1] https://sashiko.dev/#/patchset/20260416063511.3173774-1-hsiangkao%40linux.alibaba.com
> Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
> Fixes: 33bac912840f ("staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Closes: https://lore.kernel.org/r/A0FD7E0F-7558-49B0-8BC8-EB1ECDB2479A@outlook.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v3:
>   - Disallow unaligned nameoff0 to avoid petential oob reads as well.
> 
>   fs/erofs/dir.c | 29 ++++++++++++++++-------------
>   1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index e5132575b9d3..d074fded1577 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -19,20 +19,18 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>   		const char *de_name = (char *)dentry_blk + nameoff;
>   		unsigned int de_namelen;
>   
> -		/* the last dirent in the block? */
> -		if (de + 1 >= end)
> -			de_namelen = strnlen(de_name, maxsize - nameoff);
> -		else
> +		/* non-trailing dirent in the directory block? */
> +		if (de + 1 < end)
>   			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
> +		else if (maxsize <= nameoff)
> +			goto err_bogus;
> +		else
> +			de_namelen = strnlen(de_name, maxsize - nameoff);
>   
> -		/* a corrupted entry is found */
> -		if (nameoff + de_namelen > maxsize ||
> -		    de_namelen > EROFS_NAME_LEN) {
> -			erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
> -				  EROFS_I(dir)->nid);
> -			DBG_BUGON(1);
> -			return -EFSCORRUPTED;
> -		}
> +		/* a corrupted entry is found (including negative namelen) */
> +		if (!in_range32(de_namelen, 1, EROFS_NAME_LEN) ||
> +		    nameoff + de_namelen > maxsize)
> +			goto err_bogus;
>   
>   		if (!dir_emit(ctx, de_name, de_namelen,
>   			      erofs_nid_to_ino64(EROFS_SB(dir->i_sb),
> @@ -42,6 +40,10 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>   		ctx->pos += sizeof(struct erofs_dirent);
>   	}
>   	return 0;
> +err_bogus:
> +	erofs_err(dir->i_sb, "bogus dirent @ nid %llu", EROFS_I(dir)->nid);
> +	DBG_BUGON(1);
> +	return -EFSCORRUPTED;
>   }
>   
>   static int erofs_readdir(struct file *f, struct dir_context *ctx)
> @@ -88,7 +90,8 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   		}
>   
>   		nameoff = le16_to_cpu(de->nameoff);
> -		if (nameoff < sizeof(struct erofs_dirent) || nameoff >= bsz) {

You mean?

if (!nameoff || nameoff >= bsz || nameoff % sizeof(struct erofs_dirent))

Thanks,

> +		if (nameoff < sizeof(struct erofs_dirent) || nameoff >= bsz ||
> +		    (nameoff % sizeof(struct erofs_dirent))) {
>   			erofs_err(sb, "invalid de[0].nameoff %u @ nid %llu",
>   				  nameoff, EROFS_I(dir)->nid);
>   			err = -EFSCORRUPTED;


