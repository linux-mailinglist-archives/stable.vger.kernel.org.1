Return-Path: <stable+bounces-107837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1143A03F17
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 13:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E63E1648D5
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 12:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D906E1E9B39;
	Tue,  7 Jan 2025 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abvcRWwj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F811E5734;
	Tue,  7 Jan 2025 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736252933; cv=none; b=qQp67Up/8noMqd3HO37K/WQROTSPXU6dHR8mArO25CAm00+ma7MvZzT7kiFQoZE0kup8e8lsHmOSBqub4p/v5IIlSvOw6RMeF/HmKeLbjtdCHZVtfRkS6YmBIKBOL8/Vr3ePbYoNDHVlSpAkFtQycfk31q6bjk3dOnFfUhjApGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736252933; c=relaxed/simple;
	bh=QojtHw8LGUnm3rpVHZvfd9J5sm2jpmcnC6VJnQLY43w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkqVocoswXgbasoyl6oAg36JvTKjyFv/Q9ndvDN7EBPFlfHhqC5sPoUX9FSPupCie+kwM87pGg2DmJLZchCWz0gA2Tq4bMwsl0zz+eEfQbwASSNp8wPasbvlGR9RntDeDsopbkhBinywXPOOeArXvmQtu3Hj+w/B82yViBsyAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abvcRWwj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736252932; x=1767788932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QojtHw8LGUnm3rpVHZvfd9J5sm2jpmcnC6VJnQLY43w=;
  b=abvcRWwjHh+G0LyVkdHTvAIXNW1hUnMIXwP6wQtDV/EZrxXjDz/xdgbm
   ZEC8S9CzXKufRZcNsOh8cR4M4PB7om9QkOr2zs+AvibNF2uMALdiwa9/G
   aZTSZyE9hY2ACVlnVEo9dd8W2CAGab2TG1dHuj078jGhFF/XvuQs+keqw
   rKF1x9lMkSqCUMtW8pN494khLt/KtNZWvHkdxg42wdsUhfPE86Sxs4yin
   jpcEhFdMdyxJdPze7/zS48rwdOlR5DHrWfP0iyxwhbxoZus5ycPIDHHQ0
   VDyLRYi7VcBvLCZXyhMKMWMZt/J+3oQQmkmBPKTiTDb6D/YFqvbS0WlY1
   g==;
X-CSE-ConnectionGUID: AUOkPpy4RcemIcr3hvn7rw==
X-CSE-MsgGUID: s89j8rEST6iAxrM0nW547w==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="61812285"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="61812285"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 04:28:52 -0800
X-CSE-ConnectionGUID: hhglC8DaS+C5uTVkKsSkPg==
X-CSE-MsgGUID: /GyccoMoS+Sl2SiIElHSBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="102941846"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa008.fm.intel.com with ESMTP; 07 Jan 2025 04:28:50 -0800
Message-ID: <3bd0e058-1aeb-4fc9-8b76-f0475eebbfe4@linux.intel.com>
Date: Tue, 7 Jan 2025 14:29:35 +0200
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
 <2c35ff52-78aa-4fa1-a61c-f53d1af4284d@linux.intel.com>
 <0l5mnj5hcmh2ev7818b3m0m7pokk73jfur@sonic.net>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <0l5mnj5hcmh2ev7818b3m0m7pokk73jfur@sonic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6.1.2025 1.42, Forest wrote:
> On Thu, 2 Jan 2025 16:13:34 +0200, Mathias Nyman wrote:
> 
>> It's not clear to me why this patch would cause regression.
>>
>> Could you enable xhci and usb core dynamic debug before connecting the
>> device, and then share dmesg after the issue is triggered.
>>
>> dmesg of a working case would also be good to have for comparison.
> 
> I booted kernel 9b780c845fb6 (the last good one), logged in to my desktop,
> waited a couple of minutes to let things settle, and then ran 'fastboot
> getvar kernel' twice with the android device in bootloader mode.
> Here's the dmesg output:

Thanks for the logs.
  
Looks like we enable USB2 Link Power Management (LPM) in the failing case
> 
> [  226.002756] xhci_hcd 0000:0c:00.0: enable port 3 USB2 hardware LPM
> [  226.002765] xhci_hcd 0000:0c:00.0: Set up evaluate context for LPM MEL change.

Does disabling USB2 hardware LPM for the device make it work again?

Adding USB_QUIRK_NO_LPM quirk "k" for your device vid:pid should do it.
i.e. add "usbcore.quirks=0fce:0dde:k" parameter to your kernel cmdline.

Or alternatively disable usb2 lpm  during runtime via sysfs
(after enumeration, assuming device is "1-3" as in the log):
# echo 0 > /sys/bus/usb/devices/1-3/power/usb2_hardware_lpm

If those work then we need to figure out if we incorrectly try to enable
USB2 hardware LPM, or if device just can't handle LPM even if it claims
to be LPM capable.

Host hardware LPM capability can be checked from xhci reg-ext-protocol
fields from debugfs.
cat /sys/kernel/debug/usb/xhci/0000:0c:00.0/reg-ext-protocol:*
(please print content of _all_ reg_ext_protocol* files, LPM capability is
bit 19 of EXTCAP_PORTINFO)

Device USB2 LPM capability can be checked from the devices BOS descriptor,
visible (as sudo/root) with lsusb -v -d 0fce:0dde

Thanks
Mathias

