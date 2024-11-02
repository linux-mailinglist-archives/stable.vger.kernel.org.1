Return-Path: <stable+bounces-89555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F17A9B9C9E
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 04:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0C11F2162A
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 03:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C1C12BEBB;
	Sat,  2 Nov 2024 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMBfBB4B"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D31184F
	for <stable@vger.kernel.org>; Sat,  2 Nov 2024 03:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730519837; cv=none; b=HDWxNzqPZE0dLpdtEMW9Pb8JzIR+V3n+ew9Oytl25OiSK/d1PTXItw4vo3UQxYlwMQRvtwJUG33XP/LZ4FaQLTX0hu00CSPXXB3iIM+M3326drFagw4brQ3xdV+/JAyJ6GUAoICx+Wdrgv44n8lW5NJGlarE/ymoM+lcZQ4q5U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730519837; c=relaxed/simple;
	bh=4LMNQsmE74RT+GkZTBqPveMJMZBZ/AkE+2yCBDbm6UE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IyeKLCCydXgnO36II4rwndk/7zCu73G3ZIDV2VwShtVTh1kJ136RU7wkdusR7VgLUdGMfcyB11p9i6dqmAma1FwtJPiX+RoaPa7dQJoyh4Vy35dBELkXOdg8RE5yzWjrOilokuZTFZFhzHWUThlFuofNKD8a65nx94CCzLFhZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMBfBB4B; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730519836; x=1762055836;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=4LMNQsmE74RT+GkZTBqPveMJMZBZ/AkE+2yCBDbm6UE=;
  b=GMBfBB4B5ZtBw8n4jej0KK6B0lDXChkhevQmdWMRvTQdS1vLCIKjmSl7
   4APCS4ggGwpYbf3qKcq824yYoUMPsC7kqYAIiA6U6f+Vbg/jE78t34lqr
   Zq4hLOIP07thkwkBJRzuC9yovai0aN94E3FaZVOD7fG33B6vvI4Yat7+3
   MU3XktwMb/iZU2hzSML1M0iv3p37LMIVMFC3MQvE2bwCbSIzGpxlEPzfj
   KUiuOfmORclCIeKexZFt19LBaox79gecfpyD+uYJtBZp3S7tY/ovLnPAM
   uFHKW+gO3dSh4XLASzKtPGnSoQwhBnZSbEIaizd6FLw+yipJoILeULz8F
   A==;
X-CSE-ConnectionGUID: 8lYoP4LWQa6FObhJVECBZQ==
X-CSE-MsgGUID: 2lk0vq3yRlmJBfBzweDonA==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="30507454"
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="30507454"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 20:57:15 -0700
X-CSE-ConnectionGUID: AHTzTXVXTJmP82cLEGdbZw==
X-CSE-MsgGUID: MVTxw5gVQculOPAue9DPnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="113960901"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 01 Nov 2024 20:57:14 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t75GB-000iNv-2X;
	Sat, 02 Nov 2024 03:57:11 +0000
Date: Sat, 2 Nov 2024 11:57:03 +0800
From: kernel test robot <lkp@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 6/6] phy: core: Simplify API of_phy_simple_xlate()
 implementation
Message-ID: <ZyWjD7WrwSznjchj@ef09bd9f4a59>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102-phy_core_fix-v4-6-4f06439f61b1@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v4 6/6] phy: core: Simplify API of_phy_simple_xlate() implementation
Link: https://lore.kernel.org/stable/20241102-phy_core_fix-v4-6-4f06439f61b1%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




