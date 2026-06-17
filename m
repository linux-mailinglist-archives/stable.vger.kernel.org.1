Return-Path: <stable+bounces-266920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5bWvGKUOM2rM8wUAu9opvQ
	(envelope-from <stable+bounces-266920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 23:16:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D5D69C7FC
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 23:16:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=SoY5OcKf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266920-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-266920-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9145A301A042
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 21:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E798D38F24F;
	Wed, 17 Jun 2026 21:16:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827518871F;
	Wed, 17 Jun 2026 21:16:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781730973; cv=none; b=YO/AtvieBozRw7QtHNfRyjg0lWMRFiKZ70ry7fBeOoF8QfPIvLlyUXLFd/jNLtu/wcaVyh+m6p1+hFIL2WMTqNnHIHsM46zo8xX6Q/c/IvWyQkc29Qp5HwEwty4HFAleSLKe1iv7jy3eux52e/O6a+ZXITJOuLifL3UQRwFjzuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781730973; c=relaxed/simple;
	bh=9rDzKU7VRPdbg9YIlTvrFyuimiBjwL7zcmflW30AtsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nT1MBTnzS1kqz92XcaxXAQ1Usme69YTz8VU8c1cQTseLTJk1OlBIix7XIRegSfaYvgT4KsHKe3WoK2N13yB38DEe36if/A+jWNl3B21PK4DG/FIn7fTTO92Cj9v4BvWJrYtQ7RflcQiB34Ghh4RpkmGK/SAZomqD+PN9UuLaIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SoY5OcKf; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781730971; x=1813266971;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9rDzKU7VRPdbg9YIlTvrFyuimiBjwL7zcmflW30AtsM=;
  b=SoY5OcKfSGFP+cL2URpAy/ILeDDYFY0F471caO2COhxPc1n4lEu1kFEc
   zmyPbOT3S+HkJ/9dfbf/62euoXPHkX2aJnkrdTML6EoQiLnmETSEQpF36
   nSmRcbpZ+okblNF80QXVblDKg3kx+CjwWVK/n4SurpjGEWJJAo8LW1Ffs
   yFzGHUbjvet0j7kzz2pxLZ9YTHuE6H8Tse2+qYqlOhBOuDG986Xjxx/M2
   HEHR9qDP1tvD0u5/ujkFwaDmzuUhSROPEGVLWvJL1g8cVEi/3LuTOu7zp
   taeZdQolTi91iZglVooe/u+2XKYRktVwbuc+CRX3OE3xnNvg2wm2jEyTx
   w==;
X-CSE-ConnectionGUID: jvAwI7U/QLSpTrdXrEqeuw==
X-CSE-MsgGUID: +xAlxDJcTyK8ZTQ2+aOcqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82658871"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="82658871"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 14:16:10 -0700
X-CSE-ConnectionGUID: VHGTevYNRjqEMU2oxSsNhA==
X-CSE-MsgGUID: Hd7Jz8meTRm+ILD0aWyhFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="250062265"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.162]) ([10.125.111.162])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 14:16:09 -0700
Message-ID: <48d47632-00b5-46e1-8719-f35f52413404@intel.com>
Date: Wed, 17 Jun 2026 14:16:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/mce: Make the MCE notifier per-region
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 linux-cxl@vger.kernel.org
Cc: djbw@kernel.org, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, flavien@nus.edu.sg,
 stable@vger.kernel.org
References: <20260616224912.2567474-1-dave.jiang@intel.com>
 <4142d143-8bfe-4364-bfa7-73a48d214f25@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <4142d143-8bfe-4364-bfa7-73a48d214f25@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266920-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,stgolabs.net,intel.com,nus.edu.sg,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dave.jiang@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:benjamin.cheatham@amd.com,m:linux-cxl@vger.kernel.org,m:djbw@kernel.org,m:dave@stgolabs.net,m:jic23@kernel.org,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:flavien@nus.edu.sg,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,nus.edu.sg:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71D5D69C7FC



On 6/17/26 1:19 PM, Cheatham, Benjamin wrote:
> On 6/16/2026 5:49 PM, Dave Jiang wrote:
>> Flavien Solt reported lifetime issues with the CXL MCE notifier, which
>> can lead to NULL dereferences and use-after-free in the MCE handler.
>> The notifier was registered per memory device and stored in 'struct
>> cxl_memdev_state', even though it only needs the region state (the
>> region's SPA range and its extended linear cache size).
>>
>> Instead of keeping the memory device and endpoint alive, the correct fix
>> is to move the notifier into 'struct cxl_region' and register it from
>> cxl_region_probe() as it should be a per-region notifier. Setup the
>> registration to only happen for regions that have an extended linear
>> cache as that is the only current usage.
>>
>> Remove cxl_port_get_spa_cache_alias() as it is now dead code.
>>
>> Reported-by: Flavien Solt <flavien@nus.edu.sg>
>> Suggested-by: Dan Williams <djbw@kernel.org>
>> Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
> 
> One nit below, but looks good otherwise:
> 
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Thanks!

> 
> [snip]
> 
>>  static int is_system_ram(struct resource *res, void *arg)
>>  {
>>  	struct cxl_region *cxlr = arg;
>> @@ -4070,6 +4043,19 @@ static int cxl_region_probe(struct device *dev)
>>  	if (rc)
>>  		return rc;
>>  
>> +	/*
>> +	 * Regions fronted by an extended linear cache need the MCE notifier to
>> +	 * offline the aliased page on a memory error.
>> +	 */
>> +	if (p->cache_size) {
>> +		rc = devm_cxl_register_mce_notifier(&cxlr->dev,
>> +						    &cxlr->mce_notifier);
>> +		if (rc == -EOPNOTSUPP)
>> +			dev_warn(&cxlr->dev, "CXL MCE unsupported\n");
> 
> I would demote this to an info() or dbg() print. A warning print here is a bit overkill
> for essentially having a config option disabled that's largely dependent on the platform.
> 
> If you think a warn() is warranted, I'd change the message to say the config is disabled instead
> so that the end user is pointed to why it's unsupported.

Given that it won't report expected MCE emits and handle dealing with the aliased address, warn is probably reasonable. I'll update the message. 

> 
> Thanks,
> Ben


