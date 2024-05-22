Return-Path: <stable+bounces-45562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E38CBD0C
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 10:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10531F228EB
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 08:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47D07E782;
	Wed, 22 May 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmuSPSft"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34D41EA91
	for <stable@vger.kernel.org>; Wed, 22 May 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366773; cv=none; b=T2Vc9ZB6bPEroYyRWcOJcpJ8JH1g1PuPUm98HTeF87OALUiAuwvS5ybybxPk8HxDSSLiRYSk2bladVHGm0EWMQXBAdZoAZ6jV9zy2SzSOE3e/oYjdGeiJYupv0GFYuIC7zfRje9JZ8l1Z7jQVIHiajgjQKcohjrmDpeTNBHXx1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366773; c=relaxed/simple;
	bh=b4asckpLpABjt498dMFdVTmVokLyJsxzEB0aGOqJhAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=W42txJt255JMCEVStEJECT82PN2j5NqAOYXOTYyRfQ3b60qsXV70PNL3H++q3/AYTYYz0nqifMPDpA4Hab9f+OBRVS0QyrpzaKJJx7/bjgcbygMVhG806DOIKtsR3VjdxqGKkHOXtbK7GAXtXqC93ZzFHjJ4QGcp1ml+aB1ejao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DmuSPSft; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716366770; x=1747902770;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=b4asckpLpABjt498dMFdVTmVokLyJsxzEB0aGOqJhAw=;
  b=DmuSPSftnZt4fpJbZkjHRMc8XJMsopHQpchu43OBwwMz5Yscz8srSMTo
   mV+sjjyHCIDGSw04TnhGjryTrLwimjgVNXqtUDzPLBm4mwEqxEbJ+adye
   djHi+qCAoYuc5XTxPIcMa49qMUouyoHmXR7Zsr0BQxh7y6f3aDA+enKNW
   W8QA9lyG8A5AsAk2aJVsz24zWPFjiteCmGXYTVhhyDa/LI3a0TgVnIP3u
   giAE89WaBYHuPL2TmWpHmcpUx1QIjcj3g7K98BxnVR3Sys/DnITKE2DEC
   RGHdFL4p0Kjm6MUxuWv1r/GgKcLlK78frcnUUK77VsHhx5pjVeoV4TnhF
   Q==;
X-CSE-ConnectionGUID: h/l1spliSQO7IPsHOvRyaA==
X-CSE-MsgGUID: O2Soq2z1Som6vFB02XDOow==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12543108"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12543108"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 01:32:50 -0700
X-CSE-ConnectionGUID: 4Qh73Q7DTsGurCBU2b6oMQ==
X-CSE-MsgGUID: fE2azHgiQhSi5wCytlidrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="64037027"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 22 May 2024 01:32:49 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9hOw-0001BJ-2t;
	Wed, 22 May 2024 08:32:46 +0000
Date: Wed, 22 May 2024 16:32:12 +0800
From: kernel test robot <lkp@intel.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] arch/powerpc/kvm: Fix doorbell emulation by adding DPDES
 support
Message-ID: <Zk2tjEcFtINQhCag@9ce27862b6d0>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522082838.121769-1-gautam@linux.ibm.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] arch/powerpc/kvm: Fix doorbell emulation by adding DPDES support
Link: https://lore.kernel.org/stable/20240522082838.121769-1-gautam%40linux.ibm.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




