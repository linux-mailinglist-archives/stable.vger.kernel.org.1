Return-Path: <stable+bounces-265573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9y8SAa6MMWp5mQUAu9opvQ
	(envelope-from <stable+bounces-265573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:49:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 531B6693842
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:49:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=StKcjs5I;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265573-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265573-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C4323113C9A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5E147B429;
	Tue, 16 Jun 2026 17:44:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4255B47AF5F;
	Tue, 16 Jun 2026 17:44:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631884; cv=none; b=E1JTEROV4ydsqU7m5lahwMBkXBPUCmzB3ASKHTcBvqexBsuTGZ/zJgFeYFnR4URQ3468pjFEpxXEyCCL0F209+CTYkhjSEWBpi0xKVx4MukxStrIQdcWBKSoLFIYg1hIDHU+1cHibtvOo6E2VOXHcqHIPH/vxUBZF7EfyMFRzZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631884; c=relaxed/simple;
	bh=PQA145YAA2CJZfOtrtPtkSQEG98dC0r4HRCTF/mgdjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcdPOBlNPlDVdWm4qofedNpZNYSS+TfrY84NXwvi2tQQNn15jW7TinNDzBUCyn87VRd3g2oFQ0IcVErpyS9A2VGW870YrT2xihcWfRWnWtTzXb2+TlfibVmJIFDYDRqAEJLny461Y9N9lzIOabcEk5EmdxgzJVNm35CAwxVZifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StKcjs5I; arc=none smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781631882; x=1813167882;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PQA145YAA2CJZfOtrtPtkSQEG98dC0r4HRCTF/mgdjc=;
  b=StKcjs5IG/IaKGzMI+JeQgQZlKWmOIPcJSQV5mSCyiwAenSxVdnKsccJ
   xGDpdhwUmsQq9K/KxEvwKUsUprzarkokG68kjLdIKFVID2wBdDXnILhUn
   k2lUooQCdfFN6Nk0inuSVYdyA9k40G6OsHaKr5SQ2uGPfv+rW2pUvHq0e
   eSriDmsA1Nxh3DSyZLi4orSNVjC23cXR+RlYpNUSGE4rfnFNHWKf68rtm
   rtSnTo6w5Jdna7TgahFRuv/VgsDwGV5VS2LK2hCx0qfGBvzijdCNiefLr
   uCgKZFOfDTjUMQ8A18d6kMJyAGHck5tbr4uau7sAwcV+ZDslw6Jav5htE
   A==;
X-CSE-ConnectionGUID: HOGDe5ykTn+lxdAQhjCmxg==
X-CSE-MsgGUID: qJgcM1a5TZ6H3lJK1QHmbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="84971395"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="84971395"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 10:44:42 -0700
X-CSE-ConnectionGUID: EGu9RFbRTzqgHkXWAdaN6w==
X-CSE-MsgGUID: tLFRqi/tTci1/3FLRF0UZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="271908495"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.111.91]) ([10.125.111.91])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 10:44:40 -0700
Message-ID: <81f90f2e-a0df-483a-af25-7eac7a19049a@intel.com>
Date: Tue, 16 Jun 2026 10:44:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cxl/mce: Validate memdev and endpoint before
 dereference in cxl_handle_mce()
To: "Dan Williams (nvidia)" <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 vishal.l.verma@intel.com, flavien@nus.edu.sg, stable@vger.kernel.org
References: <20260616004007.4186004-1-dave.jiang@intel.com>
 <20260616004007.4186004-2-dave.jiang@intel.com>
 <6a318b25443ad_199fc4100b5@djbw-dev.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6a318b25443ad_199fc4100b5@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265573-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[stgolabs.net,kernel.org,intel.com,nus.edu.sg,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dave.jiang@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:djbw@kernel.org,m:linux-cxl@vger.kernel.org,m:dave@stgolabs.net,m:jic23@kernel.org,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:flavien@nus.edu.sg,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 531B6693842



On 6/16/26 10:43 AM, Dan Williams (nvidia) wrote:
> Dave Jiang wrote:
>> cxlmd and endpoint are both used in cxl_handle_mce() without proper
>> validation, which can lead to NULL pointer dereference or invalid pointer
>> dereference. The notifier is registered in cxl_memdev_state_create()
>> when the CXL PCI driver first binds, before the memdev is published and
>> before it is attached to a CXL topology.
>>
>> Add checks to cxlmd and endpoint to ensure they are valid before usage.
> 
> This looks to be trying to band-aid the original mistake of having
> cxl_memdev_state_create() register a region-relative callback.
> 
> Move the mce notifier registration to be per-region and all the lookup
> lifetime problems disappear.

ok that makes sense. 

