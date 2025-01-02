Return-Path: <stable+bounces-106653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADD79FFA47
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 15:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 318347A1200
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 14:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD4E1B3934;
	Thu,  2 Jan 2025 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkcAXPpL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8E51AF0CB;
	Thu,  2 Jan 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827163; cv=none; b=oevptllAUx7DmvvbypJvSPNZzMIltEjpq0FQBd8mTIKDVqGN8iVxCcV5VENDUO+ijguMG/STfo20Q9/d2ovC2fZHZ9QZLTaVtXn6EjI6ubJVWDsaI8ND1lLepbB4kaUMnM818DfqqVQjAa837C4IJVDH2MnA1lwl4GDExdYr+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827163; c=relaxed/simple;
	bh=OVHKWKqhT6GNOOLRLFZpB0wvxkRFdS/qQP80q6FshX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnOdpPSQUdqvfMBVl7ufCrQWcI9w7QKBqR4n0ZW0F85QtDEQrPo0MX4RxDJzGMaqd6mmsx+LeELVHOO5n6v1VaYhQStaKbuNe/bCJAOBwjY1Kn4+BMLT8mQS3+FGzKoHFbA+ysS5w8nAmaRRQ2rERex963K7/xXFeTu/fBQkxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkcAXPpL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827162; x=1767363162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OVHKWKqhT6GNOOLRLFZpB0wvxkRFdS/qQP80q6FshX4=;
  b=HkcAXPpL1M6eA+4FBpMMhbE0moj5b08fMdtmEKpfhyklwdMv4rF7+kIz
   FiQnAA7mEafoVafW0JypunejiKt7H1KUjQ6V0n++vsMYWYECrAbSF72aC
   VnVRPPi3gpRvnIqLLPCWG4g9jACttQYkaht6kSms/cxj/KU5ERfgzweat
   vE9rMxTDuLcY/ewKdeNAT0vB3ZzaUrs7AYIZc/tERdUMjnHWBDX9YeZSb
   YMGZU2iWgXMHCTCrHkv8hkOAtIdQv3XYyz5bvOZpTFJKn2d6vhUZZJEsj
   00/d9d1ByitnIGO3hx/y2xYortACeVdhw6PWl7HWEM70B4GqFIoHfsCRj
   A==;
X-CSE-ConnectionGUID: K0K9zxHJT66oTpW/f7vbzg==
X-CSE-MsgGUID: Cfjg3LgaQ/WdMWdun1wfkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="35940210"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="35940210"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:12:42 -0800
X-CSE-ConnectionGUID: wCF5exS/SSGCBe8VcgXFjQ==
X-CSE-MsgGUID: /lSz7rZIQWK2/i5Ed3duBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="101299585"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa006.fm.intel.com with ESMTP; 02 Jan 2025 06:12:39 -0800
Message-ID: <2c35ff52-78aa-4fa1-a61c-f53d1af4284d@linux.intel.com>
Date: Thu, 2 Jan 2025 16:13:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] usb: xhci port capability storage change broke
 fastboot android bootloader utility
To: Forest <forestix@nom.one>
Cc: linux-usb@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <hk8umj9lv4l4qguftdq1luqtdrpa1gks5l@sonic.net>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <hk8umj9lv4l4qguftdq1luqtdrpa1gks5l@sonic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 27.12.2024 23.59, Forest wrote:
> #regzbot introduced: 63a1f8454962
> 
> Dear maintainer,
> 
> I think I have found a regression in kernels version 6.10 and newer,
> including the latest mainline v6.13-rc4:
> 
> fastboot (the tool for communicating with Android bootloaders) now fails to
> perform various operations over USB.
> 
> The problem manifests as an error when attempting to 'fastboot flash' an
> image (e.g. a new kernel containing security updates) to a LineageOS phone.
> It also manifests with simpler operations like reading a variable from the
> bootloader. For example:
> 
>    fastboot getvar kernel
> 
> A typical error message when the failure occurs:
> 
>    getvar:kernel  FAILED (remote: 'GetVar Variable Not found')
> 
> I can reproduce this at will. It happens about 50% of the time when I
> run the above getvar command, and almost all the time when I try to push
> a new kernel to a device.
> 
> A git bisect reveals this:
> 
> 63a1f8454962a64746a59441687dc2401290326c is the first bad commit
> commit 63a1f8454962a64746a59441687dc2401290326c
> Author: Mathias Nyman <mathias.nyman@linux.intel.com>
> Date:   Mon Apr 29 17:02:28 2024 +0300
>      xhci: stored cached port capability values in one place

It's not clear to me why this patch would cause regression.

Could you enable xhci and usb core dynamic debug before connecting the
device, and then share dmesg after the issue is triggered.

dmesg of a working case would also be good to have for comparison.

mount -t debugfs none /sys/kernel/debug
echo 'module xhci_hcd =p' >/sys/kernel/debug/dynamic_debug/control
echo 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control
< Reproduce issue >
Send output of dmesg

Thanks
Mathias



