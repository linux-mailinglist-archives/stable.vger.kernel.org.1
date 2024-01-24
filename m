Return-Path: <stable+bounces-15652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8A783AA94
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 14:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14171C278AC
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 13:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC06077642;
	Wed, 24 Jan 2024 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4f9jGSb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D877649
	for <stable@vger.kernel.org>; Wed, 24 Jan 2024 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101444; cv=none; b=PmnAUHt5MKLsGxnvC6KwVH3kd8wXwdk9aDCgz2cko023JAoA3Fv6RC4xiUgICbA0TgwZGmL1HI2Q0pnUfq7hKgrXUQ5H/Epr3DOA93HNPhLnbBPowi2hrvFSOlXUW1mVXkAo/zV5z81B2aDkwQAkFyzpKbFxW78ShPF/xA1iHBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101444; c=relaxed/simple;
	bh=VyGwH/KUq3kjku0BaQpnemZn9qYFyPLUdaFVVhGkB70=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YaH+6xieBgIw5POz3NxgQ3zEQ5h4f5W70pJ3i6q81+Kasf2yd0X7vxYfAFwRdhXoXvu2IEqr6/x4deFqllEjlQ4xBtRr9wFgMEPGAMZ4kn9/5wm5nXrLHVMTRN8u9fw/tSL+ubMeaNmKEdksZ5VyQB33V+ksasGH8wu43+cbQvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4f9jGSb; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706101443; x=1737637443;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=VyGwH/KUq3kjku0BaQpnemZn9qYFyPLUdaFVVhGkB70=;
  b=L4f9jGSbW04qj87K7+Konnc4QhzryaqBz7x/3ZsP78HotCJP6M0d4F8o
   0dQJDZHcOzxvLcsIKhIj8VtT1SwJRI4NLiX1DNApLQkrudB4zARH+MpFE
   UgJHXo6dgT5P//s0hPsgsXSJC7s07qPSHtlGUH7tX+eUi0n+IOoL0M0KR
   CDhCssRwV/7bDsYC4e6ASBtS6Kkyt7a3YyZPgbeqPP7xyIjkJ85sAZx1Q
   fEMvCwjLUb/J8CcxTdrQkzDMsKSaa3GN1g/W8nFuBd+E+lgsCOQ2wDRlA
   JM+J6sDojXnE4dlIS/qlXDWZo8IvXlULwN+KFPwx69ArxJMnkw/wMOaEt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401496584"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401496584"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 05:04:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2019278"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Jan 2024 05:04:01 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rScv9-00086j-0c;
	Wed, 24 Jan 2024 13:03:59 +0000
Date: Wed, 24 Jan 2024 21:03:34 +0800
From: kernel test robot <lkp@intel.com>
To: Mahmoud Adam <mngyadam@amazon.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] fs: move S_ISGID stripping into the vfs_*() helpers
Message-ID: <ZbEKpvaVHrsXzISK@6c5a10f2f1e6>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124130025.2292-3-mngyadam@amazon.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 2/2] fs: move S_ISGID stripping into the vfs_*() helpers
Link: https://lore.kernel.org/stable/20240124130025.2292-3-mngyadam%40amazon.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




