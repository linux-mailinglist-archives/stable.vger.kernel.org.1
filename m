Return-Path: <stable+bounces-36333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7949289BAE3
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BF1281FDF
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18AF38FB9;
	Mon,  8 Apr 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isJxViiB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1482182C5
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566350; cv=none; b=G13b0eWNvzF71ed4tUR4WFhD9g7qNyeqGYBR1EdjG0ch6SCDIT6ympflJ2sVXU7kca8RIIf0OLeN4+jUUHR387YZKapJGdMqggIIQOSAXgaz+KrVZYjqbp/umHzSUV+wyhqh5ImngadDol4CzMq6ne2a0ZywOka1tAK3ewOW4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566350; c=relaxed/simple;
	bh=HZDVe5IXuaJzKYIyFMZ7jCk4tVodzuka2j1sl4DQPFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRuJ630z4o6HWQEd1uJtLEruyf7Q48k0TB0uMD2Wj0XVoiZoxxTVQoWGLiHssmFgTEBdNiPicNLP6IeOtcQgnYBDRRb+d6AbODA5i/o24QtaNHrkmbHyeiwJIdmeG3+Uch1Ev1wb8q/AxB2Lc0ZxdyiOsGGepc3McFyiQJ2SA1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isJxViiB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712566349; x=1744102349;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HZDVe5IXuaJzKYIyFMZ7jCk4tVodzuka2j1sl4DQPFQ=;
  b=isJxViiBN+P2wzAYcuuo3cg0iKdpgthVAJtQD7o6AoqYmUQGlJ8a9Fld
   hKikfUUz9P+TZIMzW8816ZkBygUlTvq5KaJT/P4eUfDLULvDEcfzY+7M7
   uiMD9TYHo5affcgma3FSrj0SSmiucfF33/JZG4N6VerZxsVaZ3IpAgPDR
   hR9taGoRlsD7gjhuaiJAIt+nbgCgOat9Pw0ibT1mIKtbPYQpKcqdbod/y
   OdkV8IkSoQpIce0Iq/AqmQZ9D0MTLUuB7o4yHdUxBGixXpYwPSfybrLyq
   DAGFjAcQzaMsw6DZjPh1Cje485PxnmaiKWzhTXhiUmCObnyIHwNyY4twd
   A==;
X-CSE-ConnectionGUID: bmycciQsQZG465xN3DHNMg==
X-CSE-MsgGUID: sL/bdhRGTZaeKF0NYrnxtA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19270093"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19270093"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 01:52:28 -0700
X-CSE-ConnectionGUID: GX8IjpE8SGig+o9I4yckZQ==
X-CSE-MsgGUID: I31GdFPUS62symGhti8AMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19875347"
Received: from jlawryno-mobl.ger.corp.intel.com (HELO [10.246.3.118]) ([10.246.3.118])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 01:52:27 -0700
Message-ID: <c041f109-aa9e-43db-921f-726292b9a3f7@linux.intel.com>
Date: Mon, 8 Apr 2024 10:52:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] accel/ivpu: Return max freq for
 DRM_IVPU_PARAM_CORE_CLOCK_RATE
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, stable@vger.kernel.org
References: <20240402104929.941186-1-jacek.lawrynowicz@linux.intel.com>
 <20240402104929.941186-7-jacek.lawrynowicz@linux.intel.com>
 <5a4d8fa1-a537-7690-b712-57391a192fa3@quicinc.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <5a4d8fa1-a537-7690-b712-57391a192fa3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 05.04.2024 17:26, Jeffrey Hugo wrote:
> On 4/2/2024 4:49 AM, Jacek Lawrynowicz wrote:
>> DRM_IVPU_PARAM_CORE_CLOCK_RATE returned current NPU frequency which
> 
> Commit text should be present tense, so returned->returns

OK

>> could be 0 if device was sleeping. This value wasn't really useful to
> 
> also wasn't->isn't

OK

>> the user space, so return max freq instead which can be used to estimate
>> NPU performance.
>>
>> Fixes: c39dc15191c4 ("accel/ivpu: Read clock rate only if device is up")
>> Cc: <stable@vger.kernel.org> # v6.7
>> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> 
> With the above,
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

