Return-Path: <stable+bounces-267145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IXoSJCf7M2p2KAYAu9opvQ
	(envelope-from <stable+bounces-267145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 16:05:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4251C6A0CB2
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 16:05:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=g6dPVsSn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267145-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267145-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED080308268F
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 14:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E6E3FA5D9;
	Thu, 18 Jun 2026 14:04:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C92EC083;
	Thu, 18 Jun 2026 14:03:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791441; cv=none; b=R4MWKq8wnYnGuYLbvy87KE+nGPc08Wc6wCLxoqX4FcJKrMeh48662fmEyS1JxPAoO0fx4DuFVsJHikI2NT/SHU/PHSmHOs1AELUK28pn+91kT3J+lZttuXCaWlb9Z1yz9kXvwOjrIPJykaaTNDMXPCXxMCTF/6qiHNIntVl1JEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791441; c=relaxed/simple;
	bh=srOPg0tWBjG5yQAvOL8QEzOqo9Ham8uU0STmfpTpj/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmIX0m8tf2FcvgLPLNJCrn8qf1/dOmUZOsWhAztg/18SNmzbdwWuMTUS6dA66C/I7HM2l7D69rWqR1y/9R6fMY84I/hNiMIc6Pj51WvdUtewWqoTwfcOd2po/mewcUEM0Z4xru0rNWa/DLEZiJwGdtAZ+/X/I2YV0Zg5z3q0Lt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6dPVsSn; arc=none smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781791440; x=1813327440;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=srOPg0tWBjG5yQAvOL8QEzOqo9Ham8uU0STmfpTpj/M=;
  b=g6dPVsSnqBA7jEx5VTptwhblGI19dUNPvgZ1IbNVRyu/seEECHuyXr3a
   JJXeoApvrwRvpw3JICpPnIvlZGIz4hljH8bz63OefSImouLrAQd7Jk70b
   4Ed35Pc5mvuebYfL+NLEYzn9lGQmAeoaNto/TXjpFJcvxQXQfiGuJ1Wbk
   cUfKc3lxJWVD0Al3MTOmGVa5shqGfF+K7718ss0/f2E5IO/FX/AyCWtil
   73/B5geV2lLv950uUt6gsRvIJVkmd11NZ1n19vJbL4XdSz8TVpp75B5DY
   hFz7iUvh8rSGyYU9rOT/BsxbDEmLjqdyJuzpEEfuDZ0Yjsw/pT60RcBeF
   w==;
X-CSE-ConnectionGUID: k5bgZCaPTyqIW9K66Uo0iw==
X-CSE-MsgGUID: MvVrYLz8TVmIskXjC3h4NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82496010"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="82496010"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 07:03:59 -0700
X-CSE-ConnectionGUID: 3HdCDfgwSXaEcir9yU3agg==
X-CSE-MsgGUID: MS8QkOSpTpuQQ2yIj/KBmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="250275868"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.119]) ([10.245.244.119])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 07:03:55 -0700
Message-ID: <62003881-4975-4bb2-a842-cb153ebd8cd4@linux.intel.com>
Date: Thu, 18 Jun 2026 17:03:26 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xhci: pci: Disable soft retry for Renesas uPD720201
To: raoxu <raoxu@uniontech.com>, mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <D9BA02889D046D23+20260617100957.2888108-1-raoxu@uniontech.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <D9BA02889D046D23+20260617100957.2888108-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:raoxu@uniontech.com,m:mathias.nyman@intel.com,m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[uniontech.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mathias.nyman@linux.intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267145-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[stable@vger.kernel.org:query timed out,mathias.nyman@linux.intel.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathias.nyman@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,uniontech.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4251C6A0CB2

On 6/17/26 13:09, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> The Renesas uPD720201 xHCI controller can fail to complete
> a Stop Endpoint command after a transaction error on an interrupt
> endpoint when soft retry is used.
> 
> This was reproduced with this setup:
> 
>    xHCI: Renesas uPD720201, PCI ID 1912:0014 rev 03
>    dev:  USB Ethernet device with an integrated Genesys Logic
>          USB3.1 hub, USB ID 05e3:0626, and a Realtek RTL8153
>          Ethernet function, USB ID 0bda:8153
> 
> Reproducer:
> 
>    1. Plug the integrated USB hub and Ethernet device into the
>       1912:0014 xHCI controller.
>    2. Let r8152 bind to the 0bda:8153 RTL8153 Ethernet function
>       behind the integrated hub.
>    3. Bring the Ethernet device up.
>    4. Hot-unplug the device.
> 
> The host reports a transaction error on the RTL8153 interrupt
> endpoint, queues a soft reset, and later times out the Stop
> Endpoint command while disconnecting the device:
> 
>    Transfer error for slot 8 ep 6 on endpoint
>    Soft-reset ep 6, slot 8
>    Ignoring reset ep completion code of 1
>    xHCI host not responding to stop endpoint command
>    xHCI host controller not responding, assume dead
>    HC died; cleaning up
> 
> The Renesas 1912:0014 controller cannot safely use the xHCI soft
> retry path. Set XHCI_NO_SOFT_RETRY for this controller so
> transaction errors use the pre-soft-retry recovery path. With
> this quirk the same hot-unplug test no longer times out the Stop
> Endpoint command and the RTL8153 remains usable and stable.
> 
> Fixes: f8f80be501aa ("xhci: Use soft retry to recover faster from transaction errors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---

Thanks, added

I'd appreciate your opinion on a related issue.
I'm thinking about trying to recover from these stop endpoint command timeouts.

While debugging this, did xHC controller otherwise seem somewhat functional?
Did you for example see port status change events, or transfer events
between queuing the stop endpoint command and the timeout?

Thanks
Mathias

