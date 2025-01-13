Return-Path: <stable+bounces-108453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C62A0BB69
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 16:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B252188BCB5
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE1B243341;
	Mon, 13 Jan 2025 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/+vtwXF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E624333E;
	Mon, 13 Jan 2025 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780655; cv=none; b=b78zlEwvzGpf/e/7Y838YHPiv0fAnudssgyQioa5G2zReRdIiReSRMq41ThQL1dl3KSEvABOnntpCYe0c+K1hkpt3In3ZdM58kfuHtzr7xV91K9bPr5Xm6P6sciCBOnf38g9JJZASaqU9RpYWWEQ4tvUCqwvv3Qy46WDcXLr8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780655; c=relaxed/simple;
	bh=qUCHBt5OBaWeUkrCIaW25NexaYVepiiLdWbTif3l6M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZgzPEMLslkWxDt3Blor2u42Q+MCfqBfaO2GkDWTbX2sYQHQYwbirjNgU2qV8zI5G9iOLO82wbJieBl18Qo6I67k2vQgLxN+UQfrlLk9ExbOQc92Ke39JBigI8SJvvBBMoT1v2jAAwlhCNLIEosoVIpYnIkOPyz46NV4V4Cmn+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/+vtwXF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736780654; x=1768316654;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qUCHBt5OBaWeUkrCIaW25NexaYVepiiLdWbTif3l6M4=;
  b=R/+vtwXF90DQWzTu1pV3My+CmXseUVm3gp7Fo2A/3KNfL7AdmxLQoDK6
   XW0hOSOt5XTMflqhILOp1iZwLvFHEz91N+Md7rC4VJmhd+OrMRUc0/1Mk
   4DNRmmWJKlo8uYzzFTmGQRNRgd77SMW+UVYJjapF3YYjE05GhE3/FeKFK
   ot2+ogsWXeHyAm14Ue0vt+T8uNcqzzobKmxN0MfgVMr2oJ8lBRoLPVSav
   c1detgzWIc/EH392gxuCxtQFo6bemuyruG0UZ7oKm2mmUxLP+dp+s0jmH
   UZtyq/e/v3y6A+mrzuqpuYu3nIjF0QIqd2wI7u3NAUhM0L1KfcfRynpe2
   Q==;
X-CSE-ConnectionGUID: 8rypmoOAQeqBOtlt4SuGkg==
X-CSE-MsgGUID: Q/yBBWOuQRmSHDCosh1jxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37161832"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37161832"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 07:04:14 -0800
X-CSE-ConnectionGUID: t3ualrjXQ+GMfpIB4qrjdw==
X-CSE-MsgGUID: aPZ2gO4ZSgyRAWIAtOaYNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109136569"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa005.fm.intel.com with ESMTP; 13 Jan 2025 07:04:11 -0800
Message-ID: <8a5bef2e-7cf9-4f5c-8281-c8043a090feb@linux.intel.com>
Date: Mon, 13 Jan 2025 17:05:09 +0200
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
 <3bd0e058-1aeb-4fc9-8b76-f0475eebbfe4@linux.intel.com>
 <4kb3ojp4t59rm79ui8kj3t8irsp6shlinq@sonic.net>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <4kb3ojp4t59rm79ui8kj3t8irsp6shlinq@sonic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.1.2025 2.00, Forest wrote:
> On Tue, 7 Jan 2025 14:29:35 +0200, Mathias Nyman wrote:
> 
>> Does disabling USB2 hardware LPM for the device make it work again?
>>
>> Adding USB_QUIRK_NO_LPM quirk "k" for your device vid:pid should do it.
>> i.e. add "usbcore.quirks=0fce:0dde:k" parameter to your kernel cmdline.
> 
> That fixed my test case on Debian kernel 6.12.8-amd64, which is among those
> that have been failing.
> 
> # grep EXTCAP_PORTINFO reg-ext-protocol:*
> reg-ext-protocol:00:EXTCAP_PORTINFO = 0x40000101
> reg-ext-protocol:01:EXTCAP_PORTINFO = 0x20000402
> reg-ext-protocol:02:EXTCAP_PORTINFO = 0x00190c06
> 
>>>> bool(0x40000101 & 1 << 19)
> False
>>>> bool(0x20000402 & 1 << 19)
> False
>>>> bool(0x00190c06 & 1 << 19)
> True
> 
>> Device USB2 LPM capability can be checked from the devices BOS descriptor,
>> visible (as sudo/root) with lsusb -v -d 0fce:0dde
> 
> # lsusb -v -d 0fce:0dde |grep -B 5 LPM
>    USB 2.0 Extension Device Capability:
>      bLength                 7
>      bDescriptorType        16
>      bDevCapabilityType      2
>      bmAttributes   0x00000006
>        BESL Link Power Management (LPM) Supported
> 
> I think that says the device claims support for LPM, yes?

Yes. Looks like both the device and host support USB2 LPM

I think I see what is going on.

Before commit 63a1f8454962a64746a59441687 the xhci driver apparently failed
to detect xHC USB2 LPM support if USB 3 ports were listed before USB 2 ports
in the "supported protocol capabilities.

Now that we correctly detect LPM support and enable it, it turns out the
device does not work well with USB 2 LPM enabled.

I'd recommend a patch that permanently adds USB_QUIRK_NO_LPM for this device.
Let me know if you want to submit it yourself, otherwise I can do it.

Thanks
Mathias

Additional debugging details:

We incorrectly compared usb device port numbers with xHC hardware port
numbers when checking for USB2 port capabilities.

xHC hardware has one long array of ports, including all USB 2 and USB 3 ports.
In your case host lists three sets of supported protocol capabilities:

One USB 3.2 port as the fist port at offset 1:
   reg-ext-protocol:00:EXTCAP_REVISION = 0x03200802
   reg-ext-protocol:00:EXTCAP_PORTINFO = 0x40000101

Four USB 3.1 ports starting at offset 2
   reg-ext-protocol:01:EXTCAP_REVISION = 0x03100802
   reg-ext-protocol:01:EXTCAP_PORTINFO = 0x20000402

Ten USB 2.0 ports stating at offset 6, supporting LPM
   reg-ext-protocol:02:EXTCAP_REVISION = 0x02000802
   reg-ext-protocol:02:EXTCAP_PORTINFO = 0x00190c06

Most xHC hosts used to list their USB 2.0 ports first, meaning there
was no offset difference between usb device port number and xHC port
number for USB 2.0 ports.

Usb device port numbers start from 1 on that hub, in your case it was "3"

xhci driver then checked that usb device with port number "3" does not match
the LPM supported USB 2 port range from 6 to 16 (10 LPM capabale USB 2
ports starting at offset 6).

-Mathias

