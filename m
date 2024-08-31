Return-Path: <stable+bounces-71684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE1696702A
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 09:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6891C20BA2
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 07:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B70016A94F;
	Sat, 31 Aug 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+WCodRZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0911758F
	for <stable@vger.kernel.org>; Sat, 31 Aug 2024 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725089995; cv=none; b=JX4jUVXqXEN9JQzbnZ6r8ir+ru2JrUdQ00zTb6yqw+GMYLVvp6riih1PJ9BFXQAji8M3dlmnDNplY/oaoR2x216DI4s7wzu5+FoeW35fEN0oWwF6m4tWHpZXeCcCnHUUxyxlVgHNbsqkpKiCn+oWzlfq+6RxjE90xR4LdUze14M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725089995; c=relaxed/simple;
	bh=bH4p/WjkhSlyQrdOPHrjx31BTwRgB5txEQXEJrX9mZs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hZQPssIA+Ub6HB3BxfmCCnO9VjpbNXZini5pgZPsAUDrfRQicSpUhDrPEaf9TzflD4tm38EbbBSHAk3b1SYw4Sy+CGxW33s1Mh6CwQZFT56mrJIcn0SUJCI0pH8gorgHb+4H7PjrjVnkPurK2tQ9By127BwleLwK6EUWLfr0K+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+WCodRZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725089992; x=1756625992;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=bH4p/WjkhSlyQrdOPHrjx31BTwRgB5txEQXEJrX9mZs=;
  b=G+WCodRZCjgcl8zLWfcduQoSy1dKmZREhy5sesjlizfRlP5digK1AXjA
   Lrfk4C62To8+itR2Rl9zHElB4gsUD9XHy1PIrYbINR/5R8QksAfWpo16t
   fOdCcZOM6ePahrmfFNpUj3McOuQ9FZnT6QsuoAPBt+/Eypzz8f+QMuUaZ
   Ra6g/n/bz7vV79f3LpD79nyCbziKhKsag3PKtIXTz8WIieQA34M/jodj0
   OFxQqn5w07GziPg6jLbOJ+BIN8WLpTc+Pf1gyGibiGgWZLD4kCZ1QJ21m
   UwAyALOwCrf0wKXNx9KhT+7cNhfLVylxFpUqGCngSa20Wy0LI+pGOX7il
   w==;
X-CSE-ConnectionGUID: vrgMNRe5Qf2Yx5di811iQg==
X-CSE-MsgGUID: ctj7u3LSQ6e8p5Ob3Si5Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23549004"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="23549004"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 00:39:52 -0700
X-CSE-ConnectionGUID: p0K30RINSoiAyvX9acj4pg==
X-CSE-MsgGUID: KhWmOwNySCuVRV89PJHK/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="64163769"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 31 Aug 2024 00:39:51 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skIi4-0002R0-1r;
	Sat, 31 Aug 2024 07:39:48 +0000
Date: Sat, 31 Aug 2024 15:39:26 +0800
From: kernel test robot <lkp@intel.com>
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 1/2] perf/core: Fix small negative period being ignored
Message-ID: <ZtLIrrsvCaXWjlMU@bcffd8c2c65a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831074316.2106159-2-luogengkun@huaweicloud.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v5 1/2] perf/core: Fix small negative period being ignored
Link: https://lore.kernel.org/stable/20240831074316.2106159-2-luogengkun%40huaweicloud.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




