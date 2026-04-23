Return-Path: <stable+bounces-240410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFBRCbSm6WmzgQIAu9opvQ
	(envelope-from <stable+bounces-240410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 06:57:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 745B844D1CB
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 06:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74082302E414
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 04:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22567244687;
	Thu, 23 Apr 2026 04:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QKvPMJHY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D63611E
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776920145; cv=none; b=O93QsqK71CxU4Xktf7xib6esWfG0YlZmNnoCBmzDCNlY5ANU8+4yJue7ZzJXaRUHzJq8x5Rsy/lJqOJYNGDeRSyka47bhGdG/0asu5CANYSiGolw7XkBcS+9acz4YlSs8eWdOSDJ/sqoB0Weo9OM2afvgIVw7ysX4+Dx9u9qhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776920145; c=relaxed/simple;
	bh=RUY7zs3U2LknWW0qy/Zh3yBZlxSTz3al1m/dNRBHwEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsNR0Mib6jKeFHJFB3qUUmXljKwcDoU9kZeeuVT+pMhwUGAtwuCeHxEjiR8Owqz7DHuTeAc4rwyo4VgX2robWSOzBJ0ADd+h75grPfCURJF+uKjP7f0jJcMDpFN++jmUe3u11NRthUaHzLRdENGcd3nqMNiXTQNmzBBCEffj4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QKvPMJHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2040CC2BCB2;
	Thu, 23 Apr 2026 04:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776920145;
	bh=RUY7zs3U2LknWW0qy/Zh3yBZlxSTz3al1m/dNRBHwEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKvPMJHYNzLAhd3Xly9dbWX/cZsYXJg3TmdNkibLwV0o6JGvw6LiGOKzJmDOJHYPE
	 ZSP/UZshJI/xhj4vCmZA1takA1DE8HVuIaOG0p5aDbOXTMpyJEnvlYgrXA65Tegqi3
	 v4xQ3JG/7cBs4vw5Nb8+44JNOy+K/eRju2J8SMRg=
Date: Thu, 23 Apr 2026 06:55:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: colyli@fnnas.com
Cc: stable@vger.kernel.org, Mingzhe Zou <mingzhe.zou@easystack.cn>,
	stable@vger.kerenl.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] bcache: fix uninitialized closure object
Message-ID: <2026042335-frantic-parakeet-f251@gregkh>
References: <20260422152113.70337-1-colyli@fnnas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422152113.70337-1-colyli@fnnas.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240410-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,easystack.cn:email,linuxfoundation.org:dkim,kerenl.org:email,msgid.link:url,fnnas.com:email]
X-Rspamd-Queue-Id: 745B844D1CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 11:21:13PM +0800, colyli@fnnas.com wrote:
> From: Mingzhe Zou <mingzhe.zou@easystack.cn>
> 
> In the previous patch ("bcache: fix cached_dev.sb_bio use-after-free and
> crash"), we adopted a simple modification suggestion from AI to fix the
> use-after-free.
> 
> But in actual testing, we found an extreme case where the device is
> stopped before calling bch_write_bdev_super().
> 
> At this point, struct closure sb_write has not been initialized yet.
> For this patch, we ensure that sb_bio has been completed via
> sb_write_mutex.
> 
> Signed-off-by: Mingzhe Zou <mingzhe.zou@easystack.cn>
> Signed-off-by: Coly Li <colyli@fnnas.com>
> Link: https://patch.msgid.link/20260403042135.2221247-1-colyli@fnnas.com
> Fixes: fec114a98b87 ("bcache: fix cached_dev.sb_bio use-after-free and crash")
> Cc: stable@vger.kerenl.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/md/bcache/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 6627a381f65a..97d9adb0bf96 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1376,11 +1376,12 @@ static CLOSURE_CALLBACK(cached_dev_free)
>  	/*
>  	 * Wait for any pending sb_write to complete before free.
>  	 * The sb_bio is embedded in struct cached_dev, so we must
>  	 * ensure no I/O is in progress.
>  	 */
> -	closure_sync(&dc->sb_write);
> +	down(&dc->sb_write_mutex);
> +	up(&dc->sb_write_mutex);
>  
>  	if (dc->sb_disk)
>  		folio_put(virt_to_folio(dc->sb_disk));
>  
>  	if (dc->bdev_file)
> -- 
> 2.47.3
> 
> 
<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

