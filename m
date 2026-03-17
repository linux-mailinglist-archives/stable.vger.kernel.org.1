Return-Path: <stable+bounces-225726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL26FkuquGkthAEAu9opvQ
	(envelope-from <stable+bounces-225726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 02:11:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FBC2A27AA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 02:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F7B8300FC46
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 01:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95204248891;
	Tue, 17 Mar 2026 01:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1DIAOFd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF13221FB1;
	Tue, 17 Mar 2026 01:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773709709; cv=none; b=DFdbMP0M4wNCWDwNYsUOF8e+LqqPO7z+qXKtHvN8MtqR/rdLFjpBL9LbaP62nv+oyT3HBKs9XtnGVB3BNB/IrnR0frDEXDXNWT82xr2021slHmrnHIphD6/Wir49Zo00EkTorN6HlZDkrVtIXI32Z/F4vsAAkhYoi23mcR1Fecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773709709; c=relaxed/simple;
	bh=t1D8j0zrQbbIq63XMln2o9FOnApn4uMtRi0dHRClgRI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eTC9vUglIk4pfyK/co69yICp/qeZSqx8Ll80MI/o706WofiwDdCrghVyHXnSAenTKmLIMNkLzj8tKnOanZdLbJGOZfpniguksP+UD4GCCN6BRcGZ6SyL7sRv0fKf+ij5pfjTjOvCSqu/7yNKf1s+h53mk/u0AKew8ZjMJNdVzmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1DIAOFd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773709706; x=1805245706;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t1D8j0zrQbbIq63XMln2o9FOnApn4uMtRi0dHRClgRI=;
  b=D1DIAOFdohWM/pNrS4Sw7/ef3SqfjiKbUxawQ6CjFCO7YPV5ASmd0VTg
   j/C3spN44yTQ7t2PczIh0bVghSEMnX2YnE4VEl7oPBEtbrFTeyNKtFbrc
   4Dx7f2qMiatHEe+7BULN6kbfFKj+6eAnTX3/+VTgRwX5eKDmcELXQbdrB
   Sa38Vb9J+MleFJBA+eFqbD2gbb3NwS5HubHzfaejp7Bzm8rDWiJ9xUaTA
   trbJbcozw6FbYQs8TqFxu2dRXwJUgYKIviEtm/TncXdicWH34Y9FoMBXV
   njthLRAt3UJFaXuwk5yW5U70HD02k0HJ3SFB9BvN779Fst/LQyQumUhzu
   g==;
X-CSE-ConnectionGUID: 1FUUCrwhQY6XHs4nP9GX5g==
X-CSE-MsgGUID: R/aQKxpbRIaIX5uAldP6JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74851918"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74851918"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 18:08:26 -0700
X-CSE-ConnectionGUID: 3FDoOxl2Sa6EyOErJw+H+g==
X-CSE-MsgGUID: F3zn11BhQ6GrfwcQsWBheQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="218284611"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 18:08:24 -0700
Message-ID: <e02def98-ffa4-4467-b008-4652607b0d84@linux.intel.com>
Date: Tue, 17 Mar 2026 09:08:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Only handle IOPF for SVA when PRI is
 supported
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20260310075520.295104-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260310075520.295104-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225726-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolu.lu@linux.intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: B5FBC2A27AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/2026 3:55 PM, Lu Baolu wrote:
> In intel_svm_set_dev_pasid(), the driver unconditionally manages the IOPF
> handling during a domain transition. However, commit a86fb7717320
> ("iommu/vt-d: Allow SVA with device-specific IOPF") introduced support for
> SVA on devices that handle page faults internally without utilizing the
> PCI PRI. On such devices, the IOMMU-side IOPF infrastructure is not
> required. Calling iopf_for_domain_replace() on these devices is incorrect
> and can lead to unexpected failures during PASID attachment or unwinding.
> 
> Add a check for info->pri_supported to ensure that the IOPF queue logic
> is only invoked for devices that actually rely on the IOMMU's PRI-based
> fault handling.
> 
> Fixes: 17fce9d2336d ("iommu/vt-d: Put iopf enablement in domain attach path")
> Cc:stable@vger.kernel.org
> Suggested-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/svm.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)

Queued for v7.0-rc.

