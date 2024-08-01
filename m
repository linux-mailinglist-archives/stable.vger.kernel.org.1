Return-Path: <stable+bounces-65253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F8194500F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 18:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B55283FDE
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 16:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CBF1B4C55;
	Thu,  1 Aug 2024 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3FSc2DD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011A1B0111
	for <stable@vger.kernel.org>; Thu,  1 Aug 2024 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528286; cv=none; b=Rn2epgfXaf36ATSMlK3V4+1tyHfqOcT37biQfp9P43+1nSCzGwarnkNwU/oCTbd4BYyj0otqD5OwvVyhj9rchuj7vrx9QQKifpgwzAWxmtPmr4IPqOGzHB7vZ/0N2kqoBhUuaONJNzh3R2yIWTcVRurNoaeFJgnYOtlYuqWMtXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528286; c=relaxed/simple;
	bh=Z2BU1MutSaGjdkxrpltZLmYtiRqN1R0j9HIMjY/RxyM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dzY6zrdXYUor2LGECfvzMWYJUhKsbYJXACdGzHZwWw003CXA/SF9C5aOr0CtpkLHPXpjvLJCyA/699vQq3i87dq6FJbwoZHImqwZxVMX4A8Tp1nCHS+e9dO8TRjN4v2k2WM5AXEzA8AFft0+K2WNJ6nejBibQ9ebe2zIeHuDYQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3FSc2DD; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722528282; x=1754064282;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Z2BU1MutSaGjdkxrpltZLmYtiRqN1R0j9HIMjY/RxyM=;
  b=A3FSc2DDueAltQT+x+WP4plo/CTzdmTZi9pXaXs8JdZ13EbMXoXwqUoX
   S+yb2oRRuVpjTvqC8KIOrBOShPEQ4BlP/pLQ469LRnVF7cHH3HaLF2DyV
   rz7MQ+NmftGAF5TIN+PgRtJneszLatckVRIlrRjMJECE1mjUKCbyuXN3B
   MLkeHRkPmi5j6TUF8KLG3khlxzn2NSDqr2hM19D0kAKldOZadngr7ACe4
   QTGlZDwsbJ1TnnLEuaJhzDwe9tCqNbchR64UqDWhU5iIsy57XXEuImbQL
   UrnaNfH7WIAR4g6eislwO3v6bKcBboJ1HPO41zROsAShPhGjSZ8r5tLbz
   Q==;
X-CSE-ConnectionGUID: PyNXQdfxRZajHjMLOH+vQw==
X-CSE-MsgGUID: QIKO9/19TV2HBLdTxKx+uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="20318041"
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="20318041"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 09:04:39 -0700
X-CSE-ConnectionGUID: wXx9UfViTBucm+1lNixovQ==
X-CSE-MsgGUID: Qsq4xeraTx+x1dVbkM9yHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="55880028"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 01 Aug 2024 09:04:38 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZYI7-000vk4-1R;
	Thu, 01 Aug 2024 16:04:35 +0000
Date: Fri, 2 Aug 2024 00:03:51 +0800
From: kernel test robot <lkp@intel.com>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V3 5/8] clk: qcom: clk-alpha-pll: Add support for Regera
 PLL ops
Message-ID: <Zqux5-nHm74SG8Q-@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731062916.2680823-6-quic_skakitap@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH V3 5/8] clk: qcom: clk-alpha-pll: Add support for Regera PLL ops
Link: https://lore.kernel.org/stable/20240731062916.2680823-6-quic_skakitap%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




