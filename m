Return-Path: <stable+bounces-33727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D16F891F56
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 16:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8012892BD
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3D1411C7;
	Fri, 29 Mar 2024 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3uI+5ks"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493ED140E3D
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718175; cv=none; b=Kd0iecDGtCE0DKArdyqOiSuYyJck+rXj+xStbBoXsNPvUgtDB02aeeaX1qIYYBj/d8z4TQuaTpjk+3LkuZRm1CQfay6/Fe8Sm5VXgvXh8RQKjdlPyZXuxdpNfvIoEJBnvLVQVwqJtgCltWaeBK3SV1KiXAh8JQs73ygnA5mxuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718175; c=relaxed/simple;
	bh=oq9hR9EqyvJL88vlCTaWnV8BbfIn/SdobapDJYlEb00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dowE6oowbOmaoe8jSQn+FV9iG1S29OSF0cOtPat1DNwx5NzuoRTVeGS8M0X7btPjJmJLGHsyHHHP0yXTeeIV+4e7tfWNav3VtB/xXfrZQnnpKJtGpTkRCfZEdt3kNMIRjvXRQxqWqfbZ/bZvpGzBchBx3k5bl5oGs5zvRrXZtlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3uI+5ks; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711718174; x=1743254174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oq9hR9EqyvJL88vlCTaWnV8BbfIn/SdobapDJYlEb00=;
  b=l3uI+5ks2WNFItP3QGbzaRIOZQo4wDWQdihRYSurN7e/j0l3SGwhDxQz
   wC9/ZepOMhIJBCLVAw4Ni174r+yWBKyeRqCXRIDM+3onbuaGO0wo0Ag14
   eLkuscxwqDjPPW+CHTCjo1OW3kUg2h38YcIADjdmDB1zjuKPNNUppWxii
   SMPOnRGZ3bGhK4vYeJBBGBu18MjYegjTCbpr4+MmwmJSVUrFslgh6o/bL
   wiUDpUlh70Ay9j8Jzi/cDa/NWngKbM9ZiXTPpkShA9+wzrlY145G/4jhe
   9juBMZOpZrP8EpzUKUrWzuabpnlos6qCpz7TdgwustX9ockcWYSLWT2x8
   g==;
X-CSE-ConnectionGUID: xGJbjysSSMCIxJhcgSJU+A==
X-CSE-MsgGUID: 5eD4qdXuSl6wRTRnJY5Rtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="24357851"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="24357851"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 06:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="21485628"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 06:16:12 -0700
Received: from [10.212.69.158] (kliang2-mobl1.ccr.corp.intel.com [10.212.69.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 952C4580E3A;
	Fri, 29 Mar 2024 06:16:10 -0700 (PDT)
Message-ID: <ed2715c2-d572-44c9-8b6c-0f897e5c8108@linux.intel.com>
Date: Fri, 29 Mar 2024 09:16:09 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.6 and 6.7 2/2] perf top: Uniform the event name
 for the hybrid machine
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, andrew.brown@intel.com,
 dave.hansen@linux.intel.com, Ian Rogers <irogers@google.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Hector Martin
 <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>
References: <20240308151239.2414774-1-kan.liang@linux.intel.com>
 <20240308151239.2414774-2-kan.liang@linux.intel.com>
 <2024032918-spruce-sapling-c829@gregkh>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <2024032918-spruce-sapling-c829@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

On 2024-03-29 9:09 a.m., Greg KH wrote:
> On Fri, Mar 08, 2024 at 07:12:39AM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> [The patch set is to fix the perf top failure on all Intel hybrid
>> machines. Without the patch, the default perf top command is broken.
>>
>> I have verified that the patches on both stable 6.6 and 6.7. They can
>> be applied to stable 6.6 and 6.7 tree without any modification as well.
>>
>> Please consider to apply them to stable 6.6 and 6.7. Thanks]
> 
> Already in the 6.6.23 and 6.7.11 releases.
> 

Thanks. I see this one (2/2) is merged.
Could you please also apply the first patch (1/2) as well? Without the
first one, the perf top still fails.

Thanks,
Kan

> thanks,
> 
> greg k-h

