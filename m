Return-Path: <stable+bounces-132377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A023A8763C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 05:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8918E7A17F0
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 03:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8331192B66;
	Mon, 14 Apr 2025 03:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUM8D7rM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB55DF5C
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744601293; cv=none; b=lBlBxjHT/YAQmsLm+Z2GG2AGFUZzeKjTD4vv5iWW1XyB2WAuEiZNsTNvVUk+PUh2AG40Bnpt4LGwvCW2ISXSQmlmdliKtw2CuDWh6h1aQyaKPI6wdVJQDwlSo99SOHyL3x/YDAZOxYvasRIF7k0tdnB3kxbZ0LIGV5AY6yyIhy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744601293; c=relaxed/simple;
	bh=2+g95qvtbjt+JvpQ+fOH6IajwC/Cyjr06k1hfOzTlk4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K3ukHvJ2Po7PQNWfuP+FZsnCShYgVWRxAd9XhoRzjrBeDdzqjZQaSKvMDgu/nb8cCiGe3K3fukY099ixPYwubOwGY5waDgSoVDAIp7eRe5Faf3cO8cgE3GXWMA5wyRZkpYXACdg7Of+rJsXpiS+GsZXXYT+L2iUZf8oeV8UA21o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUM8D7rM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744601292; x=1776137292;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=2+g95qvtbjt+JvpQ+fOH6IajwC/Cyjr06k1hfOzTlk4=;
  b=cUM8D7rMKR00EaE8kIvf0A3fucDH4mjXTxWZxVmranUkaX1LMhizPGC+
   asDW+jzwZpdmyYQ2ef7of0YAJBi3RG9zlmY3GwhoEpN31d/RHh7KT5Dne
   X/bIlmKqr+G6nh1xugGa6sHF83sgqpJ1VFG7Wc+KJpcW3V57Xj0Xnt5jz
   AktyDqQBjmCiYhaaMS2FE8l+h0P+0pERN4UsWoKmZMQdJQNXsSBuS41WM
   b2IwlB8eo2h25+Vm/J80WLKHxG06aazv75Mz3B8qOvP+rlC+FKzWf9yYN
   ZzE2RRBxQcObRjRQePjKAJAOQut0hT/IEaEDCJklH63umsRDi2fzzMiMV
   w==;
X-CSE-ConnectionGUID: rMr8YhpvSKKdqTk2XN3stw==
X-CSE-MsgGUID: f9wYkHVGRrq1Jm5PWKwEXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46221551"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="46221551"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 20:28:11 -0700
X-CSE-ConnectionGUID: fPCrcLTFR3y8jD6XnPpwng==
X-CSE-MsgGUID: Y++5UbcxRsO6EH9PIJPRtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="134772454"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 13 Apr 2025 20:28:11 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u4AUS-000DPi-0v;
	Mon, 14 Apr 2025 03:28:08 +0000
Date: Mon, 14 Apr 2025 11:27:26 +0800
From: kernel test robot <lkp@intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/2] drm/i915/display: Add macro for checking 3 DSC
 engines
Message-ID: <Z_yAnpQDMXmCRYSO@6bf5cb62fcc2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414024256.2782702-2-ankit.k.nautiyal@intel.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/2] drm/i915/display: Add macro for checking 3 DSC engines
Link: https://lore.kernel.org/stable/20250414024256.2782702-2-ankit.k.nautiyal%40intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




