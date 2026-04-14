Return-Path: <stable+bounces-237780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD2ENdUX3mlBmwkAu9opvQ
	(envelope-from <stable+bounces-237780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:32:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE083F8BE6
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6320E30B824C
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E18E3D5658;
	Tue, 14 Apr 2026 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iD8YaJT4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD13D4137
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162399; cv=none; b=ZoOlid0gYK2jx/EAiCRLLAz0ry5DGE1Q6/LuxTQkqAVGOqyolQe3czXspsy5Lw/ThxeCLNARqaeVHiwJnHZfA4l3uOC24RlY4KYDRS0wU/dYBWURB3TOeIx3IQiNvRuqk3/4efwxycSwelAX0XRYwpr3macnh6Rn/5oWU8AF7wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162399; c=relaxed/simple;
	bh=ryBPjDFBhZHxlXdVvV7eSlw6JpC9aOy6QBbU9DuWzSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTI8Fk9ITLvy7tLyeL4ES9ZBeUoZXFwO2vT9RGq32UignSqV0kV/olFwB+lC67xtqZhIaLhUvNoSslKCFEzS+uueHXOgKAwYwXhAnxguRiFRhBb3DE41KkVNQrZYEYSUAIVVr5rOWPsc1JQzBYVCh8q9dQspSIFb39W1z+4U5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iD8YaJT4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776162395; x=1807698395;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ryBPjDFBhZHxlXdVvV7eSlw6JpC9aOy6QBbU9DuWzSw=;
  b=iD8YaJT4n/nA4uq/MEYfOua+wsLy9UZ9IlFokX5p2KcxR0GtguL6osce
   9lcT0hDVHv/jjmqRfOYfkmCiidRkZMjpdJ6boZJjaVL5A4qZheZ9u3k9j
   jPpWeebggHtAWejzkzyRGnSGp1UVHLss612XbvjUmFm/MFpyfUcqrwu22
   p4NpuVrRt07e6evM3X6u3jGZk8qpgFcAG3lXr//5t5JZYjXnIp8a/43Ie
   cfYL4YI5tSPXricFVLtNmMv/GUiC0nU5lRUnb/epz/kOrYvYuhbmCKILr
   SlFh16K7HFa3ntLAfNCs0BSZtpNZmm7xp8jcT/K35COGzcq9pXHm3SK5o
   w==;
X-CSE-ConnectionGUID: xv+6djADTGGgnxIxfMLKkg==
X-CSE-MsgGUID: ipmaOYHFT2KqwdHQV/K1MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="102571117"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="102571117"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 03:26:32 -0700
X-CSE-ConnectionGUID: n9zZ52jyRge4c+1ydhqnBQ==
X-CSE-MsgGUID: /5s86mPoRu+RAs9ZvIH8Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253279076"
Received: from avbakuno-mobl.ccr.corp.intel.com (HELO [10.246.16.61]) ([10.246.16.61])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 03:26:30 -0700
Message-ID: <9efe2c87-fbe4-4adc-ae15-7acb3c8fe26a@linux.intel.com>
Date: Tue, 14 Apr 2026 12:26:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] i40e: Cleanup PTP pins on
 probe failure
To: Matt Vollrath <tactii@gmail.com>, intel-wired-lan@osuosl.org
Cc: Kohei Enju <kohei@enjuk.jp>, stable@vger.kernel.org
References: <20260407161447.43645-1-tactii@gmail.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260407161447.43645-1-tactii@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237780-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,osuosl.org];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawid.osuchowski@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 4DE083F8BE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-07 6:14 PM, Matt Vollrath wrote:
> PTP pin structs are allocated early in probe, but never cleaned up.
> 
> Fix this by calling i40e_ptp_free_pins in the error path.
> 
> To support this, i40e_ptp_free_pins is added to the header and
> pin_config is correctly nullified after being freed.
> 
> This has been an issue since i40e_ptp_alloc_pins was introduced.
> 
> Fixes: 1050713026a08 ("i40e: add support for PTP external synchronization clock")
> Reported-by: Kohei Enju <kohei@enjuk.jp>
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> ---

Hey Matt,

I wrote a comment on your "[PATCH iwl-net v2] e1000e: Unroll PTP in 
probe error handling" submission about the changelog positioning and 
CCing stable.

For this patch right here I see the Cc: tag is added correctly to the 
commit msg body, but the changelog is inserted in the same way as in the 
submission I mentioned above.

Not a blocker by any means, but just wanted to let you know for future 
submissions to take this into account.

Thanks
~Dawid

