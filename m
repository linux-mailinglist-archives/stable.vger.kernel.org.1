Return-Path: <stable+bounces-238527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPXiM6nA4mml9wAAu9opvQ
	(envelope-from <stable+bounces-238527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 01:22:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D449C41F24A
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 01:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF0D93013190
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 23:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E1636BCED;
	Fri, 17 Apr 2026 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nANWeg8a"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0352749ED
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776468131; cv=none; b=a48DvEXCCvagOCc1py34hd/e4cLHJ0RWMPKT4mJEuvvc1NWDg5XzxBuYUH2wXF0MjWnFJhvWlHu0d4z5kxkUS81znHAfKBshHOiGk0JfloBZD73pQbqck8a5fJhtwDp3SwRsmFmrYNDLgKdT/QajOqGQ4/QXNKBkCCBGvLQU4co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776468131; c=relaxed/simple;
	bh=Hsc7iuHeJPybBTZwDnnuXYIlD+9wmrLJ9iyjFMp0zcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS4Mx/+8xhxVbeUZL6PCZ5TRPhJf7vcBH1oNiDDhbT20Wc+B5aPV+LwAChfCJZruS4UopEL8nSBGcABWykbf3dH5zxHhD6YtL8nEDQF1Urhr17KlAW5zxzAx8+PU0hwv66qUx0Of2hJcy5ph9Wy3F3QoY4tLm6Y6Zf6A4Jo6E9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nANWeg8a; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 17 Apr 2026 17:22:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776468127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GouYhYP+Vg/V5xduMEG9471OG89qh2jPe2ZlHrxDMlk=;
	b=nANWeg8aKPXdPm1qfRXMyp0DgIGtKY3GYnbFImYzHIrt57kxcPMDuYiqL/SzWA9EFsncST
	65HAwa0y9QjrZvoUk8rjJG6JJxQomuyNeQTym1A8OG6+bAz8mPbpcwvTBZYlwuTINPxhP7
	fawTbn45umMzEbQW5cdERESWqyaxc2c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: fix device reference leak in
 firmware_upload_register()
Message-ID: <mmcqvvqqq2yj65adm2prscpnxtbp5tljaxtbiqrwlfwpwd3slg@xniqactlghfc>
References: <20260415085109.3267323-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415085109.3267323-1-lgs201920130244@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238527-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D449C41F24A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 04:51:09PM +0800, Guangshuo Li wrote:
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
> ---
>  drivers/base/firmware_loader/sysfs_upload.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
> index f59a7856934c..6b701185dcb6 100644
> --- a/drivers/base/firmware_loader/sysfs_upload.c
> +++ b/drivers/base/firmware_loader/sysfs_upload.c
> @@ -366,7 +366,8 @@ firmware_upload_register(struct module *module, struct device *parent,
>  	return fw_upload;
>  
>  free_fw_sysfs:
> -	kfree(fw_sysfs);
> +	put_device(fw_dev);
> +	goto exit_module_put;

Thanks for the patch!

Given that the free_fw_sysfs target is used only once and no longer
falls through, I suggest we remove the free_fw_sysfs target
altogether.

Instead of:
        goto free_fw_sysfs;

Do:
        put_device(fw_dev);
        goto exit_module_put;

- Russ

>  
>  free_fw_upload_priv:
>  	kfree(fw_upload_priv);
> -- 
> 2.43.0
> 

