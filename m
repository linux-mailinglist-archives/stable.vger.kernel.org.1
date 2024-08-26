Return-Path: <stable+bounces-70147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D2095ECC2
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 11:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9116028165A
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 09:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4923B13D2A9;
	Mon, 26 Aug 2024 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLbAqP7f"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330E84A4D
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663334; cv=none; b=Gs0vXwf82WidxZSyd/BdlPq/9L4iOZJz2rq0eYfFSa3g6hRb6pS9H1u2sj6oUJF1CXDQCAJ9jnAynMFw5qRDnIvs9a0WpJVF5Z4ewqFudzMXCa1NW8e6jwn176ehsW7I6hKA1c1CiQdtUmnZaZ9mEOAdpn9mi37UjdlJiIO9v0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663334; c=relaxed/simple;
	bh=mo86u66iaC6q0DfdJ4Ualr5PP0qrmGeeZ7lxltSheQM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RRHFZPNuUMBf7szb1CHHVFNf5LK0j6xzkng3gyXRA4Cz+EFK/zQfDjhQsCi+X/sGHOBfo0lreckICmPpS3454AMHXzIJgCtoj/vf+Law33iGB81cXPerNwNcJd6heiFeux0LV8ZMf5y7jTTaV9zsQB501VL1k0OCVZ/Uu0VB0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLbAqP7f; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724663332; x=1756199332;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=mo86u66iaC6q0DfdJ4Ualr5PP0qrmGeeZ7lxltSheQM=;
  b=NLbAqP7fLMJMedHeOPfahBXxuFQ1nUB5O0VM1dD8N1bMjLa8x1w0MyEW
   PsPFJYFDie1nH98YVyZe2HQXiy/RvAJ6WiWXtF0MALRPD8Ka3Ms2PLSTC
   vFr9XCA7kydWzHQJC2CvgK+ofc+VRFI5UAEbMLjPmD/TOYhpZ0Ku9sWZ0
   R5VwCuUSQcneXzviwSj020m7ZNPDYwAZbOxVVazBkgAZc4S4CGvcD8eKz
   leOuLNO8xcfIRcieaFXqTDEL+esdOaIbGRGWYuCbdqFicHUZZBHISzyMu
   sKDnNI+3HNNEramgL6mYsBwDu4WHHeOCYOyC2psglgGHgWI7gM0OvUPN4
   g==;
X-CSE-ConnectionGUID: 1nX4XToHQBaILejyzX+pWw==
X-CSE-MsgGUID: yGmFb6KrRkeT+gILH6L6Rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="34482468"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="34482468"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 02:08:51 -0700
X-CSE-ConnectionGUID: 8bHituS5Sn23q+fEBXBi/A==
X-CSE-MsgGUID: oJIngb+ZQ5OpOjp/QDNsmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="63165096"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 26 Aug 2024 02:08:51 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siViS-000GnU-0h;
	Mon, 26 Aug 2024 09:08:48 +0000
Date: Mon, 26 Aug 2024 17:07:53 +0800
From: kernel test robot <lkp@intel.com>
To: Yanhao Dong <570260087@qq.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Fixes: 496d0a648509 ("cpuidle: Fix guest_halt_poll_ns
 failed to take effect when setting guest_halt_poll_allow_shrink=N")
Message-ID: <ZsxF6Z_numqODL96@b85386817db7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_13F0C81B16C09CC67E961B5E22F78CC72805@qq.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] Fixes: 496d0a648509 ("cpuidle: Fix guest_halt_poll_ns failed to take effect when setting guest_halt_poll_allow_shrink=N")
Link: https://lore.kernel.org/stable/tencent_13F0C81B16C09CC67E961B5E22F78CC72805%40qq.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




