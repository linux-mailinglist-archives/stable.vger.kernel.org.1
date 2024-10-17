Return-Path: <stable+bounces-86614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BAF9A2324
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 15:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BC51F20CCB
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCAD1DE2CF;
	Thu, 17 Oct 2024 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3ypqPW9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7CD1DE2B6;
	Thu, 17 Oct 2024 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170511; cv=none; b=U+fmxTuBv89gWlu1jiqT7n4/Uw9JTNhj+qUp4asWyWQTzvmybEQU17XPPDpNFf+Wa/TG5LJxGqxvrxZ1ns7o1Ywd1pUTQdrBA7izBZJgZKNn0EidAUqD4wImlxQPpOWcDNxTQ2uvgWqhDchKN+iZbjNGRn+TovTcy/KFuOJAl/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170511; c=relaxed/simple;
	bh=KI8IpkDA4rsz6+i5p8MLcjGQGumtY5C+/cAQpTRz0w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcKzktUyRwa/bSWHq915foa2woo9QrM7L1dvbizjupesY7RWnnjk2OxU2cA5Th7lyp34WeDVWAXoAy15MR5wMSKKqRLGXdLFHbO55vavtIm/pKpf5OGT9ooAcgMzrwXmk0fSLPt/FDwm5x5t3ZsUzBybqAiHPYadU6m6EEKvq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3ypqPW9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729170510; x=1760706510;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KI8IpkDA4rsz6+i5p8MLcjGQGumtY5C+/cAQpTRz0w0=;
  b=b3ypqPW9/6fuHm0hI4BBWJBXXcUw//CppUf7ZNMpWvTueCTyCVugSlOL
   MP+WewtfTWMIz71zTiGqTmAzvN+mtcmL15uZFrNseDd1pOmVu423AiQ4F
   xLqaFnQVlf/JllYeaz1iBU5xZjBGTsnQrlIrnN4AaWMFs1cWLHq5Ev4Ky
   HHzrDJiljKmco5UYdeaQj2ewo2VwZ7sAyZUSq6QAipT+ugb8SiIzUFHhD
   M3BjgGIPMVAsY36DoP03pARSAqVQCBG+4pJrw3paZ7SkCE7nQuESM3L+Q
   OigZkJfgipVZV8G4pGxMVKzenj/zCvj22J8DKfRaYym4UHGNbuA7tVtIL
   A==;
X-CSE-ConnectionGUID: B7mFVLDPRXiYJc/9POkRQw==
X-CSE-MsgGUID: 4kdP5bXBScSiukly2Odp3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="28745551"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="28745551"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 06:08:29 -0700
X-CSE-ConnectionGUID: l6bFCh3fQVKY7K2w59fNFw==
X-CSE-MsgGUID: YyzwQCMtSxKIE/KlM14LPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="101850280"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa002.fm.intel.com with ESMTP; 17 Oct 2024 06:08:28 -0700
Message-ID: <3a22e31a-12bc-4fdc-90d2-e09a7f9d067f@linux.intel.com>
Date: Thu, 17 Oct 2024 16:10:39 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] xhci: Mitigate failed set dequeue pointer commands
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org
References: <20241017084007.53d3fedd@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20241017084007.53d3fedd@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.10.2024 9.40, Michał Pecio wrote:
>> Avoid xHC host from processing a cancelled URB by always turning
>> cancelled URB TDs into no-op TRBs before queuing a 'Set TR Deq'
>> command.
>>
>> If the command fails then xHC will start processing the cancelled TD
>> instead of skipping it once endpoint is restarted, causing issues like
>> Babble error.
>>
>> This is not a complete solution as a failed 'Set TR Deq' command does
>> not guarantee xHC TRB caches are cleared.
> 
> Hmm, wouldn't a long and partially cached TD basically become corrupted
> by this overwrite?

Unlikely but not impossible.
We already turn all cancelled TDs that we don't stop on into no-ops, so those
would already now experience the same problem.

We stopped the endpoint, and issued a 'Set TR deq' command which is supposed
to clear xHC TRB cache.  I find it hard to believe xHC would continue
by caching some select TRBs of a TD to cache.

But lets say we end up corrupting the TD. It might still be better than
allowing xHC to process the TRBs and write to DMA addresses that might be
freed/reused already.
   
> 
> For instance, No Op following a chain bit TRB is prohibited by 4.11.7.
> 
> 4.11.5.1 even goes as far as saying that there are no constraints on
> the order in which TRBs are fetched from the ring, not sure how much
> "out of order" it can be and if a cached TD could be left with a hole?
> 
> If the reason of Set TR Deq failure is an earlier Stop Endpoint failure,
> the xHC is executing this TD right now. Or maybe the next one - I guess
> the driver already risks UB when it misses any Stop EP failure.
> 
> If it didn't fail, xHC may store some "state" which allows it to restart
> a TRB stopped in the middle. It might not expect the TRB to change.

This should not be an issue.
We don't queue a 'Set TR Deq' command if we intend to continue processing
a stopped TD, as the 'Set TR Deq' is designed to dump all transfer related
state of the endpoint.

> 
> 
> Actually, it would *almost* be better to deal with it by simply leaving
> the TRB on the ring and waiting for it to complete. Problem is when it
> doesn't execute soon, or ever, leaving the urb_dequeue() caller hanging.

We need to give back the cancelled URB at some point, and 'Set TR Deq'
command completion is the latest reasonable place to do it.

After this we should prevent xHC hw from accessing URB DMA pointers.

Thanks
Mathias


