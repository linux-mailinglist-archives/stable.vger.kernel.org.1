Return-Path: <stable+bounces-158482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 938F7AE7636
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 06:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E207AD6F5
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 04:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3301DE8BB;
	Wed, 25 Jun 2025 04:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ej2Zs27E"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016A235280;
	Wed, 25 Jun 2025 04:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750827288; cv=none; b=eOOqkugakhDstxGtkCeAPK3JeUrnOWSB9mC+UBAWwzu5EP8T0BFgARR9GTo/RsQn+rO4aqT3ubIIfSSew7f/8Ldv5P+bgPLPqv+gEyl3lX31qHF7KnvEdh88TnxKFuvZSLtedzVIXCdA9bBT8EGVuqzAE701aMx2FG7BcaimmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750827288; c=relaxed/simple;
	bh=dd9Qun5alIb832kjxzLiwo2DDL06Ewvd0ileT0Lq4iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzwcAQNRjIF2MZNz3TPKXr7E+C2F1ntUPKsAfnLY6CjjrEpMUZ8fJ1PTGDoxFJnKBDn4hPrKNdDblSA4w65qdIyasX0j95sYE42yg/yJJeYB7r0z8iFI92igZw9IvTu1VEY//Exv3gIpChGkfa74H2znwHBXKBu3vDkdRgG7uzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ej2Zs27E; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750827287; x=1782363287;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dd9Qun5alIb832kjxzLiwo2DDL06Ewvd0ileT0Lq4iI=;
  b=ej2Zs27EcZ70ss42YWC9i8d67xQnbKHYZasgOaovb8Ka6/dzIbTtAI4N
   cD8fJTr9GHkNhU3y6/bQyGtsw+QNDJFFNfJFRsD52AsRiDH/KgyL5yXLJ
   rR2728M0aQECXM64zV78jMaJy8BXX341R9fcSo/0WWe6Hy5CymVP//txX
   4mHahTF+usXiJk2/wAYg0T+bBC+rqc02082rF4VhTfKVtOCKoPOP8pfU6
   Y77MVFyC7h9ttp0p+atIDOpDLXqZp3wF5TcvVXgoQxUb7V0En4/MTb2ox
   UZG4galYEIBb9MRPpr0t3RXG/a1v1duZY16qhlJ6ux5BW3eKeQ8t//7x3
   g==;
X-CSE-ConnectionGUID: 1ApRzU4dRte27iOLR01s4Q==
X-CSE-MsgGUID: X0ZuPMRCQn2sjG0RJ36jAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64142051"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="64142051"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 21:54:45 -0700
X-CSE-ConnectionGUID: c+mawL3RRL+swpu2DZhapQ==
X-CSE-MsgGUID: kPfirjqcSd2q+AfUierqVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="175750369"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 21:54:43 -0700
Message-ID: <c2191a58-5330-406c-b6b0-951a9d370bed@linux.intel.com>
Date: Wed, 25 Jun 2025 12:53:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable ATS before cache tag assignment
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250620060802.3036137-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276371ACFE0B5CEAAA021C88C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276371ACFE0B5CEAAA021C88C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 16:33, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Friday, June 20, 2025 2:08 PM
>>
>> Commit <4f1492efb495> ("iommu/vt-d: Revert ATS timing change to fix boot
>> failure") placed the enabling of ATS in the probe_finalize callback. This
>> occurs after the default domain attachment, which is when the ATS cache
>> tag is assigned. Consequently, the device TLB cache tag is missed when the
>> domain is attached, leading to the device TLB not being invalidated in the
>> iommu_unmap paths.
>>
>> Fix it by moving the ATS enabling to the default domain attachment path,
>> ensuring ATS is enabled before the cache tag assignment.
> 
> this means ATS will never be enabled for drivers with driver_managed_dma
> set to '1', as they don't expect their devices attached to the default domain
> automatically.

You are right.

> 
> does it make more sense sticking to current way (enabling ATS in
> probe_finalize) and assigning cache tag for device tlb at that point?
> 

Yes. I will post v2 with this approach.

Thanks,
baolu

