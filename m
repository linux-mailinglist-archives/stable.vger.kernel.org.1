Return-Path: <stable+bounces-202812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D7ACC87CD
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80039300180C
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C334BA22;
	Wed, 17 Dec 2025 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lf78DF9k"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2F34B662;
	Wed, 17 Dec 2025 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975109; cv=none; b=SBrghEI4vRGVX742AuxwChvWdLq1pANzbN1z9kspzwKVPYFIOkzDUamlqpSgDwqGb2/qBHcmnrefx0A6Vns6g/a3SuyIAGm544N5mhgJouYgADSEjTokhRwKpc7HF7iuR3YzfE3gd40ODu7+YaY73ybOabyoZHjRWu8lNTBuY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975109; c=relaxed/simple;
	bh=FUADaIH6FUNqz9Gma+BqsJh4JaQpNLE4Dsd9O+7cJlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUM3+UctgM4LHyPgYutnudXS9eCQGiktVPgZKIdkdR1e5crLFY4naTS1lIg5P0Hqfm4TUoC8eRREIEFtNIoCJ7BDXHyXh6QUcYMR7emqnLzXf4/V5EArA5thRupeiD2tXXIwIyEiZeeWU54IqiS83mRJjVADX3Xd2bBCSkeydeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lf78DF9k; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765975108; x=1797511108;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FUADaIH6FUNqz9Gma+BqsJh4JaQpNLE4Dsd9O+7cJlc=;
  b=Lf78DF9kzXzhFWnRzQnszbeWhQWHOIXtv4gWzZqI1e4kHuGme0CCFdhN
   w5WNAxqStNCTO9leIlWDM1qs5EGW50zDzskOZ2QbmJ03z/f4QCHLYLj48
   YsGz2kWWvxnTsfyeMIFQy7GUdjdR+Es41lavczQ3V9LmPnaEZHhpDJfEa
   iI+i6FAEZWx64sO0EHk2AkQq8A+DqbJk4FnqT+rWxx1BOXU2SCzCTh2wO
   qmCQN8301qPK+5az8cNUSyZEGkrlBr8gDbLtnd6O5HyP4Mih26bwv8vWp
   dW6/GHqld/wr4euGmLcrfbr3kB9UPpjYA9vm+ZmXb6QXt8Z56iW7i5px8
   g==;
X-CSE-ConnectionGUID: wih+sJl6Q2qDhlCgWAm31A==
X-CSE-MsgGUID: hXp/Mj2QQvqz1pE9oLDFMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="85327637"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="85327637"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 04:38:27 -0800
X-CSE-ConnectionGUID: QtvAO31vSCmeZNdoW0poPA==
X-CSE-MsgGUID: DNsGudjrRUepGc1IjwxO2Q==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.187]) ([10.245.246.187])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 04:38:24 -0800
Message-ID: <56411df9-3253-439a-b8eb-75c5b0175a7a@linux.intel.com>
Date: Wed, 17 Dec 2025 14:38:50 +0200
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
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <af368a9e-16c0-4512-8103-2351a9163e2c@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/12/2025 14:36, Richard Fitzgerald wrote:
> On 17/12/2025 12:20 pm, Péter Ujfalusi wrote:
>>
>>
>> On 17/12/2025 14:16, Mark Brown wrote:
>>> On Wed, Dec 17, 2025 at 02:06:23PM +0200, Peter Ujfalusi wrote:
>>>> In 'normal' controls the mc->min is the minimum value the register can
>>>> have, the mc->max is the maximum (the steps between are max - min).
>>>
>>> Have you seen:
>>>
>>>    https://lore.kernel.org/r/20251216134938.788625-1-
>>> sbinding@opensource.cirrus.com
>>
>> No, I tried to look for possible fixes for this, but have not found it.
>>
>> I think my one liner is a bit simpler with the same result, but I'll let
>> people decide which is better (and test on Cirrus side)
>>
> Does it pass the kunit tests for SX controls?
> The ASoC kunit tests have specific tests for SX controls.
> The original patch failed those tests, but it was merged anyway.

It passes my manual tests on cs42l43, not sure how to run the unit-test
for SX, can you by chance test this?

-- 
Péter


