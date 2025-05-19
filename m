Return-Path: <stable+bounces-144815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB132ABBE58
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0385817E2E1
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854CE278E5D;
	Mon, 19 May 2025 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2qvmrfe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE71F1C683;
	Mon, 19 May 2025 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659178; cv=none; b=Z2xteLTv0LedfrcgJXkJlblAWFISWy6YcBR1cYnH1N8Ory0i8hT2Qro5q2YZTu3duUcz7WCcZ9SJ6a4775Cg9Bd7AL8XfMA+UfT16somaWgLjFtWu7hnZz7BjVWnrX926y4FmMIg6dvy0Y0+934uhctVQE/jQnqnJVxA6nooQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659178; c=relaxed/simple;
	bh=x3xvYVGXBZZpUoVLsbCNPd67Q3UDjJPR1pi9qAO5+GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzE2znZbO9nQsPZwCRnW7ZEzUuKVrN6RcYrUJdj6l2JL3GEHg3n7PYdDd7uKjvBNBHC+0RdqiEWyfdoLwfvub3B05b/872UnIrjwbEpESvU1s3wPLzyfolV1uw98LlKqR8KPmyeqsbIi2z4FCr6wNXTy6c15n3117OQDs1R8PBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2qvmrfe; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747659177; x=1779195177;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x3xvYVGXBZZpUoVLsbCNPd67Q3UDjJPR1pi9qAO5+GI=;
  b=d2qvmrfehHh6agv8tLFg90DD/ycrjIfyAoltGMaJJr+Pp++yFMfhxOkD
   5NayNrZOhsPl86Aq0ALly1Y08U7TtpY3k8H+UEanfVCfrCmbq75NRtNxX
   nPs2cDeuvnZ/pOA0MahQgfvBKaBzR1edFtG1vwPuWX+R3JzqlPm8lu+x2
   KReY/d7SsyaMUJCex54QozgNiivpvNHg5nofeJZ1QR3WUTHPL1Q5+Fp9y
   p5i/0GA69tkIBkPZ2NacjKduQAobx6MVS6Gn35tUqwU286ew6NMwJk6/i
   KOY/Dk/qIV0sr0piJZycYIohPDLUJq+5ThhG7gmko8+vf7jk71n2AWP/E
   Q==;
X-CSE-ConnectionGUID: 2eS69JDRRlGyP8ecEWPPXg==
X-CSE-MsgGUID: JoqhC/c2QtqJyrkc5S8DkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="60950652"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="60950652"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 05:52:57 -0700
X-CSE-ConnectionGUID: oGNm2gWUQIKUauBGoUZW0g==
X-CSE-MsgGUID: PtWEXZPYSnSs1ViA9nCAHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139855553"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa010.fm.intel.com with ESMTP; 19 May 2025 05:52:53 -0700
Message-ID: <8f023425-3f9b-423c-9459-449d0835c608@linux.intel.com>
Date: Mon, 19 May 2025 15:52:52 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Revert "usb: xhci: Implement
 xhci_handshake_check_state() helper"
To: Roy Luo <royluo@google.com>, mathias.nyman@intel.com,
 quic_ugoswami@quicinc.com, Thinh.Nguyen@synopsys.com,
 gregkh@linuxfoundation.org, michal.pecio@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250517043942.372315-1-royluo@google.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250517043942.372315-1-royluo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.5.2025 7.39, Roy Luo wrote:
> This reverts commit 6ccb83d6c4972ebe6ae49de5eba051de3638362c.
> 
> Commit 6ccb83d6c497 ("usb: xhci: Implement xhci_handshake_check_state()
> helper") was introduced to workaround watchdog timeout issues on some
> platforms, allowing xhci_reset() to bail out early without waiting
> for the reset to complete.
> 
> Skipping the xhci handshake during a reset is a dangerous move. The
> xhci specification explicitly states that certain registers cannot
> be accessed during reset in section 5.4.1 USB Command Register (USBCMD),
> Host Controller Reset (HCRST) field:
> "This bit is cleared to '0' by the Host Controller when the reset
> process is complete. Software cannot terminate the reset process
> early by writinga '0' to this bit and shall not write any xHC
> Operational or Runtime registers until while HCRST is '1'."
> 
> This behavior causes a regression on SNPS DWC3 USB controller with
> dual-role capability. When the DWC3 controller exits host mode and
> removes xhci while a reset is still in progress, and then tries to
> configure its hardware for device mode, the ongoing reset leads to
> register access issues; specifically, all register reads returns 0.
> These issues extend beyond the xhci register space (which is expected
> during a reset) and affect the entire DWC3 IP block, causing the DWC3
> device mode to malfunction.

I agree with you and Thinh that waiting for the HCRST bit to clear during
reset is the right thing to do, especially now when we know skipping it
causes issues for SNPS DWC3, even if it's only during remove phase.

But reverting this patch will re-introduce the issue originally worked
around by Udipto Goswami, causing regression.

Best thing to do would be to wait for HCRST to clear for all other platforms
except the one with the issue.

Udipto Goswami, can you recall the platforms that needed this workaroud?
and do we have an easy way to detect those?

Thanks
Mathias


