Return-Path: <stable+bounces-3886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09034803648
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 15:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85754B2096B
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F9828DA7;
	Mon,  4 Dec 2023 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaCT2Z3a"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899BDA4;
	Mon,  4 Dec 2023 06:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701699677; x=1733235677;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=S/q+3vorDfPpthd0q6uZxtoV7s+8c0tIQjUWqprsjHc=;
  b=SaCT2Z3aoLZhoVgz6DYtvnpC+sjJNETTu9f2OtMDaxHX3+HJMsHja7gE
   zbtPb8koGtTX3SDIvDooHYxlPTvKwnvPhSwxN0AE+h6RSAX4NI8Q/iP0O
   /5vvCaIatDNERyi7gMddAAg9yVClda5qfj33SDZl8VHgJEXjnS3NnJhFG
   8xdAAvsFurzvAwYaWnJHjH6CW9nzmWxiqEnSGNfrC8qOy4upmXD7r+qU7
   WxhVmOLi6+Q+8+jnWdKI3h4mnAlt2u3PhrPZ0+yeRqNIHLQDv6GWW3o1H
   5ubyReT2flmW6++xXNpa36YCZmAzFh5iQ3jJG3s03RmVCLfZzVmYxaLIF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="460233418"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="460233418"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 06:21:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="861391915"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="861391915"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2023 06:21:14 -0800
Message-ID: <db579656-5700-d99b-f1eb-c1e27749eb7b@linux.intel.com>
Date: Mon, 4 Dec 2023 16:22:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Basavaraj Natikar <bnatikar@amd.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 mario.limonciello@amd.com, regressions@lists.linux.dev,
 regressions@leemhuis.info, Basavaraj.Natikar@amd.com, pmenzel@molgen.mpg.de,
 bugs-a21@moonlit-rail.com, stable@vger.kernel.org
References: <3d3b8fd3-a1b9-9793-b709-eda447ebd1ab@linux.intel.com>
 <20231204100859.1332772-1-mathias.nyman@linux.intel.com>
 <070b3ce1-815c-4f3d-af09-e02cda8f9bf0@amd.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH 1/2] Revert "xhci: Enable RPM on controllers that support
 low-power states"
In-Reply-To: <070b3ce1-815c-4f3d-af09-e02cda8f9bf0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4.12.2023 12.49, Basavaraj Natikar wrote:
> 
> On 12/4/2023 3:38 PM, Mathias Nyman wrote:
>> This reverts commit a5d6264b638efeca35eff72177fd28d149e0764b.
>>
>> This patch was an attempt to solve issues seen when enabling runtime PM
>> as default for all AMD 1.1 xHC hosts. see commit 4baf12181509
>> ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")
> 
> AFAK, only 4baf12181509 commit has regression on AMD xHc 1.1 below is not regression
> patch and its unrelated to AMD xHC 1.1.
> 
> Only [PATCH 2/2] Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"
> alone in this series solves regression issues.
> 

Patch a5d6264b638e ("xhci: Enable RPM on controllers that support low-power states")
was originally not supposed to go to stable. It was added later as it solved some
cases triggered by 4baf12181509 ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")
see:
https://lore.kernel.org/linux-usb/5993222.lOV4Wx5bFT@natalenko.name/

Turns out it wasn't enough.

If we now revert 4baf12181509 "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"
I still think it makes sense to also revert a5d6264b638e.
Especially from the stable kernels.

This way we roll back this whole issue to a known working state.

Thanks
Mathias

