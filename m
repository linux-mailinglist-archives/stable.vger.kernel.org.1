Return-Path: <stable+bounces-267680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6yw7NqkeOWqGnAcAu9opvQ
	(envelope-from <stable+bounces-267680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 13:38:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3C36AF26A
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 13:38:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="jrGeW/kx";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267680-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267680-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B154B309DBB5
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013BD2D0C72;
	Mon, 22 Jun 2026 11:32:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907C429D27A;
	Mon, 22 Jun 2026 11:32:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127925; cv=none; b=HuIvUbKdAwcPYVTBE4+MlWMuZbpoEDgy4jfBVLY/sN0kmToiAWSLtugYVWI8sxvJHToQ14Z2TDo0JDo9Ffwv11ghYeYk/774UduxOVvNhnZQeflw3T7HElzUoWAUvk2JRwYhJEMIx30VwBTN/T0zt7EkZCY3hheBQO3lvgrNmnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127925; c=relaxed/simple;
	bh=HN1V8qtgV3fIWRsR1jZQRHDCYOZtMvmI9KomBmsAGnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/rCmMzc3q2Y5KCEEAV7sLoABSDEw20+SGJjFhfdkA7sX5NGD310yRb/9fyx4Unh2Pkg1Waxn1agTfoxFP4OxWiEm52egMl7R+u96NU2Wix4yQp4v5HSxaULpGTaqWdHsYS7B6eBAdPL7sl8pLdfrdn1cnPxOMawSQyhQ8irf+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrGeW/kx; arc=none smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782127924; x=1813663924;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HN1V8qtgV3fIWRsR1jZQRHDCYOZtMvmI9KomBmsAGnc=;
  b=jrGeW/kxI5jyuV+CXuabfBG9f8l45UubQEP2VdwAOaxCgSHCXoqUfkh3
   ANMCk0lMtsI0CyjDqM5WLGSsY9x64SvnxRVUP5GcJsxSEzbuCquKXZAcP
   JpmjNCuCYLOmYbqN97G+snlWqEVapTZVq8jY5ujgr9M+rErFoZA4tpNjE
   EZCNLhEKxhSPV5Mb3qf0osNoqgDZjBVkXj8ncHjPhHK1j3f8mvHDFWIzZ
   RuK1jXjzCAx2VKc5dICo4qkKfpntIKATBH1Ptz9jBSgaAeBaz7k7tj9F0
   l/0Y8Na4MHWn+dhT+cP78NKvb+avukut2c4cdu9fEkpqSpMysRk9n1rkU
   A==;
X-CSE-ConnectionGUID: MRfvxBvkTsug8auDlt4kUA==
X-CSE-MsgGUID: 9IxGdnwcSwqgHVBlL8DWaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82858254"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="82858254"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 04:32:03 -0700
X-CSE-ConnectionGUID: 9yvaQduzTfSypwHnQZ+Rbw==
X-CSE-MsgGUID: tEhBITmTQTuG2VVvyJxe9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="254300381"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.57]) ([10.245.245.57])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 04:32:00 -0700
Message-ID: <c4ef0081-fbe9-47a4-b5d5-60665564ca02@linux.intel.com>
Date: Mon, 22 Jun 2026 14:31:58 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xhci: pci: Disable soft retry for Renesas uPD720201
To: raoxu <raoxu@uniontech.com>, michal.pecio@gmail.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com, stable@vger.kernel.org
References: <20260619124234.0a9e4670.michal.pecio@gmail.com>
 <237BFC17C62D63DF+20260622062117.56278-1-raoxu@uniontech.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <237BFC17C62D63DF+20260622062117.56278-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267680-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:raoxu@uniontech.com,m:michal.pecio@gmail.com,m:gregkh@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:mathias.nyman@intel.com,m:stable@vger.kernel.org,m:michalpecio@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mathias.nyman@linux.intel.com,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[uniontech.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathias.nyman@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.intel.com:mid,linux.intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E3C36AF26A

On 6/22/26 09:21, raoxu wrote:
> Hi Michal,
> 
>>>> The host reports a transaction error on the RTL8153 interrupt
>>>> endpoint, queues a soft reset, and later times out the Stop
>>>> Endpoint command while disconnecting the device:
>>>>
>>>>     Transfer error for slot 8 ep 6 on endpoint
>>>>     Soft-reset ep 6, slot 8
>>>>     Ignoring reset ep completion code of 1
>>>>     xHCI host not responding to stop endpoint command
>>>>     xHCI host controller not responding, assume dead
>>>>     HC died; cleaning up
>>
>> There is other stuff too, like concurrent teardown of a separate bulk
>> endpoint, not yet sure what exactly breaks these chips.
>>
>> Would you mind to apply the attached debug patch, reproduce and post
>> dmesg from your system for comparison?
> 
> I applied the debug patch and reproduced the issue.
> The XHCI_NO_SOFT_RETRY quirk was disabled during the test.
> 
> Short timeline from the log:
> 13:23:29 The USB hub with an integrated RTL8153 Ethernet adapter was
> 	 plugged in.
> 13:23:39 The USB hub was unplugged, and the endpoint error occurred.
> 13:23:44 The Stop Endpoint command timed out and the xHCI host was
>           declared dead.
> 
> The complete dmesg output follows:

Thanks,
I think there are some steps we could do to avoid soft retry, restart, and stopping
an endpoint we know is behind a disconnected parent.

> 
> ----- dmesg begin -----
> 2026-06-22T13:23:39.445959+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: Port change event, 1-3, id 7, portsc: 0x202a0

usb2 part of hub disconnect now known by xhci driver

> 2026-06-22T13:23:39.449096+08:00 uos-PC kernel: xhci_hcd:handle_port_status: xhci_hcd 0000:04:00.0: Port change event, 2-3, id 3, portsc: 0x202c0

usb3 part of hub disconnect now known by xhci driver

> 2026-06-22T13:23:39.449108+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] queue_disable_slot
> 2026-06-22T13:23:39.449111+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 7/-1 (fff/f) [ffffffff/ffffffff/ffffffff] handle_cmd_completion cmd_type 10 comp_code 1

