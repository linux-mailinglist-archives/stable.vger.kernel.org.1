Return-Path: <stable+bounces-203301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9300ACD905C
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 12:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4697300DD36
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 11:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38462311C33;
	Tue, 23 Dec 2025 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmDE2N8e"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04411D5CD9
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488059; cv=none; b=rcuOFi4NbZK+gKTgYpQVTrWaQEca3mS3W/gYw9VxAiYHcng2kvFDW8PKFgmnMx7doHcpZph35vPOaaXcjK0N9WJObeHftITS3eJ02bchRFdd4sMHR6nSBAyOXDoTGugYfFHPu7RGJWSlL4JkFh08j5yiT+S8NcREc/Y6DP8EgaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488059; c=relaxed/simple;
	bh=HOSHFLdxlmosF0QGR6CMzIv2ex7rYeXl97FFZ9uAlkY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d4Pw3grp1aUcTvxce7M2U+AmLPmdWnRAD/FP4pmuWNElyRz2PKGYBBNoiKYY8R44gUgbskDEXpVxuEvgu9ahyyPmZwybbcCpOy1k9oe6VuPVo1S7UGVpoXeGxxkFfGKY3UJ3Gfo4FBWyo5EuVkNLaKRGfDjGLgH2z9HLEUbLvms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmDE2N8e; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766488057; x=1798024057;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=HOSHFLdxlmosF0QGR6CMzIv2ex7rYeXl97FFZ9uAlkY=;
  b=JmDE2N8eOTykNpzSLPNbGbc4sxDqrfEExMQNDevsv8EKTgbxYJybhpVf
   VWL22eCuZue3r9pvi/42YkKUvK1Rxc/fKjEOdrOk5xytIbvKlu4qvX+dG
   ra0DwvarVgjrK334bPEXrkYLKuSfyZEgzvXCCZLyp7F/2OiArFe4GKtwh
   jPNBMK1Py+WBPpBVbXQlzjCJLSPDh4bkTOZWI19Z7hmn6HZc/9IqtDcGT
   vLHcaVKPHkfYkaJBtXiNwRP2v7Y1O/ZV8OQ62GMr8oIE8ONK3t4/yfJHG
   s+OwQFYh3AIsZEVRrxY+dluZMgyIz5Z1oTVh3duPfK7KM/0rSrDWPOOwP
   A==;
X-CSE-ConnectionGUID: MMDmYj3xRrOc9cN7ifcmbQ==
X-CSE-MsgGUID: MCClvB4ARQeY2P398UAFrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="68230578"
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="68230578"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 03:07:37 -0800
X-CSE-ConnectionGUID: T/GetWGASWqmmDIr0XeC+g==
X-CSE-MsgGUID: zNbnmoluR5ewwKH4F9mKDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="198892355"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 23 Dec 2025 03:07:35 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vY0Em-000000001n7-2zfx;
	Tue, 23 Dec 2025 11:07:32 +0000
Date: Tue, 23 Dec 2025 19:07:20 +0800
From: kernel test robot <lkp@intel.com>
To: Sjoerd Simons <sjoerd@collabora.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] clk: mediatek: Drop __initconst from gates
Message-ID: <aUp36E8dQwQFLHfZ@a397199831b6>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223-mtk-gate-v1-1-e4a489ab33de@collabora.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] clk: mediatek: Drop __initconst from gates
Link: https://lore.kernel.org/stable/20251223-mtk-gate-v1-1-e4a489ab33de%40collabora.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




