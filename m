Return-Path: <stable+bounces-92978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568439C840B
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 08:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E94B22FC3
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 07:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F44163;
	Thu, 14 Nov 2024 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItQmytwu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED51F26E5
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569763; cv=none; b=txHKNHN5d+AqBUuJuMMeiSoxLAIV0YwC+Yp7dNwxNoy79UBz5mOx7SOacUAobJADBpoVJzS94tjg/lhT6WegO9NB847ZHJktY0K3O4qQ09Mt6wsr8VQM/t/jsVgP97FSaKO8IK4tjaJsS8nUQAz5UM3fGU0jyaO8dt1AtkDYIHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569763; c=relaxed/simple;
	bh=B6+57d567WW8RFzH8w2fwfRNATW/vdBpHIuXwJ56fgM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rcIlcoWhXh79EuYCDEvZs9ZU3wjTjS5O1fo73xELmIPAg6FbRCTy53h9cKLKbEWlpAmHftbYPwI8ukN+ylfXlx+p91+J+wOlTGgAa/Zt/E04mTDBi6aEnWCjujwCd0MLg1+TA++t0Ciu+GieVvBmD9MpwNHLDCTvOfltPa4iSkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItQmytwu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731569762; x=1763105762;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=B6+57d567WW8RFzH8w2fwfRNATW/vdBpHIuXwJ56fgM=;
  b=ItQmytwuFuDe2hSWV6/W8iHK+k8MiOYXG7AeU8clIwuyBVHm40XTUNl/
   /EkoUAtJXTLSHFwDY1NCvEii4A3lAsxxmaMl1PdLOfEVNePJK4Ufvcalf
   B/7QingUG0kjIAPGzdiMtdwNgjySZni5Q+25UZ7ZXIzgxmkP9+4pZQyIM
   0sD9whlEnb6hWX5aTBnKnZq6FSBVF2cJYVbZXvnpLU1TW7my51TT7S2v3
   n7mY9rOduviuYLIsvMiWXx7p5XrKdKc9e8cfwtA69lumeKeyTBzXxBAJC
   Eqz6Yg6mrajqk34vbTGtI6cITwPJwicIsLim8DIkVDxrONjgqFC38Hzeu
   A==;
X-CSE-ConnectionGUID: NFn+5NvXS42R8x6FRKv0ng==
X-CSE-MsgGUID: xZFUBrVUTrePENFmFkpB/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="35203763"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="35203763"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 23:36:01 -0800
X-CSE-ConnectionGUID: juqaGlDmTUSXw+0lG1PfmA==
X-CSE-MsgGUID: KL2buDI5R5SyMvKQtAUhIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88001905"
Received: from lkp-server01.sh.intel.com (HELO 8eed2ac03994) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Nov 2024 23:36:00 -0800
Received: from kbuild by 8eed2ac03994 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBUOU-00002k-05;
	Thu, 14 Nov 2024 07:35:58 +0000
Date: Thu, 14 Nov 2024 14:32:42 +0800
From: kernel test robot <lkp@intel.com>
To: Wade Wang <wade.wang@hp.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] ALSA: usb-audio: Fix control names for Plantronics/Poly
 Headsets
Message-ID: <ZzWZiplchBjzuRqW@d805bc2396b4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114061553.1699264-1-wade.wang@hp.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] ALSA: usb-audio: Fix control names for Plantronics/Poly Headsets
Link: https://lore.kernel.org/stable/20241114061553.1699264-1-wade.wang%40hp.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




