Return-Path: <stable+bounces-232774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHrxEGgUzWmMZwYAu9opvQ
	(envelope-from <stable+bounces-232774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 14:49:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC5537ABA8
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 14:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E07B930B8486
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 12:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1976375AB2;
	Wed,  1 Apr 2026 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hT8bSuDr"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12894035AA;
	Wed,  1 Apr 2026 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047327; cv=none; b=Zs7sQ7SZPYtiYdRv+M3/gCvvjobmr0NeoEYXYDO2Gz1g1IbQ9KRs9A4EVRwamNpo+ZS859fHbDL1n94BqZLJIw5uUixq6hKgk+UPjzJehRymWdpXnsdViNbk6eY07cTv0aqr62qia+dfc6hoefQz5uKx4/6AUW0bavH76sEsHus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047327; c=relaxed/simple;
	bh=IUtHHW1twySLQ0R/EgJ0RDxUtOK2a05tO/UtVAaPPWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlA9cMeAAsqX5xDWFG+UZ71+OH6TKhD7sO8YegscdNb4JToQkSMOy45Bceds50sUb6W6VZUGS3Rv5fSHm/dAp+zCiLx6A7iZzrt/ptwtqTrv002fzZNq2HE68i6l5twAe9IKkucgBYur2heb6L7cs29KelTElcEbGHYQzWdPk50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hT8bSuDr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.37] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id E44ED20B6F01;
	Wed,  1 Apr 2026 05:42:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E44ED20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775047323;
	bh=4JfxsnbFOsoxlp/wX8KJqhEcE820wEAC7GiZUCG9Irw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hT8bSuDr1de26Qxm9ab+vPyUBSFKa1OLnTtT+wciyPScjYdoAYT+YFjWbe1Whvr8K
	 +qFPEEashYTTs0r/+9XDl/DWvfTj6wWiCRZj5B0ZrMgNyC+duhrKrWgq+7+ltdTDaI
	 yjY/ag6R2VfqlwgmPVKOlaJJeUkKzHgQd0ql4CFM=
Message-ID: <c2988216-cb2a-451f-b2a4-6eb5c8631a9f@linux.microsoft.com>
Date: Wed, 1 Apr 2026 18:11:59 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] EDAC/versalnet: Fix device_register() error handling
 in init_one_mc()
To: Borislav Petkov <bp@alien8.de>
Cc: shubhrajyoti.datta@amd.com, tony.luck@intel.com,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260322131107.1684647-1-ptsm@linux.microsoft.com>
 <20260322131145.1684744-1-ptsm@linux.microsoft.com>
 <20260322161052.GAacAUjFGWFwPle6c9@fat_crate.local>
 <84ae7198-b755-4dde-b97c-978958d27b4b@linux.microsoft.com>
 <20260324112312.GKacJ0IEL2iD7JZnSk@fat_crate.local>
 <20260324121656.GAacKAuPpPt9bjj15q@fat_crate.local>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <20260324121656.GAacKAuPpPt9bjj15q@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232774-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ptsm@linux.microsoft.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: BBC5537ABA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Boris,

On 24-03-2026 17:46, Borislav Petkov wrote:
> On Tue, Mar 24, 2026 at 12:23:12PM +0100, Borislav Petkov wrote:
>> So let's do it another way (totally untested ofc):
> 
> AI found a couple of issues, here's v2:
> 
> ---
> diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
> index b87fe57aa842..953f96c8fd6f 100644
> --- a/drivers/edac/versalnet_edac.c
> +++ b/drivers/edac/versalnet_edac.c
> @@ -772,12 +772,11 @@ static void remove_one_mc(struct mc_priv *priv, int i)
>   	edac_mc_free(mci);
>   }
>   
> -static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i)
> +static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, struct device *dev, int i)
>   {
>   	u32 num_chans, rank, dwidth, config;
>   	struct edac_mc_layer layers[2];
>   	struct mem_ctl_info *mci;
> -	struct device *dev;
>   	enum dev_type dt;
>   	char *name;
>   	int rc;
> @@ -802,7 +801,7 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
>   	}
>   
>   	if (dt == DEV_UNKNOWN)
> -		return 0;
> +		return -EINVAL;
>   
>   	/* Find the first enabled device and register that one. */
>   	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> @@ -817,14 +816,10 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
>   	if (!name)
>   		return rc;
>   
> -	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> -	if (!dev)
> -		goto err_name_free;
> -
>   	mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers, sizeof(struct mc_priv));
>   	if (!mci) {
>   		edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
> -		goto err_dev_free;
> +		goto err_name_free;
>   	}
>   
>   	sprintf(name, "versal-net-ddrmc5-edac-%d", i);
> @@ -856,8 +851,6 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
>   	device_unregister(mci->pdev);
>   err_mc_free:
>   	edac_mc_free(mci);
> -err_dev_free:
> -	kfree(dev);
>   err_name_free:
>   	kfree(name);
>   
> @@ -866,18 +859,26 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
>   
>   static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
>   {
> -	int rc, i;
> +	int rc = -ENOMEM, i;
>   
>   	for (i = 0; i < NUM_CONTROLLERS; i++) {
> -		rc = init_one_mc(priv, pdev, i);
> -		if (rc) {
> -			while (i--)
> -				remove_one_mc(priv, i);
> +		struct device *dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +		if (!dev)
> +			goto free;
>   
> -			return rc;
> +		rc = init_one_mc(priv, pdev, dev, i);
> +		if (rc) {
> +			kfree(dev);
> +			goto free;
>   		}
>   	}
>   	return 0;
> +
> +free:
> +	while (i--)
> +		remove_one_mc(priv, i);
> +
> +	return rc;
>   }
>   
>   static void remove_versalnet(struct mc_priv *priv)
> 
> 

Thanks for sharing this.

Without rearranging the code I have simplified the error path and sent v2.

Thanks,
Prasanna Kumar

