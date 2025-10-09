Return-Path: <stable+bounces-183680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E46C7BC8849
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 12:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753F01882901
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 10:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B8E2C11E2;
	Thu,  9 Oct 2025 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzDXOicz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9DB2C11DB
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760006163; cv=none; b=Y91csOXLoJhEK6ITsYHNpYHjyohn4RThbJsCZ7b1Xlc8jnIZcUxocrQvVefk+zj14JAghcp2L9tu1GZrg2pN/ith1BLHJHkHDmXEPUEE7/qdQflaH9vPjFLr1RYsIisrOhmvJo12uP5OlZ+frqg09U9ywL1h+NN/lTxrPc/gXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760006163; c=relaxed/simple;
	bh=3jSlWK4l+M4ijsYlN+DTcRjodb6H0pjkmFnOs4WGzlM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UOAJB5MZAwMlNdj9391QnPtaDJfBSdB+W2gAShz+/PejcDzy793H/uAuueNrjy+676jDeFIJ/gC1bLblXwSYaT8YzjdN2dt88+vLKqKwcoKIltUAV+jP7Kda4QP/V5IhdlJX+rjtq8qLaxdUg8A7le5C/FnVGH/PSVGrTbjA08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzDXOicz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760006161; x=1791542161;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=3jSlWK4l+M4ijsYlN+DTcRjodb6H0pjkmFnOs4WGzlM=;
  b=JzDXOiczKHBypBq8XnuL/4uXZPmwIDRvD782vYA052UKVMPP6qJJlYdk
   uLQyNEONxYcTReEzuNIA4Ti+OLlyvCBMelgw9ZrTWa1zRUo9PCb/5iGm/
   sHisouZLdBFS2i0AVEoEHjg6K1Q+7g2NEmJGwY6C9fHAC+H9MQ0ug5IPK
   4uR1qFHBBlhRb/2Apew0t4knF0WUu0qAYvpsFcDSSlH4ZJUth+Sb8yzo/
   L1lumPZAqPy8c034Jfg7s8MkFVvBGrU4A3BHnaUL02y2D2lkxwRBaIIQ9
   xQ5ISfkEcjbwRadK435Yu4W7nTsarEsTw/pPD0FueCpqEaHgZ3eTEcRNv
   g==;
X-CSE-ConnectionGUID: r+46C8SUSHS7DYbhBsrw4A==
X-CSE-MsgGUID: qf+Ov2nOQXar1YEuBh+RKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="65860565"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="65860565"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 03:36:01 -0700
X-CSE-ConnectionGUID: vM0QTB1DRGWfIwP6Ko5+gw==
X-CSE-MsgGUID: SvSpeLNjTQOFDb3n6BUydw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="180500272"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 09 Oct 2025 03:35:59 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6o04-0000Vz-1n;
	Thu, 09 Oct 2025 10:35:56 +0000
Date: Thu, 9 Oct 2025 18:35:16 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Revert "drm/amd/display: Only restore backlight after
 amdgpu_dm_init or dm_resume"
Message-ID: <aOeP5MXpJ2IPTlGg@d0417ff97f04>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009092301.13212-1-matthew.schwartz@linux.dev>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] Revert "drm/amd/display: Only restore backlight after amdgpu_dm_init or dm_resume"
Link: https://lore.kernel.org/stable/20251009092301.13212-1-matthew.schwartz%40linux.dev

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




