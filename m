Return-Path: <stable+bounces-243853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLVDGsy4+Gn1zAIAu9opvQ
	(envelope-from <stable+bounces-243853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:18:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAB94C08E6
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AE153009B24
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF5B3DD519;
	Mon,  4 May 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HhnBy3Pv"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E239B963
	for <stable@vger.kernel.org>; Mon,  4 May 2026 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907808; cv=none; b=OFSvPPZu3abn7t4eWFTZIe5Id0nqzUz2pUgsBfCqBLkM3FCEiqVvNkYn1lQnA/5q4E/Qwh/FtlKs3u2sFWa2E3F8mi7sbVXcwxXW9uSuYTsgDdMvc3S0PzFxRu5XhiCCer8ZuGr3/pYI6vs9Gd2Oyp0CQOt3SPc/SsmWwOdTPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907808; c=relaxed/simple;
	bh=i/4hYMFf//svTflcq9f9gKFs+2rGtotqjH1ofCdpbP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFMibnQ9z1rkwBQpIMdfD2NHj6H0q3NI4NlATaKAJ3Oq+71wbe1icSUFh2hbA2VAcAstq6M7OCc9bvAXB5M20OnygSKrMZsQlKaTpcvxxvutBS/6xD+QCk8iqh7o44m3X3pk0qT1lnLpg9e2g6RLtDDkpG2E1DE02SuxDPkwp80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HhnBy3Pv; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 4 May 2026 09:16:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777907795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bfwD5Irdem1njLTO4qcSxhBNtYSz/64bwE1nCVFo0kM=;
	b=HhnBy3Pvznh/jfbaqwnrS3Sr1LgnK9907GuwDqCeA7BJiUuV/C0L53j3p0tPlo2ceNmbOF
	kxH+qVW8EopVYJkr5PxfSFnV3aRpW2P9sW+dFuliPm9WaXEAoX1UsueOSw55Y5a72fTn4c
	UGUggb9SGS78EM+UNMJVtFXt8DL+BY4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] firmware_loader: fix device reference leak in
 firmware_upload_register()
Message-ID: <lmyvhhsg5f6cwkjuyt3ugvch2beahrau43sz66bkrzyuwpbqtn@ts3oawaepou3>
References: <20260418070220.64542-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418070220.64542-1-lgs201920130244@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: AAAB94C08E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-243853-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[russ.weight@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, Apr 18, 2026 at 03:02:20PM +0800, Guangshuo Li wrote:
> firmware_upload_register()
>   -> fw_create_instance()
>      -> device_initialize()
> 
> After fw_create_instance() succeeds, the lifetime of the embedded struct
> device is expected to be managed through the device core reference
> counting, since fw_create_instance() has already called
> device_initialize().
> 
> In firmware_upload_register(), if alloc_lookup_fw_priv() fails after
> fw_create_instance() succeeds, the code reaches free_fw_sysfs and frees
> fw_sysfs directly instead of releasing the device reference with
> put_device(). This may leave the reference count of the embedded struct
> device unbalanced, resulting in a refcount leak.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review. Fix this by using put_device(fw_dev) in the
> failure path and letting fw_dev_release() handle the final cleanup,
> instead of freeing the instance directly from the error path.
> 
> Fixes: 97730bbb242c ("firmware_loader: Add firmware-upload support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Russ Weight <russ.weight@linux.dev>

> ---
>  drivers/base/firmware_loader/sysfs_upload.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
> index f59a7856934c..a6dab34b22d8 100644
> --- a/drivers/base/firmware_loader/sysfs_upload.c
> +++ b/drivers/base/firmware_loader/sysfs_upload.c
> @@ -351,7 +351,8 @@ firmware_upload_register(struct module *module, struct device *parent,
>  	if (ret != 0) {
>  		if (ret > 0)
>  			ret = -EINVAL;
> -		goto free_fw_sysfs;
> +		put_device(fw_dev);
> +		goto exit_module_put;
>  	}
>  	fw_priv->is_paged_buf = true;
>  	fw_sysfs->fw_priv = fw_priv;
> @@ -365,9 +366,6 @@ firmware_upload_register(struct module *module, struct device *parent,
>  
>  	return fw_upload;
>  
> -free_fw_sysfs:
> -	kfree(fw_sysfs);
> -
>  free_fw_upload_priv:
>  	kfree(fw_upload_priv);
>  
> -- 
> 2.43.0
> 

