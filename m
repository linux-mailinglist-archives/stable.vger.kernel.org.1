Return-Path: <stable+bounces-213363-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULApEicXg2mKhgMAu9opvQ
	(envelope-from <stable+bounces-213363-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 10:53:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9685E41F7
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 10:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5274D3009882
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 09:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79903BFE5A;
	Wed,  4 Feb 2026 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCXvj6ci"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E583B960F;
	Wed,  4 Feb 2026 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198811; cv=none; b=DUbyJsK4sDfOESZ9F8ClTqoVWaIzwF3chTm4hv4EqS5dZfa683pfQbyFqRrKeYv4MwS1zuqGQkgar+/qsU19UFw1CvAMkF/677ga22yhXfTcC9FuvAeq5VMcGbecUxyiJZOZhxdcC3+dSUCxbCYb2mONm2nJcfpGcb4PqC7OFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198811; c=relaxed/simple;
	bh=wJK26FBbmGNnjcC/ytG6PPMqz5KeQHbTwM1XSyhSD7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hzn4TL5Im2AI+/EvnxCglEDBb/LaiircEGfvhthZ/7kTJnXV8C5Mw97CEboEgkI7yUtKoDTpzV70Fqo86z1SyX01yU+cmrHS0dGF3JabOt/nqmffBqQlHcS7F/5jA8xnIMnihTvibMcKi5K/OPTcOq9Cnj2dBy8GNJKx/KHiqpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCXvj6ci; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770198812; x=1801734812;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wJK26FBbmGNnjcC/ytG6PPMqz5KeQHbTwM1XSyhSD7Y=;
  b=fCXvj6ci86MIlsdV3hVl2lfFLRB0NIgxUVZxpAN7UfTPH/gVi4nfYQrO
   ounMcD94FSZm1MDTw2eCBBJ5y903nXgPm+UDpvJQ3AsBMJ6HiXhm3462G
   ergGfI0kJwvT9x1xuvKqbTj0Jv249N47HNFEQvWHA+OciLcAB1wyf+6CP
   7782kqIvd6ds/xEoOyIpFsY8qvh+m2sUS+yMBb6BhABPK6wl0DPA1Ra2v
   U8lurOK85DX1iJhUjhNHD4D5ygiKEBTah5ws4+FiZQXSZcatkTVftoPQq
   +Opns/F2uyusnaIODz4V+iNnv8ZS3XTbVQL2D+CpotbFC0Cj8AirE6Pjm
   A==;
X-CSE-ConnectionGUID: xu99+BepTt6U1mqo5M6qJA==
X-CSE-MsgGUID: cx1bJ6VTTE6DHit1lvE/eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82493656"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82493656"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:53:31 -0800
X-CSE-ConnectionGUID: xqWwWq1nRs6mKdw9wiFDvQ==
X-CSE-MsgGUID: LLLp1A4ORluKC60NDBYLEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214288883"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.245.239]) ([10.245.245.239])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:53:29 -0800
Message-ID: <6fbc7f6d-7799-47db-b1d6-730c9dea5b22@linux.intel.com>
Date: Wed, 4 Feb 2026 11:53:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] usb: host: xhci-sideband: fix deadlock in unregister
 path
To: Guan-Yu Lin <guanyulin@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, mathias.nyman@intel.com,
 stern@rowland.harvard.edu, wesley.cheng@oss.qualcomm.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260130074746.287750-1-guanyulin@google.com>
 <2026013133-tamale-massager-3c76@gregkh>
 <CAOuDEK0o2jqqOUZVUdi9JDcyXRQHEuL9GCBrU0VQhWAfDtJnUg@mail.gmail.com>
 <6acaaae2-4e93-46f5-8170-277bc369f922@linux.intel.com>
 <CAOuDEK3xzpY7Cr8JgactH=Sy=h7aTEgdTqUiuX8xh6gvUNR5uw@mail.gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <CAOuDEK3xzpY7Cr8JgactH=Sy=h7aTEgdTqUiuX8xh6gvUNR5uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213363-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathias.nyman@linux.intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,linux.intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9685E41F7
X-Rspamd-Action: no action

On 2/4/26 11:15, Guan-Yu Lin wrote:
> Regarding xhci_sideband_check():
> I have a concern regarding power management with the proposed check:
> 
> if (xhci->devs[i] && xhci->devs[i]->sideband)
>          return true;
> 
> vdev->sideband is assigned during xhci_sideband_register(), which
> happens when the class driver probes (device connection), and it
> persists until disconnect. If we use this check, the xHCI controller
> will be prevented from PM suspending (system suspend) as long as the
> device is connected, even if it is idle (not playing audio).
> For mobile power optimization, we need to allow the controller to
> suspend when the sideband is registered but idle.
> 
> Since we are proceeding with Option B, the class driver will be
> maintaining the udev->offload_usage count via usb_offload_get/put(). I
> propose we still rely on usb_offload_check() (or check offload_usage)
> within the xHCI sideband check. This ensures we only block or adjust
> the PM suspend flow only when there is active data transfer.
Sounds reasonable to me

Thanks
Mathias

