Return-Path: <stable+bounces-119506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A51A44142
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52C877AAB8F
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB032698AE;
	Tue, 25 Feb 2025 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XF2rjCgP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32F2269837
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491210; cv=none; b=U4gP1vvr7BJt1oGGEO8TDytqdzUZSt/jdLYgkEHrQUPUTcRMQDfPNTndXUu9FLDtdqJnzeLcR/DlCnx73obfbzYfxSfI1bxKVX9aPS9DmYNeeQdHzOa7S45ifOllIvb3I5nwdznsrbYQllrvs7gBxhgDeRtJ07YKRY/Rs1MznGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491210; c=relaxed/simple;
	bh=Km2KIT046jnyJlSCBZuePZUSvEIIe9O957LoKl3ShyE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KMjUS/LYVbSSxyiJIAHk256ZHGXOmbXmkjEV+8jZjzONb8G+3RjlMsKyce4EzpbEGaT/AVsYuoHsCmV1C8A8VW0p/8T+YnxF1gvXpq98qElxrGgsJYY1aejZ65697U0+0l0dr4eLlHe1+w4WHaJWfl9ZLJMs8AKjh6DW/zE3eBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XF2rjCgP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740491209; x=1772027209;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Km2KIT046jnyJlSCBZuePZUSvEIIe9O957LoKl3ShyE=;
  b=XF2rjCgPwB//rUjMOFd0s/yyHtu3J5MfGbT30Div5dnOXFXC6eiMPjsy
   doRWTCwicjq3pC8Q1PE/7wkn5L48eTBOXSd8a2imeQRVYsynr5M7NWo99
   HBR6BzRXzeMKVJPcmQYEcf3WE5mnmLAJLngSofzUkQFLMgkSNWz5hcrIE
   l+HQCHbCBXqWnaEFOVcIHEx1LipDuHFKXNWnQ2yjAa9dfJIRBKi59nE4x
   jQM2eeDAut+JtS8qEEh/m3nVIcrCsX7INLniu4Mpw9kt2YKGzQKwI3dQh
   rnNuanW7+UydlRIWfF0t6OQOx9TJFiXRnGjJsH/dVENeqczKk4uz4w1zj
   g==;
X-CSE-ConnectionGUID: mhrtxVr2RqaO/nWaGrZMaQ==
X-CSE-MsgGUID: zhAk9RZ6RT+xhZHyH8Y2qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="51931935"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="51931935"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 05:46:48 -0800
X-CSE-ConnectionGUID: QE0qsuZ/RGire+pe1QDxdA==
X-CSE-MsgGUID: FXoFclDjSva8ZgRoep5M9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117320515"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 25 Feb 2025 05:46:46 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmvGm-000AJ6-1N;
	Tue, 25 Feb 2025 13:46:44 +0000
Date: Tue, 25 Feb 2025 21:45:58 +0800
From: kernel test robot <lkp@intel.com>
To: niravkumar.l.rabara@intel.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH RESEND v2] arm64: dts: socfpga: agilex: Add dma channel
 id for spi
Message-ID: <Z73JlgLQHLTupk_y@37ee6694ac45>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225133919.4128252-1-niravkumar.l.rabara@intel.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH RESEND v2] arm64: dts: socfpga: agilex: Add dma channel id for spi
Link: https://lore.kernel.org/stable/20250225133919.4128252-1-niravkumar.l.rabara%40intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




