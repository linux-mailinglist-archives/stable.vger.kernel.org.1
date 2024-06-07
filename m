Return-Path: <stable+bounces-50009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF93900D14
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 22:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89EA91C2192F
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 20:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C487F79DC;
	Fri,  7 Jun 2024 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbZ5gKN+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703814036D
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792664; cv=none; b=OUHMXuzRQ8IUbn9Ge4syv7vs4rCndMPzpQAev4oz5NPMxQTIFe06aR/nCqjJzx+MejsvdJkVfXbMCuTjOQ3Vvu2cJhjanKGTk9yQz7n0hLNFx1AiXpLZhV0WnhxvBhPoLE1n4wJqStGiOCL0GmG6DDQQmYmoC6RvLWPmMJmkgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792664; c=relaxed/simple;
	bh=wdB8GzWxUZlJXJkVgsdwQdu9tH/SeXHnpEoXtHeYFQs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fDoI+uC1ApRE+X2VvlELoPzH4l89om2hvHwyer3/sEn3ddWhEl9H6cuh3+XlLXQnjiWmsYeuJznoiGuryjsXiYno4rafVPRsHdYrXOfljF8eekgqhp8NRVWM+xHqtgUXqRZRJnfZJHRgwSYiTSPwFjnd0qIENRTOVpdqBY900cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YbZ5gKN+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717792663; x=1749328663;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=wdB8GzWxUZlJXJkVgsdwQdu9tH/SeXHnpEoXtHeYFQs=;
  b=YbZ5gKN+/oYB5GtrVyy/i6fuzBhTeLhqMgHkJ6XkIpCc5FNJKFrVxJmF
   OxnE9IgEi3ba1z4DfMTA+yE56DPtC9HLxyD6TKpIFZ3GppDspWgTyBv8z
   ZbTHuvK3AS0FJzKCKZmiB08Usuexis65Y6mF9phQo4OT6w1q0rdDj5DRk
   JWknVdSGyPwxJuq/k4nmewNkMiHwXJWL/K3c+71eaikPnjrdOuI4n4NnI
   GGqL/okedHf65P9R+X/2RIDSTWCdBnoQdOQ3wHIPtdncwoo6iiAAplvDO
   iuRCEVO3Np8Aoi4MDSy9ZCViHci8nQX4PxD11uIU+X4ftw0HhhiRFtwUO
   A==;
X-CSE-ConnectionGUID: LjvM538VSPCqyVZCOSBp4Q==
X-CSE-MsgGUID: 134oXkMoQUWiSF5gxmwM0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="37063884"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="37063884"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 13:37:42 -0700
X-CSE-ConnectionGUID: t5Z+yxOUQ0qulCQgd8ryFQ==
X-CSE-MsgGUID: jkzAviqZTPavcuS9Q/WC6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38290508"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 Jun 2024 13:37:42 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFgLD-0000Ug-14;
	Fri, 07 Jun 2024 20:37:39 +0000
Date: Sat, 8 Jun 2024 04:37:17 +0800
From: kernel test robot <lkp@intel.com>
To: jeffxu@chromium.org
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 1/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL
 MFD_EXEC
Message-ID: <ZmNvfZU1EgVyIeO6@242c30a86391>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607203543.2151433-2-jeffxu@google.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v1 1/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC
Link: https://lore.kernel.org/stable/20240607203543.2151433-2-jeffxu%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




