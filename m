Return-Path: <stable+bounces-165738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAEFB18224
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 15:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE833627EF6
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 13:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1CE24887E;
	Fri,  1 Aug 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MbsM8BNI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D28247284;
	Fri,  1 Aug 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053593; cv=none; b=keYNY0NgeHfLXkJ+/efkYGr0nKNG55fXCLsvt1S0bT/L9zx+ZC8DOdIIPi6SkQlFMPbqAXOhf1JUXfWS9ae+Mkzy+ifzeErx01qWnJsGQoKqTxPvC3ZiZmAguYzlrMEg0ux+dZyRzpLGbkpX6PymD7Pc9tGYsxfBch591bIK8hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053593; c=relaxed/simple;
	bh=sEw9KSgIPZRHJ1gVK4TjPXW0BX1S9WDtiHbYXd25qCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J55j+53zPAo3VUIC/+nCLBscjzVMXMiosZi/7toAjogWCpv1ECnhi0vPAGg9K/Ugy0It3f+VFFyCEX8pHKhio1uaNmxIlFh1KkFrsy3WPg0cMe6fEKIWi1F6vq3WLDJA1XdqvBnRg0Q7KlZ3axU7jOLx/A99o01os+NAYHtBNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MbsM8BNI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754053591; x=1785589591;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sEw9KSgIPZRHJ1gVK4TjPXW0BX1S9WDtiHbYXd25qCw=;
  b=MbsM8BNIQNqAAy8YGXToflpBEYcCVo4gVr+RQ+l74Yo2VR43PEF2BRLi
   qceDqCrjztwFFTIdFiYrJjCR0iEnPpz+MCVXdC5WMKxZ7MCojeSg9krBF
   SFyadHt+D9Hq6z4c9Psyb5/QLsYxBRg0J3nAK/PHgjJJaRQxILPOobnm8
   kXWTmc+SeW44D23qrCGHHTx7oW/6/O6A17QdkbVs28RPqh9VW7EGqYnZI
   g+Qk016AS/pTC8KE2OBoboca3HLYPXR6jBg0ApJWBd80YVwPr09l8xRiV
   6yPIYTBD2sreGjBXpJhzm3u+lc66XCUh9Kqiyy3K2ggjkyk7EdrrNsfNl
   g==;
X-CSE-ConnectionGUID: QvXMwEMaTgiyx9Cx6G1zRA==
X-CSE-MsgGUID: GJDISb8kROGbp62nyJg0NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56358984"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56358984"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 06:06:30 -0700
X-CSE-ConnectionGUID: a7YXSyRgQW2Z1sLrJLrlvg==
X-CSE-MsgGUID: X3MyL08pSt6KoYfPN6KGrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="194522052"
Received: from mnyman-desk.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa002.jf.intel.com with ESMTP; 01 Aug 2025 06:06:28 -0700
Message-ID: <42d12655-dca5-4465-a19d-17a2e4984d31@linux.intel.com>
Date: Fri, 1 Aug 2025 16:06:26 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb:xhci:Fix slot_id resource race conflict
To: Weitao Wang <WeitaoWang-oc@zhaoxin.com>, gregkh@linuxfoundation.org,
 mathias.nyman@intel.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: WeitaoWang@zhaoxin.com, wwt8723@163.com, CobeChen@zhaoxin.com,
 stable@vger.kernel.org
References: <20250730152715.8368-1-WeitaoWang-oc@zhaoxin.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250730152715.8368-1-WeitaoWang-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.7.2025 18.27, Weitao Wang wrote:
> In such a scenario, device-A with slot_id equal to 1 is disconnecting
> while device-B is enumerating, device-B will fail to enumerate in the
> follow sequence.
> 
> 1.[device-A] send disable slot command
> 2.[device-B] send enable slot command
> 3.[device-A] disable slot command completed and wakeup waiting thread
> 4.[device-B] enable slot command completed with slot_id equal to 1 and
> wakeup waiting thread
> 5.[device-B] driver check this slot_id was used by someone(device-A) in
> xhci_alloc_virt_device, this device fails to enumerate as this conflict
> 6.[device-A] xhci->devs[slot_id] set to NULL in xhci_free_virt_device
> 
> To fix driver's slot_id resources conflict, clear xhci->devs[slot_id] and
> xhci->dcbba->dev_context_ptrs[slot_id] pointers in the interrupt context
> when disable slot command completes successfully. Simultaneously, adjust
> function xhci_free_virt_device to accurately handle device release.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7faac1953ed1 ("xhci: avoid race between disable slot command and host runtime suspend")
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>

Thanks, added to queue with some minor commit message tuning

-Mathias

