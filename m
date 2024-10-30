Return-Path: <stable+bounces-89311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94629B5E99
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 10:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53EEBB212CD
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DC21E201C;
	Wed, 30 Oct 2024 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYYfgMv/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C647C1CCEC2
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730280019; cv=none; b=ZYQ1+8wcNnp/BZCsSBWhwZN6h9PmxEijCenIkYqfmve5DEpFh7hf3tU3NOB/t90GPvmU/eNIL95x1fK1ohJbHzWKpbAHcStY3ZImMnx2NL8HS9hqcG/g+pEFoIBvDkz5gqlw66mZ1/dRkA3AVNHrjSa2lchaSxi84WSVvTbp5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730280019; c=relaxed/simple;
	bh=tzwzfPL6sDcM7hK/ZuZGsoyr5EDSuOQtW/1SYTG9TWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvZU/7hQFylHq+gId1k45F1w5BUvhllcXfVvPvTwVX6p35NoPBPdz73U0mhvL8meRfgVO8+6izqqfJ03KlYYuMISlvOF9X8IQIIqz0CWHS1eVTVtoWppoj89eCus7AUb9HCbPnrF8pohJ8QUMezE8P5Lr78suO4dXwTiRwuFJuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYYfgMv/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730280017; x=1761816017;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tzwzfPL6sDcM7hK/ZuZGsoyr5EDSuOQtW/1SYTG9TWk=;
  b=iYYfgMv/aaMgd/2K45hAFxO7p0Hi+u6Z9yajT5TcjEF6HaLUwOFQTXmU
   xmh1oxdviYBVGZNWrdsi+utC8t/EXuyloDVbtESzco/t7RW2h8JsjCnKv
   1r9ERzoFnCFAZviuz74gDnJc9GHyCUJCDTrGxeEptt2fzox+rQLnbcLyt
   1OqSd0jEJnaKEeebp/RFLjbfSjZQe2HyhoV3iWRVfDyvhGn+E3Zly018g
   Y/zPP4P75cQHeTMZGekQdEnHl0FRegNyZ2jMSgGQ3h3sfHHtv22Dv8OhY
   7zOUTwavHk12htUy/eCZqAx9niop0NHYAEsQ/QNbYXv4SGWjOZQaO6gr9
   A==;
X-CSE-ConnectionGUID: Dd1lCEgdQzKrsNnOzFH6Sw==
X-CSE-MsgGUID: av0vQAAcQdeozEEIEn/dqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29927145"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29927145"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 02:20:17 -0700
X-CSE-ConnectionGUID: QG68GbR2SQWRujRd9rMGEg==
X-CSE-MsgGUID: +Ff7mRYeRC68xJWHw60y4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82356143"
Received: from jcarrol-mobl.ger.corp.intel.com (HELO [10.245.85.88]) ([10.245.85.88])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 02:20:14 -0700
Message-ID: <48b274ce-2c96-4827-8471-61575a107b1a@linux.intel.com>
Date: Wed, 30 Oct 2024 10:20:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Fix NOC firewall interrupt handling
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, quic_jhugo@quicinc.com,
 Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>, stable@vger.kernel.org
References: <20241017144958.79327-1-jacek.lawrynowicz@linux.intel.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20241017144958.79327-1-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Applied to drm-misc-fixes

On 10/17/2024 4:49 PM, Jacek Lawrynowicz wrote:
> From: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
> 
> The NOC firewall interrupt means that the HW prevented
> unauthorized access to a protected resource, so there
> is no need to trigger device reset in such case.
> 
> To facilitate security testing add firewall_irq_counter
> debugfs file that tracks firewall interrupts.
> 
> Fixes: 8a27ad81f7d3 ("accel/ivpu: Split IP and buttress code")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
> Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> ---
>  drivers/accel/ivpu/ivpu_debugfs.c | 9 +++++++++
>  drivers/accel/ivpu/ivpu_hw.c      | 1 +
>  drivers/accel/ivpu/ivpu_hw.h      | 1 +
>  drivers/accel/ivpu/ivpu_hw_ip.c   | 5 ++++-
>  4 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
> index 8958145c49adb..8180b95ed69dc 100644
> --- a/drivers/accel/ivpu/ivpu_debugfs.c
> +++ b/drivers/accel/ivpu/ivpu_debugfs.c
> @@ -116,6 +116,14 @@ static int reset_pending_show(struct seq_file *s, void *v)
>  	return 0;
>  }
>  
> +static int firewall_irq_counter_show(struct seq_file *s, void *v)
> +{
> +	struct ivpu_device *vdev = seq_to_ivpu(s);
> +
> +	seq_printf(s, "%d\n", atomic_read(&vdev->hw->firewall_irq_counter));
> +	return 0;
> +}
> +
>  static const struct drm_debugfs_info vdev_debugfs_list[] = {
>  	{"bo_list", bo_list_show, 0},
>  	{"fw_name", fw_name_show, 0},
> @@ -125,6 +133,7 @@ static const struct drm_debugfs_info vdev_debugfs_list[] = {
>  	{"last_bootmode", last_bootmode_show, 0},
>  	{"reset_counter", reset_counter_show, 0},
>  	{"reset_pending", reset_pending_show, 0},
> +	{"firewall_irq_counter", firewall_irq_counter_show, 0},
>  };
>  
>  static int dvfs_mode_get(void *data, u64 *dvfs_mode)
> diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
> index 09ada8b500b99..4e1054f3466e8 100644
> --- a/drivers/accel/ivpu/ivpu_hw.c
> +++ b/drivers/accel/ivpu/ivpu_hw.c
> @@ -252,6 +252,7 @@ int ivpu_hw_init(struct ivpu_device *vdev)
>  	platform_init(vdev);
>  	wa_init(vdev);
>  	timeouts_init(vdev);
> +	atomic_set(&vdev->hw->firewall_irq_counter, 0);
>  
>  	return 0;
>  }
> diff --git a/drivers/accel/ivpu/ivpu_hw.h b/drivers/accel/ivpu/ivpu_hw.h
> index dc5518248c405..fc4dbfc980c81 100644
> --- a/drivers/accel/ivpu/ivpu_hw.h
> +++ b/drivers/accel/ivpu/ivpu_hw.h
> @@ -51,6 +51,7 @@ struct ivpu_hw_info {
>  	int dma_bits;
>  	ktime_t d0i3_entry_host_ts;
>  	u64 d0i3_entry_vpu_ts;
> +	atomic_t firewall_irq_counter;
>  };
>  
>  int ivpu_hw_init(struct ivpu_device *vdev);
> diff --git a/drivers/accel/ivpu/ivpu_hw_ip.c b/drivers/accel/ivpu/ivpu_hw_ip.c
> index b9b16f4041434..029dd065614b2 100644
> --- a/drivers/accel/ivpu/ivpu_hw_ip.c
> +++ b/drivers/accel/ivpu/ivpu_hw_ip.c
> @@ -1073,7 +1073,10 @@ static void irq_wdt_mss_handler(struct ivpu_device *vdev)
>  
>  static void irq_noc_firewall_handler(struct ivpu_device *vdev)
>  {
> -	ivpu_pm_trigger_recovery(vdev, "NOC Firewall IRQ");
> +	atomic_inc(&vdev->hw->firewall_irq_counter);
> +
> +	ivpu_dbg(vdev, IRQ, "NOC Firewall interrupt detected, counter %d\n",
> +		 atomic_read(&vdev->hw->firewall_irq_counter));
>  }
>  
>  /* Handler for IRQs from NPU core */


