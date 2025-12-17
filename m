Return-Path: <stable+bounces-202847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6540ACC81E2
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93281308744A
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8929382596;
	Wed, 17 Dec 2025 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLx1fvtP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646F9363C56;
	Wed, 17 Dec 2025 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979926; cv=none; b=URFEmBdONyUFS1hiCNd6ZZ9PJfcMUewTHWBSS/ybIKKbIg8NrLsMAvPuNR/MZavZvcecOizQfrGff39OOXkVCsbBJmaJkOSNYBjTB6VxS4P/EkPWtKP9c7I5q5GcLYRbaaZnftTO8AAlC1aBQCDASy/b7OkuqVdvXOvJDfVYlqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979926; c=relaxed/simple;
	bh=I3QJCJZ1ljm8J3Va4YCMB4RQa1pGsuARiW8BtPzfX3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZqyfEDa0m8onGFkjcsDbfQM2tM6LOJsovU82C5+LEJqumt/xSQflxugLgtiafqXuEg8LAgo+SJumGoiWsejAk8XdUi9jSF9F/fP8HJTYilASiayXQRdS1F4JyszY9cvvOt7mfmnFwsSEGzB/l1ZcoqRVK1tR26teSddxv7OuJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLx1fvtP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765979923; x=1797515923;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I3QJCJZ1ljm8J3Va4YCMB4RQa1pGsuARiW8BtPzfX3A=;
  b=JLx1fvtPh1o734sfbFeRfetFi7pyYOE4avEkqyBb5Y+/+o60QgKt4Yo2
   KSO5rsvBLFby0T9Qv0/DwV5giu4lK/3isv6Bz4eBMIJa+KLQkRoMnYgFv
   TFKshyTtwia0g4glx36QevTPJKJos4lSdFjwxPO03IrU2250PUF08VNBo
   +OcUWpN+xCD153dJTreyi++Ca7x3HhUTZ/ZtfirJjboXO0aPGbFkvlybh
   ZBLN5wDIsjeM92vJinKMW+y1G855KU1IUFboXgLg8Rj67oNLegTieeVB3
   875Unoq1qPI6cQTx9X8UmRv4XdXlQg0+oAwOoXa5Ff1Lb+XsDA9SdIkKQ
   A==;
X-CSE-ConnectionGUID: aeysSJwXSYy1DKpBVxqTbA==
X-CSE-MsgGUID: fQf9aqloQ9aFq55s6piM9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="78554889"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="78554889"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 05:58:41 -0800
X-CSE-ConnectionGUID: NV4AbHmWTrCpDknnVrYUNw==
X-CSE-MsgGUID: 6JAvtKVIQbq0z7654THSDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="197928350"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.187]) ([10.245.246.187])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 05:58:37 -0800
Message-ID: <9e0c68de-c528-47f2-94e7-ddb118d3dda2@linux.intel.com>
Date: Wed, 17 Dec 2025 15:59:02 +0200
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
References: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
 <6e97293c-71c1-40a8-8eba-4e2feda1e6ea@sirena.org.uk>
 <27404fce-b371-4003-b44b-a468572cf76d@linux.intel.com>
 <af368a9e-16c0-4512-8103-2351a9163e2c@opensource.cirrus.com>
 <56411df9-3253-439a-b8eb-75c5b0175a7a@linux.intel.com>
 <bc6f3e66-ca9b-4ba3-bbe1-5ef31c373e6d@opensource.cirrus.com>
 <e98a78fc-0b30-4af1-b6f5-2bc5cacc8115@linux.intel.com>
 <9f1d5b88-e638-4b87-bee0-fc963231d20e@opensource.cirrus.com>
 <87c2d498-60fe-4339-83c8-f6d6bc256ea7@linux.intel.com>
 <8e2d0294-318c-4776-a02e-f6e6497852db@sirena.org.uk>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <8e2d0294-318c-4776-a02e-f6e6497852db@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/12/2025 15:56, Mark Brown wrote:
> On Wed, Dec 17, 2025 at 03:54:43PM +0200, Péter Ujfalusi wrote:
> 
>>> rf@debianbox:~/work/kernel/linux$ time ./tools/testing/kunit/kunit.py
>>> run --alltests
> 
>> well, I don't have kunit test setup, so it fails, but I can build the
> 
> What do you mean by "kunit test setup" - that's just a self contained
> Python script that drives everything, it has minimal Python
> requirements.

I'm holding it wrong I'm sure:

[15:35:21] Configuring KUnit Kernel ...
[15:35:21] Building KUnit Kernel ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
Building with:
$ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=14
[15:35:30] Starting KUnit Kernel (1/1)...
[15:35:30] ============================================================
Running tests with:
$ .kunit/linux kunit.enable=1 mem=1G console=tty kunit_shutdown=halt
[15:35:30] [ERROR] Test: <missing>: Could not find any KTAP output. Did any KUnit tests run?
[15:35:30] ============================================================
[15:35:30] Testing complete. Ran 0 tests: errors: 1
[15:35:30] Elapsed time: 9.328s total, 0.001s configuring, 9.321s building, 0.006s running

-- 
Péter


