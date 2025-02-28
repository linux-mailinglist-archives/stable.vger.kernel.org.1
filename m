Return-Path: <stable+bounces-119960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E929A49E65
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 17:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCB73B8335
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 16:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5CB270041;
	Fri, 28 Feb 2025 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Re77xIoP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A228221348;
	Fri, 28 Feb 2025 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759174; cv=none; b=F48LeHND1cWds8nEUYanuWgtF4DHoDH3ofsMvy0Z/jqbSljfpHaW4/ARITjgRDwQErv7PyoiAqLgOSTRItrbqBRw1UED/UB1vYm1buERF1FwSFQglhd416ODKRdqKgFe/LTX1gKCtRdtr1Ww9NI1Zhe0dBhkbq/BUG7uUTNaq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759174; c=relaxed/simple;
	bh=uUPIQAo2p0/zk7/2PTZ/u7XnicP4q7wfRlfM5Bg6coE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fG7HaFxY+syaLU7gqHkpTjHitEt27lJMJvZw/C13PYWmdD0ArNq25jaOxFceLFJRePBbNNZIcOZ/3CZsynWdOzHKxYRujuW9+gCC5HPuIeMRVK15DlaHhOWpFoll6E+NmjmPMGgjjqa9NGHvJJHFDaddEwBNJKpYQmtE8FR69iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Re77xIoP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740759173; x=1772295173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uUPIQAo2p0/zk7/2PTZ/u7XnicP4q7wfRlfM5Bg6coE=;
  b=Re77xIoPYS/zhfvrvK+TBGNInTH7zKewyCX6R6IczCba4RyiSwIPMZBc
   YgfSyjgbIivblAP5HFWGGSvi7m23v5pKGJsEQl3gh6/0GSXHmYSFXR1FQ
   mlIzxBi7ihMUeCrzoa6Fhe0CGwRgbyTjoxIh9BfdBdIMBh3axDLHllLal
   uh5nQXVuumNZ4iMGDYBnGrp2QG+6u3pXBAm1W+uZcpFxfXmPjrI+JVwbe
   djgZcDKrGEvzWUyFy9R5UFOi0AxDZjj/XnwDqt1gVX8XTkCX09UM1vgBl
   iGM9Asp/Ze+0d9luiIr/K4KRgbZqVyQ+tRjS+BFrTEsytxmmFpJQspS9B
   A==;
X-CSE-ConnectionGUID: 61tDOdoRR8GywWXyl4QKCg==
X-CSE-MsgGUID: F93Y9aHwSqiMWayMWglOTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="53101009"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="53101009"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 08:12:51 -0800
X-CSE-ConnectionGUID: tIvet7CqTLOKPPU2qDcMqg==
X-CSE-MsgGUID: 6icOC5B7TvC93dMTx7qGDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="122382014"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa004.jf.intel.com with ESMTP; 28 Feb 2025 08:12:50 -0800
Message-ID: <41847336-9111-4aaa-b3dc-f3c18bb03508@linux.intel.com>
Date: Fri, 28 Feb 2025 18:13:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: Handle quirky SuperSpeed isoc error reporting
 by Etron HCs
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>,
 Kuangyi Chiang <ki.chiang65@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com, stable@vger.kernel.org
References: <20250205234205.73ca4ff8@foxbook>
 <b19218ab-5248-47ba-8111-157818415247@linux.intel.com>
 <20250210095736.6607f098@foxbook> <20250211133614.5d64301f@foxbook>
 <CAHN5xi05h+4Fz2SwD=4xjU=Yq7=QuQfnnS01C=Ur3SqwTGxy9A@mail.gmail.com>
 <20250212091254.50653eee@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250212091254.50653eee@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.2.2025 10.12, Michał Pecio wrote:
> On Wed, 12 Feb 2025 13:59:49 +0800, Kuangyi Chiang wrote:
>>> +       if (xhci->quirks & XHCI_ETRON_HOST && td->urb->dev->speed == USB_SPEED_SUPER) {
>>> +               td->error_mid_td |= error_event;
>>> +               etron_quirk |= error_event;
>>
>> This would be the same as etron_quirk = error_event; right?
> 
> Yeah, same thing I guess.
> 
>> I tested this with Etron EJ168 and EJ188 under Linux-6.13.1. It works.
> 
> Well, I found one case where it doesn't work optimally. There is a
> separate patch to skip "Missed Service Error" TDs immediately when the
> error is reported and also to treat MSE as another 'error mid TD', so
> with this Etron patch we would end up expecting spurious success after
> an MSE on the last TRB.
> 
> Well, AFAIS, no such event is generated by Etron in this case so we are
> back to waiting till next event and then giving back the missed TD.
> 
> 
> Maybe I will seriously look into decoupling giveback and dequeue ptr
> tracking, not only for those spurious Etron events but everywhere.
> 
> Mathias is right that HW has no sensible reason to touch DMA buffers
> after an error, I will look if the spec is very explicit about it.
> If so, we could give back TDs after the first event and merely keep
> enough information to recognize and silently ignore further events.

This issue was left hanging, I'll clean up my proposal and send it as
a proper RFT PATCH.

Thanks
Mathias


