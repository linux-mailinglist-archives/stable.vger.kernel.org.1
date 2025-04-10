Return-Path: <stable+bounces-132078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90967A83EE3
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 11:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5E19E18A9
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 09:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136D02571BA;
	Thu, 10 Apr 2025 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DH9bbBxr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91EB256C90;
	Thu, 10 Apr 2025 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744277318; cv=none; b=p1nfwjvi/FheLGrGB4e1PHZv5CXFUZp60iO+tHdqascNkBVWV03nCt+eRwGQJrBvXeb+zRdIhlidtEZ9wf26/qos997NW6sWYQ6YRuEmHxUOh4wBT64ABa0auBqGjY8AzIY1+YKvhGwdB4sQCWc/qLg1pFyg3xVosvIa4cEM7Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744277318; c=relaxed/simple;
	bh=SPlSdN2gYFFkaeYx3wI2cVeA5iCWnjK1bIIn+mR/MWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fq6BF2XjqPaDFnEMFlqR1gFVEJt24QD4JjQI2jNked5LAtSJ8msK48OnGLb31b3Dhk9KyTa27yB1Qi8fHFRkXfmRGcmGiMhi1UfZGOAXXj0FJGjf8cnTb0+xEcr20GgOtEYfu4bcJ7b2G+v+0w2rm4WqMXEw/mwSHeSMw3W10os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DH9bbBxr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744277316; x=1775813316;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SPlSdN2gYFFkaeYx3wI2cVeA5iCWnjK1bIIn+mR/MWs=;
  b=DH9bbBxrhu4YfD9QXnB16xVae48SaTOCueuULcedC1BYHCYwEAak+JWh
   Hu4DcZBzq7FI8jW/iIAInYP3kLZ5k+s0W1P4cjwVNEgKsovsfXBYPzjwW
   jJ64KyBhChZEebSWknQ8AktAtPKLtzC+WflF5f24te9ZEHevZ79Mmn8j2
   TWg9P4w+94GQ+Z7Ztpx0oTAmYHCQZAVrunG/bEIjEUhWZu0ukM3bM/sh0
   I5LjZQbXCLTJGkNFov8Ozd1mca0elUrZxldaiqMHp8AjN2WZgox3cp95k
   p0iXLc6NDHqiiazRd+Uli8hyu9JkQSf8TyqgcGtNhcSbKK2H7xJJROvDG
   Q==;
X-CSE-ConnectionGUID: jli9ZyHaQN607HngNpFeiQ==
X-CSE-MsgGUID: lZ8NmSLiQNWQdE8CKy1PYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="57168207"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="57168207"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:27:37 -0700
X-CSE-ConnectionGUID: abz7UXdRS6W2DsU4AlI4/A==
X-CSE-MsgGUID: 6CE/erL6SNGiu35pCr4KCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="152025459"
Received: from kwywiol-mobl1.ger.corp.intel.com (HELO [10.245.83.152]) ([10.245.83.152])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:27:36 -0700
Message-ID: <bd5308eb-57a3-4484-8be6-b41ee30233ae@linux.intel.com>
Date: Thu, 10 Apr 2025 11:27:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add handling of
 VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Karol Wachowski <karol.wachowski@intel.com>
References: <20250408095711.635185-1-jacek.lawrynowicz@linux.intel.com>
 <8d96c75d-e8fb-446b-a85c-803a2b5212ed@linux.intel.com>
 <2025041011-borrowing-shrug-781e@gregkh>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <2025041011-borrowing-shrug-781e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/10/2025 10:03 AM, Greg Kroah-Hartman wrote:
> On Thu, Apr 10, 2025 at 09:49:37AM +0200, Jacek Lawrynowicz wrote:
>> Hi,
>>
>> This is an important patch for the Intel NPU.
>> Is there anything it is missing to be included in stable?
> 
> Patience, you only sent this:
> 
>> On 4/8/2025 11:57 AM, Jacek Lawrynowicz wrote:
> 
> 2 days ago, AFTER the latest of -rc releases was sent out for review,
> and those kernels have NOT even been released yet!
> 
> [rant about how you all know this process works deleted as it was
>  just snarky on my side, although quite cathartic, thanks for letting me
>  vent...]
> 
> Relax, it will get handled when we can get to it.  To help out, please
> take the time to review pending stable backported patches that have been
> submitted to the mailing list ahead of yours.

Yeah, sorry about that. It seems I'm still learning the art of patience in the kernel processes.
I didn't mean to rush anything. I was just worried my patch might have been overlooked due to a typo or a wrong commit message tag.

I'll make sure to review the backported patches in the meantime.

And thanks for holding back on the rant. I really think that the standard set by Linus is not healthy.

Regards,
Jacek