hub slot now disabled

> 2026-06-22T13:23:39.449112+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 1-3 read: 0x2a0, return 0x100
> 2026-06-22T13:23:39.457060+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/2) [200cb341b0/200cb341b1/200cb341c0] handle_tx_event comp_code 4 trb_dma 200cb341b0
> 2026-06-22T13:23:39.457070+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/2) [200cb341b0/200cb341b1/200cb341c0] handle_tx_event stream_id 0 trb_len 2 missing 2
> 2026-06-22T13:23:39.457071+08:00 uos-PC kernel: xhci_hcd:handle_tx_event: xhci_hcd 0000:04:00.0: Transfer error for slot 8 ep 6 on endpoint

transfer error on realtek ethernet child device behind the disconnected hub

> 2026-06-22T13:23:39.457072+08:00 uos-PC kernel: xhci_hcd:xhci_reset_halted_ep: xhci_hcd 0000:04:00.0: Soft-reset ep 6, slot 8

Try to soft reset/retry. (xhci driver knows parent is disconnected, need a fix that avoids soft retry here)

> 2026-06-22T13:23:39.457072+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/2) [200cb341b0/200cb341b1/200cb341c0] queue_reset_endpoint tsp 1
> 2026-06-22T13:23:39.457082+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (002/3) [200cb341b0/200cb341b1/200cb341c0] handle_cmd_completion cmd_type 14 comp_code 1

> 2026-06-22T13:23:39.457084+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/3) [200cb341b0/200cb341b1/200cb341c0] ring_ep_doorbell stream 0

Tried to restart ring after soft retry, we know parent is gone, should write a fix that avoids restarting ring.


> 2026-06-22T13:23:39.477064+08:00 uos-PC kernel: xhci_hcd:xhci_hub_control: xhci_hcd 0000:04:00.0: Get port status 2-3 read: 0x2a0, return 0x2a0
> 2026-06-22T13:23:39.477069+08:00 uos-PC kernel: usbcore:port_event: usb usb2-port3: Wait for inactive link disconnect detect
> 2026-06-22T13:23:39.477070+08:00 uos-PC kernel: usbcore:hub_port_connect_change: usb usb2-port3: status 02a0, change 0001, 5.0 Gb/s
> 2026-06-22T13:23:39.477071+08:00 uos-PC kernel: usb 2-3: USB disconnect, device number 3
> 2026-06-22T13:23:39.477071+08:00 uos-PC kernel: r8152-cfgselector 2-3.1: USB disconnect, device number 4
> 2026-06-22T13:23:39.477072+08:00 uos-PC kernel: usbcore:usb_disconnect: r8152-cfgselector 2-3.1: unregistering device
> 2026-06-22T13:23:39.477079+08:00 uos-PC kernel: usbcore:usb_disable_device: r8152-cfgselector 2-3.1: unregistering interface 2-3.1:1.0
> 2026-06-22T13:23:39.477080+08:00 uos-PC kernel: xhci_hcd:xhci_dbg_trace: xhci_hcd 0000:04:00.0: Cancel URB 000000005c134e45, dev 3.1, ep 0x83, starting at offset 0x200cb341b0

Cancel the realtek URB we tried to soft retry earlier.

> 2026-06-22T13:23:39.477082+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (000/3) [200cb341b0/200cb341b1/200cb341c0] xhci_urb_dequeue cancel TD at 200cb341b0 stream 0
> 2026-06-22T13:23:39.477082+08:00 uos-PC kernel: xhci_hcd 0000:04:00.0: 8/6 (004/3) [200cb341b0/200cb341b1/200cb341c0] queue_stop_endpoint suspend 0

queue stop endpoint to cancel URB for realtek device.
Endpoint context still shows endpoint is in "stopped" state.
Note that we restarted the endpoint 20ms earlier, endpoint context might not have updated yet.

> 2026-06-22T13:23:44.565110+08:00 uos-PC kernel: xhci_hcd:xhci_handle_command_timeout: xhci_hcd 0000:04:00.0: Command timeout, USBSTS: 0x00000000

Stop endpoint command times out.

-Mathias

