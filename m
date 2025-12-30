Return-Path: <stable+bounces-204271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3EDCEA780
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 19:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87027301E930
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12832C329;
	Tue, 30 Dec 2025 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtutVDB5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F623231C91
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767119275; cv=none; b=pHfAP/tCbHBCtCAqVtV2eojqTZKK6NBr2a9xg71fDCiK3eDlniEmFHqizds2n1sI+0Sh4eLATsv4frWd1FbxjOjURm75hFo+gmaRDzewChlrB5QbBSo9p97u/6y7PF+bYl6lTlJ7n/rX864KrtwEe8rr2zVF8s3v+H/Fq7qUk6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767119275; c=relaxed/simple;
	bh=dYRDkC/oKLOue3PjdGIWgKxlpFbsXkFHvM/FdYEFzmQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=APmoY7aDMYOqfGGX5kFwUatSD61LVFxrSc4rdQFvUraZE2KWdRZ+YmGaW+iIDQaPMRCuaRUxS6AK43iu2JFTYj8j7EDcHSVK8ZK08LEYbE70y+zGimLzmh5eaxJJmYJ4VnduCsedxy1zXwSafkwpd6rXlyBLu660SGmOVYlH/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtutVDB5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767119273; x=1798655273;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=dYRDkC/oKLOue3PjdGIWgKxlpFbsXkFHvM/FdYEFzmQ=;
  b=jtutVDB5oE9mLW8Wo8J/ikcT+VqdiaNFAGFPnnMijkP1OQNuRwM/8ysh
   qTUFu3b9EwxbAgVxIPAF0Dmou/xcH0E0FizQpILqzzzKJgI3WJIA9e8fA
   wcRR5As9tLXamxPpyJCASteIOj4Q0ebLzHZ+gpxvOhEM9JCwrBme/PfBy
   1HmajFn3NSlhPQm62M/NXxH0mcbIhmH3Puzpo0DgjDTxzTreYqxXl0HQq
   cVmG1nqEa3OS4BbjDUN6m+a5vz9Aj+Km29WzzbL6671FJtYn3vkm3yd2M
   ByALUBG13R3ZNRyOxjPWnQwks724oyb3tLBbrVvykvgrS1y672qhEOaPq
   Q==;
X-CSE-ConnectionGUID: ZWocGm0zQlaMKW2W3GxkGQ==
X-CSE-MsgGUID: qAQgDKE3SsaA8q1OxRdUMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11657"; a="80158678"
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="80158678"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 10:27:53 -0800
X-CSE-ConnectionGUID: o4HBOwgPQsy7eh6OEMr1TA==
X-CSE-MsgGUID: wv9Eadp7S9WFLC/zobdKSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="202218558"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 10:27:52 -0800
Message-ID: <f83c0d52-b435-422e-b8ab-b6362bb4e51f@linux.intel.com>
Date: Tue, 30 Dec 2025 10:27:52 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: kaushlendra.kumar@intel.com
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH STABLE] powercap: intel_rapl: Add support for NOVALAKE
 processors
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Stable Maintainers,

I would like to request the following patch be merged to the stable tree:

Upstream commit: 58075aec92a8141fd7f42e1c36d1bc54552c015e
Patch subject: powercap: intel_rapl: Add support for NOVALAKE processors
Author: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Upstream link: https://lore.kernel.org/all/20251028101814.3482508-1-kaushlendra.kumar@intel.com/

Reason for stable inclusion:
It is required for Android 17 release which is based on v6.18 stable tree. You can find related
discussion in https://android-review.googlesource.com/c/kernel/common/+/3895011. This patch
should be applied to the following kernel versions: v6.18

This patch applies cleanly to v6.18 stable branch with no conflicts.

Please let me know if you need any additional information or if there are any concerns with this stable back-port request.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


