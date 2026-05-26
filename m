Return-Path: <stable+bounces-254335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECFGM96WFWqNWgcAu9opvQ
	(envelope-from <stable+bounces-254335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:49:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E165D5C51
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 399BE3016C57
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C8E22D7A9;
	Tue, 26 May 2026 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2PwWHOu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FFF222597;
	Tue, 26 May 2026 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799743; cv=none; b=lMbU8AzokLoRavqm/K8USRJ+1zn2jp2FAca0dsFBHs+cRGNZ4xOoMEVyHXH/l5L7JvnNOhwvUlq2ee1KZXKmQxoEKpWY5gfg8zi15LRaDgIHGjAt+35c0oJYAxaDT0F/I4lmWsK/t6YqW3PHZ8L4yAObCgEcHdo3SW4XeC7wk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799743; c=relaxed/simple;
	bh=VCpyIz4nKjkWSGeEJFlo4VCbFIDHAjaOkR/pMAOHCSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOO8j1u+sb4SLLP0jL/E0jifoMMT3Ari/0a7atzjharqy9f+dQrcDqUXikVIRvy+c2LDoTTfpMspQ9vaxNmQVFrlJswSZmFLq261Tan7yEDic6oozyqHYfdEGBkdrfdIMT0o724+hWTxX+YO2yXSGJTKN9iCpHvDkaRf/p39ukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2PwWHOu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779799741; x=1811335741;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VCpyIz4nKjkWSGeEJFlo4VCbFIDHAjaOkR/pMAOHCSg=;
  b=N2PwWHOulGm/YxiyuzmYK1GNtF3UGhU7DsXXq6WDQPsg3JJWsCK9nKEW
   nTOwlDTJrycO6mGJIEVJQSBTzs2NQQTVnIiY1D8Wh5vjQ6dBEJsClANwu
   LQs2NBwDO6mNeT1tAzK7tdfwOIG/Am6Xjh5V0BWsMKSu3vE0mZ2Za8UTS
   fLjt5B2kOuj4rBvNIJA+SXY/v4A5PStjK1UnMTEqBbFz6fO83r7sgIRNQ
   dMjsRT5Ix/sPlzOTCgCzHYDn9NtUM5WQsKZLcvDXOlAGgb1hJtjfFydwr
   JpNSpKvx7v1CJjFOUSYehX1XZSjQgSW6mGpvLjEb8ozcs+o1Fpxug+zWU
   w==;
X-CSE-ConnectionGUID: YWPhufCWT1mdtO6XiWMJhg==
X-CSE-MsgGUID: ZaUAPD4vTeSGvSyb8st1Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="98034368"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="98034368"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 05:49:00 -0700
X-CSE-ConnectionGUID: +1DEV9KRReCtulYpbdvNEg==
X-CSE-MsgGUID: HVqWz8g/SaKDY3+PSwr0uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="238892788"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.113]) ([10.245.244.113])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 05:48:57 -0700
Message-ID: <99f74d53-0060-4fed-b83e-955071883651@linux.intel.com>
Date: Tue, 26 May 2026 14:48:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18.y 0/5] drm/vkms: Backport generic vblank timer to fix
 ABBA deadlock
To: w15303746062 <w15303746062@163.com>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, tzimmermann@suse.de,
 mripard@kernel.org, louis.chauvet@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>
References: <9c4a68c4-43a3-4a9b-a131-9570174c8df3@linux.intel.com>
 <20260525131610.608273-1-w15303746062@163.com>
 <20260525231000.agent5-0001@kernel.org>
 <51ff85d2.9c25.19e642e591c.Coremail.w15303746062@163.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <51ff85d2.9c25.19e642e591c.Coremail.w15303746062@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254335-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[163.com,kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maarten.lankhorst@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 89E165D5C51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Den 2026-05-26 kl. 14:06, skrev w15303746062:
> 
> Hi Sasha,
> 
>> Looking at the five commits:
>>
>>  - 1/5 (74afeb812850) is the one that actually fixes the ABBA
>>    deadlock you observed under Syzkaller; it adds the generic vblank
>>    timer that replaces the open-coded vkms hrtimer path.
>>
>>  - 2/5 (d54dbb5963bd) adds new CRTC helpers for "simple use cases".
>>    No Fixes:/Cc:stable, no described bug.
>>
>>  - 3/5 (02e2681ffe1a) is a refactor that converts vkms to the new
>>    helpers. No Fixes:/Cc:stable, no described bug.
>>
>>  - 4/5 (79ae8510b5b8) is a v7.1-rc1 timeout bump that depends on 1/5.
>>    It is not yet in any released stable, so applying it to 6.18.y
>>    would put it on an LTS before any LTS contains it.
>>
>>  - 5/5 (3946d3ba9934) is a doc fix for 1/5.
>>
>> Per stable-kernel-rules, what I need to queue is the minimum set that
>> fixes the bug. Could you explain, per patch, why 2/5..5/5 are required
>> to make 1/5 work / are required to actually fix the deadlock? If only
>> 1/5 is needed, please resend just that one with your Signed-off-by
>> added (the carried patches today only have Thomas's S-o-b, which
>> breaks the chain of custody on a stable submission).
> 
> Thanks for the quick review and for pointing out the missing Signed-off-by. I apologize for that omission; it was my mistake during the cherry-pick process.
> 
> Regarding the dependency chain, I would like to clarify why commit 1/5 alone cannot fix the issue:
> 
> Commits 1/5 and 2/5 introduce the new generic vblank timer infrastructure to the DRM core but do *not* touch the vkms driver at all. 
> Commit 3/5 (02e2681ffe1a) is the actual fix that modifies `drivers/gpu/drm/vkms/vkms_crtc.c`. It removes the buggy open-coded hrtimer that causes the ABBA deadlock and switches vkms to use the new infrastructure introduced in 1/5 and 2/5. 
> 
> Therefore, 1/5, 2/5, and 3/5 form an indivisible set. Applying only 1/5 would leave the deadlock in vkms completely unpatched.
> 
> As for 4/5 and 5/5 (the timeout bump and doc fix), Maarten Lankhorst (DRM maintainer) explicitly recommended pulling in this exact 5-commit list as the proper upstream fix for this specific vkms issue (see the mailing list link in this thread). 
> 
> However, if you feel 4/5 and 5/5 introduce unnecessary risk for the 6.18.y stable tree, I can absolutely drop them and only submit 1/5, 2/5, and 3/5. 
> 
> I am preparing a v2 patch series now with my Signed-off-by added to the chain of custody. Could you let me know if you prefer the full 5-patch series as recommended by DRM maintainers, or just the minimal 3-patch series?
> 
> Best regards,
> Mingyu

5/5 might strictly speaking not be needed as it's a documentation fix and I have no idea of the policy about those.

The reporter made a bug report of an ABBA deadlock that was fixed in upstream by the first 4 patches, perhaps it's good to those attach here to this discussion.

Kind regards,
~Maarten Lankhorst

