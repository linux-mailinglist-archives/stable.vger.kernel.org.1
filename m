Return-Path: <stable+bounces-151563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D65ACF8CD
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 22:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18B13A8017
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 20:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7123127C875;
	Thu,  5 Jun 2025 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="t2u0+gy4"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FAB278E5A
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749155464; cv=none; b=lG330WhqrwdQMLK5RL8eAUsjbUxbO08yqZI5fh12xicl3Sz9qsTnHGeu+RoE8/KfJAWsarTU25apqPAAZKMDw6VTjw3waMy5UfHxANEoqH1WLISfraKFYyvafC88UTEbivM/C7l8k5JNrPqcIEN3KDYJ+OVmh+ghXFSWGLezI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749155464; c=relaxed/simple;
	bh=gmlp2jwO30hBqhp/YJOURodm64jKP/qFtrzv2wdnmiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9yRFWhjrQCB/m4gW47ni1nKA4YWJs6bUGLFTbtwFLA6JACEX9KUvdYib/26Aw3fUZQSBqMwhT/lPnWQD+jt3n0BIjFglKG56Gtq0wzcXKyonFXix3xDYMbelxVw46vE1dIUTmrwjM9YALAenXp2S+28sXOH5HLpTiJ7luvXQEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=t2u0+gy4; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bCx0w75fNz9tCl;
	Thu,  5 Jun 2025 22:30:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1749155457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pqZ663Cp9gzndHJjTiWWCOUPFc901sb/+7c37wwcIXE=;
	b=t2u0+gy4JG5d0W54nnpWwF8JuiS0daocYRAz2FS8pJ20+YebcrSZAoHisR9G7K1HoltrZR
	fYVjp3t7CLd47YIEtfBi0PGcxqLQC6w8xchHUyiprU5Tzh4dRzQ/gt3/mUS8Yad1J2pBe4
	XoS6NKxnWOob6rITShJ6pIaYKV/Fo/mbArAgR0DHIn2fFey07SZvVxjhYOenijN1xzSi0I
	yLes3fFWbuCnZiWI2N2c9NOq787Juj3t33GkjsuypWStOEZdhe+0f8pVGQT0zDGenqdCny
	obOHKWD2MCItedA8FyzBs+tzD6B8+0uTzghnuOaJ7ZJQgJk6fmsBR49+ToL6NA==
Date: Fri, 6 Jun 2025 02:00:52 +0530
From: Brahmajit Das <listout@listout.xyz>
To: stable@kernel.org
Cc: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
	gregkh@linuxfoundation.org, mpatocka@redhat.com, stable@vger.kernel.org, 
	patches@lists.linux.dev
Subject: Re: [PATCH 1/1] dm-verity: fix a memory leak if some arguments are
 specified multiple times
Message-ID: <65ci7zvx3kr5qfq2ioadzzd4ghrtrtrc3pxefosexxpbup63kb@4jkc6e6usols>
References: <20250605201116.24492-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250605201116.24492-1-listout@listout.xyz>
X-Rspamd-Queue-Id: 4bCx0w75fNz9tCl

Greg, Shuah, Mikulas,
This is my first attempt at backporting an upstream patch (Part of Linux
kernel Bug Fixing Summer 2025). Please feel free to correct me, I'm open
to feedback.
I see I've added two From section, if that requires me to
resend a v2 of the patch, please let me know.

On 06.06.2025 01:41, Brahmajit Das wrote:
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> [ Upstream commit 66be40a14e496689e1f0add50118408e22c96169 ]
> 
> If some of the arguments "check_at_most_once", "ignore_zero_blocks",
> "use_fec_from_device", "root_hash_sig_key_desc" were specified more than
> once on the target line, a memory leak would happen.
> 
> This commit fixes the memory leak. It also fixes error handling in
> verity_verify_sig_parse_opt_args.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>  drivers/md/dm-verity-fec.c        |  4 ++++
>  drivers/md/dm-verity-target.c     |  8 +++++++-
>  drivers/md/dm-verity-verify-sig.c | 17 +++++++++++++----
>  3 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
> index 0c41949db784..631a887b487c 100644
> --- a/drivers/md/dm-verity-fec.c
> +++ b/drivers/md/dm-verity-fec.c
> @@ -593,6 +593,10 @@ int verity_fec_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
>  	(*argc)--;
>  
>  	if (!strcasecmp(arg_name, DM_VERITY_OPT_FEC_DEV)) {
> +		if (v->fec->dev) {
> +			ti->error = "FEC device already specified";
> +			return -EINVAL;
> +		}
>  		r = dm_get_device(ti, arg_value, BLK_OPEN_READ, &v->fec->dev);
>  		if (r) {
>  			ti->error = "FEC device lookup failed";
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 3c427f18a04b..ed49bcbd224f 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -1120,6 +1120,9 @@ static int verity_alloc_most_once(struct dm_verity *v)
>  {
>  	struct dm_target *ti = v->ti;
>  
> +	if (v->validated_blocks)
> +		return 0;
> +
>  	/* the bitset can only handle INT_MAX blocks */
>  	if (v->data_blocks > INT_MAX) {
>  		ti->error = "device too large to use check_at_most_once";
> @@ -1143,6 +1146,9 @@ static int verity_alloc_zero_digest(struct dm_verity *v)
>  	struct dm_verity_io *io;
>  	u8 *zero_data;
>  
> +	if (v->zero_digest)
> +		return 0;
> +
>  	v->zero_digest = kmalloc(v->digest_size, GFP_KERNEL);
>  
>  	if (!v->zero_digest)
> @@ -1577,7 +1583,7 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  			goto bad;
>  	}
>  
> -	/* Root hash signature is  a optional parameter*/
> +	/* Root hash signature is an optional parameter */
>  	r = verity_verify_root_hash(root_hash_digest_to_validate,
>  				    strlen(root_hash_digest_to_validate),
>  				    verify_args.sig,
> diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
> index a9e2c6c0a33c..d5261a0e4232 100644
> --- a/drivers/md/dm-verity-verify-sig.c
> +++ b/drivers/md/dm-verity-verify-sig.c
> @@ -71,9 +71,14 @@ int verity_verify_sig_parse_opt_args(struct dm_arg_set *as,
>  				     const char *arg_name)
>  {
>  	struct dm_target *ti = v->ti;
> -	int ret = 0;
> +	int ret;
>  	const char *sig_key = NULL;
>  
> +	if (v->signature_key_desc) {
> +		ti->error = DM_VERITY_VERIFY_ERR("root_hash_sig_key_desc already specified");
> +		return -EINVAL;
> +	}
> +
>  	if (!*argc) {
>  		ti->error = DM_VERITY_VERIFY_ERR("Signature key not specified");
>  		return -EINVAL;
> @@ -83,14 +88,18 @@ int verity_verify_sig_parse_opt_args(struct dm_arg_set *as,
>  	(*argc)--;
>  
>  	ret = verity_verify_get_sig_from_key(sig_key, sig_opts);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		ti->error = DM_VERITY_VERIFY_ERR("Invalid key specified");
> +		return ret;
> +	}
>  
>  	v->signature_key_desc = kstrdup(sig_key, GFP_KERNEL);
> -	if (!v->signature_key_desc)
> +	if (!v->signature_key_desc) {
> +		ti->error = DM_VERITY_VERIFY_ERR("Could not allocate memory for signature key");
>  		return -ENOMEM;
> +	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.49.0
> 
> 

-- 
Regards,
listout

