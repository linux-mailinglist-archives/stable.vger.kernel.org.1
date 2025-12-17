Return-Path: <stable+bounces-202844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A344FCC8053
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BCB33004207
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC31D382571;
	Wed, 17 Dec 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4cYZcgu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1299342C9E;
	Wed, 17 Dec 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979661; cv=none; b=YeHuGUxk8EoDFSJhgs9icaxcom79bwOLug4gZwlX/sicI7B3qLo/7BPBQUUh0RfkACItOFDoUryYzhpfVe8+7D9qLFmRE2zbCQCVux/nuYINT7CCBtYgfTEAosAHvf0Wqf2TSHjpg1O12r/EASoLbxB918p6jAX72W6M5ldANqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979661; c=relaxed/simple;
	bh=56XwzCy9kzqLxz2UThRyiNxem9t6aJeL21NX8ZKyBVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1cHv97dKWa9tQu0f554b8EWnI6/xsQkdaAE+8YPNxJVbvu0dM4robBkoOhn6wzokPF8mVuMsRsS/wMSCTcVdMvi6m5Rtw3mNTg597fIgjbUUFv+R0NYHnFGqsBG+rehra061R9nCMaSZBeITMo91Jh5OFufgQNzgMlx5BylQ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4cYZcgu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765979660; x=1797515660;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=56XwzCy9kzqLxz2UThRyiNxem9t6aJeL21NX8ZKyBVY=;
  b=H4cYZcguHSoQEaz3aPHWpLy0NGU+B8C7V1gN++Z6qYDgC1wwMb32yrwE
   N/n/F597P62sXXe+PdYV7auPQhLme4aIwWV4HPfc2JXDf3SaMeHZfWERm
   6lwzC235NM5faKfJYrDo/1Udc2aVjJKTyZRCWOU561GCbSmyZsGQsniwM
   WPTXZ5pOkMX7oAIachgUqR8xKyb9kdllA1Ep/uRaMvh7yrwur2y0q6Dgb
   Mm1/MJrdE9t+8ta9ipasRVfP7FW3xLKZS5zdqntYXSZS9OnL7lGN0al4H
   nwU3KfeoM1G4C3cxPcs+At3/e0I0sc7sQGB/1LJapkGFBas+ZMBCFgxuz
   A==;
X-CSE-ConnectionGUID: 357GI9xMT8CAeAZXOaplrA==
X-CSE-MsgGUID: HXlO5pE7ScWwpVgJZcv78Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="78554512"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="78554512"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 05:54:19 -0800
X-CSE-ConnectionGUID: hdGUCJBlSF6UeWq9pXsMzQ==
X-CSE-MsgGUID: ucH+ZRetSGmql8C+FTD9pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="197927844"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.187]) ([10.245.246.187])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 05:54:16 -0800
Message-ID: <87c2d498-60fe-4339-83c8-f6d6bc256ea7@linux.intel.com>
Date: Wed, 17 Dec 2025 15:54:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
To: Richard Fitzgerald <rf@opensource.cirrus.com>,
 Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
 kai.vehmanen@linux.intel.com, seppo.ingalsuo@linux.intel.com,
 stable@vger.kernel.org, niranjan.hy@ti.com, ckeepax@opensource.cirrus.com,
 sbinding@opensource.cirrus.com
References: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
 <6e97293c-71c1-40a8-8eba-4e2feda1e6ea@sirena.org.uk>
 <27404fce-b371-4003-b44b-a468572cf76d@linux.intel.com>
 <af368a9e-16c0-4512-8103-2351a9163e2c@opensource.cirrus.com>
 <56411df9-3253-439a-b8eb-75c5b0175a7a@linux.intel.com>
 <bc6f3e66-ca9b-4ba3-bbe1-5ef31c373e6d@opensource.cirrus.com>
 <e98a78fc-0b30-4af1-b6f5-2bc5cacc8115@linux.intel.com>
 <9f1d5b88-e638-4b87-bee0-fc963231d20e@opensource.cirrus.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <9f1d5b88-e638-4b87-bee0-fc963231d20e@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/12/2025 15:16, Richard Fitzgerald wrote:
> On 17/12/2025 1:01 pm, Péter Ujfalusi wrote:
>>
>>
>> On 17/12/2025 14:40, Richard Fitzgerald wrote:
>>>>
>>>> It passes my manual tests on cs42l43, not sure how to run the unit-test
>>>> for SX, can you by chance test this?
>>>>
>>> The easiest option is to run them from your kernel build tree like this:
>>
>> It is in my to-do list to get kunit working on my setups (Artix Linux on
>> dev and DUTs), so it is really something that will take rest of the year
>> easily ;)
>>
>>>
>>> make mrproper
>>> ./tools/testing/kunit/kunit.py run --kunitconfig=tools/testing/kunit/
>>> configs/all_tests.config
>>
>>>
>>
> The kunit tests can run on the computer you use to build the kernel. It
> takes a couple of minutes to run.
> 
> On my desktop box with vanilla 6.19-rc1:
> 
> rf@debianbox:~/work/kernel/linux$ make mrproper
> rf@debianbox:~/work/kernel/linux$ time ./tools/testing/kunit/kunit.py
> run --alltests

well, I don't have kunit test setup, so it fails, but I can build the
kernel and install on DUT and load the module:
[  159.843361]         ok 97 single volsw_sx: 0,0 -> range: 15->4(0), sign: 0, inv: 0 -> 0xf,0x0
[  159.843499]     # soc_ops_test_access: EXPECTATION FAILED at sound/soc/soc-ops-test.c:520
                   Expected result->value.integer.value[0] == param->lctl, but
                       result->value.integer.value[0] == 0 (0x0)
                       param->lctl == 1 (0x1)
[  159.843641]         not ok 98 single volsw_sx: 1,1 -> range: 15->4(0), sign: 0, inv: 0 -> 0x0,0x0

I guess, this implies that this patch is indeed does not work.

Tested the other patch and that works, sent my tested-by for it.

> 
> <SNIP>
> 
> [13:12:31] Testing complete. Ran 7154 tests: passed: 7082, failed: 36,
> skipped: 36
> [13:12:31] Elapsed time: 110.250s total, 3.072s configuring, 55.003s
> building, 52.119s running
> 
> real    1m50.314s
> user    15m52.878s
> sys    1m18.186s
> 

-- 
Péter


