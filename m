Return-Path: <stable+bounces-167125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 268F8B224F0
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 12:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813C35648C5
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861082EBBBB;
	Tue, 12 Aug 2025 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewdyFgKY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95B52EBDE1;
	Tue, 12 Aug 2025 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995736; cv=none; b=R4yPJ0P1asGQIDuBsioi7/akX/UwfmriUAhwVUdCF8zyV5OZamBqBO0yYlzCYeu/gdsemonc51sYNqEcTYLzTulD2NeDFI3YcoQ9alom0L3BbgCBfk4VoSs482b/p8OspigiTYg9gqdAyhN/G+cQqcAWN1hHDOWHpWVpqL3k56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995736; c=relaxed/simple;
	bh=Esq8t7wbTlKL0Q3zZg56LpOHe5ZR3qmGQXipZBa5Ju8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XK8tWmqbI72oUM+45TJcRXQJiVfs1d2hUXkHG6RfkCO/WdQc2WLRfAETGpMXybZEvJ6N+1wWNXU0m7Ln9E4IkIityFXSRGtNCKqsULWaiEHbGhq5RqlWXjHTwCNEUeaQlzsR9/tlNJRooh9tbOZv+CXaeOMvoUdrAQXXkY1dnzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewdyFgKY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754995734; x=1786531734;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Esq8t7wbTlKL0Q3zZg56LpOHe5ZR3qmGQXipZBa5Ju8=;
  b=ewdyFgKYLHM3BrK9KMTKYO1RtKv8zFK3CYb02TsUSbnz6+vKndSKnCYw
   xa9hWAwOPHqKCg43/a0zPCDMw7dL5rAKBVqwyWHySt3Z0c1jNJaPRngkp
   EXSINqUTVfxi+2haZAlq3yruZ/+gcz6HHon/loLRBFnph4ewJL6TDNWIE
   oArnSwHVQxuIi3H33oVBiEBYqtNJfigs0lqu7TGd1O/Q1w/oHg2XZH8hG
   1Gn3IX//YCXWKt0dF/YzM/Gc3SoLEANuYr/yQDn7mK5ErifBHdNUz3iNz
   CoKhDfEiuDfUZ3jv0PMAmjeO0x1pmVpEHbx/NiAQS6qvjdWnkqhgQNKYo
   A==;
X-CSE-ConnectionGUID: xEYJaoHFTaGQzTi42XboCw==
X-CSE-MsgGUID: EVuOtToZR9CvsOdrhAteyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57330116"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57330116"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 03:48:54 -0700
X-CSE-ConnectionGUID: hGELmE0YTJatBo18EmMKVQ==
X-CSE-MsgGUID: wgXcgqpHQYm84PLQ74q6MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166960085"
Received: from mnyman-desk.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa010.fm.intel.com with ESMTP; 12 Aug 2025 03:48:52 -0700
Message-ID: <5b039333-fc97-43b0-9d7a-287a9b313c34@linux.intel.com>
Date: Tue, 12 Aug 2025 13:48:50 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: hub: Don't try to recover devices lost during warm
 reset.
To: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
 stable@vger.kernel.org, =?UTF-8?Q?=C5=81ukasz_Bartosik?=
 <ukaszb@chromium.org>, Oliver Neukum <oneukum@suse.com>
References: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
 <fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

> 
> This was reported to break the USB on one box:
>> [Wed Aug  6 16:51:33 2025] [ T355745] usb 1-2: reset full-speed USB device number 12 using xhci_hcd
>> [Wed Aug  6 16:51:34 2025] [ T355745] usb 1-2: device descriptor read/64, error -71
>> [Wed Aug  6 16:51:34 2025] [ T355745] usb 1-2: device descriptor read/64, error -71

Protocol error (EPROTO) reading 64 bytes of device descriptor

>> [Wed Aug  6 16:51:34 2025] [ T355745] usb 1-2: reset full-speed USB device number 12 using xhci_hcd
>> [Wed Aug  6 16:51:34 2025] [ T355745] usb 1-2: device descriptor read/64, error -71
>> [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: device descriptor read/64, error -71
>> [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: reset full-speed USB device number 12 using xhci_hcd
>> [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: Device not responding to setup address.

The xhci "address device" command failed with a transaction error
Slot does not reach "addressed" state

>> [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: Device not responding to setup address.
>> [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: device not accepting address 12, error -71
>> [Wed Aug  6 16:51:35 2025] [ T355745] usb 1-2: WARN: invalid context state for evaluate context command.

xhci evaluate context command failed, probably due to slot not in addressed state

>> [Wed Aug  6 16:51:36 2025] [ T355745] usb 1-2: reset full-speed USB device number 12 using xhci_hcd
>> [Wed Aug  6 16:51:36 2025] [     C10] xhci_hcd 0000:0e:00.0: ERROR unknown event type 2

This is odd,
TRBs of type "2" should not exists on event rings, TRB type id 2 are supposed to be the
setup TRB for control transfers, and only exist on transfer rings.


>> [Wed Aug  6 16:51:36 2025] [ T355745] usb 1-2: Device not responding to setup address.
>> [Wed Aug  6 16:51:37 2025] [     C10] xhci_hcd 0000:0e:00.0: ERROR unknown event type 2
>> [Wed Aug  6 16:52:50 2025] [ T362645] xhci_hcd 0000:0e:00.0: Abort failed to stop command ring: -110

Aborting command due to driver not seeing command completions.
The missing command completions are probably those mangled "unknown" events

>> [Wed Aug  6 16:52:50 2025] [ T362645] xhci_hcd 0000:0e:00.0: xHCI host controller not responding, assume dead
>> [Wed Aug  6 16:52:50 2025] [ T362645] xhci_hcd 0000:0e:00.0: HC died; cleaning up

Tear down xhci.

> 
> Any ideas? What would you need to debug this?

Could be that this patch reveals some underlying race in xhci re-enumeration path.

Could also be related to ep0 max packet size setting as this is a full-speed device.
(max packet size is unknown until host reads first 8 bytes of descriptor, then adjusts
it on the fly with an evaluate context command)

Appreciated if this could be reproduced with as few usb devices as possible, and with
xhci tracing and dynamic debug enabled:

mount -t debugfs none /sys/kernel/debug
echo 'module xhci_hcd =p' >/sys/kernel/debug/dynamic_debug/control
echo 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control
echo 81920 > /sys/kernel/debug/tracing/buffer_size_kb
echo 1 > /sys/kernel/debug/tracing/events/xhci-hcd/enable
echo 1 > /sys/kernel/debug/tracing/tracing_on
< Reproduce issue >
Send output of dmesg
Send content of /sys/kernel/debug/tracing/trace

Thanks
Mathias

