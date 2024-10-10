Return-Path: <stable+bounces-83360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3080998898
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 16:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7191C23C27
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 14:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776DC1C9DD8;
	Thu, 10 Oct 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/52gZ+O"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC51BDA90
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568889; cv=none; b=NbTuwrF8LbI/pbT21+L45BChQOl+SLV/j+lDX9OvAXMCSokSZ8UwMuGvz7JFFngHJfk5LyBVT3/37Lz7yOM27By+LSNGtzd9O1PZW0ECkgYRoCVbuFKI1qczWsDMgCMMzzn6aEMd/sMuerou0sr0Y4P3lsefm0vmu6I3anJjS2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568889; c=relaxed/simple;
	bh=Zbm+qJJQ0R/QF9HbWCros9cHGg4g9SG4o5soieW3Cs8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IHuiRMsujp3bBuvWiSL2ui9RstA2+cx2jZcJApUyI5AKQEwJEiN5Gzc+KiM3PGHm3iPTlqn1muHfDQf59lGjka7IDF/Oa8GP0KAx6Sh3Sbw3Mq9G2Y52UKXdcTdZD1hJ8zpi/XtqxHAfEmzCxXcK86spduzU/m3yc+kvXTpxbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/52gZ+O; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728568887; x=1760104887;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zbm+qJJQ0R/QF9HbWCros9cHGg4g9SG4o5soieW3Cs8=;
  b=C/52gZ+OrqhD6PG5oNyIULIdokrHc8W5i1/hX9ZP9Ojc7SUSIMboq3vv
   py1EIksmp6IZSoTEAOvnO7w7W2uk137j5y0mqWVY8I+1NS98YvswSX06l
   IFcFQQzD9vW0JRCmawHKqshsF+pBk0oIKAghCTq+NZCk4MrhgOTbmntKw
   +/9DeXiYHJINSIGARXC5yNej0bsAGURDXEdf3BSdB1r/tYpCYfohZYtx3
   ZOH4INn0ldVxBf4g/NvQpmo8cLLbfgfPAkRq0abWBK+2WezculgFVEqEP
   DgjNUh5jfmoPLWH6kRdGmHmTso4NtEqozZa2VWtpZHdCcZqizrRHjCAL2
   A==;
X-CSE-ConnectionGUID: l67qa5CpSZiFrsQypBoiLg==
X-CSE-MsgGUID: bsKP1lWdQtunN7y5NMqEeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="39294269"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="39294269"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:00:38 -0700
X-CSE-ConnectionGUID: GNCH3032S/aRj9wYpsoRfQ==
X-CSE-MsgGUID: 85AxBxU4SRG4yJXvH7a47Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76911442"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:00:24 -0700
Message-ID: <9539f133-2cdb-4aa8-8eac-ddf649819d98@linux.intel.com>
Date: Thu, 10 Oct 2024 22:00:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, stable <stable@vger.kernel.org>,
 jroedel@suse.de, Sasha Levin <sashal@kernel.org>, x86@kernel.org
Subject: Re: [regression]Boot Hang on Kernel 6.1.83+ with Dell PowerEdge R770
 and Intel Xeon 6710E
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Greg KH <gregkh@linuxfoundation.org>
References: <CAMGffE=dPofoPD_+giBnAC66-+=RqRmO2uBmC88-Ph1RgGN=0Q@mail.gmail.com>
 <2024101006-scanner-unboxed-0190@gregkh>
 <CAMGffE=HvMU4Syy7ATEevKQ+izAvndmpQ8-F9HN_WM+3PKwWyw@mail.gmail.com>
 <2024101000-duplex-justify-97e6@gregkh>
 <CAMGffE=xSDZ8Ad9o7ayg2xwnMyPDojyBDh_AHf+h7WBV7y630w@mail.gmail.com>
 <635be050-f0ab-4242-ac79-db67d561dae9@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <635be050-f0ab-4242-ac79-db67d561dae9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/10 21:25, Liang, Kan wrote:
> On 2024-10-10 6:10 a.m., Jinpu Wang wrote:
>> Hi Greg,
>>
>>
>> On Thu, Oct 10, 2024 at 11:31 AM Greg KH<gregkh@linuxfoundation.org> wrote:
>>> On Thu, Oct 10, 2024 at 11:13:42AM +0200, Jinpu Wang wrote:
>>>> Hi Greg,
>>>>
>>>> On Thu, Oct 10, 2024 at 11:07 AM Greg KH<gregkh@linuxfoundation.org> wrote:
>>>>> On Thu, Oct 10, 2024 at 09:31:37AM +0200, Jinpu Wang wrote:
>>>>>> Hello all,
>>>>>>
>>>>>> We are experiencing a boot hang issue when booting kernel version
>>>>>> 6.1.83+ on a Dell Inc. PowerEdge R770 equipped with an Intel Xeon
>>>>>> 6710E processor. After extensive testing and use of `git bisect`, we
>>>>>> have traced the issue to commit:
>>>>>>
>>>>>> `586e19c88a0c ("iommu/vt-d: Retrieve IOMMU perfmon capability information")`
>>>>>>
>>>>>> This commit appears to be part of a larger patchset, which can be found here:
>>>>>> [Patchset on lore.kernel.org](https://lore.kernel.org/ 
>>>>>> lkml/7c4b3e4e-1c5d-04f1-1891-84f686c94736@linux.intel.com/T/)
>>>>>>
>>>>>> We attempted to boot with the `intel_iommu=off` option, but the system
>>>>>> hangs in the same manner. However, the system boots successfully after
>>>>>> disabling `CONFIG_INTEL_IOMMU_PERF_EVENTS`.
>>>>> Is there any error messages?  Does the latest 6.6.y tree work properly?
>>>>> If so, why not just use that, no new hardware should be using older
>>>>> kernel trees anyway 🙂
>>>> No error, just hang, I've removed "quiet" and added "debug".
>>>> Yes, the latest 6.6.y tree works for this, but there are other
>>>> problems/dependency we have to solve.
>>> Ok, that implies that we need to add some other patch to 6.1.y, OR we
>>> can revert it from 6.1.y.  Let me know what you think is the better
>>> thing to do.
>>>
>> I think better to revert both:
>> 8c91a4bfc7f8 ("iommu: Fix compilation without CONFIG_IOMMU_INTEL")
> I'm not sure about this one. May need baolu's comments.

I can't find this commit in the mainline kernel. I guess it fixes a
compilation issue in the stable tree? If so, it depends on whether the
issue is still there.

Thanks,
baolu

