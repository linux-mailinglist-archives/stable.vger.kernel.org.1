Return-Path: <stable+bounces-116404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031E8A35DA4
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 13:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444E83AAEE7
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 12:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4016E263F26;
	Fri, 14 Feb 2025 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSU7iI3+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B20C25D548;
	Fri, 14 Feb 2025 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536116; cv=none; b=f8fDSsT7y3SQN8zHIa1u3rha/zAeiOEFyRXL+RIh4qKWBexjeC3yQk3sAKBlOO5pYc3lweAW4w6+5ZMPV4qse8QlbUTu8q0OZG8v3JF1M0zOheH1MDJtGM6G8p/XDOJ4jCg/BrWaY1cqL/IhGZnzSH1QpPglmlZWXEeGlmKLjR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536116; c=relaxed/simple;
	bh=fRjc2nDr9iho6s/jktZVJtcoUCpu4hN+vZJ7QYt1dPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOG7JwNqOLUUV/TTfRoMeBAnb6jAnX9hbYwSdGqsTggSZbuAcjsyYvechjLWn6pJZyk2jh8T0mjKingvIDbCDURItGHEwW/kMnOHz4TZxo+lBKPfcuq94zAVpS0q9AmP3u7qSip/PcaKGcgTpPk8nj6dbaHqXITGPm9Xw6Wa6Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSU7iI3+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739536114; x=1771072114;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fRjc2nDr9iho6s/jktZVJtcoUCpu4hN+vZJ7QYt1dPs=;
  b=OSU7iI3+Vl+tIVDYr478Q6xDEbXuKAg0xDsZ03F7Wo8ODFFprQ8pK8Of
   v/gktMGs8vOq/cDm3IKNJcVWk9xc7+7KXMO5LictyDUeJVFZQ7PCVnuuL
   JEMnJn10incKucI83EHQTdeb6ncm7/zZZNgyM0AlIq7yPHKRYaIdjWdkl
   vkXYZ1S5TPpYmzivHX6y060M5YK8ysnS3S8AX+F7SpNeRsQBLaSy9nrCq
   ZjCdRTjGyu6wJVZqGcGSamQ5yUV7MEQ75NpjH01cOuLhMyx85nHK7h76i
   20eEe+EahE4Dv54/82cYbpGTLF4LuB/kBUFDwu6pG/b76RddhjQFByGgf
   g==;
X-CSE-ConnectionGUID: YixZC+9uS5iHZKmlKlH6iA==
X-CSE-MsgGUID: mDuOX+WxTcCVzCAq3PURmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40426124"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="40426124"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 04:28:33 -0800
X-CSE-ConnectionGUID: o1jYiYWASk2gp5QgoekvHA==
X-CSE-MsgGUID: vsF/i9AKQY++Chde4rj/aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118650552"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa005.jf.intel.com with ESMTP; 14 Feb 2025 04:28:32 -0800
Message-ID: <f2563e57-1982-4a64-a655-236dd4fff208@linux.intel.com>
Date: Fri, 14 Feb 2025 14:29:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] usb: xhci port capability storage change broke
 fastboot android bootloader utility
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Forest <forestix@nom.one>, linux-usb@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <hk8umj9lv4l4qguftdq1luqtdrpa1gks5l@sonic.net>
 <2c35ff52-78aa-4fa1-a61c-f53d1af4284d@linux.intel.com>
 <0l5mnj5hcmh2ev7818b3m0m7pokk73jfur@sonic.net>
 <3bd0e058-1aeb-4fc9-8b76-f0475eebbfe4@linux.intel.com>
 <4kb3ojp4t59rm79ui8kj3t8irsp6shlinq@sonic.net>
 <8a5bef2e-7cf9-4f5c-8281-c8043a090feb@linux.intel.com>
 <2tq7pj5g33d76j2uddbv5k8iiuakchso16@sonic.net>
 <ee229b33-2082-4e03-8f2b-df5b4a86a77d@linux.intel.com>
 <Z65U9rZrZUjofo02@eldamar.lan>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <Z65U9rZrZUjofo02@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.2.2025 22.24, Salvatore Bonaccorso wrote:
> Hi Mathias,
> 
> On Wed, Jan 29, 2025 at 01:01:58PM +0200, Mathias Nyman wrote:
>> On 24.1.2025 21.44, Forest wrote:
>>> On Mon, 13 Jan 2025 17:05:09 +0200, Mathias Nyman wrote:
>>>
>>>> I'd recommend a patch that permanently adds USB_QUIRK_NO_LPM for this device.
>>>> Let me know if you want to submit it yourself, otherwise I can do it.
>>>
>>> It looks like I can't contribute a patch after all, due to an issue with my
>>> Signed-off-by signature.
>>>
>>> So, can you take care of the quirk patch for this device?
>>>
>>> Thank you.
>>
>> Sure, I'll send it after rc1 is out next week
> 
> Not something superurgent, but wanted to ask is that still on your
> radaar? I stumpled over it while looking at the current open bugs
> reported in Debian, reminding me of https://bugs.debian.org/1091517

Yes, patch was here:
https://lore.kernel.org/linux-usb/20250206151836.51742-1-mathias.nyman@linux.intel.com/

Greg applied it to his tree today:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-linus&id=159daf1258227f44b26b5d38f4aa8f37b8cca663

Thanks
Mathias

