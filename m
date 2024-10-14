Return-Path: <stable+bounces-83657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F6099BD63
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 03:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9F42B20E6B
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 01:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C2F33C9;
	Mon, 14 Oct 2024 01:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJvYhZ4j"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B01812B71;
	Mon, 14 Oct 2024 01:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728869966; cv=none; b=chCFrNcOTb0+kWXGVe+PONFszVK5tcrGULwJXOTi6cHaLYo6lvUcBav+WBgPwG0uFaMXDZzZzjhkPik0zL9Mz0xBtAk4KIqSLtBWwY/MXrHP0Je/nM7z85XwmTYqDMS1o0hhl9KRUbk068k21ytwvrL9UjNml52gNCB+HyCN4NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728869966; c=relaxed/simple;
	bh=9yGpnLRQqo4qFc61E+nRYS3zDFC+qK7mTDtGZhkszFI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jbF/2N+0KbOXKNikmAKLW+LK/Fvmg7QgJ3eKOYPbZilSeKvz6KQ8zeTqRzNLvj+bHd756ZQSorVLSttZiXFJeQhMaxBqZ+kZy8ZbInf3+SS07BkKX/4IXZ+7lFoKE9mTShFgX5qAf6bKRQqkLjrsDSjVAIu/FsF+wAVYwgg/wcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJvYhZ4j; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728869966; x=1760405966;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9yGpnLRQqo4qFc61E+nRYS3zDFC+qK7mTDtGZhkszFI=;
  b=LJvYhZ4j4oRxAnJXsrk7Y2bRtVOO0QNLWR0sZtpOe8+UMgl5GOppKoUx
   ruA+92e4NyjkVcUzc//C1M4qUtam9Kj9U5+bVBYzQNrTmgVYOu6tRFUUd
   6GBo2BzWzZ4La5fY/WsIJ6PYycW0EAUWBAHsNPYQdTRj7Zn5QpNP9xh3l
   1NHO5xjWyT/FBNztRpfo1Zo8WEjoj22tVlv6SGKTWPqJkuID/mwsJKM+f
   8v/FMmtqIRa4tle1giOs4uyYNo+iJU+cYl5FVn1LdIt9qc5xuQuBuxk26
   88wIp3E8yEgEl13jP6sm0YAtpZRyfgCLXc0eP+xXZHweAnjoyDJUfTcFQ
   w==;
X-CSE-ConnectionGUID: OXiFJj6xTz+fE9Wnoa/u/A==
X-CSE-MsgGUID: RKGGdDCISEOh+duDm40M4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31899879"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31899879"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 18:39:25 -0700
X-CSE-ConnectionGUID: ivQGbxgCR3a8hFE/jjo/7g==
X-CSE-MsgGUID: Ttu0Sd/GRdeaxNfmb6/gwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="78252560"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 18:39:22 -0700
Message-ID: <e81fb7bb-4a80-4c45-b9fa-5fc485e134ca@linux.intel.com>
Date: Mon, 14 Oct 2024 09:39:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Todd Brandt <todd.e.brandt@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect pci_for_each_dma_alias()
 for non-PCI devices
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>
References: <20241012030720.90218-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241012030720.90218-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/12 11:07, Lu Baolu wrote:
> Previously, the domain_context_clear() function incorrectly called
> pci_for_each_dma_alias() to set up context entries for non-PCI devices.
> This could lead to kernel hangs or other unexpected behavior.
> 
> Add a check to only call pci_for_each_dma_alias() for PCI devices. For
> non-PCI devices, domain_context_clear_one() is called directly.
> 
> Reported-by: Todd Brandt<todd.e.brandt@intel.com>
> Closes:https://bugzilla.kernel.org/show_bug.cgi?id=219363
> Fixes: 9a16ab9d6402 ("iommu/vt-d: Make context clearing consistent with context mapping")
> Cc:stable@vger.kernel.org
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Queued for v6.12-rc.

Thanks,
baolu

