Return-Path: <stable+bounces-222997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A5mFXTdp2lnkgAAu9opvQ
	(envelope-from <stable+bounces-222997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:21:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B85271FB88A
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D02F13015A41
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2D734D385;
	Wed,  4 Mar 2026 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4YmKS1M"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412E308F1D
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608847; cv=none; b=eyU1vmyKF0TD/+ZE5tg7IuwoIFGWC4W/A+IgQ3G5D7GSvnTBmLaoEdkqdcygoypUVsKJHVqTiMmevJpjBMVNHy5guQQPQecd65VcCxbRXpVMxd0o7C4Kv6rTUKPT4L/Z8LF7CEDH6Ko7kCxZDHr338I633K/mkdjgITtBgqB648=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608847; c=relaxed/simple;
	bh=gs/g+FFrHcAMrvZFa5tAqEwg8s88EPVlvR7P02Xxxlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFvSW/q4raRSQDF3KuHY0YrJaCGaLQW7CdwfzUMEZI5s/7CEX1ju4cBufKmSVM6bxT4gk4fYjYYsd5fh6J4SSKGO5liSfX4iApZTuwji0XQfiN5D1dTQrchlT4FE0yz/vSYcjh3CBlVBezjPR1I8OqjrWg4E++5Txz6ofMhsAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4YmKS1M; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772608846; x=1804144846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gs/g+FFrHcAMrvZFa5tAqEwg8s88EPVlvR7P02Xxxlo=;
  b=Y4YmKS1MXpFQoPRIJVbYC6MZMR+YT3M37r+sz1ZAb3ONU733ZwLpsz4/
   uzhi2pnKTAOwe9EbqnycqGe9xaf+4OXp/Rb3FJUPp7yoipMIHaDi3GSmA
   +0JVjlh2qaeQ4mOQYCH6X+7szc3cMEoDif1YwHKDo+9eo5MBOIXc8cLp/
   xxJ2EpAhGGLX5dGth6H1WOgx1YFTXuteNiNyIWLHP1bS4tF6/Ox1SG2Yx
   IbwZbFSK6qySk0yWk4bbzgvbAoo7jzPRb0Igs1i6ygYbCzkfTIYZoRLwp
   QQSLz7xR+o4BvEPoa8jaA8Gos1Ah0qeqWqEwdpMOgem+PQzmsWbmR5LSD
   w==;
X-CSE-ConnectionGUID: a5HFcQgNQ+GYVkRCr96LnQ==
X-CSE-MsgGUID: bgT0ShF7QhO3K6ilukuziA==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77268481"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="77268481"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 23:20:46 -0800
X-CSE-ConnectionGUID: A5+kVgiXSn+sq0RUQkrTbA==
X-CSE-MsgGUID: Ni1cf27lSROwdTV1k7mGgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="248733775"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 23:20:44 -0800
Message-ID: <bf7ba077-ecc0-4ff5-918d-c724b96bb0f6@linux.intel.com>
Date: Wed, 4 Mar 2026 15:20:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc 2/2] iommupt: Fix short gather if the unmap goes into a
 large mapping
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Joerg Roedel <joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
 Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org
References: <2-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B85271FB88A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-222997-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolu.lu@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.intel.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

On 3/3/26 06:22, Jason Gunthorpe wrote:
> unmap has the odd behavior that it can unmap more than requested if the
> ending point lands within the middle of a large or contiguous IOPTE.
> 
> In this case the gather should flush everything unmapped which can be
> larger than what was requested to be unmapped. The gather was only
> flushing the range requested to be unmapped, not extending to the extra
> range, resulting in a short invalidation if the caller hits this special
> condition.
> 
> This was found by the new invalidation/gather test I am adding in
> preparation for ARMv8. Claude deduced the root cause.
> 
> As far as I remember nothing relies on unmapping a large entry, so this is
> likely not a triggerable bug.
> 
> Cc:stable@vger.kernel.org
> Fixes: 7c53f4238aa8 ("iommupt: Add unmap_pages op")
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

