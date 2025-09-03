Return-Path: <stable+bounces-177563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0091B41292
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 04:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B9C56081D
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 02:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B58221723;
	Wed,  3 Sep 2025 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEQX+4kt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD3E218EA8
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868071; cv=none; b=IdyRYVhgcDgGNqOwpYOJqMcLho3teRTvSJX+PapjUjTc2aW526uDgsOlC0rLYTgmGUt507f++5gftmc23g31fbnUpeEK0HKbEASPbR3Bw8hYx4VddY+40tSN/q4FN75U7ldUItFzkxgF3IsWVhHAoQ/ku7XVK5+gDipeaU05le4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868071; c=relaxed/simple;
	bh=9qOYXHccmgI9JaqIIXjbgrLpGRBpHjfbFjVUvyeeRfs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Xhh/5Bh0ZDKPet7w09LLAhwffIbFcDnQLYarelLWvoxs6Qdy5vrDDU7a/jeaD6zkfc1jsl9OnlVNFtYtLVxHvprLONxWXdtWn7hslb2pA9eF2hVeSlxpq+1RUmd4MG9Acg1Kx13bJOpsW+LLQSgRXSuu4ZfyNykJa39mWI09jhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEQX+4kt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756868069; x=1788404069;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=9qOYXHccmgI9JaqIIXjbgrLpGRBpHjfbFjVUvyeeRfs=;
  b=jEQX+4ktgt11rg6u1jKwTrI0Rswl0Nd+1AS6zbh2n+m8krlTtomNiaR1
   mAnsKiOxBHEG74Mp6uozafDBrGEUvVCXJAu+rVU7DxkK5osbw4aQkSzkb
   ATsJCPZhtRbozb4SPsDjxmG48oW/LlG+xlK1rOusQGJeEqHN9T79U/2ya
   8EmTzaZclaVEO96E0EVkKEXvvFsqAEI1FpdoiO1Ie5eapAaqxUFZtv0Z5
   2FtJHvQu1dhhZSZOdxYrhueytSpQj5Mgpu78T9TzGqkIiXr+4j6UQrayV
   5zZwKRh4QJFDBMTesX6pXtNZtCjKNyf3ptMsVliinEFv0tfZpReifn2iA
   w==;
X-CSE-ConnectionGUID: WnoCzwKkQV+vohJi5QWj1g==
X-CSE-MsgGUID: 0aQHmtRHSnuqmvBEyO7rTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="62814003"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="62814003"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:54:28 -0700
X-CSE-ConnectionGUID: oON9fRhuRDyMfKGa9qB/KA==
X-CSE-MsgGUID: tzIuy3BnRjWYZ1hV1LpBGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171427866"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 02 Sep 2025 19:54:27 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utddg-0003Hn-2E;
	Wed, 03 Sep 2025 02:54:24 +0000
Date: Wed, 3 Sep 2025 10:54:06 +0800
From: kernel test robot <lkp@intel.com>
To: Abin Joseph <abin.joseph@amd.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net v3] net: xilinx: axienet: Add error handling for RX
 metadata pointer retrieval
Message-ID: <aLetzpf_cdd8EOBn@c25d56e612e5>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903025213.3120181-1-abin.joseph@amd.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net v3] net: xilinx: axienet: Add error handling for RX metadata pointer retrieval
Link: https://lore.kernel.org/stable/20250903025213.3120181-1-abin.joseph%40amd.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




