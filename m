Return-Path: <stable+bounces-204269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0819CEA722
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 19:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E33D301A72F
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011F631A044;
	Tue, 30 Dec 2025 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+ySyujT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F16316910
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767118338; cv=none; b=j/5qerPP2/T6tEX+ZsRxLuNfEUpwwNGoW6GOPYdTsI/hWt5WD6PSN+ZrWqhgOiCiAQH/MQF/P8oeX2IS2rJih3Jev4IAUeJa8dTgpxIckACfExdPLKB8WMt6nurcPDGUJDSLFGPpq1x/5SCVMdQPQe9r1940vbyvwUPSMRN9R3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767118338; c=relaxed/simple;
	bh=oSJE+SBPZnqbJWDnuURdzrgegTM9FK6jNFZ1bvETCOQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=YRmC7L+VW/r/6+UPBLGKYpQ6qnMcg9kYWafmsaCYCT5WCsLO+L+qJAvSojHXCSy6fWXOHKBaYWodfK+NfyFs6N3xxE1W5rSeEbca02GD22DxEFMOYp5O0ACfu4syAlkKCyFvRmLCKl54pyus4Sl0Pa3mH47EdmfCqdBhCfyn77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+ySyujT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767118336; x=1798654336;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=oSJE+SBPZnqbJWDnuURdzrgegTM9FK6jNFZ1bvETCOQ=;
  b=C+ySyujTRCymhyQK90FBa+H5fFJGVUGDDtNk5QoQAOc6BwuGGJrf1vBE
   dmZnye/T82SVzdGSnZ8cbxKhA+1Mw7ezkLZvfPoLOF+dAYuXRwWqMcAUZ
   Wv55TdzE/c2gKAxJ6JK7lW5v9f4QjkXs1dma0yTW9Sm++ypvOpiqCuHHQ
   KEaVL3IZCIl6OKqGd1IH5JWVIXXACf/+FlXQ4o03aFmMx6ZEms0UxWsQh
   7CX5ZXXchRI3doK0pSjhjy/0eQsmM1zUDsvtI4/M7amYffp9GYSOTVzPK
   q7pzeVbxJh6v6aOSNRoOaoctqo9it5uc5OFDcQfJwbj97jPWvjJ+yHrZD
   Q==;
X-CSE-ConnectionGUID: 9sHhGlqbTVO1ChbQTRwiqA==
X-CSE-MsgGUID: N/iCkr18TR+/LGMkywXQnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11657"; a="79012711"
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="79012711"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 10:12:16 -0800
X-CSE-ConnectionGUID: RzH+oHhJS4m0D6qeGf081g==
X-CSE-MsgGUID: wTc1GHdeT7W+0N+OM8bKsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="201015188"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 10:12:17 -0800
Message-ID: <3292f903-6896-4ea3-af7f-286aeff554ac@linux.intel.com>
Date: Tue, 30 Dec 2025 10:12:15 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH STABLE] powercap: intel_rapl: Add support for Wildcat Lake
 platform
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Stable Maintainers,

I would like to request the following patch be merged to the stable tree:

Upstream commit: 39f421f2e301f995c17c35b783e2863155b3f647
Patch subject: powercap: intel_rapl: Add support for Wildcat Lake platform
Author: Srinivas Pandruvada srinivas.pandruvada@linux.intel.com
Upstream link: https://lore.kernel.org/all/20251023174532.1882008-1-srinivas.pandruvada@linux.intel.com/

Reason for stable inclusion:
It is required for Android 17 release which is based on v6.18 stable tree. You can find related
discussion in https://android-review.googlesource.com/c/kernel/common/+/3895010]. This patch
should be applied to the following stable branches: linux-6.18.y

Testing:
This patch works fine in Wildcat lake platform and it applies cleanly to linux-6.18.y branch with no conflicts.

Please let me know if you need any additional information or if there are any concerns with this stable back-port request.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


