Return-Path: <stable+bounces-227617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBqPI/KvvWnIAQMAu9opvQ
	(envelope-from <stable+bounces-227617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:37:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D64422E0E80
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 433A03034641
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E8C34F486;
	Fri, 20 Mar 2026 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cTBQJ4Od"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F1E34A765
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038867; cv=none; b=sGSqcf5uM6JTt8JgzRmpqPXbvMigLu10dKjxY5RyXNIywxaaJjqg0M9OMLAroN0Bh900qLK6gR+921BJTP0nvEVQyM7w6FygByfvt+yoo9NvXtJ4x2SaLTisAoldtCzRC0dCE9D9FxgrMMzSFCfmua/nGHuBa2qTSD0xJR7AwkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038867; c=relaxed/simple;
	bh=98KaJw/oCwyC5Xn141upYr/+Qxkwh7BSfQzrwNjtpgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFvR4rBYx3vyt6PlwCRWZiuquvJb1ZFUxWD0hYPS+RigJGEYDgErpRjRAHAenvUVvColND9CGco41vnLcLO8MlbX6rsKtpzH0kRkXn6N5Sh5IWGH8MM01RQtVNW3h2wo6Yrv7yU9legeaWqJq4hhpbnvPdxp01TKPqIwjWyCltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cTBQJ4Od; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d0e34348-0ed5-438c-85da-5429537076a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774038863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/WoR8K7XGmDVEtoi9ivwH2sJTHd+vd68YWIhfqzP1KY=;
	b=cTBQJ4Od+uooOgg8vdoYAevQC/04ylnzYBzYel716jciHEzINF8HKFOMxG5frxtHrljbOb
	0IvVS1lVOVMqLRZL49GhPx70xwioBUrdSz4dOoW3xXpjH453ALWBEOG+3MZroLFUt9mq/D
	UGwYQmhNpzJ4R6Fz7IlajyjNiRg24OE=
Date: Fri, 20 Mar 2026 13:34:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] ASoC: SOF: Intel: hda: Fix NULL pointer dereference on
 SoundWire IRQ during removal
To: gaggery.tsai@intel.com, linux-drivers-review-request@eclists.intel.com
Cc: yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
 stable@vger.kernel.org
References: <20260312150005.2069660-1-gaggery.tsai@intel.com>
 <20260312150837.2076641-1-gaggery.tsai@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20260312150837.2076641-1-gaggery.tsai@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227617-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre-louis.bossart@linux.dev,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: D64422E0E80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 08:08, gaggery.tsai@intel.com wrote:
