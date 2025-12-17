Return-Path: <stable+bounces-202854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4B7CC8402
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 180C3305FB52
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE79378315;
	Wed, 17 Dec 2025 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvmOz+gC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817BB376BF4;
	Wed, 17 Dec 2025 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981155; cv=none; b=I1YKoxUbe5f7Gvnz5oKCrRIlR834PBRyHZLfG3grJxPFA8bvJ6S+UdZM12lUJeUQdpuRxHMP9U+cJ1tZv86hT7R5D3Y23IkYWTTYtSOdGnfdDVZOAbV3hwib1c6KKFYdlDDX+vJN5XMSNcpOp1B6PDcVMxuovWRBhRssqyAFT3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981155; c=relaxed/simple;
	bh=p5eYT7+ffI1teBj2m9yWCMHeKIxMTyhHtLaWnOvzZOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiF5KDiowkrJM6+oRwPM1iMxkUDIyVgBQXfqibgeuKM+L5Xu01eA08Dl7LlRnfZ5strp6qh6lleVYR+ZA0GOl+RTdxS0iqvfjEE5EraeV7T5LjY8zBi1Uy3OZUtWrY63kAdiShk/7oDHZdI95m7T/3vkBuyKcO4JPoXfCM14O3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvmOz+gC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765981152; x=1797517152;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p5eYT7+ffI1teBj2m9yWCMHeKIxMTyhHtLaWnOvzZOo=;
  b=TvmOz+gCHhaObXR5Uv4UjpaiqAsoBXoUoKrA2plDN50XgmUuJXAUs+Kc
   IYlE6V9Q/hmQZ4G35dZCRv/dYujgDEz7PCY17WsvVMAvZ5MZR0c+T8ZUU
   3OnR9XFmhe7OfYGG/goUU6/DO3CdNB+KuXgWSiY+62+K98KovFjNPm4vE
   A24bAHh9/euuyxz6D4nJU+eTyhSjgqCrODENa+YwQEpuSBGllRxISiBiB
   Bslklm4LEhbI63du86X3VNSVMn5nLXIPMoFoQBJWXHuzRem8LPlz6qwFL
   ln6ZY3SFzIKoY0cPlgQaSYr3eflgiuFwdAOOwO0BxhRofE44leF2OpAdl
   g==;
X-CSE-ConnectionGUID: m1dNtB1+TeGMBHpvCJftjw==
X-CSE-MsgGUID: BrN7dgIWSZOjh/voVAsHqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="85506493"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="85506493"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:19:08 -0800
X-CSE-ConnectionGUID: s0NG1WW9S3CtKMgqNIP6ag==
X-CSE-MsgGUID: 1SewdYcGRNGEeao2VXU7Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="197931713"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.187]) ([10.245.246.187])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:19:05 -0800
Message-ID: <e513fe97-a0b2-4d96-9987-07b41a2891a7@linux.intel.com>
Date: Wed, 17 Dec 2025 16:19:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
To: Mark Brown <broonie@kernel.org>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, lgirdwood@gmail.com,
 linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
 seppo.ingalsuo@linux.intel.com, stable@vger.kernel.org, niranjan.hy@ti.com,
 ckeepax@opensource.cirrus.com, sbinding@opensource.cirrus.com
References: <6e97293c-71c1-40a8-8eba-4e2feda1e6ea@sirena.org.uk>
 <27404fce-b371-4003-b44b-a468572cf76d@linux.intel.com>
 <af368a9e-16c0-4512-8103-2351a9163e2c@opensource.cirrus.com>
 <56411df9-3253-439a-b8eb-75c5b0175a7a@linux.intel.com>
 <bc6f3e66-ca9b-4ba3-bbe1-5ef31c373e6d@opensource.cirrus.com>
 <e98a78fc-0b30-4af1-b6f5-2bc5cacc8115@linux.intel.com>
 <9f1d5b88-e638-4b87-bee0-fc963231d20e@opensource.cirrus.com>
 <87c2d498-60fe-4339-83c8-f6d6bc256ea7@linux.intel.com>
 <8e2d0294-318c-4776-a02e-f6e6497852db@sirena.org.uk>
 <9e0c68de-c528-47f2-94e7-ddb118d3dda2@linux.intel.com>
 <ccc3f3c6-c99d-4e78-9296-f49898894c61@sirena.org.uk>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <ccc3f3c6-c99d-4e78-9296-f49898894c61@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/12/2025 16:00, Mark Brown wrote:
> On Wed, Dec 17, 2025 at 03:59:02PM +0200, Péter Ujfalusi wrote:
>> On 17/12/2025 15:56, Mark Brown wrote:
> 
>>> What do you mean by "kunit test setup" - that's just a self contained
>>> Python script that drives everything, it has minimal Python
>>> requirements.
> 
>> I'm holding it wrong I'm sure:
> 
>> [15:35:21] Configuring KUnit Kernel ...
>> [15:35:21] Building KUnit Kernel ...
>> Populating config with:
>> $ make ARCH=um O=.kunit olddefconfig
> 
> What did you actually run there?  Did you somehow have an existing
> .config that it was picking up with everything turned off?
git clean -xdf
make mrproper

./tools/testing/kunit/kunit.py run --alltests
[16:09:25] Configuring KUnit Kernel ...
Generating .config ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
[16:09:30] Building KUnit Kernel ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
Building with:
$ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=14
[16:12:52] Starting KUnit Kernel (1/1)...
[16:12:52] ============================================================
Running tests with:
$ .kunit/linux kunit.enable=1 mem=1G console=tty kunit_shutdown=halt
[16:12:52] [ERROR] Test: <missing>: Could not find any KTAP output. Did any KUnit tests run?
[16:12:52] ============================================================
[16:12:52] Testing complete. Ran 0 tests: errors: 1
[16:12:52] Elapsed time: 206.260s total, 4.835s configuring, 201.418s building, 0.007s running

well, this is for the cold and dark winter days.. ;)

-- 
Péter


