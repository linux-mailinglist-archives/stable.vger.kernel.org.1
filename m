Return-Path: <stable+bounces-227352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOD8HrszvGl3uwIAu9opvQ
	(envelope-from <stable+bounces-227352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:34:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7981D2D015C
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3094300AD8F
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B158D35A38F;
	Thu, 19 Mar 2026 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2eU1UdS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E042ED870
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941039; cv=none; b=rLj9O1uFmOH4HF1eJQpvyVSDeFMNVNIyBRAX5yPeFkiO8s+Vxd1CUFDS/JGONHJGiuOakUtUTR5x55aGuVAyd734hEG55u9EcubJFKgI2lBM4XrzJrqCRshZZPu0OPcL8Z22AzP1u7UQda/ZZoh6HztcofqA0+KxvKte99oIdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941039; c=relaxed/simple;
	bh=CYwEZfYc13dbwPHwddAoB03lq+V/tAJQTzkgW1sCysc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrlnSz/cbQu5t+YNxpGJBvDOb31MzrU7JQJzR7/25+/FfgKpf8QX/rpNrPbGl9fv61SueE6S98KAm41bni0quhFQbRv9Thk40mttfadA0zHATMzUPJHkXZ12PAsoJOxVhnOyhuujw3LzaK+7FmSwiZbu3LGHKbbIoWhZNtvqCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2eU1UdS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773941038; x=1805477038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CYwEZfYc13dbwPHwddAoB03lq+V/tAJQTzkgW1sCysc=;
  b=f2eU1UdS8E/Ac1NAH2e7IzHwYoPGnegXe3Tp8DR6nJnBcR/qMyIhr0Lj
   JpY89mB9ScegUTDd18lq8un4lUkfp2MuFqcrmnO0B7KIIvi49SAdl5qSW
   LYPJpKKsu596iPNaGK9jKpuLEraREOWjO50+WesC9WwMHn04vAqSDQRjS
   BnZZu9ho9UANU2W8ElpOlPpfu9qbzmUS7qGeCBHVrfdhKW5SaBj2l6LHI
   6LOt2wcpm/j3u9KSK6ANb02uDsDXzghBjWd4Rxez0c1Z86KEXc+SqYZ7V
   5ste8h8X9ccwsktbvVXRnW2+IBqxFD9CoqjHml0Cowqn/eXQ3sdDIdYSO
   g==;
X-CSE-ConnectionGUID: 4w1iGaf6TyqnegOGuEoWxQ==
X-CSE-MsgGUID: unS2yH4RT+OmLvwJiiCJKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="97634933"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="97634933"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 10:23:56 -0700
X-CSE-ConnectionGUID: 05xTASooS96BQAHb5y5Afw==
X-CSE-MsgGUID: ntkKk4NfQC60LxLl7hriFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="223245187"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.189]) ([172.28.180.189])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 10:23:54 -0700
Message-ID: <f66d988c-3125-4753-bd63-2f0d6ae15dbc@linux.intel.com>
Date: Thu, 19 Mar 2026 18:23:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y 3/3] ice: reintroduce retry mechanism for indirect
 AQ
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
 Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
 Michal Schmidt <mschmidt@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Rinitha S <sx.rinitha@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <2026031701-reapprove-dollar-1839@gregkh>
 <20260318000947.379271-1-sashal@kernel.org>
 <20260318000947.379271-3-sashal@kernel.org>
 <fd3ab8b8-708f-43a6-84be-e6cf98fb2463@linux.intel.com>
 <abwoRsrQ-dOKp8TF@laps>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <abwoRsrQ-dOKp8TF@laps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-227352-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawid.osuchowski@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,linux.intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7981D2D015C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-19 5:45 PM, Sasha Levin wrote:
> On Thu, Mar 19, 2026 at 04:49:56PM +0100, Dawid Osuchowski wrote:
>> On 2026-03-18 1:09 AM, Sasha Levin wrote:
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> Hey Sasha,
>>
>> Thank you for trying to reapply this patch. Unfortunately for 6.1.167- 
>> rc1 this will not work, we tried this with my colleague Jakub 
>> Staniszewski and got the following output:
>>
>> # git am sasha_levin_ice_6_1_y.mbox
>> Applying: ice: reintroduce retry mechanism for indirect AQ
> 
> I think that your mbox is missing the first two patches in this series :)

Yep... I saw the [PATCH 6.1.y 3/3], but didn't realize the first two 
patches are backports of the prerequisites for this to apply cleanly... 
I thought it was some other unrelated patches ^^

You live you learn I guess. This is the first time where any patches I 
am involved with failed to apply cleanly to the stable trees, so I hope 
you will forgive my ignorance on this, heh.

I will try to do better next time :)

Thanks
~Dawid

