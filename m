Return-Path: <stable+bounces-62727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D39B940E22
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340001F2465F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEF0195807;
	Tue, 30 Jul 2024 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DowYfad9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A1195B33;
	Tue, 30 Jul 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332640; cv=none; b=O0wIbPRunYOs6hzuOBvTiy8jBFFDQtjrWBShg1as8cVGoyVdhRCBtsO73w9LgBXNfrlgaGo5ETK0tVUMGiJZozZ4F34e9SUN2ZFNlEskHWZBcAh4PiUvtgJr7IFNPIumTKdNHCjhiZrh04vgCv6EHIwK+kB89gJCOkqR9u1Q3ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332640; c=relaxed/simple;
	bh=n+bDskUWnn1bpt3i1mkDbx3XQvcnjEMr1Kdl+ZZWL1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QX3fufNFhPkVXCiw6vRFf7Bo8iaWhPWskYF1V0Z0qMwZOKBHR8wsr8L0EEE2glUOUwz/B2cVR1YZ9X/DubcPcD0lCo9rWEHjwZ65uW1l2tBeevvNsRTV2LvdFYRnP02cbc2Q/9Ddiqb1g0o59awFPzhi83e4w//he5MWLX9c4uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DowYfad9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722332639; x=1753868639;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n+bDskUWnn1bpt3i1mkDbx3XQvcnjEMr1Kdl+ZZWL1E=;
  b=DowYfad9xMZ7nNn6MrC18K1qJAvGCQwuZcGEbtxqEtUJq3eKOAf89ehu
   Wrq6q8D0DhwMUKxk+1t007nWwSvgYVVMS1xy2s9SJYrxLs+7+l3xchsMA
   LcPBkKin2SNt99JJ05sCTLRElrd0MYSDcDCPdkamZjMObqz0JlePa8zj8
   iaDnOTgi4AxBklEjtj9n9SEKLgvMkE7RuV0HOsPy9LhHbcfCMO72y5LtV
   LWoAkzU4Eg4ROMVHHHaW+4mFfB7qgQeetDB5qdOtfL6iP6Z21A0ahqr4u
   J6SZJAyS8zL5zi/4DGmZpYgxlt4bpYuhXTgAAgvmFnu776K+63IAxpzOC
   g==;
X-CSE-ConnectionGUID: cT2PX+ZcQuK7/JE2bI/gpw==
X-CSE-MsgGUID: wguzLZpJTQ6L83GENO+ntw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31545732"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="31545732"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:43:58 -0700
X-CSE-ConnectionGUID: pew9M1btT9Ce452/apMdbw==
X-CSE-MsgGUID: ShtEv/XbR2+cJhrDgLtQlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54191390"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO [10.245.246.40]) ([10.245.246.40])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:43:55 -0700
Message-ID: <d3d4e197-285a-49d9-8c1b-f718cd1f30d7@linux.intel.com>
Date: Tue, 30 Jul 2024 11:43:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: stream: fix programming slave ports for
 non-continous port maps
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240729140157.326450-1-krzysztof.kozlowski@linaro.org>
 <095d7119-8221-450a-9616-2df6a0df4c77@linux.intel.com>
 <22b20ad7-8a25-4cb2-a24e-d6841b219977@linaro.org>
 <dc66cd0d-6807-4613-89a8-296ce5dd2daf@linaro.org>
 <62280458-3e74-43b0-b9a1-84df09abd30e@linux.intel.com>
 <7171817f-e8c6-4828-8423-0929644ff2df@linaro.org>
 <048122b2-f4cc-4cfa-a766-6fcfb05f840a@linux.intel.com>
 <9b916fb9-84ac-4574-8f3d-aad2f539fcd0@linaro.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <9b916fb9-84ac-4574-8f3d-aad2f539fcd0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/24 11:29, Krzysztof Kozlowski wrote:
> On 30/07/2024 11:28, Pierre-Louis Bossart wrote:
>>>
>>>>
>>>> So if ports can be either source or sink, I am not sure how the
>>>> properties could be shared with a single array?
>>>
>>> Because I could, just easier to code. :) Are you saying the code is not
>>> correct? If I understand the concept of source/sink dpn port mask, it
>>> should be correct. I have some array with source and sink ports. I pass
>>> it to Soundwire with a mask saying which ports are source and which are
>>> sink.
>>>
>>>>
>>>> Those two lines aren't clear to me at all:
>>>>
>>>> 	pdev->prop.sink_dpn_prop = wsa884x_sink_dpn_prop;
>>>> 	pdev->prop.src_dpn_prop = wsa884x_sink_dpn_prop;
>>>
>>> I could do: s/wsa884x_sink_dpn_prop/wsa884x_dpn_prop/ and expect the
>>> code to be correct.
>>
>> Ah I think I see what you are trying to do, you have a single dpn_prop
>> array but each entry is valid for either sink or source depending on the
>> sink / source_mask which don't overlap.
>>
>> Did I get this right?
> 
> Yes, correct.

Sounds good, thanks for the explanations.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


