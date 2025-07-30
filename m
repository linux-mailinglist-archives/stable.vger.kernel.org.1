Return-Path: <stable+bounces-165197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 605CAB159FB
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD873A68D2
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 07:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BA91F1537;
	Wed, 30 Jul 2025 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNoZE/Yi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9B423A9AD
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861769; cv=none; b=tEgxL23J736/fa0oqwiDv6udObjktwaCe1ojDB4h+rUXA+OgDNI6JfyRrDRq+HimZ/ZbGFC+UutY/FX7VlbV86hHSp7YufdClFjfyrDfeeIO5glEg5DAUemSDzK9EjKkghdK4/ERpT3EuzlfOYBuY1DFySfMBiigtpnsczLn9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861769; c=relaxed/simple;
	bh=T6rSuGbyJUJDIVrbYZO6srafpB8YbqE4qAmT+ZcrP5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hMBiOKUZrBQ5CjfCkwj70nh5zg/s35OopOCgc8gYbafpoaIoaBQ/18tcRBmKCyHxocJdzc5b3UPPi5fEi2dR0u/XABiusbQuJQaOuBFk3f+Xhms2bZbOyn3mQ2DPvd+Bdd+8O8zyZS3Sc9NT4iR+GhVvTi5WcDN+pH9wcayqRF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNoZE/Yi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753861768; x=1785397768;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=T6rSuGbyJUJDIVrbYZO6srafpB8YbqE4qAmT+ZcrP5Q=;
  b=hNoZE/YiJ7a4NWM8gHAuYFGqNeLY5szN5ebyZRPRAy6Ya6qfn8fgqF2o
   tx7tLeA2jRcapWq9M0fDQp6CC0B38HUH/7KBoT6D0j1i5eZ0+ymqkHve2
   r/kYi4We6QRh0M6RwxmlHaIklf/8fwuAO1zmoY/pkrv1j+E0s7UTc8aWq
   9ynSu6Ty0Ea1yM7j90GLWLnFkxh0lX5BlXXwk4Z7f2CoCs/ZO3Fza+AM6
   F39ZJ+jsKni7uJtTPGWMC9EsdyZh66hEKdNaIUKvVH1CecNNdseUDOblv
   FWQEEoq8IVlJUZ42MS6ai+ldd30lPuZjXT4Atpw5TKlfzVn6FUjPbBf9D
   Q==;
X-CSE-ConnectionGUID: iFDyL3cxTHOfOhQtqG266g==
X-CSE-MsgGUID: 2fei2YWSREiDiNHZ3i5Arg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="66720059"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="66720059"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 00:49:28 -0700
X-CSE-ConnectionGUID: 3oXxr4wPR1eLC4xOrC/H6w==
X-CSE-MsgGUID: f5jXxcuORLKgn4l/ZScN1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163263860"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 30 Jul 2025 00:49:27 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uh1Yy-0002B6-1R;
	Wed, 30 Jul 2025 07:49:24 +0000
Date: Wed, 30 Jul 2025 15:48:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] x86: XOP prefix instructions decoder support
Message-ID: <aInOZ-1UbvCIPjG7@c35d1a63b3c5>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175386161199.564247.597496379413236944.stgit@devnote2>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] x86: XOP prefix instructions decoder support
Link: https://lore.kernel.org/stable/175386161199.564247.597496379413236944.stgit%40devnote2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




