Return-Path: <stable+bounces-47641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3F98D3739
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 15:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6518928A51F
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 13:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F707E542;
	Wed, 29 May 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUr5Y1bL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3AFDDAB;
	Wed, 29 May 2024 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988331; cv=none; b=PHRmps5pzgxVyujA75/zknZUEbz/Yb0ReTURk2RdzfbdgaIgbaI013NCG1vkugki157bEcUdZ8UKDFGO/FFItJD2IM1xs0IcYa87GaVTlF6BFIbLQrdZx742ezo+vmJoZqpfD52S0b2NMbI5PPfdn+yFBz/lT+cBFhf9qBqDaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988331; c=relaxed/simple;
	bh=LihBiyEtP+byKlYeJMhmFzcL1/UxANEmf6BaRF8uarE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFJgHLRXgvKiuVOdTV6y+hSaKqrax33W+vwm7RZ0it+sO6K14eqHISocOOZoP7CZ4xIuXIbjir/9tKLCwLJfMh043tlWAQ/QagmqXQSZweGImHL5LYy+zMsPdVklBWdUF5oZIpJBunnIphcbiKFtPD/lGkJt8+jucMUOFNNOnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUr5Y1bL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716988328; x=1748524328;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LihBiyEtP+byKlYeJMhmFzcL1/UxANEmf6BaRF8uarE=;
  b=LUr5Y1bLEExkpB3cxp00NqyOJJGWHDz0cu2FgVP6xczj+saik6gXqMUY
   4P7L9rkH0iH/W/Ka/w6xuM84ZOeBNTgyptdFKxK5fY5LITCqQtHwoVesx
   Uk2VOHLnd/g696iZyyyAy62EeGxyTn+lFMvz7M3KEDWNxWJEpSkrIZTzu
   NdOZu2w1hItjMLnfcbIXOUnJ3GNCNKWNnoqjM1U1ohco1UmbKsRev9dIh
   kENPyaXdIF+ld0P+qaV8sVnR8JAhRWngUzz77v8WS1b8TJE7VviMN4Ycs
   jDgFXgKzkmcZdN46UpohmjpWKuRIkeinLVVqyvoOR7kbqck5wclg/kXk8
   A==;
X-CSE-ConnectionGUID: jdebM3dGSRu62HhDn2u5sA==
X-CSE-MsgGUID: Dt1QnlAyScqpPPJeNvpm1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13210542"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13210542"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 06:12:08 -0700
X-CSE-ConnectionGUID: DFjTX8MvTFy4uRXjF2xMkg==
X-CSE-MsgGUID: UI9DxQ6uTIGp9aT9tnyybw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35460544"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 06:12:08 -0700
Received: from [10.212.55.153] (unknown [10.212.55.153])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 686422078A11;
	Wed, 29 May 2024 06:12:06 -0700 (PDT)
Message-ID: <67f531f8-6d8c-49f7-a405-09cce28f738b@linux.intel.com>
Date: Wed, 29 May 2024 09:12:05 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] perf/x86/intel/uncore: Fix the bits of the CHA
 extended umask for SPR
To: peterz@infradead.org, mingo@kernel.org, acme@kernel.org,
 namhyung@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: irogers@google.com, mpetlan@redhat.com, eranian@google.com,
 ak@linux.intel.com, stable@vger.kernel.org
References: <20240416180145.2309913-1-kan.liang@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240416180145.2309913-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter and Ingo,

Could you please take a look and accept the bug fix patch?

It's to fix some broken uncore events on SPR.
https://lore.kernel.org/linux-perf-users/alpine.LRH.2.20.2405281153210.4040@Diego/

Thanks,
Kan

On 2024-04-16 2:01 p.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The perf stat errors out with UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL
> event.
> 
>  $perf stat -e uncore_cha_55/event=0x35,umask=0x10c0008101/ -a -- ls
>     event syntax error: '..0x35,umask=0x10c0008101/'
>                                       \___ Bad event or PMU
> 
> The definition of the CHA umask is config:8-15,32-55, which is 32bit.
> However, the umask of the event is bigger than 32bit.
> This is an error in the original uncore spec.
> 
> Add a new umask_ext5 for the new CHA umask range.
> 
> Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
> Closes: https://lore.kernel.org/linux-perf-users/alpine.LRH.2.20.2401300733310.11354@Diego/
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/events/intel/uncore_snbep.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index a96496bef678..7924f315269a 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -461,6 +461,7 @@
>  #define SPR_UBOX_DID				0x3250
>  
>  /* SPR CHA */
> +#define SPR_CHA_EVENT_MASK_EXT			0xffffffff
>  #define SPR_CHA_PMON_CTL_TID_EN			(1 << 16)
>  #define SPR_CHA_PMON_EVENT_MASK			(SNBEP_PMON_RAW_EVENT_MASK | \
>  						 SPR_CHA_PMON_CTL_TID_EN)
> @@ -477,6 +478,7 @@ DEFINE_UNCORE_FORMAT_ATTR(umask_ext, umask, "config:8-15,32-43,45-55");
>  DEFINE_UNCORE_FORMAT_ATTR(umask_ext2, umask, "config:8-15,32-57");
>  DEFINE_UNCORE_FORMAT_ATTR(umask_ext3, umask, "config:8-15,32-39");
>  DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
> +DEFINE_UNCORE_FORMAT_ATTR(umask_ext5, umask, "config:8-15,32-63");
>  DEFINE_UNCORE_FORMAT_ATTR(qor, qor, "config:16");
>  DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
>  DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
> @@ -5957,7 +5959,7 @@ static struct intel_uncore_ops spr_uncore_chabox_ops = {
>  
>  static struct attribute *spr_uncore_cha_formats_attr[] = {
>  	&format_attr_event.attr,
> -	&format_attr_umask_ext4.attr,
> +	&format_attr_umask_ext5.attr,
>  	&format_attr_tid_en2.attr,
>  	&format_attr_edge.attr,
>  	&format_attr_inv.attr,
> @@ -5993,7 +5995,7 @@ ATTRIBUTE_GROUPS(uncore_alias);
>  static struct intel_uncore_type spr_uncore_chabox = {
>  	.name			= "cha",
>  	.event_mask		= SPR_CHA_PMON_EVENT_MASK,
> -	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,
> +	.event_mask_ext		= SPR_CHA_EVENT_MASK_EXT,
>  	.num_shared_regs	= 1,
>  	.constraints		= skx_uncore_chabox_constraints,
>  	.ops			= &spr_uncore_chabox_ops,

