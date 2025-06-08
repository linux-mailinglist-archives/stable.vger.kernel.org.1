Return-Path: <stable+bounces-151935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 087E3AD12D5
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 17:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACA5188ADB8
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 15:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D19424E016;
	Sun,  8 Jun 2025 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUv5Yg48"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62124DCE5
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749395116; cv=none; b=Dhj+Vbj7s4sK1z7gwkOqrY9liqmDrpPTMvx7VJ/vamru8PAJIqqpyAOB+Sic4QsbkGpU8scniZ0VMHOttkAdl+gvKIxgN8Huw82cc5lO0YTxwLPYJu/povM3aPVWFQMPmQ0+pPlO+pS/WDztAHWiyES9/qBK736YLkQ+dPmB9A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749395116; c=relaxed/simple;
	bh=/QikAlWhPpF6AEgZhHEKPXUfz5lsYD4M9mswV0JLjdk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PeSEQmdz1UmVw/cyuUR/sTqxe7SKcPlXso6bGSzzUqcN/gVSbviZaxVM8VGc5+BuvDKDXpQRVL2bjCG9m5sidj1NomsRFi+qbCHQvMIZlHBcYXtKv1/wDcUJ3yxlLhgCruuyKiaW063cUr6sZj/ZjUWlacUg8mkt/RAemYVdjrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUv5Yg48; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749395113; x=1780931113;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=/QikAlWhPpF6AEgZhHEKPXUfz5lsYD4M9mswV0JLjdk=;
  b=gUv5Yg48PyXHq/OqC0wSVXoHHT5X70nxpboIQ0MKBEzHxBFkXjy2j23q
   dqet0TBNn83TeO++7AKP56/0n/1clh5aymPLfeZBtzojlf/S4HojEiAs4
   IjjqboBmM3NJTCgiTRR76Xfu5anY2qBWk3g0BLCSvv6A13foYduGr9jEX
   yvGAiO+hBfUGSeJDEHut003AEFWCSUGKN7wFTak/CqkF/wMn3y3H1+H8n
   2krIdi4Qo3x4HV0kVbDhsgQbG/j7NXTIJFdt2pVWc2FuHqS4lzd9MV3Lv
   Q1mfMUIb+/a0eQGlh/reHeUMpWGZzCZfVAUCa4SptBkZCrEXoQzg5oWN/
   w==;
X-CSE-ConnectionGUID: Yv7ocovKQKW1pdmh2Ejb7w==
X-CSE-MsgGUID: 0laA1i1lR8uDalveA7ssbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="69045799"
X-IronPort-AV: E=Sophos;i="6.16,220,1744095600"; 
   d="scan'208";a="69045799"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 08:05:13 -0700
X-CSE-ConnectionGUID: UBI7ZAy/Ssy267mAU791sw==
X-CSE-MsgGUID: yGp5UaEqQve3xpdwLEiX6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,220,1744095600"; 
   d="scan'208";a="151528759"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Jun 2025 08:05:12 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uOHa9-0006Q1-1h;
	Sun, 08 Jun 2025 15:05:09 +0000
Date: Sun, 8 Jun 2025 23:04:40 +0800
From: kernel test robot <lkp@intel.com>
To: moyuanhao3676@163.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] net: core: fix UNIX-STREAM alignment in
 /proc/net/protocols
Message-ID: <aEWmiFPGgBdwJ1Vz@3ff94bb081bb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250608144652.27079-1-moyuanhao3676@163.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] net: core: fix UNIX-STREAM alignment in /proc/net/protocols
Link: https://lore.kernel.org/stable/20250608144652.27079-1-moyuanhao3676%40163.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




