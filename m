Return-Path: <stable+bounces-222996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NSZB1bdp2lnkgAAu9opvQ
	(envelope-from <stable+bounces-222996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:20:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4AC1FB87C
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B48E301B73C
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9DF34D937;
	Wed,  4 Mar 2026 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNWDJEWT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49C308F1D
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608842; cv=none; b=OybSwcMl/IYH+2O0eRFI0gJNH4wpukx/gyyBSsfxELOCSxMMblxLd+WJbLQ68lEFjgRMf8KUov2Jj6oQ9rvUHSiBuiPdKOduRbPfCt45I76+xdsqTqhzp5rUHqbMFI14/8OV9tWcB+qqkAlZv4cs7rlob0ySFTmtk3Dp51hbQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608842; c=relaxed/simple;
	bh=D6GYEd3d6gvnRsSCgzPjSlNov5PrrHCdZ5y8IBebYA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/5FkAdmZdWBcLHtiRGOTV44Ct7Vny/uIUPAW3CQurwbU+FdfAYVwnj1VOKN1PKlu8rAxXYx5ysKP4OFVpO7OMeOFKsBS2TYGmIMVwIwr83ZIAHlv3baDliWj77IBTesZ90RG/kbZUGLCRnSXE8G1ddsuWwmOzCB5L6QcP6+rsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNWDJEWT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772608840; x=1804144840;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D6GYEd3d6gvnRsSCgzPjSlNov5PrrHCdZ5y8IBebYA8=;
  b=jNWDJEWTUiHLS4JQeMBoSh3iklnL6nY7R39nnbCTUMj1bjrPZVssUaog
   SV2jpk1UqKvWEj4Jbfzc6xqDxtk2etkIo57zNsNs1BQACh3JkXG0Fp16G
   ijsGUfKe4yN5aPLM8g/33LSmEuDSp9YAo/HNRvG+CzmoEOmAlKwiJY+KP
   zyoqce7a1jhc/hhVxX5XFt9WfhvzeXW/AsL/PCFq5mkKlSkNqvBK1JW5/
   tcmA+defJ1n4C50R80qmWfeHj5s1RcEWK5Vdj62H5zOOvNAVrNAB8mVTc
   jD2WV6eomDGeBMtXpdc45Re840CHIHThrZLIA7n0Je9Kvd0E9y96R2uQ5
   A==;
X-CSE-ConnectionGUID: Kpt8/4GGTIe6rY08Qj6rNg==
X-CSE-MsgGUID: tZ0DtjHOSKyQzzc725Upig==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77268457"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="77268457"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 23:20:29 -0800
X-CSE-ConnectionGUID: Rg4hloOgT4eSbbO7WSHaNA==
X-CSE-MsgGUID: 8gdJvCT/Tuy8Xmcr03vmSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="248733762"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 23:20:27 -0800
Message-ID: <3b745716-b24a-46be-95a3-fe1e34e005fb@linux.intel.com>
Date: Wed, 4 Mar 2026 15:19:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc 1/2] iommu: Do not call drivers for empty gathers
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Joerg Roedel <joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
 Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org
References: <1-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5E4AC1FB87C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-222996-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolu.lu@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,linux.intel.com:mid]
X-Rspamd-Action: no action

On 3/3/26 06:22, Jason Gunthorpe wrote:
> An empty gather is coded with start=U64_MAX, end=0 and several drivers go
> on to convert that to a size with:
> 
>   end - start + 1
> 
> Which gives 2 for an empty gather. This then causes Weird Stuff to
> happen (for example an UBSAN splat in VT-d) that is hopefully harmless,
> but maybe not.
> 
> Prevent drivers from being called right in iommu_iotlb_sync().
> 
> Auditing shows that AMD, Intel, Mediatek and RSIC-V drivers all do things
> on these empty gathers.
> 
> Further, there are several callers that can trigger empty gathers,
> especially in unusual conditions. For example iommu_map_nosync() will call
> a 0 size unmap on some error paths. Also in VFIO, iommupt and other
> places.
> 
> Cc:stable@vger.kernel.org
> Reported-by: Janusz Krzysztofik<janusz.krzysztofik@linux.intel.com>
> Closes:https://lore.kernel.org/r/11145826.aFP6jjVeTY@jkrzyszt- 
> mobl2.ger.corp.intel.com
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

