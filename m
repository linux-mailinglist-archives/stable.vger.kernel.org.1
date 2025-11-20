Return-Path: <stable+bounces-195393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE01EC75F63
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91C2A35AAA4
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471631DC1AB;
	Thu, 20 Nov 2025 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9KYRaH5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DCC1A0BF3
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664328; cv=none; b=eodNTbEmKdi2moLCGSDbXDhgNDT56mAkwvOvce2C0tAh0jikncSAbFx/cpZWoTg5AfdTNBoJEztmtlTPF/ujwKOH5h/YywT4YFf9qPBOB2Jk4/B4AwX8hs29/tdeDbK5ejg5C8oNZzYYjQtpsAljuIwdl/0Oh0LUjrWhdbfM2oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664328; c=relaxed/simple;
	bh=GpPHegU4ODiufIEOiuRo82W/PMuQuwZ//BKOmjfQDPo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DUAffqbSUHEIWVIePWQFOhd+620tImdkfizmAqrul3TiB2YPahZTo1Ow7Q+5cLyCh8LPuaGrWXY1QeHiAQN7CAzGYIK2+pQxNUq7C94WswLAeA5LIUkPHUTd+qBW5jVesODpUx8yzizfciyEdSxQC3vLXf4/3DTN21HNB9Ffo04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9KYRaH5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763664325; x=1795200325;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=GpPHegU4ODiufIEOiuRo82W/PMuQuwZ//BKOmjfQDPo=;
  b=S9KYRaH5XUuOSIlu4ouw1+ekiBlOk9oKcuptGih7a9HymZ5TmUKCMEBa
   yIM/wsMsAiGpMt1OtWHKFAfmDO1HOG1FdJKmxNOL0qnQY5mDKZ4uHtv3a
   6Fhf1yj5ZNSREZF6Fek5Y2t5RgCn47lLrYcYiSYpqTFY9NZuZX3QdLqlc
   ygappAZP+QX9u8jS9gU9jF4M9SiMFJqux1WW95odvg3aNrVVhaGEUEomQ
   3+8jVjn3vhN080NKbzRmr2dNtvMJt9AZCFKwjwiP0bmBrnfz1XvN19e9F
   WFuvR8NVTOicnaRaxAEhwBoklqe1FeObOMghvwFMtAqQZxByC5uEvBPJz
   Q==;
X-CSE-ConnectionGUID: GuIP+Z1TQwCxv9uOIwKNMA==
X-CSE-MsgGUID: eRzSnePARVypKEtoTCv4QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="88400683"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="88400683"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 10:44:57 -0800
X-CSE-ConnectionGUID: vfKjZCW2TNOUc70+gVqjQA==
X-CSE-MsgGUID: r/6xQDW6QYanTrnqPDrqKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191477294"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 20 Nov 2025 10:44:55 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vM9eH-0004Od-0g;
	Thu, 20 Nov 2025 18:44:53 +0000
Date: Fri, 21 Nov 2025 02:44:24 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 2/2] fs/writeback: skip inodes with potential
 writeback hang in wait_sb_inodes()
Message-ID: <aR9hiE7WB5ex9ED6@041890d37db4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120184211.2379439-3-joannelkoong@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v1 2/2] fs/writeback: skip inodes with potential writeback hang in wait_sb_inodes()
Link: https://lore.kernel.org/stable/20251120184211.2379439-3-joannelkoong%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




