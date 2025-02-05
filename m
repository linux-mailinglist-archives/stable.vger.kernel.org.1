Return-Path: <stable+bounces-112858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDD8A28EBA
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2BD164927
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6DD8634E;
	Wed,  5 Feb 2025 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfxywMgP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625471519BE;
	Wed,  5 Feb 2025 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764997; cv=none; b=WGqH4/lc66etkCORGpa3zrCe6MkX12dzkCJ8OowKcTwFBKivqEeLxfR0KfKSWngNcH87kjuytZ9vykjtVWrJwbqQc3b6BXeOBAWjaXnl0p1EYxEYsINdNTxsmLCKXus/FAuMShv9FhstCZCprwylMemBS/FqW2dwnCNM4I7NKIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764997; c=relaxed/simple;
	bh=ytnuGd7Q2qXoBsvqoNaaIzEvhm8uBCFG9Rm4tRWce10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQ1uM5JD0xYiSC77brUyYo+r4zrnvJ5WpDheOJlxRG5K8R5r6CSzNFQyDkUeGa/UAha3niOGsPhVisw2eRtbq51dH1OR08a/QMfeaseRLbcKrPye+S2hiUeaqNWdiQf2TUDejiuVgBKBajyCHRdSzfgAklXxnzdN7oAoqPccx28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfxywMgP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738764996; x=1770300996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ytnuGd7Q2qXoBsvqoNaaIzEvhm8uBCFG9Rm4tRWce10=;
  b=bfxywMgPA00vIOlwuakc4lmGXz9JN843nTt1zyL2Jx43Wzo0X17qj7qN
   diUUSKN91mcFib92cgjtbNH29Vwc4jlURB2+HrcPnNGo4dxUFHFmAdc3v
   cns9fUTJEB037vofLEjjer+pxFuOE30/HQjFScVu9O3XIx9dXdBxqMVyn
   oFtIsABBXo6ZTLQVLPFlcakOueirExBSO0d50TZecHNKoryc+a27PgfKK
   yiaQu4jUHjY6ryGV94lLCnqNYUsKoQfOwcZaMo4Uq9S5lHXQvvfrN49Rr
   eR+rzdkI2RBAFuWaSHQnY0DvMH/T9kDthPum8kp/yKeAwPeaa6HiDiRUU
   g==;
X-CSE-ConnectionGUID: 1bhRCv8OTVycUix+3GxRYQ==
X-CSE-MsgGUID: +nGrMYbbTK6FZTUJCWjCwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="26935325"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="26935325"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 06:16:35 -0800
X-CSE-ConnectionGUID: 143MMiNlRHaIXhEvZWb7Zw==
X-CSE-MsgGUID: GiGYv/mAQ1yJxLRtX0HmkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116114484"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa005.jf.intel.com with ESMTP; 05 Feb 2025 06:16:33 -0800
Message-ID: <c746c10a-d504-48bc-bc8d-ba65230d13f6@linux.intel.com>
Date: Wed, 5 Feb 2025 16:17:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] xhci: Correctly handle last TRB of isoc TD on
 Etron xHCI host
To: Kuangyi Chiang <ki.chiang65@gmail.com>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250205053750.28251-1-ki.chiang65@gmail.com>
 <20250205053750.28251-2-ki.chiang65@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250205053750.28251-2-ki.chiang65@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5.2.2025 7.37, Kuangyi Chiang wrote:
> Unplugging a USB3.0 webcam while streaming results in errors like this:
> 
> [ 132.646387] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 18 comp_code 13
> [ 132.646446] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8630 trb-start 000000002fdf8640 trb-end 000000002fdf8650 seg-start 000000002fdf8000 seg-end 000000002fdf8ff0
> [ 132.646560] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 18 comp_code 13
> [ 132.646568] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8660 trb-start 000000002fdf8670 trb-end 000000002fdf8670 seg-start 000000002fdf8000 seg-end 000000002fdf8ff0
> 
> If an error is detected while processing the last TRB of an isoc TD,
> the Etron xHC generates two transfer events for the TRB where the
> error was detected. The first event can be any sort of error (like
> USB Transaction or Babble Detected, etc), and the final event is
> Success.
> 
> The xHCI driver will handle the TD after the first event and remove it
> from its internal list, and then print an "Transfer event TRB DMA ptr
> not part of current TD" error message after the final event.
> 
> Commit 5372c65e1311 ("xhci: process isoc TD properly when there was a
> transaction error mid TD.") is designed to address isoc transaction
> errors, but unfortunately it doesn't account for this scenario.
> 
> To work around this by reusing the logic that handles isoc transaction
> errors, but continuing to wait for the final event when this condition
> occurs. Sometimes we see the Stopped event after an error mid TD, this
> is a normal event for a pending TD and we can think of it as the final
> event we are waiting for.

Not giving back the TD when we get an event for the last TRB in the
TD sounds risky. With this change we assume all old and future ETRON hosts
will trigger this additional spurious success event.

I think we could handle this more like the XHCI_SPURIOUS_SUCCESS case seen
with short transfers, and just silence the error message.

Are there any other issues besides the error message seen?

Thanks
Mathias


