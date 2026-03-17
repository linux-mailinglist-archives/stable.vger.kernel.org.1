Return-Path: <stable+bounces-226097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNGcFtxxuWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:23:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C666B2ACF24
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 146433046DA3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4DA3EB7ED;
	Tue, 17 Mar 2026 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGAvgQAs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C2D28DB54;
	Tue, 17 Mar 2026 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760653; cv=none; b=sAXpT3pDGsH/b5LObnfSGw0wHQ8XGpOlEawKQeqHhwMu+KT9FAMpRtTPRjdxnp9xx/IcWnO5IkNT5f5gOaXh5wQQ++K/0c+ziXX24bK+AhQ9lXEQqPPvKJ8wGyc5jKaTun1RLb4vqoTXaWIkQ7O8iH9dJ3iaTNed5bfWOZ/7itU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760653; c=relaxed/simple;
	bh=fXhAv80TDNHx6q3VvIjQK76KxGjBlPUfNt1wuEPppcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRyuO3TZV8sxenLAuhCQF02eE1l6LnBHqBpJzbjrXOvLuffpCB+Apl474HJY3R98keR85ECK+ncIP7XP5x2DbtGgfOFTIHF0/U4Y4dLlLFpEMxtEJki/WJr68XsZoiP9Qfn+PvoZzKEBaI9mUE90sTUL4lqdn+tikKuJwtksYck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGAvgQAs; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773760653; x=1805296653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fXhAv80TDNHx6q3VvIjQK76KxGjBlPUfNt1wuEPppcY=;
  b=GGAvgQAs1NocbrBYtbUaa6mKZdexBxS0PWf6wWvpukKs372Fw2D2yo0b
   fOXw/OuwGiLuBxugNWFOs6WUsqOaMm4iHCR+3kvNik9BgYFsRSARuCUeS
   Fvgy3EQy3D3+QMAhz4ST/onxewMM/xTe79VanHAbiJs34T2ksghQJRCFe
   G0CKvzgtu1AOM4/Lj5zujO46VckHoLPinxxiEFg+vfFV+E7lfZdxRCImw
   kZ4keksBoN414xz0rmhzmlZFRzrZWeF0JquZVdhTrCdXS1vqF9IePC8cQ
   ij79+nqON15f6XDZabrflM0tjnTgLf9yBVwc32BParK1lDbMX/hTdGjuC
   w==;
X-CSE-ConnectionGUID: wu6XD01ATO2Rq5ZgoZ0e9w==
X-CSE-MsgGUID: JMD/mjF/SUCCyJLWKgw6BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85112158"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="85112158"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:17:32 -0700
X-CSE-ConnectionGUID: T/bKUvGIRT6Y3lXqzIhgkw==
X-CSE-MsgGUID: IUVvh4KzS8uOFgJRceiyUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="218427856"
Received: from unknown (HELO [10.102.89.74]) ([10.102.89.74])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:17:30 -0700
Message-ID: <e9720578-7922-40c0-8c18-d2856180a884@linux.intel.com>
Date: Tue, 17 Mar 2026 16:17:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ice: fix retry for AQ command 0x06EE" has been added to
 the 6.1-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, gregkh@linuxfoundation.org,
 aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 jakub.staniszewski@linux.intel.com, pmenzel@molgen.mpg.de,
 przemyslaw.kitszel@intel.com, sx.rinitha@intel.com
References: <2026031719-kiwi-anagram-b69c@gregkh>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <2026031719-kiwi-anagram-b69c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226097-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,linux.intel.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: C666B2ACF24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-17 1:11 PM, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>      ice: fix retry for AQ command 0x06EE
> 
> to the 6.1-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       ice-fix-retry-for-aq-command-0x06ee.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

Hey stable maintainers!

This patch **depends heavily** on the change "ice: reintroduce retry 
mechanism for indirect AQ" which failed to apply for 6.1-stable and 
5.15-stable trees.

Until I can try to resolve the conflicts and resend, it might be 
necessary to pull this change from the 6.1-stable and 5.15-stable trees 
immediately as it will result in multiple WARN messages being printed 
into the dmesg upon issuing 'ethtool -m' on a interface under the 'ice' 
driver control.

What is the timeline is for resending a conflict free version of the 
"ice: reintroduce retry mechanism for indirect AQ" patch for 6.1-stable 
and 5.15-stable? And ensuring that the "ice: reintroduce retry mechanism 
for indirect AQ" commit lands in the tree before "ice: fix retry for AQ 
command 0x06EE"?

I don't know how to make that requirement / relation between commits 
known for stable. I didn't find anything in the docs and I assumed if 
the whole series doesn't get applied to a given tree (e.g. 6.1-stable 
and 5.15-stable as is the case here) then the rest also doesn't. If 
there's a way to hint at that for future submissions, please share the 
relevant doc / guideline. Sorry!

Best regards
Dawid

