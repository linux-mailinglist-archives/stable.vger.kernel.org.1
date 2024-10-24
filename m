Return-Path: <stable+bounces-88086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B13AD9AE933
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEC628B05F
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812491E9075;
	Thu, 24 Oct 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K54yTDFN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD11E6316
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780982; cv=none; b=vBp7ePq80/cXRUYtCjXD8rGF+jFPjUkU1ElOgQN2LOyVWsn/gIE6SDqCGwfEU3orSRAdVly1878aKzPncdcZoAi5qaMDye3H+2066/zb3pp3OFAt0EE1GR4PvhqsbdwVOyLjYAH7vf6aOZkL/BH47lYZbFPV38+kWZqgb44o2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780982; c=relaxed/simple;
	bh=zCUgnqD5mO98AkIjhdXNX3G3zNpNXTgMPKWp54Dpsyg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bZMb0bfw9A3zSxOyjULR6VI4bnfiBcVlpn7YUxESzCvzMPRNb+4wrBHjE6qojkzxETiqCc1EeVdoy5Rdyebpc8I4lh+F0NLvVpQmxHB7/1eWeI/oc7jo6Ryb9Oc/Y22GmzhR6n9jLxjhH/azIK7xNQUzIl1ZshrSuP/11J/rDVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K54yTDFN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729780980; x=1761316980;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=zCUgnqD5mO98AkIjhdXNX3G3zNpNXTgMPKWp54Dpsyg=;
  b=K54yTDFNdmg047CYHyLu+NnRB921P3/943RMB8onj2SW6De4YZ6cvcei
   eirWskFot9YmMC+GRDBxZJpUdFqksIYcLgR4qVpEnF66j+B+2P6eQ6Pmr
   8LbS/KqAJm0nVcIVxv15ul15BroAJVMmGe135hbFXm3tRhzQKa5u/usTn
   OifqFGLEu1hOk2XU9qlqAk/CsRy4oSWwrMgoun1598EW4V6YocKRw4h5G
   2xETdQ/TTnqQoq7g3qIqqDzK8HMR+OAdwtfhYdl9lZuqmySh9sCeWoGh1
   5Cyla0r6cv2G+kvcD5uRsi1SfiIO+lK+VkOZNuUWqPR5bWUI8jgUMhUav
   w==;
X-CSE-ConnectionGUID: szJ15v9EQmmyLSr2vGlGJg==
X-CSE-MsgGUID: Q8h+tJbvQau5mMiaIgI8bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29520457"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29520457"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 07:42:59 -0700
X-CSE-ConnectionGUID: I2eSZ54bS6eivhZPZBJC6g==
X-CSE-MsgGUID: AF1dJlsJQtmXYhqTluQZ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="85215849"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Oct 2024 07:42:58 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3z39-000WXE-2D;
	Thu, 24 Oct 2024 14:42:55 +0000
Date: Thu, 24 Oct 2024 22:42:47 +0800
From: kernel test robot <lkp@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 6/6] phy: core: Simplify API of_phy_simple_xlate()
 implementation
Message-ID: <Zxpc51rJJvfJ-wdY@0218aad26cb2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-phy_core_fix-v2-6-fc0c63dbfcf3@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 6/6] phy: core: Simplify API of_phy_simple_xlate() implementation
Link: https://lore.kernel.org/stable/20241024-phy_core_fix-v2-6-fc0c63dbfcf3%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




