Return-Path: <stable+bounces-177558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A406DB4110B
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 01:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAB95E6BF0
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 23:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4112EAB78;
	Tue,  2 Sep 2025 23:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTJlMORN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8F24E4BD
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857368; cv=none; b=koQKgkh1GgxlNS9PZSaI0WzvF4Fs8L/3uFj7PY8fYpVaAPeECVCfGzUxiQyQZ2R4OJsF/cQ2Ab8XdHgai5e2cpoTKvkNR4HmaT/Jg8+cFK4JKvjVhWYk0mAz66Wy6t0xaPUWYpcZC3fl8ZYY4yLr3guprTlJAoM+lisHk8FdV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857368; c=relaxed/simple;
	bh=zBZ25W1D/hW1RtusXInYkAbUKTt7RS+K9r56apj9f3w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZI1vQ7//7HzpR1GpSSfU/xFF2f6wXeEaysAMxoz2sIh46ThKuPm1Xf3lxwc2W5k9vV7xKMHe4+R5e+Cw3otEMdDhNw3ioRzt4t4Asc1g9nIlStNK31rgg05lMM+O8JAkdp+OoTQvm8dh9oGood7rEC5bZJI736QYxUv/5mlSe3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTJlMORN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756857367; x=1788393367;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=zBZ25W1D/hW1RtusXInYkAbUKTt7RS+K9r56apj9f3w=;
  b=DTJlMORNcNWxETLkdKklOKwbZ5zv/XLh6U5lJpdZxJ0pUQzPX6Ety0ex
   Pq28Li/8GXIlkyHnBNeS4/vvTZDMkJ5+DNKg5sPYqFvcbqTSVpgEYbxWc
   bZu1foOr8B6M8sg3sLuWlnszOgC+PIqwG36S9j7qgwGvWJiVt7KN3BVFY
   hmaP5DFJErZZ61ijdfXeZ7+ZJJxIhuiVdlAizDDqEEJOfCfdKjqrKkPbJ
   mBnrHImEfmll8/AzXDY354qByA2KDpdXnz1I+X94XY038ZiARGp9o5MzB
   WUobjA2ALulnngyIf72XBsHnv11GjYmM1ZQlEZLFiCKQCqqKVeDYeeyg7
   g==;
X-CSE-ConnectionGUID: ismQi8lOQaeKRrNJa9PR2Q==
X-CSE-MsgGUID: TI1E4EFiTCKSGwPKyot8Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="62977915"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="62977915"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 16:56:06 -0700
X-CSE-ConnectionGUID: Yqt6xY5KQhqPil9u02S92A==
X-CSE-MsgGUID: 4sM5+UcWRzOy20ptawM/Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="208633647"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 02 Sep 2025 16:56:05 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utar5-00039H-0G;
	Tue, 02 Sep 2025 23:56:03 +0000
Date: Wed, 3 Sep 2025 07:55:10 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.4 only] powerpc: boot: Remove unnecessary zero in label
 in udelay()
Message-ID: <aLeD3g7ZCFXkTZVu@c25d56e612e5>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902235234.2046667-1-nathan@kernel.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.4 only] powerpc: boot: Remove unnecessary zero in label in udelay()
Link: https://lore.kernel.org/stable/20250902235234.2046667-1-nathan%40kernel.org

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




