Return-Path: <stable+bounces-83355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17112998792
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 15:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979F91F2335A
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 13:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF881C9B6D;
	Thu, 10 Oct 2024 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aoPxQ75l"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FFA1C2457
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566749; cv=none; b=WiRxgjkJNnk1M6NJzOx97VOMU1CegMODrTsNccFNnvBgarr0pZPLFagPYR1KLk7h2N4gEhKBmaNgKP3bzItEB4jkfVOtMuMYpHLDON1RNJ0nxy1aA7K74G210Gv9OnEiJWweXBFD6m5WM7Z+BP2KrI7z637JNvfCewA4AMQAOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566749; c=relaxed/simple;
	bh=SSm8FMcKQN9aEzadseoH+Ari2ZrNiHPVUKInNqS7OeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hw8Vv3cd2/LO/4vxjECRLu+Sxi7GXxUhp75XuNvwQ4pjnmyXW9qiav19YOTWPcaeMglIlcmXYcK7i94DFwZx//X05z6s8H70PcHSGYUzgxZa6/AcZjr7Izbsh7LLJ6OVbGazPrnNfF5pwD15OzYtmMvSC1MKNrgntoDTdAykvw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aoPxQ75l; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728566748; x=1760102748;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SSm8FMcKQN9aEzadseoH+Ari2ZrNiHPVUKInNqS7OeM=;
  b=aoPxQ75lnU0i/Mg2gp9z5geJE0RGC+AjPT6fPu8vH9F2ypWoHsbBlJJp
   OLwzIjbcIyLFmkBBByPMIPeHuAinngD6QDG74DpPYPAsQfSw/jYN0hkNE
   BuqVEEF+/e0HFbvoVuk8SbmS8CYznfpaqGtIb2shvbKbuJQUS2XwS+YWs
   bSIInJdtWdDKO9TwrMHVCnptsZ9A7yPsfw1Q7X9iUtLEqU7uwF0lV62XA
   KLfun8ec3MDSlpbVbtuAcLj/uYFfk1qU2hhclzvTRFUZnXxl4SOQ83bP6
   5T7MqMhD9GU6OaKjdkhygv/H01FNjLRRuDo+I9ehxN3niqAbX/DkymXAs
   Q==;
X-CSE-ConnectionGUID: zMH7QMUEQkiBHwT69HCqaQ==
X-CSE-MsgGUID: +kclub+ARY+Cg/pW1KoYFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27867062"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="27867062"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 06:25:48 -0700
X-CSE-ConnectionGUID: xsKVl7RoRCi03bsjZbAKTg==
X-CSE-MsgGUID: rB2RbH7ORnir0dGQr4PYig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76499389"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 06:25:48 -0700
Received: from [10.212.25.197] (kliang2-mobl1.ccr.corp.intel.com [10.212.25.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id F34C020B5782;
	Thu, 10 Oct 2024 06:25:46 -0700 (PDT)
Message-ID: <635be050-f0ab-4242-ac79-db67d561dae9@linux.intel.com>
Date: Thu, 10 Oct 2024 09:25:45 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression]Boot Hang on Kernel 6.1.83+ with Dell PowerEdge R770
 and Intel Xeon 6710E
To: Jinpu Wang <jinpu.wang@ionos.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, baolu.lu@linux.intel.com,
 jroedel@suse.de, Sasha Levin <sashal@kernel.org>, x86@kernel.org
References: <CAMGffE=dPofoPD_+giBnAC66-+=RqRmO2uBmC88-Ph1RgGN=0Q@mail.gmail.com>
 <2024101006-scanner-unboxed-0190@gregkh>
 <CAMGffE=HvMU4Syy7ATEevKQ+izAvndmpQ8-F9HN_WM+3PKwWyw@mail.gmail.com>
 <2024101000-duplex-justify-97e6@gregkh>
 <CAMGffE=xSDZ8Ad9o7ayg2xwnMyPDojyBDh_AHf+h7WBV7y630w@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAMGffE=xSDZ8Ad9o7ayg2xwnMyPDojyBDh_AHf+h7WBV7y630w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-10-10 6:10 a.m., Jinpu Wang wrote:
> Hi Greg,
> 
> 
> On Thu, Oct 10, 2024 at 11:31 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Oct 10, 2024 at 11:13:42AM +0200, Jinpu Wang wrote:
>>> Hi Greg,
>>>
>>> On Thu, Oct 10, 2024 at 11:07 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Thu, Oct 10, 2024 at 09:31:37AM +0200, Jinpu Wang wrote:
>>>>> Hello all,
>>>>>
>>>>> We are experiencing a boot hang issue when booting kernel version
>>>>> 6.1.83+ on a Dell Inc. PowerEdge R770 equipped with an Intel Xeon
>>>>> 6710E processor. After extensive testing and use of `git bisect`, we
>>>>> have traced the issue to commit:
>>>>>
>>>>> `586e19c88a0c ("iommu/vt-d: Retrieve IOMMU perfmon capability information")`
>>>>>
>>>>> This commit appears to be part of a larger patchset, which can be found here:
>>>>> [Patchset on lore.kernel.org](https://lore.kernel.org/lkml/7c4b3e4e-1c5d-04f1-1891-84f686c94736@linux.intel.com/T/)
>>>>>
>>>>> We attempted to boot with the `intel_iommu=off` option, but the system
>>>>> hangs in the same manner. However, the system boots successfully after
>>>>> disabling `CONFIG_INTEL_IOMMU_PERF_EVENTS`.
>>>>
>>>> Is there any error messages?  Does the latest 6.6.y tree work properly?
>>>> If so, why not just use that, no new hardware should be using older
>>>> kernel trees anyway :)
>>> No error, just hang, I've removed "quiet" and added "debug".
>>> Yes, the latest 6.6.y tree works for this, but there are other
>>> problems/dependency we have to solve.
>>
>> Ok, that implies that we need to add some other patch to 6.1.y, OR we
>> can revert it from 6.1.y.  Let me know what you think is the better
>> thing to do.
>>
> I think better to revert both:
> 8c91a4bfc7f8 ("iommu: Fix compilation without CONFIG_IOMMU_INTEL")

I'm not sure about this one. May need baolu's comments.

> 586e19c88a0c ("iommu/vt-d: Retrieve IOMMU perfmon capability information")
>

7 patches are required to enable the IOMMU perfmon.
https://lore.kernel.org/all/20230128200428.1459118-1-kan.liang@linux.intel.com/
But it looks like only the above 1 patch is back ported to the 6.1.y.
Unless we can back port the rest of 6 patches, I think it should be ok
to revert it for 6.1.y.

Thanks,
Kan


> unless other guys have a different opinon.
>> thanks,
>>
>> greg k-h
> Thanks!


