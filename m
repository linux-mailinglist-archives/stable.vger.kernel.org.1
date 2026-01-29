Return-Path: <stable+bounces-212769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHaxBMBGe2kdDQIAu9opvQ
	(envelope-from <stable+bounces-212769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 12:38:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B2AAFB46
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 12:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 485723012C41
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 11:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B21C38737E;
	Thu, 29 Jan 2026 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbGiv/yV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9043327E06C;
	Thu, 29 Jan 2026 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769686713; cv=none; b=bXaYFe4546YU8F2+tOxDPV/owlx/F9LWSogNASNEXDfv4CHeuyMUYH62ft8gbUstzAawrCmIWe9VOQvcZh7Ao563gpoyIAyJWhlSxMPt5OdQqC3H+auol9KlRLj3YY0anW/iwkmRMzzyfB4E9ccxDhtIaPXM3rd00MsBKbs65mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769686713; c=relaxed/simple;
	bh=zqQahS7LRYqZ4TDiRpmQd3h7XJYvjr9FSGUE7Ui8kmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqN5D2fYbQ+KOwXuqzbB6AzAG+jy1bmKouH3GD+A+B6MtsBY7s1yhPw/D2iesfXYCix1udXar8new3WVoXpeBo8qtdUM2SReXQUjWKZJg8UH1MLMnHIHg+q3rfiZvzL3yiUgvFqg3o0+fwdyY2H4nycD+/cr6PWOtsiG0Gfchrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbGiv/yV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769686712; x=1801222712;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zqQahS7LRYqZ4TDiRpmQd3h7XJYvjr9FSGUE7Ui8kmg=;
  b=CbGiv/yVHVq/WxMPkE0FEiP2u5H0fpE4O5r4XrmAbOC25k1CSX4IDaa6
   mHuo+Et1J6mbvxWCjQjEhnMrkGJ7Ka6NZx73Y8Kk+i6ScQUgICpE5Kj8d
   GIlurf6m1ZJBpWWlKlIhD7pXvcSFRnYau9CXx/W6VV14E0anB71ENxTXe
   m/4ad6zj0qTe46hmisZ7QiuyWOmsEbvsefj2MFYag9hzvG3kRpvo1DiRo
   1KzZBUkL9uqTE9bRMy5NHNB/Fxflz1rNblWcEZqM9Kny2DwoMXa4U/oZ/
   GvLOzUVHVum6pTfncfrFs/E3kRR0ep3C5zIldxColpck5lIiEiBnrEIB4
   Q==;
X-CSE-ConnectionGUID: ez3updEPSSuVFEDgyRrFiQ==
X-CSE-MsgGUID: PgpwyjDzSe6ZI6gNHHcq3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="82350935"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="82350935"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 03:38:31 -0800
X-CSE-ConnectionGUID: dyQPo88fSmqifbAaQimUKg==
X-CSE-MsgGUID: ywxbSiq+SDSiUX61X7iiaw==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.88]) ([10.245.245.88])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 03:38:28 -0800
Message-ID: <c7ad4630-5659-4e06-9f4b-3fa7ec2c9472@linux.intel.com>
Date: Thu, 29 Jan 2026 13:38:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: xhci: Fix memory leak in xhci_disable_slot()
To: Michal Pecio <michal.pecio@gmail.com>, Zilin Guan <zilin@seu.edu.cn>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, stable@vger.kernel.org
References: <20260109045410.1532614-1-zilin@seu.edu.cn>
 <20260129095634.0775dc40.michal.pecio@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20260129095634.0775dc40.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,seu.edu.cn];
	TAGGED_FROM(0.00)[bounces-212769-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathias.nyman@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,seu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 65B2AAFB46
X-Rspamd-Action: no action

On 1/29/26 10:56, Michal Pecio wrote:
> On Fri,  9 Jan 2026 04:54:10 +0000, Zilin Guan wrote:
>> xhci_alloc_command() allocates a command structure and, when the
>> second argument is true, also allocates a completion structure.
>> Currently, the error handling path in xhci_disable_slot() only frees
>> the command structure using kfree(), causing the completion structure
>> to leak.
>>
>> Use xhci_free_command() instead of kfree(). xhci_free_command()
>> correctly frees both the command structure and the associated
>> completion structure. Since the command structure is allocated with
>> zero-initialization, command->in_ctx is NULL and will not be
>> erroneously freed by xhci_free_command().
>>
>> This bug was found using an experimental static analysis tool we are
>> developing. The tool is based on the LLVM framework and is
>> specifically designed to detect memory management issues. It is
>> currently under active development and not yet publicly available,
>> but we plan to open-source it after our research is published.
>>
>> The bug was originally detected on v6.13-rc1 using our static analysis
>> tool, and we have verified that the issue persists in the latest
>> mainline kernel.
>>
>> We performed build testing on x86_64 with allyesconfig using
>> GCC=11.4.0. Since triggering these error paths in xhci_disable_slot()
>> requires specific hardware conditions or abnormal state, we were
>> unable to construct a test case to reliably trigger these specific
>> error paths at runtime.
>>
>> Fixes: 7faac1953ed1 ("xhci: avoid race between disable slot command
>> and host runtime suspend") CC: stable@vger.kernel.org
>> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> 
> This looks like correct fix to an actual bug, but it seems that it has
> been missed? I see it neither in usb-next nor usb-linus or mainline.
> 
> The leak is still there, even if arguably a small and rare one.

Thanks for the reminder.
We are so late in the cycle now that I'll send it after rc1

Thanks
Mathias


