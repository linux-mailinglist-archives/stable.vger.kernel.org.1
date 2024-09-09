Return-Path: <stable+bounces-74047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D40F0971E5D
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FAA8B235C9
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BC150297;
	Mon,  9 Sep 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISAoSvwy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBBA22EED;
	Mon,  9 Sep 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725896718; cv=none; b=mhUUdcKtNOYy4YzZZMiZZZI/y2bj4UMptSA6Gvz5yLszcDq1WgTnvyaa/ZVTeepyIp4iOV6irxJrSeOGmu6QBrV3r77bAU/FVoaNn+h3PlxuS3map9n6f2pIj7iU4CmYzznrwPaRsBclB1Uz18TSxTd/rjxM/VBP43rtEiR67M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725896718; c=relaxed/simple;
	bh=YgYd4UDRaHUx/I4aBI/a5xRLjPGeXP51J3gubakkuJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLaqmpUqKfREiIjVixV9fYglheFuxFyuPXYn3L5E4yMJzZ50MRrUsUA/Qqr9knpww/4ENi2SBSDNZsaJeMnHkLlxDHzKUK9Se0F9dUq33O3oNH5iCfpk5KU+fn8Ic2dcoH2E8cmejjIFA8Lsgl34qX+si63L2WDraTQs01LRq90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISAoSvwy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725896717; x=1757432717;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YgYd4UDRaHUx/I4aBI/a5xRLjPGeXP51J3gubakkuJk=;
  b=ISAoSvwyt04S2ToQfbTMGO9bxjmxwTz+og0cEYi3HVYiXxaa0Y+sTToO
   AgfKc5L2qb552jiZ9nFlv7g5bHObuCSOGeNL91bCOA0nVeUCx4adSticw
   RdIPUs27Lk23bd3h2IxI0c7gX/eU8JxeFfJ/5Xy9YsLim65UU+dCaUjPV
   nKSeVRYxB66/wEas0NfOZRsY1VKnZNMde1joLtLT2Q2OzJpnAIkqqg3wU
   M1uVZyLETKCPPeERRmwgyA/z9UCTjGDuaM9hF0O5Uc6vVQuLr4x0BwcD6
   9MYLl1HyT6fbHPPusYn/M51dhJrgRUFeqgXH2KWl+0AgxExeewHlB+5vx
   g==;
X-CSE-ConnectionGUID: CH36O9WCQrSOEK5ydiW+vw==
X-CSE-MsgGUID: E7KKY8weRzqsSrywTYu8KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24149204"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24149204"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 08:45:17 -0700
X-CSE-ConnectionGUID: 1F/bI0RxRoKO7kAoUB8ykA==
X-CSE-MsgGUID: 9w46N3gdQ5KYPrVn7LS6tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="67014967"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO [10.245.246.241]) ([10.245.246.241])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 08:45:15 -0700
Message-ID: <8462d322-a40a-4d6c-99c5-3374d7f3f3a0@linux.intel.com>
Date: Mon, 9 Sep 2024 17:45:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: stream: Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
To: Charles Keepax <ckeepax@opensource.cirrus.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Bard Liao
 <yung-chuan.liao@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240904145228.289891-1-krzysztof.kozlowski@linaro.org>
 <Zt8H530FkqBMiYX+@opensource.cirrus.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Zt8H530FkqBMiYX+@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/24 16:36, Charles Keepax wrote:
> On Wed, Sep 04, 2024 at 04:52:28PM +0200, Krzysztof Kozlowski wrote:
>> This reverts commit ab8d66d132bc8f1992d3eb6cab8d32dda6733c84 because it
>> breaks codecs using non-continuous masks in source and sink ports.  The
>> commit missed the point that port numbers are not used as indices for
>> iterating over prop.sink_ports or prop.source_ports.
>>
>> Soundwire core and existing codecs expect that the array passed as
>> prop.sink_ports and prop.source_ports is continuous.  The port mask still
>> might be non-continuous, but that's unrelated.
>>
>> Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> Closes: https://lore.kernel.org/all/b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com/
>> Fixes: ab8d66d132bc ("soundwire: stream: fix programming slave ports for non-continous port maps")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
> 
> Would be good to merge this as soon as we can, this is causing
> soundwire regressions from rc6 onwards.

the revert also needs to happen in -stable. 6.10.8 is broken as well.

https://github.com/thesofproject/linux/issues/5168