> From: Gaggery Tsai <gaggery.tsai@intel.com>
> 
> hda_sdw_exit() sets hdev->sdw to NULL after calling sdw_intel_exit(),
> but the shared IPC IRQ handler is not freed until much later in
> hda_dsp_remove(). If a SoundWire interrupt fires in this window, the
> IRQ thread calls hda_dsp_sdw_thread() -> sdw_intel_thread() with a
> NULL context pointer or with link->cdns already freed, causing a NULL
> pointer dereference:
> 
>   BUG: kernel NULL pointer dereference, address: 00000000000003d0
>   RIP: 0010:sdw_cdns_irq+0x9/0x2b0 [soundwire_cadence]
>   Call Trace:
>    sdw_intel_thread+0x2d/0x50 [soundwire_intel]
>    hda_dsp_interrupt_thread+0x99/0x3a0 [snd_sof_intel_hda_generic]
>    irq_thread_fn+0x25/0x60
> 
> The race window is between hda_sdw_exit() tearing down SoundWire
> links and free_irq() in hda_dsp_remove(). During sdw_intel_exit() ->
> sdw_intel_cleanup(), each link's auxiliary device is unregistered,
> which clears link->cdns. Meanwhile the IRQ thread can still fire and
> iterate the link list, calling sdw_cdns_irq() with a NULL cdns.
> 
> Fix this in three ways:
> 
>   1. In hda_sdw_exit(), disable SoundWire interrupts at the hardware
>      level (hda_sdw_int_enable) and call synchronize_irq() BEFORE
>      tearing down the SoundWire context, preventing new IRQ threads
>      from entering the SoundWire path.
> 
>   2. Add a NULL guard for link->cdns in sdw_intel_thread() to handle
>      the case where the IRQ thread races with individual link
>      removal during sdw_intel_cleanup().
> 
>   3. Add a NULL guard in hda_dsp_sdw_thread() as defense-in-depth
>      for the case where hdev->sdw is already NULL.
> 
> Tested on Intel Panther Lake with SoundWire codecs by manually
> unbinding the SOF PCI device while audio was active.
> 
> Fixes: 722ba5f1f530 ("ASoC: SOF: Intel: hda: merge IPC, stream and SoundWire interrupt handlers")
> Cc: stable@vger.kernel.org
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Signed-off-by: Gaggery Tsai <gaggery.tsai@intel.com>
> ---
>  drivers/soundwire/intel_init.c |  6 ++++--
>  sound/soc/sof/intel/hda.c      | 11 +++++++++--
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
> index ad48d67fa935..e093a29f1590 100644
> --- a/drivers/soundwire/intel_init.c
> +++ b/drivers/soundwire/intel_init.c
> @@ -145,8 +145,10 @@ irqreturn_t sdw_intel_thread(int irq, void *dev_id)
>  	struct sdw_intel_ctx *ctx = dev_id;
>  	struct sdw_intel_link_res *link;
>  
> -	list_for_each_entry(link, &ctx->link_list, list)
> -		sdw_cdns_irq(irq, link->cdns);
> +	list_for_each_entry(link, &ctx->link_list, list) {
> +		if (link->cdns)
> +			sdw_cdns_irq(irq, link->cdns);

is this really a fix? Couldn't you have a case where the branch is taken, but the context is freed by the exit below?
You'd have a case of use-after-free, which is just as problematic as accessing a NULL pointer...

The synchronize_irq() only guarantees no new IRQ will be generated, but it doesn't control if a thread can execute and when the context is used.

It almost feels like you need some sort of lock to prevent this list from being accessed.

Bard, can you review this as well?

> +	}
>  
>  	return IRQ_HANDLED;
>  }
> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
> index c0cc7d3ce526..02a0e354414e 100644
> --- a/sound/soc/sof/intel/hda.c
> +++ b/sound/soc/sof/intel/hda.c
> @@ -256,12 +256,17 @@ static int hda_sdw_exit(struct snd_sof_dev *sdev)
>  
>  	hdev = sdev->pdata->hw_pdata;
>  
> +	/* Disable SoundWire IRQ at the hardware level first to prevent
> +	 * the IRQ handler from accessing hdev->sdw after it is freed.
> +	 * synchronize_irq() ensures any in-flight handler has completed.
> +	 */
> +	hda_sdw_int_enable(sdev, false);
> +	synchronize_irq(sdev->ipc_irq);

In addition to my concern above, this feels like a layering violation. The IRQ is used for SoundWire,
but also IPC and DSP interrupts. You'd want to do this in hda_dsp_remove(), no?

This may require hda_sdw_exit() to be broken in two, with a _disable() followed by _remove() helper.

> +
>  	if (hdev->sdw)
>  		sdw_intel_exit(hdev->sdw);
>  	hdev->sdw = NULL;
>  
> -	hda_sdw_int_enable(sdev, false);
> -
>  	return 0;
>  }
>  
> @@ -309,6 +314,8 @@ static bool hda_dsp_check_sdw_irq(struct snd_sof_dev *sdev)
>  
>  static irqreturn_t hda_dsp_sdw_thread(int irq, void *context)
>  {
> +	if (!context)
> +		return IRQ_HANDLED;

If the issues are solved, is this really needed?

>  	return sdw_intel_thread(irq, context);
>  }
>  


