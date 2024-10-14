Return-Path: <stable+bounces-83738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF0D99C207
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 09:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB441F23408
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 07:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E39A14B94B;
	Mon, 14 Oct 2024 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UCww/qbC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404914A092
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892419; cv=none; b=UILQj1vaQN4jtflDVfd97+D05vmVlZFHWAKShS/KaNjzJgGfGd9ZAta8RWJ91ndtODZat8zHFO4SSRDXlUrRTfVep9kjQ/V6//ZUifufFpR9mdHCwZ6baaV1wJqs8NI0jp7CKUmGnNxj+/VEShAWYCl+RqdEcVgwQqHW+h4Pn7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892419; c=relaxed/simple;
	bh=DGETLDSlQ4ezwlWlI/LnEF+cRQYknpxbmggCml9SCnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZH/8zVis4l+c2h/yIKsxQqiXUL+MUlmvz2j9nMymwYI0gdbwuA360z33U8qJTXL8y66H/udOE4a4UlP+UXRaiFT4l9FwmeK1qsgXWlrnBNP+3SycocoD3zLoIIdAhXWfHJeZB3/r2hjBN3PKWEs6gAP6Ci5s3mrDk9CObGHuac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UCww/qbC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728892418; x=1760428418;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DGETLDSlQ4ezwlWlI/LnEF+cRQYknpxbmggCml9SCnE=;
  b=UCww/qbChKzmtfLe0IfbE+JIf98RSVM1TTdJGQi1fOhlDVTrjDmMtuNv
   TukgccqcetBdbxmMqrzi/aiHYp7skZdVXJucirrru2TuqALJYf36hSETq
   lcGXRRuAoNviZBpF54cPHd4jCpLOx6O5mnYkhbIN01/ipsVI7ZbleKcxK
   n2n5DPTedEb82OdbiQa8V8bflg8szRfCWetyBpybFqGud2FTg3sFGdYrJ
   jGoHFI4Z1gztPEzzJeDh89BEafEBfMIZnEU0SpHJqkP2lmyTDPqRe4SGp
   L1bbAz98Vi+BngGBYjRgxT0qN/sLSOvbGrcQEkEyGLEnh//nN4kHoAPqy
   Q==;
X-CSE-ConnectionGUID: XX31dy2RR1C5YlRejZ9v5Q==
X-CSE-MsgGUID: 62XufLOLSLWBUi9CzUInRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="28112321"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="28112321"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 00:53:37 -0700
X-CSE-ConnectionGUID: Q0AN8MZHRi62pWP+AW+P/Q==
X-CSE-MsgGUID: wmxC1R8aTV+Ivk1frMgKWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="108291489"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.94]) ([10.245.244.94])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 00:53:36 -0700
Message-ID: <a8e10e81-8f54-44da-b8af-a10dd7f55f6a@intel.com>
Date: Mon, 14 Oct 2024 08:53:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/ufence: ufence can be signaled right after
 wait_woken
To: Nirmoy Das <nirmoy.das@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Bommu Krishnaiah <krishnaiah.bommu@intel.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <20241011151029.4160630-1-nirmoy.das@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20241011151029.4160630-1-nirmoy.das@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2024 16:10, Nirmoy Das wrote:
> do_comapre() can return success after a timedout wait_woken() which was

s/comapre/compare

> treated as -ETIME. The loop calling wait_woken() sets correct err so
> there is no need to re-evaluate err.
> 
> v2: Remove entire check that reevaluate err at the end(Matt)
> 
> Fixes: e670f0b4ef24 ("drm/xe/uapi: Return correct error code for xe_wait_user_fence_ioctl")
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1630
> Cc: <stable@vger.kernel.org> # v6.8+
> Cc: Bommu Krishnaiah <krishnaiah.bommu@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>


