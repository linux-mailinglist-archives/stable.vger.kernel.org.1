Return-Path: <stable+bounces-89492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFE59B9243
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 14:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EDC283109
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 13:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90B1A00DF;
	Fri,  1 Nov 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7bBA/GN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237F7168DA
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468663; cv=none; b=Esar0TjAPRFzCzTLChz8FTX10bHUkTMrQ1+eyjGUWWlipNSSa+rz5kO+m+WSvv07ywPP2K47BZSV0ZcFoycy10oa6xn/RJMRPOXn57D2QL2Tp75gsZ8SJVMQ2OkMda0oaeH4dWyShcAxE1blD0tPsC3mtbjpqdDp6fuiPjEYtvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468663; c=relaxed/simple;
	bh=67HjPmbKYCAr4uQ095Emn6CUZGx1r07vJjgEtU/0ZfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCB8bHUc3k3GodevixfdHpqRmcNYJ1nUNT4iIRmA4OIi38FgjQGnUzbX0p5zpcfDnDAVLp+tbGAHDzeIAJ1Ii4OEoG3Kl2+hyXmw09Io7ufOXAEM+3IfopdwJZIO6lnv715qNMc0c8GLQAnq8Hgt51mrF/Zxz+Hr0lszwZQfSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7bBA/GN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730468661; x=1762004661;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=67HjPmbKYCAr4uQ095Emn6CUZGx1r07vJjgEtU/0ZfA=;
  b=L7bBA/GN+nTn1v5tEfFGo06Q3mnIhuifRtbfs4MMTmyVOdW2GZwhMLpF
   pqReellubll/oCSEi1miQDYO/KvehuJbIojEtQZhqgkJ6BrfuT7av59ls
   i+qDDiGXo6d15KqgJkXK36ufnQa+WfWW8GqfR/Q/CAU/SmPNqHVsOEZdC
   gL2n1E/oFJtzh+S4OeBVirGXAt0qTkNCtWkWZwRO/XEFPVxnbLaKbD/TU
   CNKpCJ9/9hHuI2aXLkz9CV8nZHuSzXvdO2R+2WQEqbUVMU3fcY1NaZ9Rq
   HogcPcnScP16dO7z/yWD+UiK4mzvFiU2FvcL4kydbllEJBouRJtXbZY4J
   w==;
X-CSE-ConnectionGUID: 1Z2wRM22TBC8tX/IXyNaRw==
X-CSE-MsgGUID: Id+wlJv8Smefvz73zVMIQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52799911"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52799911"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:44:20 -0700
X-CSE-ConnectionGUID: 1Icn4DtZQ8KDsztBkXvUSA==
X-CSE-MsgGUID: oaKBJx1ySTSLQNqmox2+9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="113750397"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.245.196.144]) ([10.245.196.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:44:17 -0700
Message-ID: <65a8fa25-0c14-4251-ad22-8f4b31be0d4e@linux.intel.com>
Date: Fri, 1 Nov 2024 14:44:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] drm/xe: Move LNL scheduling WA to xe_device.h
To: Matthew Auld <matthew.auld@intel.com>, Nirmoy Das <nirmoy.das@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Badal Nilawar <badal.nilawar@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, stable@vger.kernel.org,
 John Harrison <John.C.Harrison@Intel.com>
References: <20241029120117.449694-1-nirmoy.das@intel.com>
 <afd4adf1-5220-40ff-816e-da588b74fadc@intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <afd4adf1-5220-40ff-816e-da588b74fadc@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/1/2024 2:21 PM, Matthew Auld wrote:
> On 29/10/2024 12:01, Nirmoy Das wrote:
>> Move LNL scheduling WA to xe_device.h so this can be used in other
>> places without needing keep the same comment about removal of this WA
>> in the future. The WA, which flushes work or workqueues, is now wrapped
>> in macros and can be reused wherever needed.
>>
>> Cc: Badal Nilawar <badal.nilawar@intel.com>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> cc: <stable@vger.kernel.org> # v6.11+
>> Suggested-by: John Harrison <John.C.Harrison@Intel.com>
>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>


Thanks for reviewing the series, Matt!


