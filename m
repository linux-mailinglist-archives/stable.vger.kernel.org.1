Return-Path: <stable+bounces-3142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21D77FD48B
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 11:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBE82834B6
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 10:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0C81B291;
	Wed, 29 Nov 2023 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQbbbdiC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA91D54
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 02:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701254584; x=1732790584;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=kohXLGKwSp1QeowEi8Un4paJ/XEzuN05g0M8Irixm8E=;
  b=VQbbbdiC5Gju/ZOcKvTFaPnol0qBViN5VzXG7JEnziVrspkT42dyMzka
   JbSuJ0mYJvMetu+Ngreh7Tt0c2t3G+Tb1/j8HEDuzBfwbmPvN2CMcUSRa
   VoS/jyWFdPunvxSbSRmXj1e5gLz20F4yfwwMh4zko0SS6BO9onbxYjWBQ
   r3LVuXyWUyCDQ2mW+drApeV/fsqwMygqposndwVfXcYAM/ybZFAWpPXf1
   +liYBNdvaijAJN5SdqpsIQIQsofteYmp9MSzEq+fGZNh/L/kASH3CuEQq
   cIeoRF4sc6YaxhVNMS555hlNlxukn+LBXWet063D0psQuPdhC9SkNhzrb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="424285722"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="424285722"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:43:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="803254034"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="803254034"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 29 Nov 2023 02:43:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8I1z-00005z-28;
	Wed, 29 Nov 2023 10:42:59 +0000
Date: Wed, 29 Nov 2023 18:42:05 +0800
From: kernel test robot <lkp@intel.com>
To: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] x86/sev: Update ghcb_version only once
Message-ID: <ZWcVfXrkc4nmI03s@520bc4c78bef>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701254429-18250-1-git-send-email-kashwindayan@vmware.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] x86/sev: Update ghcb_version only once
Link: https://lore.kernel.org/stable/1701254429-18250-1-git-send-email-kashwindayan%40vmware.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




