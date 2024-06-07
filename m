Return-Path: <stable+bounces-49943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBAF8FFA38
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 05:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714CF2862A9
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 03:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6FA175B1;
	Fri,  7 Jun 2024 03:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4ows6Lz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1F179DC
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 03:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717731626; cv=none; b=HZZ1EsZOCK+GTME5ykr7N4f7Pcdx3JhplipDsf6/T4nLN7VsGUShBQj+f2gxnwvVAuy2VojxCbHHLUqFybGnbax97gBz+m210ydrMhet0EBLz9GwR0+RzBSL293zFxN/HFdUezK6TWIJbn4pqiGh7L2pUvk2qmbkgewbfBQwc4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717731626; c=relaxed/simple;
	bh=rPJ5ufAViNYhCGjh+ZuXBltquKOKg7geswHuJeUpgpY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MYivKxzaRpEdN2vJAqg1NGW2HNoqOe6NvP/8bLwaPOVS19bMiVIU7n0QS9a6L7tA3zpYuAzqkKnRmUtbpMG5vfRA03VmDaqwJ0M2MdzotFsQZKEzzt0tO7+SXaA8+r7cR3RKB04LgmERH5aIgbru2bS/8Oe69IO0BJmYiah+nNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4ows6Lz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717731623; x=1749267623;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=rPJ5ufAViNYhCGjh+ZuXBltquKOKg7geswHuJeUpgpY=;
  b=E4ows6Lz6PP7iYfUGRLVa9nmgFhzcefjY17SRO3Xbk8CK/ikID6GSQbk
   NnyayZpv7aDsszOY2BxScO0hV4nLsApZTb+vV/KR3mJydF5CpYrTShk6J
   QLGFA5leOistqwqSBGiR35I73NOxDWq9GAqhcqF4UGBxA1MDJE9YCggmB
   NcXS8Yspsz3VmeLDRJfMoipWIsn6CKsP/9Ovmv8b/h9t5EOW2xzWvXjJ/
   2bOqMeJCimV0mo4tU6nF6UhzojgYxF+EewiEtS0EE49CqxYTZsyPF3ecu
   TevRjtX6sZAcDcmFGbRrnqqbmBvWKXiRdZcMm0zGvavZjYfME7T6J2tt0
   Q==;
X-CSE-ConnectionGUID: k4HBJe5GSpmc5RZpUD7kLA==
X-CSE-MsgGUID: wr+OTyIySZWeCIoDPaJY3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="31981899"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="31981899"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 20:40:07 -0700
X-CSE-ConnectionGUID: V+Y5JIl2Rp2SBL9aKz9Azg==
X-CSE-MsgGUID: 1WaOr71cQROGxp4tEIjeJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="38123056"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jun 2024 20:40:07 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFQSS-0003zD-2Z;
	Fri, 07 Jun 2024 03:40:04 +0000
Date: Fri, 7 Jun 2024 11:37:31 +0800
From: kernel test robot <lkp@intel.com>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <ZmKAez4QQawL3dSg@242c30a86391>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in purge_fragmented_block
Link: https://lore.kernel.org/stable/20240607023116.1720640-1-zhaoyang.huang%40unisoc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




