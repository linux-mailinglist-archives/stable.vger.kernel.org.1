Return-Path: <stable+bounces-3890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37555803841
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 16:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D4F1F211E1
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 15:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EE829438;
	Mon,  4 Dec 2023 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5OPDaVo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60081B2;
	Mon,  4 Dec 2023 07:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701702345; x=1733238345;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=64ZxS30NJt+fUaGcwGEanxzPTAeQjRu0SMM1BZzKljQ=;
  b=M5OPDaVol3wrnewIGi2uCGqC08k2s/iM4mEuDnz9NPDRzgzLfvHEtqDL
   36O7SBWY3vNH3HThcdyMkXggeeCQMNwTMT8wkug8gS4uggf9J6LBbaDFy
   B6hgCDkXUUXA5COUY5tkFa1nFWi4LZrfkTTlhJdx3MWe0sK9qBar4f982
   cVKFHb3wjll2LX6/NohRk4goZHqLgS4QxZGlXsTZWYYmKpKUiTlXNvBCE
   s84eCN2wtrtq+A7n+zGGxy09li+lDNqezb4+3pmMFbtsGOsgSjBF2UJfJ
   7o+zoYVE+4GV6mZVLALzonsOyn6eVf/vKIN0Jtc4G95qDBVWEr3O70Lp7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="789934"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="789934"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 07:05:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="746867985"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="746867985"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga006.jf.intel.com with ESMTP; 04 Dec 2023 07:05:06 -0800
Message-ID: <273a8811-f34e-dbe7-c301-bb796ddcced1@linux.intel.com>
Date: Mon, 4 Dec 2023 17:06:25 +0200
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
 <db579656-5700-d99b-f1eb-c1e27749eb7b@linux.intel.com>
 <f28b4e98-dd9b-458e-8a72-a9da3c0727cd@amd.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH 1/2] Revert "xhci: Enable RPM on controllers that support
 low-power states"
In-Reply-To: <f28b4e98-dd9b-458e-8a72-a9da3c0727cd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4.12.2023 16.49, Basavaraj Natikar wrote:
> 
> On 12/4/2023 7:52 PM, Mathias Nyman wrote:
>> On 4.12.2023 12.49, Basavaraj Natikar wrote:
>>>
>>> On 12/4/2023 3:38 PM, Mathias Nyman wrote:
>>>> This reverts commit a5d6264b638efeca35eff72177fd28d149e0764b.
>>>>
>>>> This patch was an attempt to solve issues seen when enabling runtime PM
>>>> as default for all AMD 1.1 xHC hosts. see commit 4baf12181509
>>>> ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")
>>>
>>> AFAK, only 4baf12181509 commit has regression on AMD xHc 1.1 below is
>>> not regression
>>> patch and its unrelated to AMD xHC 1.1.
>>>
>>> Only [PATCH 2/2] Revert "xhci: Loosen RPM as default policy to cover
>>> for AMD xHC 1.1"
>>> alone in this series solves regression issues.
>>>
>>
>> Patch a5d6264b638e ("xhci: Enable RPM on controllers that support
>> low-power states")
>> was originally not supposed to go to stable. It was added later as it
>> solved some
>> cases triggered by 4baf12181509 ("xhci: Loosen RPM as default policy
>> to cover for AMD xHC 1.1")
>> see:
>> https://lore.kernel.org/linux-usb/5993222.lOV4Wx5bFT@natalenko.name/
>>
>> Turns out it wasn't enough.
>>
>> If we now revert 4baf12181509 "xhci: Loosen RPM as default policy to
>> cover for AMD xHC 1.1"
>> I still think it makes sense to also revert a5d6264b638e.
>> Especially from the stable kernels.
> 
> Yes , a5d6264b638e still solves other issues if underlying hardware doesn't support RPM
> if we revert a5d6264b638e on stable releases then new issues (not related to regression)
> other than AMD xHC 1.1 controllers including xHC 1.2 will still exist on stable releases.

Ok, got it, so a5d6264b638e also solves other issues than those exposed by 4baf12181509.
And that one (a5d6264b638) should originally have been marked for stable.

So only revert 4baf12181509, PATCH 2/2 in this series

Thanks
Mathias

