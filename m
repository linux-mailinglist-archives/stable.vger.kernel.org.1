Return-Path: <stable+bounces-227842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOuIIPsUwGnMDQQAu9opvQ
	(envelope-from <stable+bounces-227842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 17:12:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C262E9F34
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 17:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AB7E30125CA
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B992834F46B;
	Sun, 22 Mar 2026 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="c3ieBGPF"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE891A9F87;
	Sun, 22 Mar 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774195874; cv=none; b=WnhIVpEXS7FdjNkat1I1bqVhT/v6LrBBrpyoVbY2LJjDwa37+bRFppeYIArRHT+aBzGuCFMOA9l0xtvvmWbFmLwDf+qBv8m3Ss4N/ofDIpX2zvIe6s9QaMi12FjSI69pJM6A8QRHOt2hs7YE9S48Nk/4ch9jlHoYWoUD8CKeEHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774195874; c=relaxed/simple;
	bh=pEnm7T+9XrzCAJnSB3IFyiSsHclQ7anAvWrdr6zmGgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgNuO7WmxQcpIL3B8flZ+ECtLhZ8yMQ+E4N/lA9j5seA463D5ILwr8oblcg1kCBFNEGttBXCyu3vfrj1JedN0wHM35uSbFFbqjrtRje8WESxRkeGzK2U1TppvJLHSotKgvo20bPbdtltkm0Rj6qa1shDRZSgSdcztVJOLhoM1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=c3ieBGPF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D1E7540E0194;
	Sun, 22 Mar 2026 16:11:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BTvp3JLCsNEk; Sun, 22 Mar 2026 16:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774195865; bh=89DNFtB08FN4cMZDHyVOZAMPq04Jf8ESETI4+f3Y2m8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3ieBGPFThoisWiR1EWgXqk0a9aawtR4O3hykTKV5h/m79sYnJurpNNZkeT08gOVI
	 JAECawBh9HNHPmd3z9FjCt7G7Keb5SGLEkkZPFl3irtLk7QQ7mUCaZ/PBVd3Isiorh
	 vcuyqrOURIvGf+uPm9blZVpBn+VmhCAf85Q4ZvjKzFtriFf9enPQL3NrHdYyZbYRlX
	 zVD4VfWR8k605f1e91EVi/YuKDiabPNe/MJdN6/LsHkKEhi+oDhkXi1yNfzaTLDrQv
	 f0uP/GEXnuZeLJM/49mDh6uCmi5ZBYu3P59fg7lqn98Qqv/nNNxv5JnNyg9O2rkAz7
	 PotJs4jL0urC9J6/xTGMjOnZwT2bO51d800mOJXgNvEhcePT2seAkE0JjGR63PP0bi
	 rDqyFLm6g9MVnauJ5HfYNVFfFGWdRzy8iIz5bJ9T0NvBRM5W3kO1j8V+w50b4hk1Dz
	 CchSsvfJ7MAIuiHM4DJbFKe4Kg4+yqY8QCJPH1VK20XBr3AWPlcJjOsFWiKrBV6bRQ
	 T0Olq61I/TAfkU8gNI/TapRSXF2F0ISEYhooB7jVA4ZaFnkEpObSOQeBg4iSX4iang
	 6pkjHDivkKC4TT4bw+ow/bHTxVyIu8MbkjVG8PPlpTat8RsVudJeCDSGx7DHKGMKDA
	 7ueBb6ZO9SSTP5naugYAqQOk=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6301E40E0031;
	Sun, 22 Mar 2026 16:10:59 +0000 (UTC)
Date: Sun, 22 Mar 2026 17:10:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Cc: shubhrajyoti.datta@amd.com, tony.luck@intel.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] EDAC/versalnet: Fix device_register() error handling
 in init_one_mc()
Message-ID: <20260322161052.GAacAUjFGWFwPle6c9@fat_crate.local>
References: <20260322131107.1684647-1-ptsm@linux.microsoft.com>
 <20260322131145.1684744-1-ptsm@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260322131145.1684744-1-ptsm@linux.microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227842-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: D3C262E9F34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 06:11:45AM -0700, Prasanna Kumar T S M wrote:
> When device_register() fails, it must be followed by put_device()
> rather than kfree(), because device_register() calls
> device_initialize() which sets up the device refcount. The matching
> release function versal_edac_release() handles the actual kfree().
> 
> Also reorder the dev allocation to after edac_mc_alloc() so the error
> path no longer needs a separate err_dev_free label.

Nope.

edac_mc_alloc() is a lot more heavy-weight than a simple k*alloc(). Pls keep
the ordering as it is.

> Fixes: d5fe2fec6c40d ("EDAC: Add a driver for the AMD Versal NET DDR controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
> ---
>  drivers/edac/versalnet_edac.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
> index acd51b492772..6463e88ed3d3 100644
> --- a/drivers/edac/versalnet_edac.c
> +++ b/drivers/edac/versalnet_edac.c
> @@ -817,24 +817,26 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
>  	if (!name)
>  		return rc;
>  
> -	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> -	if (!dev)
> -		goto err_name_free;
> -
>  	mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers, sizeof(struct mc_priv));
>  	if (!mci) {
>  		edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
> -		goto err_dev_free;
> +		goto err_name_free;
>  	}
>  
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		goto err_mc_free;
> +
>  	sprintf(name, "versal-net-ddrmc5-edac-%d", i);
>  
>  	dev->init_name = name;
>  	dev->release = versal_edac_release;
>  
>  	rc = device_register(dev);
> -	if (rc)
> +	if (rc) {
> +		put_device(dev);

Why here and not at the error label below?

>  		goto err_mc_free;
> +	}
>  
>  	mci->pdev = dev;
>  	mc_init(mci, dev);
> @@ -856,8 +858,6 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
>  	device_unregister(mci->pdev);
>  err_mc_free:
>  	edac_mc_free(mci);
> -err_dev_free:
> -	kfree(dev);
>  err_name_free:
>  	kfree(name);
>  
> -- 
> 2.49.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

