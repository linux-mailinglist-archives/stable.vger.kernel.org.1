Return-Path: <stable+bounces-98202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F40E9E3179
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 03:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C951C285BCE
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 02:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DEA347C7;
	Wed,  4 Dec 2024 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQsgzfK4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391820DF4
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279821; cv=none; b=K1+NeEQhm0EW2spoUqNDcxwR0WKqVfnDLNhXI0vPsoicmqg7Wci5IquSZvtfI10NzHmLq8HiP8xH593fsmFUlAVpfCtseAdJwtNizhJStE5qYmTDSFH0xaIUMs9e3JQ27KxN5Hab3i2ED4X+8q2VIvHTlA6r2U0TJ9jS9QBdUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279821; c=relaxed/simple;
	bh=yThAkq8eibTs6BQzTGBL335PJtz65pyzvH4azdC1Y4M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pb8Bxcoj8J6JKCir5TyiExzt8JSEgY1QJBXR0KjDsxQam1HPkhUiq9J8b3TWrGWk0/cmISr+83Gnx/T4AiCnJ7RK3usVMVmrpPjrF7AG6HfccKhHTtvNoc5I8mRMHrRTqoIoWweF0wcFxmyROfUIW4/k9OZQgirisxJtMQgXyrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQsgzfK4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733279819; x=1764815819;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=yThAkq8eibTs6BQzTGBL335PJtz65pyzvH4azdC1Y4M=;
  b=kQsgzfK4Q+W17DIxraEX9/mw3zLulXCKd5lzXZ/4hA3rmTMAvTm3OOJO
   r9OuTze51LalcNWqQ2xy7Qb9uX8Yv09/vCc64pGA7xGb1OG05KTycm4x9
   l6KrU6ziZ++ASD57S2vouhekH+OLIiRARzl9UzSy3bOtTMR4tgvlCnvQz
   kUAMGUgpzHyqV0fVwXHFNdVtnD+TGFIkzYYPLTY4sWXcxw+wX/lXl4AK1
   usdv2zAAA9x+JP3TN0HeWuilipv95NXy9AoYYuxDkaMOyMfUyLZIyN9AZ
   JAY0+/gDXWs77PzfwOv2FXgumQvCPJg7i0esf+hfSuym2j4n3/tnmv5dt
   w==;
X-CSE-ConnectionGUID: w9Vhe6B2Q26N471u3iR8cg==
X-CSE-MsgGUID: nnTQjvpNQz+PWwVLgLJ9gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44188564"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="44188564"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 18:36:58 -0800
X-CSE-ConnectionGUID: 4/hQHBcZTI6ADVAUTSXSHg==
X-CSE-MsgGUID: s2MALBw+SH+xeXPOn9XuQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93967680"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 03 Dec 2024 18:36:56 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIfG2-0000UH-35;
	Wed, 04 Dec 2024 02:36:54 +0000
Date: Wed, 4 Dec 2024 10:36:24 +0800
From: kernel test robot <lkp@intel.com>
To: Haoyu Li <lihaoyu499@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] drivers: clk: clk-en7523.c: Initialize num before
 accessing hws in en7523_register_clocks
Message-ID: <Z0_AKFA365ggXzBU@24ad928833eb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203142915.345523-1-lihaoyu499@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] drivers: clk: clk-en7523.c: Initialize num before accessing hws in en7523_register_clocks
Link: https://lore.kernel.org/stable/20241203142915.345523-1-lihaoyu499%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




