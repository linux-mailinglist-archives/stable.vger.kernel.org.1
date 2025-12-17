Return-Path: <stable+bounces-202826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A80CDCC7F2A
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F19830F9558
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B288F34886F;
	Wed, 17 Dec 2025 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzLzVrl3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85FC347FD0;
	Wed, 17 Dec 2025 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976471; cv=none; b=SOROhLq4qM1nq5T6lH4NUcbu715c9+bSTE7uFTUFl3Jm1s07xQhN/sgirAnO1hAmZ7HfkopRK/MS0H/5ylIj7IO6w3gP4ailAEtQ6hxoX2g8WJyEiEBA8Jcigtx0iMgIj4MEw3c+XA3iuV85gPMdV/aW/7emaZ6YH0WE29bDVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976471; c=relaxed/simple;
	bh=cjgn/BA7Ju+Q5Ubk2VcZLOA1TllX33llG7QDDvCmOpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyLqVQe9TV3ZUhu//NcY5yK1UNK2CCCDiPlPf8lGMghcM44QM9ifPrfvn3bJvCYJzUvWhISiunuy8qm5RJ37Uk0wPHGeiWRG4BcNH3v6+mmRC3fsBZsQoIXdV2ISlNc2HOBOKtPggJIcdggvbifCPRuiVltp+ZXIqZY4gralz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzLzVrl3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765976469; x=1797512469;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cjgn/BA7Ju+Q5Ubk2VcZLOA1TllX33llG7QDDvCmOpk=;
  b=gzLzVrl3PGCzwPuxHh6gZnZIP4r0/iJ86SVDdMJOBbJtPYFv7nFWnPiu
   4LnZjga9hz3Sl3vmonnTm7WZ/GC7IoU3Y6SCXPxKEaBdRXTIhe79yxVnK
   uxTjRfWYPQbLsMftSsognXrBy6kSbcoQA64B8yBJMNYxoutihUTyQ2/u1
   Aevda4GjaBwbfX8eVfn+CXRk+VIz0efMnClAnM05kYI4lm7dzPfuGKI6b
   KOMB07m17Rh0T3PXZELMJEJw2MPsBUmOvUoAzcQiiN5Q41xi14HbqGedF
   kCPL6v+mKUxnuieF5+IRciwXgS30w0IlnB2gM6qAEMuhXO9Ty5giaVQEJ
   w==;
X-CSE-ConnectionGUID: z3zd+t8sSyCCVUomcrY92w==
X-CSE-MsgGUID: Fn+UdWAmSJKvAXog1zQyvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="71542632"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="71542632"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 05:01:09 -0800
X-CSE-ConnectionGUID: eZp8HpbIS1ev7ELvRXINPw==
X-CSE-MsgGUID: wv4Qa3EzQka36zqqvPnrEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="202677818"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.187]) ([10.245.246.187])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 05:01:06 -0800
Message-ID: <e98a78fc-0b30-4af1-b6f5-2bc5cacc8115@linux.intel.com>
Date: Wed, 17 Dec 2025 15:01:32 +0200
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
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <bc6f3e66-ca9b-4ba3-bbe1-5ef31c373e6d@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/12/2025 14:40, Richard Fitzgerald wrote:
>>
>> It passes my manual tests on cs42l43, not sure how to run the unit-test
>> for SX, can you by chance test this?
>>
> The easiest option is to run them from your kernel build tree like this:

It is in my to-do list to get kunit working on my setups (Artix Linux on
dev and DUTs), so it is really something that will take rest of the year
easily ;)

> 
> make mrproper
> ./tools/testing/kunit/kunit.py run --kunitconfig=tools/testing/kunit/
> configs/all_tests.config

> 

-- 
Péter


