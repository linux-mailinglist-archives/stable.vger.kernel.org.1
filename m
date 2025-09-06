Return-Path: <stable+bounces-177933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6A8B468A2
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 05:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 319E14E30D0
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 03:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689E322D780;
	Sat,  6 Sep 2025 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUfHmY/w"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D65C2236E0
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128971; cv=none; b=faWongaRpyeWBcprmAGGxZddj0ufavEafxfWRkFhN/pq0dd4EYT8hX/TbAdUHRlOmm0P3TqC9Q9UII1HcQI5UqSP/g/8d4ZjcY4cSO1nssPqQ0/nwUnhrHycWaw9rN9MvoYhHSmonPl8WT/bNRtZuJYilPO/GBcseHu7rgo23L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128971; c=relaxed/simple;
	bh=KObDRXggQqG+V1kipTtid3AfkhMbWNyRIQO9r5bBZaU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AcKHMdfrfT38DqvtExveL95EYjqaa6MNt7zyya5AslyhqBUGNuK2WAFYe67BgFtCt30iuT0wDQBOVoLt3XY/xJXFsS1bQULoIwaJaA+pD4liYe/2WJQUJqXKkpDvY4mWiyqX7cVQJ8t6tyebl9D14WE+wahDqf1Vf7DC5wxqwC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUfHmY/w; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757128968; x=1788664968;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=KObDRXggQqG+V1kipTtid3AfkhMbWNyRIQO9r5bBZaU=;
  b=IUfHmY/w3/8FDDVt2QWyC9rmiOHuAcsZNP/yEVCtytw9w6c5OjU7A1jd
   avNMxq1I9UR+xNCMVLg34PvV5Gktv+5Y04xI4jqMp2W9lRVLVDc/+q/jq
   gPEIkEVTZl86HaJYzjEOUYkMF4TNGp7aVP1YKZgY1k9UUBza9OvymGURp
   MJQMuT2F5Fyx5V4faj7WSv4Mkx1RNhvIcxDqnNGTFXa4Hlufq9GfzFPat
   E0FjDYm2gxxonPt/gWGumg/tPK8Xk1f+3ejm8x2/P6NFszMz6DvqZfFXs
   uY6E/fPw2Uij8s0NSZwaj/J3T0zncJWNqDTWLfoqr6Enh8Ak4FAptWu8q
   w==;
X-CSE-ConnectionGUID: i3m+sWF/SPK4/RislHM3aA==
X-CSE-MsgGUID: ia+/I9viTo2+4zhI8qLVkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="58514500"
X-IronPort-AV: E=Sophos;i="6.18,243,1751266800"; 
   d="scan'208";a="58514500"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 20:22:47 -0700
X-CSE-ConnectionGUID: xjdogmciTZSIIJkZERrK8Q==
X-CSE-MsgGUID: /mLWqu07Rhiiou8bvSDbZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,243,1751266800"; 
   d="scan'208";a="172668344"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Sep 2025 20:22:47 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uujVk-0001A3-1J;
	Sat, 06 Sep 2025 03:22:44 +0000
Date: Sat, 6 Sep 2025 11:22:41 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Guerrero <ajgja@amazon.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] mm: memcontrol: fix memcg accounting during cpu hotplug
Message-ID: <aLupAVl-DSxOXuza@b7823f61de85>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906032108.30539-1-ajgja@amazon.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] mm: memcontrol: fix memcg accounting during cpu hotplug
Link: https://lore.kernel.org/stable/20250906032108.30539-1-ajgja%40amazon.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




