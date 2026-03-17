Return-Path: <stable+bounces-226113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCnxHTx5uWnQGQIAu9opvQ
	(envelope-from <stable+bounces-226113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:54:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4732AD5A9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D46A30B4E76
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1857D165F16;
	Tue, 17 Mar 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KpB/NouG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EBD2C3260;
	Tue, 17 Mar 2026 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762785; cv=none; b=OJto09z0DuJwHc+FDuQ8KAnAwvTjIQWfSfmpqRt/nAUO55qwhdfGHLvXO8Suy9L6sr0VMSBQbJWQVKn9ipBY78tlfcqOdcGJh3LIJmptrz4rVB9VavyQkKkaeW5i1IteKMq761D3LmwZ4nKVMOBVRMZMIFlLAp5/5zbFvHZhhcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762785; c=relaxed/simple;
	bh=WkOtaLA4cLaCHuzz/nuzEmtsoKxReySojEhImFBeApY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uK0u/rbaXyTw2P5PApJZ+9HwtKUf9EGSoQlzRzCKtdRt7nkHTdwUxxT4h4SLE15nbQDPGnZEdbMU9hojgLmCPDfyYlARhcxEMz3iEPsnZIBKhZT/0cVYXcR9lcydGVh1QQPgJoaGuHEI3rcLtKiugfnIUunO5BpczpVgs2RB0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KpB/NouG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773762785; x=1805298785;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WkOtaLA4cLaCHuzz/nuzEmtsoKxReySojEhImFBeApY=;
  b=KpB/NouGyICkwJBEE1QO0U2W1+B2ayOkrQexhQ8ghUGxCa1R84bDofgc
   44wdKoFSybWBUD1O18ZBDa/CbpS/fw+2wqGV7VGgI7gBksxOgtp0f8VZU
   KMP3GaLOg9i2vl7NwRMepd4/5W7Yn2x9LcwMoBZmCNlFAIr6uJTCNY/Mi
   hHwVEBPFS08XE0msLvuGWxeG2LQYMNVHLiNylw6Dfgkep4u+mNC/5xMqL
   W7CicLr9kIY/yD0wunMqA55DTT4aDKGRjQ3ARFWlVuIsqaKKRkZJQWPoF
   EEUf4FCBe79xwGMgGzS48OZPR58+ANaqmOY8roD3ZLweB9GMcYdcLf0qQ
   A==;
X-CSE-ConnectionGUID: IyeZvYuhRZqsw+k1FcxjCQ==
X-CSE-MsgGUID: 8TUH6L12R4eoac7xt6DCcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78405557"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="78405557"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:53:04 -0700
X-CSE-ConnectionGUID: 17+q91BRQpuq2aU4qEISxA==
X-CSE-MsgGUID: IQ0PZSrmR/2Yh2Zt/jrEZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="252787822"
Received: from unknown (HELO [10.102.89.74]) ([10.102.89.74])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:53:01 -0700
Message-ID: <b4023056-9c0b-4bf3-aef9-91c1e72d1e73@linux.intel.com>
Date: Tue, 17 Mar 2026 16:52:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ice: fix retry for AQ command 0x06EE" has been added to
 the 5.15-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 jakub.staniszewski@linux.intel.com, pmenzel@molgen.mpg.de,
 przemyslaw.kitszel@intel.com, sx.rinitha@intel.com
References: <2026031705-nimbly-relatable-1e23@gregkh>
 <c0b7e32a-b46a-4376-a3f6-f01ccfd85622@linux.intel.com>
 <225eb7e2-c470-4307-90d5-0b56a35c4543@linux.intel.com>
 <2026031723-graceful-chaos-9ca2@gregkh>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <2026031723-graceful-chaos-9ca2@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-226113-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawid.osuchowski@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: CB4732AD5A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-17 4:39 PM, Greg KH wrote:
> On Tue, Mar 17, 2026 at 04:24:15PM +0100, Dawid Osuchowski wrote:
>> On 2026-03-17 4:14 PM, Dawid Osuchowski wrote:
>>> On 2026-03-17 1:11 PM, gregkh@linuxfoundation.org wrote:
>>>> If you, or anyone else, feels it should not be added to the stable tree,
>>>> please let <stable@vger.kernel.org> know about it.
>>>>
>>>
>>> Hey stable maintainers!
>>>
>>> This patch **depends heavily** on the change "ice: reintroduce retry
>>> mechanism for indirect AQ" which failed to apply for 5.15-stable and
>>> 6.1-stable trees.
>>>
>>> Until I can try to resolve the conflicts and resend, it might be
>>> necessary to pull this change from the 5.15-stable and 6.1-stable trees
>>> immediately as it will result in multiple WARN messages being printed
>>> into the dmesg upon issuing 'ethtool -m' on a interface under the 'ice'
>>> driver control.
>>
>> !!! FALSE ALARM - ABORT !!!
>>
>> I'm sorry, a bit of a chaotic day here at work...
>>
>> I was worried the lack of the "ice: reintroduce retry mechanism for indirect
>> AQ" patch will result in issues for users. It will not, as my colleague
>> Jakub Staniszewski politely informed me that the 5.15-stable and 6.1-stable
>> doesn't have the code from Michal Schmidt that we "reverted" using "ice:
>> reintroduce retry mechanism for indirect AQ". No warnings will be printed to
>> dmesg and everything should work correctly...
>>
>> Once again I am very sorry
> 
> No worries, I'd much rather people warn us and then say "nope, we were
> wrong" instead of not saying anything if they think there might be a
> problem.  So all is good here, thanks!
> 
> greg k-h


Thanks for understanding Greg.

Let me double check if this will break or not finally. I went in very 
hot headed and I apologize about that. I'll cool off a bit and compile 
the 5.15-stable and 6.1-stable trees and test on real hardware if this 
can remain in the trees unchanged or if some modifications are necessary.

I'll also read up on the stable process more in-depth to see how long it 
takes from the patch queue / linux-stable-rc for a given tree to be 
actually part of the next 6.1.y/5.15.y release.

Best regards
-Dawid

