Return-Path: <stable+bounces-226096-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNzWLrtxuWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226096-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:22:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4002E2ACEF6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52F5B31C25AF
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2643EB81E;
	Tue, 17 Mar 2026 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXNXgSI3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6605D3EBF2D;
	Tue, 17 Mar 2026 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760491; cv=none; b=bg0i+tA8e1/PtuiCgqZFrcpEbvLy9K6TOA2S0/m4fYajuKVl3sCaFCzxCBLahoOaymH1deiA4/YfH/Yav0Iz1EJEl+HUnbV16ylvHM3J80Js2K1FaUCrcVWIrqsnaRU3BGbHm3mDnf706eCpUo9H7WedWO3o5L5HmUOgKF29q/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760491; c=relaxed/simple;
	bh=kTMCfO3inlCSoJk0IYOgplNZOt0cPoJe0s1YkJNQ1n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePKMmBdD5pa3RRBS16O0YakV/k5Ge0xWlDdBrfFaVsqzjPV2vbT1tDj+2OwptmmAiytl5IhTckhq/erDU3LBqE7P13fO66RM7TWrGyJ8tthdj04Ncyk5YNpdaZe0q2B32y1sBi+3+W1ikslrWy6S3tzOik17lQrJeEt4pTCXZYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXNXgSI3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773760490; x=1805296490;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kTMCfO3inlCSoJk0IYOgplNZOt0cPoJe0s1YkJNQ1n8=;
  b=TXNXgSI3/zWz9DxS6WJt68qso526gDCVIMKlEsbAj3Z5+6U2SojpCtgn
   dH+Gu17BQkWRBsjsPlzH6xuzARq59cY1WJXb8I5aU8iEdd1cgrgI3GuJg
   cdoHWIgtcHbFG3zneXNIwg0Io/5ZVGCu/m1yWvYn1u0NsKmZ6Jg1vVDIK
   PqYPqzguS9VZStdKnVV7l4kJeDqVp+gmvOiLf817rFyr7vcOmWk9NaLt0
   oO18VX8bitf9HhL2KBgkz5nVK6qBO93yUlVWwJiuDIDDjmECnvcFL4oWr
   npnhj1QPH/LD568aMzBVVHATjWS6/MKT4Dr82OVBNRXvZieA1I624AvqV
   g==;
X-CSE-ConnectionGUID: yeWgs85cTquYc8Ibb6FniA==
X-CSE-MsgGUID: sXUTrFI4R+qXxpn6ffvUsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74980755"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74980755"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:14:49 -0700
X-CSE-ConnectionGUID: b/C1BBnjQe+4OHwYMljn3w==
X-CSE-MsgGUID: sV4l2XR6RJGjG0ITmsce/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="217983031"
Received: from unknown (HELO [10.102.89.74]) ([10.102.89.74])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:14:47 -0700
Message-ID: <c0b7e32a-b46a-4376-a3f6-f01ccfd85622@linux.intel.com>
Date: Tue, 17 Mar 2026 16:14:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ice: fix retry for AQ command 0x06EE" has been added to
 the 5.15-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, gregkh@linuxfoundation.org,
 aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 jakub.staniszewski@linux.intel.com, pmenzel@molgen.mpg.de,
 przemyslaw.kitszel@intel.com, sx.rinitha@intel.com
References: <2026031705-nimbly-relatable-1e23@gregkh>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <2026031705-nimbly-relatable-1e23@gregkh>
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
	TAGGED_FROM(0.00)[bounces-226096-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4002E2ACEF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-17 1:11 PM, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>      ice: fix retry for AQ command 0x06EE
> 
> to the 5.15-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       ice-fix-retry-for-aq-command-0x06ee.patch
> and it can be found in the queue-5.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

Hey stable maintainers!

This patch **depends heavily** on the change "ice: reintroduce retry 
mechanism for indirect AQ" which failed to apply for 5.15-stable and 
6.1-stable trees.

Until I can try to resolve the conflicts and resend, it might be 
necessary to pull this change from the 5.15-stable and 6.1-stable trees 
immediately as it will result in multiple WARN messages being printed 
into the dmesg upon issuing 'ethtool -m' on a interface under the 'ice' 
driver control.

What is the timeline is for resending a conflict free version of the 
"ice: reintroduce retry mechanism for indirect AQ" patch for 5.15-stable 
and 6.1-stable? And ensuring that the "ice: reintroduce retry mechanism 
for indirect AQ" commit lands in the tree before "ice: fix retry for AQ 
command 0x06EE"?

I don't know how to make that requirement / relation between commits 
known for stable. I didn't find anything in the docs and I assumed if 
the whole series doesn't get applied to a given tree (e.g. 5.15-stable 
and 6.1-stable as is the case here) then the rest also doesn't. If 
there's a way to hint at that for future submissions, please share the 
relevant doc / guideline. Sorry!

Best regards
Dawid

