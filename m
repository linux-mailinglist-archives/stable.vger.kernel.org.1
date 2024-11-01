Return-Path: <stable+bounces-89491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A613C9B91EA
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 14:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DCEB2392C
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4094315F40B;
	Fri,  1 Nov 2024 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Slww6ePi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D642381B9
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467324; cv=none; b=j+r80HJ1Wf8Gr8rlpR2p3eLfLWaNIG6CPkgxsfvljIkrkzQzZY0TE5B+IxNR0int9PcBcU1e/hvyTjyIeSxMftKkwN7uXOtGeusMl7n5hjo4k3zbO6qDJqnUiPb4zDVku0A0Ea5RKx/oSI7JaWvKGatVSIz6CjJOjmCx5RDhilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467324; c=relaxed/simple;
	bh=sl65pNdL+vhy6fiRdH8AVzPc+fTP4JD7HNRvpzPQJEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiSIpG9GIPqe7R6k1/YKTp5LY0S1kJkQ0tZeQb5CbZg2ZuQ7edwC+CX61t0dfGXgv66NNpvj4hxlC37+kAIWS/pMaxdfUGm5Bw1WlEDdMs8Nx9tMx/SG4L6MWxY1vUNPWGoixxRJIwySNFTfLpV4Li8G+9xc1ghRwoMn6Q1sWpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Slww6ePi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730467322; x=1762003322;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sl65pNdL+vhy6fiRdH8AVzPc+fTP4JD7HNRvpzPQJEU=;
  b=Slww6ePiaZBzTNhjMMatupLClMD19hwANaINsgQI8BpjW3bO5d7+VeY7
   da08OONkT4T2u6N5qJzPbVVlSgQeDAxfi7vlVTcvLXwjch6SdzRKwAh8g
   eZ/WREC9CGLskhKC0EKgvi/Oibc3b6x6qG3+0TnjiAIhT8AWQISEQnTMw
   7NkMxVI+W9H8vvymioAoSeZrxiUhOfYfgnAUx6sCe/SKUFZc4XvZQomLE
   9LYuSJeeIy4PD8qKaW7ROI15Ls3sCSUfNdOU1ByLB7Ek+3hJfwM/MydVb
   Agbe02LAbLaSi34PAN4J5mEH58Rmt2VCQkBrrDUVXUnou6iggTyZ3DHZd
   g==;
X-CSE-ConnectionGUID: a/wQu6GGSfO6fxfJpWrDAA==
X-CSE-MsgGUID: iAkvvF5fQkmykSkwBA37mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="40814699"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="40814699"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:22:01 -0700
X-CSE-ConnectionGUID: pLeL0BrdSA+dwV7JmSiRdQ==
X-CSE-MsgGUID: 4aXaXWmsTdudMqTOwUSHCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="82645265"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO [10.245.244.34]) ([10.245.244.34])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:22:00 -0700
Message-ID: <afd4adf1-5220-40ff-816e-da588b74fadc@intel.com>
Date: Fri, 1 Nov 2024 13:21:57 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] drm/xe: Move LNL scheduling WA to xe_device.h
To: Nirmoy Das <nirmoy.das@intel.com>, intel-xe@lists.freedesktop.org
Cc: Badal Nilawar <badal.nilawar@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, stable@vger.kernel.org,
 John Harrison <John.C.Harrison@Intel.com>
References: <20241029120117.449694-1-nirmoy.das@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20241029120117.449694-1-nirmoy.das@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2024 12:01, Nirmoy Das wrote:
> Move LNL scheduling WA to xe_device.h so this can be used in other
> places without needing keep the same comment about removal of this WA
> in the future. The WA, which flushes work or workqueues, is now wrapped
> in macros and can be reused wherever needed.
> 
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> cc: <stable@vger.kernel.org> # v6.11+
> Suggested-by: John Harrison <John.C.Harrison@Intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>

