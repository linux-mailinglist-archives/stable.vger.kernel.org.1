Return-Path: <stable+bounces-69952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F63995C8CF
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 11:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4906F1F21E4E
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 09:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106CD14A087;
	Fri, 23 Aug 2024 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UU8xBozu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255A21442F4;
	Fri, 23 Aug 2024 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404028; cv=none; b=pdVqUgPzc4NECH5ApJ8pfqngYbsZSqTW3L0PXa4eOaRoLirKyBSdZyp9e0XTDFWB8HFx+vWBVtUwXdUx7sVmA1voc4QKhHNHRLKr65wrD3dHBszGHTgrqLpjbmgQ4sVJgLwQl6rZYLcTBqDjHybh0d6CA89ai7D2fY2DbIHxRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404028; c=relaxed/simple;
	bh=+8Fu/rZKFtxsUw6aNrkFYOyfx45h89bkz9fVgWxBbhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4hTHAh3yFhYOytN/HgtcXQlmmD1TUlNsgiw9J4Vdtrlo5fOG5JqJTjnIyya+l6z/H3XM4579pnL59SLmlhmo4Rza/bxb6fT+Yq+C6eWMIg9n3/mpUyEWfFTeMesUvvinXZ9ZXPAJ6F0X5a6viwZYnkjEMs0J73uHAE4ZvekL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UU8xBozu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724404027; x=1755940027;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+8Fu/rZKFtxsUw6aNrkFYOyfx45h89bkz9fVgWxBbhY=;
  b=UU8xBozu4TTrhvFYZT66K2E5x7M9bkmgaxCqSML94AYHGt2vOanIzT5m
   I66tmUemDhsgkX6IhI92+DXyoFOVMBVexMJX99rXSGxrjY6RAWFE/9r6u
   rXcxOoAXlx80MrcKg7QgLurIe1VmDd+JyhH2RxRkbQdS7uniOvhqq6KJS
   4Sm6hz0CgwdSY1F0XwFPXNeWbI9TP84w88pIsNjIJbjPxOO3XiMrdWX9d
   JEh1RD02mT0Cu7btfdmOuhBYP9mHFcBxCM8YCa4chxDYFDqb+Nb1pDZMg
   jjZpVRkIbI/tT+b8x1ABc4fIpvyhYUWM0afsf2Z68Cy9Lnp1WA1dLFK9o
   A==;
X-CSE-ConnectionGUID: uwVUmVaRR1CQbzCsavublA==
X-CSE-MsgGUID: lsrkcylRSJCVupqFJIPD6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40377631"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="40377631"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 02:07:07 -0700
X-CSE-ConnectionGUID: tsR3MRv+TpS1KulT6HcNyg==
X-CSE-MsgGUID: kVSL0mjlQGSKTbFkhZ2Mow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="62041956"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.246.219]) ([10.245.246.219])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 02:07:04 -0700
Message-ID: <69c1f722-e864-4668-9db0-c44fac00af8e@linux.intel.com>
Date: Fri, 23 Aug 2024 09:50:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 regression fix] ASoC: Intel: Boards: Fix NULL pointer
 deref in BYT/CHT boards harder
To: Hans de Goede <hdegoede@redhat.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 stable@vger.kernel.org
References: <20240823074217.14653-1-hdegoede@redhat.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240823074217.14653-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/23/24 09:42, Hans de Goede wrote:
> Since commit 13f58267cda3 ("ASoC: soc.h: don't create dummy Component
> via COMP_DUMMY()") dummy codecs declared like this:
> 
> SND_SOC_DAILINK_DEF(dummy,
>         DAILINK_COMP_ARRAY(COMP_DUMMY()));
> 
> expand to:
> 
> static struct snd_soc_dai_link_component dummy[] = {
> };
> 
> Which means that dummy is a zero sized array and thus dais[i].codecs should
> not be dereferenced *at all* since it points to the address of the next
> variable stored in the data section as the "dummy" variable has an address
> but no size, so even dereferencing dais[0] is already an out of bounds
> array reference.
> 
> Which means that the if (dais[i].codecs->name) check added in
> commit 7d99a70b6595 ("ASoC: Intel: Boards: Fix NULL pointer deref
> in BYT/CHT boards") relies on that the part of the next variable which
> the name member maps to just happens to be NULL.
> 
> Which apparently so far it usually is, except when it isn't
> and then it results in crashes like this one:
> 
> [   28.795659] BUG: unable to handle page fault for address: 0000000000030011
> ...
> [   28.795780] Call Trace:
> [   28.795787]  <TASK>
> ...
> [   28.795862]  ? strcmp+0x18/0x40
> [   28.795872]  0xffffffffc150c605
> [   28.795887]  platform_probe+0x40/0xa0
> ...
> [   28.795979]  ? __pfx_init_module+0x10/0x10 [snd_soc_sst_bytcr_wm5102]
> 
> Really fix things this time around by checking dais.num_codecs != 0.
> 
> Fixes: 7d99a70b6595 ("ASoC: Intel: Boards: Fix NULL pointer deref in BYT/CHT boards")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

