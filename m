Return-Path: <stable+bounces-235968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF2RNXmx3GldVQkAu9opvQ
	(envelope-from <stable+bounces-235968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:03:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E0E3E9826
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4570301EC6E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69253AE182;
	Mon, 13 Apr 2026 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsH8TLK/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783E3AB271;
	Mon, 13 Apr 2026 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071007; cv=none; b=l4ppa28NeCKGPmUGFXCHGcL5P5GRLXjhZ3Yy/rcdaA1HrT6BZfdyOxIxlXsaRx2LR5YHYjwruBnFV8UgTuC26sdpQiER5xdh9CbbvKqtjPrCTgyKYK6br7qGpddu8z+GkR+z3qz+h9RMW4zV0w69z7ZaskJqCe8eoJlFk6GLBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071007; c=relaxed/simple;
	bh=0sOX8GKgRbRUwdzVDoXTccQF5IzCxIxM+r1xkMMHTZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iu8U8eXZxjLGWhPPU3zcTC50ziomMgwD3SXbhUYzRoX6GmfjkYCW6wYf4ko7W2ishJ5++zj8k2yGZi1XQMkcv82GlgbMGu1d0ximRmkGHh9ZdQECt8TPm4pXopRuql/TJnkpdlmWVG9CcRteNO65tVQK2lw6EBvoQ1/uh1zSq74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsH8TLK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97609C116C6;
	Mon, 13 Apr 2026 09:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776071007;
	bh=0sOX8GKgRbRUwdzVDoXTccQF5IzCxIxM+r1xkMMHTZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsH8TLK/CS0f6wGP6Rzc0K7rbFX2d2dJbKZyEHh+Y9ytqG3NGUpPaSxDYNQ46Tp7N
	 vJTiet+KUIGUc+ojY4Qymk8YZ9R41HSBuYE8o1t5mEPOHHF98zKYQ6XlO/toMuQPDQ
	 SefRMoXaTxaO75NhY501/mew2QimrQy1qSd5uCFqY36aXPsH4NpUo6RmmtBtHf+847
	 c9Ec8N1FO+eACjVSfjuWPcTknt/t7C6a+fxOTjNYSJTVl3kuQzWL0sk551Q50bdmzo
	 E9KjQG9yg2ykd+/WwarONjc/lcx5UlbXfVUh+vCk6o962EMyKWPjhU6fW/YLQLGoH3
	 vyFXWVGAzOWCA==
Date: Mon, 13 Apr 2026 14:33:21 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Georgiy Osokin <g.osokin@auroraos.dev>
Cc: jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	s.shtylyov@auroraos.dev, stable@vger.kernel.org
Subject: Re: [PATCH] tee: shm: fix shm leak in register_shm_helper()
Message-ID: <adyxWXpcxJ3f0w6G@sumit-xelite>
References: <20260408155203.817744-1-g.osokin@auroraos.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408155203.817744-1-g.osokin@auroraos.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235968-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxtesting.org:email,auroraos.dev:email]
X-Rspamd-Queue-Id: 33E0E3E9826
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 06:52:03PM +0300, Georgiy Osokin wrote:
> register_shm_helper() allocates shm before calling
> iov_iter_npages(). If iov_iter_npages() returns 0, the function
> jumps to err_ctx_put and leaks shm.
> 
> This can be triggered by TEE_IOC_SHM_REGISTER with
> struct tee_ioctl_shm_register_data where length is 0.
> 
> Jump to err_free_shm instead.
> 
> Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer registration")
> Cc: stable@vger.kernel.org
> Cc: lvc-project@linuxtesting.org
> Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
> ---
>  drivers/tee/tee_shm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the fix, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index e9ea9f80cfd9..6742b3579c86 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -435,7 +435,7 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>  	num_pages = iov_iter_npages(iter, INT_MAX);
>  	if (!num_pages) {
>  		ret = ERR_PTR(-ENOMEM);
> -		goto err_ctx_put;
> +		goto err_free_shm;
>  	}
>  
>  	shm->pages = kzalloc_objs(*shm->pages, num_pages);
> -- 
> 2.50.1
> 

