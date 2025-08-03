Return-Path: <stable+bounces-165817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA8EB19302
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 09:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22ED51895408
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 07:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4633328312D;
	Sun,  3 Aug 2025 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m03QvoI7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEEA28315D
	for <stable@vger.kernel.org>; Sun,  3 Aug 2025 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754205854; cv=none; b=hrpC6JBxzD4NlM+t60IJ4YjoU1x/zlTJYnLUpLDIUmCJiyvcnhE6LNeJW9Y5/R+iFwzJIFUv1HPB2gQgZj538Fqhw0kXeMjSp3C6+vTLXov1Vzut0PPYHvpTYLNrMQCw9bWcHRJMk0Q8SoRWn2JIm34t49z8euurSrGCcKIariQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754205854; c=relaxed/simple;
	bh=34Pa3CNe+fM00KWoMMYVMVgBS8ScG8oTLR+QEgwLvN4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VqSOYwhutOV/ijxSK5wNa0Hw4Y9SK2cRKAcWkk4BwyizoyjslvIVxPjwRSO1s//TZXp519GGAcWPg6I+U1JKRFHwgeOmiYr2TxCK/pDTiCI5xsmUSBlSQs7Tl1SPSUi0ifrISf8bTw57PVNh9Q26YVYlWIL7arNGVP4yM5fHpS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m03QvoI7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754205852; x=1785741852;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=34Pa3CNe+fM00KWoMMYVMVgBS8ScG8oTLR+QEgwLvN4=;
  b=m03QvoI7rp2yj3p4+p+X+0uQt+LhcwFOgsbVp38DqJq5pO3GDaIcGxWM
   l4WR3vBxCBrvmq4fdAy2w4XDetSubl0CcPwnj1PXMEoUaLYUsWfqYNYOv
   txnCLXRw858DN7Cplfa7Ib5ivUrnjEm0/5O+WwvQtqsJVOu8xjb5zjD71
   GEw65yz8UF7Nyc0/eSytG7W0137bb3DyPPOY6jGXWLh9JGo3ZeLWjOetC
   SY0LzuniqOj4nm746g/S+0fhbpIyjeDXTktDfzfSfuTaqVkN9jmAK9UI1
   DccWfmwLWge6Iezw6OTVKFGhaat9sZdmrkk258C9NM5yddqfVYivWcq2M
   Q==;
X-CSE-ConnectionGUID: O2yA3Q7JSW6Eg6QIew9iCg==
X-CSE-MsgGUID: eG5pL4muTnWE3hY7vbSaNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11510"; a="44084289"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="44084289"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2025 00:24:12 -0700
X-CSE-ConnectionGUID: Me+Bayc6TTi0IENhzGCZBg==
X-CSE-MsgGUID: HK8hxItqQ6yN+YltwmiT5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="168109913"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 03 Aug 2025 00:24:11 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uiT4i-0006GW-0K;
	Sun, 03 Aug 2025 07:24:08 +0000
Date: Sun, 3 Aug 2025 15:23:47 +0800
From: kernel test robot <lkp@intel.com>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/4] kcov: Use raw_spinlock_t for kcov->lock and
 kcov_remote_lock
Message-ID: <aI8Og4xn4q8XnH3X@94c7d3b5cd18>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250803072044.572733-4-ysk@kzalloc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/4] kcov: Use raw_spinlock_t for kcov->lock and kcov_remote_lock
Link: https://lore.kernel.org/stable/20250803072044.572733-4-ysk%40kzalloc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




