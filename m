Return-Path: <stable+bounces-58148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939F5928C72
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 18:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F483B235AA
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D122716ABC6;
	Fri,  5 Jul 2024 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuXPKUUe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09851C2AF;
	Fri,  5 Jul 2024 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198061; cv=none; b=ZcaOfZNtzPKeHFD83pGuSxDkH8+ToL43abzna8x7C6nbsDu29YhYrhfiStMicWn0HliZm9vjGjuEvLX9Kh4RgjAqXFt1BlPlXilFvi5I/AyfWTSjd6YbtoMstvY7PcmV+XxUAnLbWUxzNvQq1v92WKoywNFktT+fEbPH9abjZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198061; c=relaxed/simple;
	bh=OsQBIcaZV6hpTwnvHv8LU4FRqNY5U0nNux6t1Y82xgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHA5+F+2loMuDUhoGZhYBruEPsxI+dygVSXiIx5GXleVAOIg/eyiXHitoPjGoljJq59jqqRDzu32rylqFRajGbdXrf6z3rXPVUil9xQ1bYOgiV3xQAFCaO9cUUz5pxDOdqNo40jBdbwB3IQweshJbtOlioy29dX/wp4zWay2Ruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuXPKUUe; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720198060; x=1751734060;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OsQBIcaZV6hpTwnvHv8LU4FRqNY5U0nNux6t1Y82xgs=;
  b=MuXPKUUeKh/oE3BT2xNkFJ+ufW5ElrvUYqrT5651QgiPht0U+T9dbIe/
   aYIRxpoMV5m3DPb/Nzd6k9xVwJQYWyDU6KwZN2rshEy4p2MWVX6sJVB8r
   rndssuUfoPCvkS5FEL/H1aZXcD3Es4DbYGDBlL6WLl2YbSxXNBxfC10jt
   p93Vr1wbDLLCT71jhcDr5ZTUYy5JCHCax7Q4ehO/Zl4AZ08zgCZNLeQTF
   pxvLUqxpWe85dsmVT3GzFx+gK+MMpLxxV9znMwtb+sZ02eVtLrCsmZNwu
   CSjxmw/dOeHwYC15c3k66QLUFNp4iVnE8mbjwgi326GtNgcwyL3K6HAOF
   Q==;
X-CSE-ConnectionGUID: 9xRrBFTbTgWW6icyBUWiQg==
X-CSE-MsgGUID: Qm4maWsqQuWhwUvIcYw6OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17628106"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="17628106"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 09:47:39 -0700
X-CSE-ConnectionGUID: UkTg0KnjTTuxoPQWrXhqUA==
X-CSE-MsgGUID: fEMJnxKyRw6GT8EREbUC1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="47570619"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.38.162]) ([10.247.38.162])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 09:47:35 -0700
Message-ID: <faabc72b-b421-48c7-93cb-b2fe65655989@linux.intel.com>
Date: Sat, 6 Jul 2024 00:47:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v1 3/4] igc: Remove unused qbv_count
To: Simon Horman <horms@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com>
 <20240702040926.3327530-4-faizal.abdul.rahim@linux.intel.com>
 <20240703151008.GP598357@kernel.org>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20240703151008.GP598357@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/7/2024 11:10 pm, Simon Horman wrote:
> On Tue, Jul 02, 2024 at 12:09:25AM -0400, Faizal Rahim wrote:
>> Removing qbv_count which is now obsolete after these 2 patches:
>> "igc: Fix reset adapter logics when tx mode change"
>> "igc: Fix qbv_config_change_errors logics"
>>
>> The variable qbv_count serves to indicate whether Taprio is active or if
>> the tx mode is in TSN (IGC_TQAVCTRL_TRANSMIT_MODE_TSN). This is due to its
>> unconditional increment within igc_tsn_enable_offload(), which both runs
>> Taprio and sets the tx mode to TSN.
>>
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> 
> Hi Faizal,
> 
> This change looks good to me.
> However, it seems more appropriate as a clean-up for iwl-next
> once the previous to patches make it there via iwl-net.
> 
> That notwithstanding,
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> ...

Got it, will do that.
Thanks.

