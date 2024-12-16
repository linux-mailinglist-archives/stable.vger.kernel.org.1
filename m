Return-Path: <stable+bounces-104340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1A49F30DA
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 13:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F011885B22
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F46204F6B;
	Mon, 16 Dec 2024 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFlhtQN1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A0201253
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353407; cv=none; b=WwuLPhPwK0F7EEWBvutYT4rc1aDgQ0fMsISg7KgQ91Vzkzp7PLYP09OQl9ZJ/v5lFNh4rDmSVPOZBEkTI+A8Xscrt0x7kYzl1kSmKKezRrMmwOcBtIHaWsAKL43VNMs3TVS5vHR0g1ZZ95LaxpTG73ZXQSh+h920Ti135jXbrEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353407; c=relaxed/simple;
	bh=ClxpZzbJW5S3a4xXpx9c49RH23i6sKeBvGipYmQpME4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ue+E5IUQtWxo6+M0/t7Ln+F8Z+6FJwEm9CXC9pGdvgcF2vT5e2fzVHrX0CyhkMWlwdU9YddEOMbFOlYYEhhZK7RIgD/Am+b3rL5eUkLofqMVWCr+8zJ07aAVyxeIvqOvIoTpB5Eg17VzntDPUnKk6F6ehEGeL65hLLtqN/gU7wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFlhtQN1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734353405; x=1765889405;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ClxpZzbJW5S3a4xXpx9c49RH23i6sKeBvGipYmQpME4=;
  b=NFlhtQN1NcOJYiX474YOJrk1hQtK2QAZoAt08hxfI/LGt02QemoFxVtq
   QrZmYcXwsiKDH4WtW0nYNflgTRO6RVF1owmpiSiYFNgRfsWCkTK0UKHkr
   f3SpqCbtEyeA99s2duXFhTe524vuuPqGtaHiNxgU1txHb7O1MQFB7pXxQ
   FRSwvT9EKL5Ofi9R9Eg/SObFVl9lFKHXIUXxL+bTfquozwU0c/QI87wAC
   CZWwzsUbKI1XamWYqs9bO4Pv+lkt12Po9mm+P+CV+wLpbxWSNGLy/0CSv
   TPnDMQ4dSqvN3OLxxHMdi5Ze1UoHgejeQq23+8IjYavI/iZlG3/jowv4H
   A==;
X-CSE-ConnectionGUID: 52I1tXJ7RE6qqXYzhGE4rg==
X-CSE-MsgGUID: ozJt+BZmThukclGmnqxbmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45738149"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45738149"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 04:50:05 -0800
X-CSE-ConnectionGUID: fivJMMkDS8WfQSIZpLgv2w==
X-CSE-MsgGUID: ga/5VrNaQASr9cTwjW4alg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101337666"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 16 Dec 2024 04:50:03 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNAXx-000EDM-0D;
	Mon, 16 Dec 2024 12:50:01 +0000
Date: Mon, 16 Dec 2024 20:49:10 +0800
From: kernel test robot <lkp@intel.com>
To: Zhanxin Qi <zhanxin@nfschina.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 v1] drm/nouveau: Fix memory leak in
 nvbios_iccsense_parse
Message-ID: <Z2Ahxmy8VwvlPsON@39f568f0a533>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216124652.244776-1-zhanxin@nfschina.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v1 v1] drm/nouveau: Fix memory leak in nvbios_iccsense_parse
Link: https://lore.kernel.org/stable/20241216124652.244776-1-zhanxin%40nfschina.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




