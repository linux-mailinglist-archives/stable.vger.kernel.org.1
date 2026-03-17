Return-Path: <stable+bounces-226100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGluEypzuWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:28:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A533B2AD0AD
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACD43303AA88
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72C43EC2C2;
	Tue, 17 Mar 2026 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAQIRi6P"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC4D3EBF2F;
	Tue, 17 Mar 2026 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761061; cv=none; b=Rg0i+x8RAW0UYv2sfKF6gSKRvoZSr9XAzY/LxShyGAr/6lrDCedAcmyQNn0bZok96LnyRYLkKtgdbP9+t+UDKHwcr0kFA/LlBeiXC/Kj7MFCGU+pG0BCqCr9u8z7hZVRTH8xhX5/OSCNFXFLUXp9yXHDevga8SxfbqNwMXo+/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761061; c=relaxed/simple;
	bh=CKrPAoxvL0Iloec6BK/I4FIwW5FdQEzTQkB1o+cs2iI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZanEOtOal9A3mywPFTyI5F9ZZE/dXanr6cH+rvakxA633JmYe350QE2qkJTp9PG7DlF+fRUUJINwpnwmfncLXaNK6Hj/glEsRGAeFPaHLsV0BxRv1/ArEFLz2GfRWxmOTSqF6xxfToXMsJwtW609ZBNbMCafmuzN6WCCxuP+IMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAQIRi6P; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773761061; x=1805297061;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=CKrPAoxvL0Iloec6BK/I4FIwW5FdQEzTQkB1o+cs2iI=;
  b=NAQIRi6PQP6MRGzCSXTalTejzrdxPUWHhKnibXth8rD3wc7/Zfq/b+z9
   i0AOIy0ksxcH5EaioGeA6yD5A6T0I7B6JnDlU+w+Z8hAPZUGX6+ggK+zh
   suQoufVU7goDLDv1L6h0GY8cg4+Fo9mWiwR3aYJvYtnfiWL5mqeO10WIt
   wSlOtmZgAb2zXZO/05HzIATsRbpikJXfbyq4i1StMLFCc9lN0B14t1un5
   +lk67Mccg6HYn+ceGzbKUmvCzePrl+AOnrVs7a0/ktdRhwNFh7YaiYFlm
   PV+7uAYVAlboCaDi+oDmBenK/+Chn0SiM1RrWPNPwwvYphGUptHmKjNag
   Q==;
X-CSE-ConnectionGUID: QPQvjU0tTjCQP/UtdXGtfg==
X-CSE-MsgGUID: xPbUy/HwTQGUOMM+TGX6VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85113165"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="85113165"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:24:20 -0700
X-CSE-ConnectionGUID: sGZb7QTZSmmzL/rgeUNGCw==
X-CSE-MsgGUID: vU5T01mfRriZ1tExv5Pljg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="218429190"
Received: from unknown (HELO [10.102.89.74]) ([10.102.89.74])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:24:17 -0700
Message-ID: <225eb7e2-c470-4307-90d5-0b56a35c4543@linux.intel.com>
Date: Tue, 17 Mar 2026 16:24:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ice: fix retry for AQ command 0x06EE" has been added to
 the 5.15-stable tree
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, gregkh@linuxfoundation.org,
 aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 jakub.staniszewski@linux.intel.com, pmenzel@molgen.mpg.de,
 przemyslaw.kitszel@intel.com, sx.rinitha@intel.com
References: <2026031705-nimbly-relatable-1e23@gregkh>
 <c0b7e32a-b46a-4376-a3f6-f01ccfd85622@linux.intel.com>
Content-Language: pl, en-US
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <c0b7e32a-b46a-4376-a3f6-f01ccfd85622@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226100-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawid.osuchowski@linux.intel.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A533B2AD0AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-17 4:14 PM, Dawid Osuchowski wrote:
> On 2026-03-17 1:11 PM, gregkh@linuxfoundation.org wrote:
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
> 
> Hey stable maintainers!
> 
> This patch **depends heavily** on the change "ice: reintroduce retry 
> mechanism for indirect AQ" which failed to apply for 5.15-stable and 
> 6.1-stable trees.
> 
> Until I can try to resolve the conflicts and resend, it might be 
> necessary to pull this change from the 5.15-stable and 6.1-stable trees 
> immediately as it will result in multiple WARN messages being printed 
> into the dmesg upon issuing 'ethtool -m' on a interface under the 'ice' 
> driver control.

!!! FALSE ALARM - ABORT !!!

I'm sorry, a bit of a chaotic day here at work...

I was worried the lack of the "ice: reintroduce retry mechanism for 
indirect AQ" patch will result in issues for users. It will not, as my 
colleague Jakub Staniszewski politely informed me that the 5.15-stable 
and 6.1-stable doesn't have the code from Michal Schmidt that we 
"reverted" using "ice: reintroduce retry mechanism for indirect AQ". No 
warnings will be printed to dmesg and everything should work correctly...

Once again I am very sorry
-Dawid


