Return-Path: <stable+bounces-25945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B08B870632
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 16:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9BB1F2273E
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 15:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C00947772;
	Mon,  4 Mar 2024 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6CByYTB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56FE4654E;
	Mon,  4 Mar 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567486; cv=none; b=tkuINaVGpKEqukaSBMGxC5k2f+ghSo8de+MfX6jraH13OnhYRPGHbwtQgNDcTNj+0T1VWm+mztXNaD7oehf7zAYScTotiBR/ycWfSwQMK/aV8WPMasHNcHTWBZtrPWVeBUEBvUkUi20DyJlPFvITlPyhz2AYEqWtvsC2YxMC21U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567486; c=relaxed/simple;
	bh=0lbdHoE8wBY59uc2iX+cWek1vZda8uKlxFEeIYRikvY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XKDTLoxaYDbhvRq5jNliZtM5Ex+osAEcf48uHAGR/8rqb+1/LV0mdpC25jSs3H8C3w5xhAeaY89wEy7U16rpgEuwrdFP4of9qts5MHyMpyEFKokBm/2fo9QZiqRCYo4hPpLN5VO9r7Y9wmRKI83/FgqLhlJhYFhV+KmguonX42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6CByYTB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709567485; x=1741103485;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=0lbdHoE8wBY59uc2iX+cWek1vZda8uKlxFEeIYRikvY=;
  b=R6CByYTBJhgFp1iKtpkg5s2IYlrjIBwTiBeBo33iRpzRMTgGEr/z0fUa
   XCqYnr7IWf7+GC37lP9CUGTuB8L+i1C8+YdZnfefu4mOPSTQIq7pH+qSp
   2f1WUit3mq5ZEAKdOW6PAWZE1UURhtdF3fS5GF3hQ+OASkAGcHwkWikON
   Iv4jBB3GYeXtTYfgGSO2zRAvhysWhziFUMN7jzj1jBJqSuQ7o/9dVXlZK
   30ZG+3UF0qqVqD+1ByDa0HlsHscA9xNadyQTrJiLMDpM2xsiP/wzwMdWx
   q2fIJkfOSbKjj+8gGNTJWqmoeyxbZ5VAokJQCCroUnn+NayRD/IzslmWg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3929473"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3929473"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 07:51:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040723"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040723"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 07:51:22 -0800
Message-ID: <3a560c60-ffa2-a511-98d3-d29ef807b213@linux.intel.com>
Date: Mon, 4 Mar 2024 17:53:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: 6.5.0 broke XHCI URB submissions for count >512
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: Chris Yokum <linux-usb@mail.totalphase.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 stable <stable@vger.kernel.org>, linux-usb@vger.kernel.org,
 Niklas Neronin <niklas.neronin@linux.intel.com>
References: <949223224.833962.1709339266739.JavaMail.zimbra@totalphase.com>
 <50f3ca53-40e3-41f2-8f7a-7ad07c681eea@leemhuis.info>
 <2024030246-wife-detoxify-08c0@gregkh>
 <278587422.841245.1709394906640.JavaMail.zimbra@totalphase.com>
 <a6a04009-c3fe-e50d-d792-d075a14ff825@linux.intel.com>
In-Reply-To: <a6a04009-c3fe-e50d-d792-d075a14ff825@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4.3.2024 13.57, Mathias Nyman wrote:
> On 2.3.2024 17.55, Chris Yokum wrote:
>>>> We have found a regression bug, where more than 512 URBs cannot be
>>>> reliably submitted to XHCI. URBs beyond that return 0x00 instead of
>>>> valid data in the buffer.
>>>
>>> FWIW, that's f5af638f0609af ("xhci: Fix transfer ring expansion size
>>> calculation") [v6.5-rc1] from Mathias.
>>>
> 
> Ok, I see, this could be the empty ring exception check in xhci-ring.c:
> 
> It could falsely assume ring is empty when it in fact is filled up in one
> go by queuing several small urbs.

Does this help?

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 6a29ebd6682d..52278afea94b 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -332,7 +332,13 @@ static unsigned int xhci_ring_expansion_needed(struct xhci_hcd *xhci, struct xhc
         /* how many trbs will be queued past the enqueue segment? */
         trbs_past_seg = enq_used + num_trbs - (TRBS_PER_SEGMENT - 1);
  
-       if (trbs_past_seg <= 0)
+       /*
+        * Consider expanding the ring already if num_trbs fills the current
+        * segment (i.e. trbs_past_seg == 0), not only when num_trbs goes into
+        * the next segment. Avoids confusing full ring with special empty ring
+        * case below
+        */
+       if (trbs_past_seg < 0)
                 return 0;

Thanks
Mathias


