Return-Path: <stable+bounces-98902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC91F9E632A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 02:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0D618825F9
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00991758B;
	Fri,  6 Dec 2024 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEL59BKs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8C13A86A
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447665; cv=none; b=DVnJ1Arx2OOVT9BTB6OofhRCu6sVzFyJkgF/iyyo1fEDg/zqxeQ+WXuCoyRY0inK1paOh+b6u5F0uhcY/O/CoI/0J+p7kT4fVd5BkxP1uqIYv1g17ZXmrE4NwwX0ypXCBVTwEg+lmFDamERHfU8jcIO9I6ucSqFVvrkGSsICtV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447665; c=relaxed/simple;
	bh=CVx1tfEuzgmg3TrwXPsBFQ07hZHrMJCVg1qAPFUMJfE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sg6s2TKPfpVPjP0kf5S38KzTl/K6WHgNRQf0xYFqYCXJ70+KEB3gC34wDD3Go2t9AERDMXpcQNGaR2EUBQqzh30SxmOD6lvqwEnM/3A+uRAW3SCbQM1MoemsTgVZDqsFKDTRAkNJ8+sXWI09b3WyQ1yLsTjzKaypPrnCVdAzxo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEL59BKs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733447664; x=1764983664;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=CVx1tfEuzgmg3TrwXPsBFQ07hZHrMJCVg1qAPFUMJfE=;
  b=IEL59BKskv7gH+jxKWWms9IJn2exU2pIXNW3RimqO3Cke+CzuN41Pikn
   /MdGENat6ml9+ef0Lizp7DVM1BBHLx+/mlU9AQWB9Naxk8XjannV+0xXK
   T9fKZl/9y8OYA5/LdUb6ptcHe+rY74Npr/Y1nhNKnrH0Or6XhzXPx38Md
   XefrHQqh+C3RmHM3+UktrnkrpgkkL0RJcI6me0NU0n7BnwgZggN2Bda/o
   He/MY1hpxVVLFpwIGojPZNx9NYLBIA4wnfrIHk/YnqudJ8rgTNuv0b7XD
   GIQEgtIWKybat8Vh0YjLvqFMthDLZm/v54TJ5MkN6k1tjA1nLRXpX3X/Y
   A==;
X-CSE-ConnectionGUID: EvHwXt0+QLqz9D5rvMkGaw==
X-CSE-MsgGUID: qPESYfZDSlelMwTbpwV16w==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44455411"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="44455411"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 17:14:23 -0800
X-CSE-ConnectionGUID: r4LX7kKvSWe3uFhHhN8dVQ==
X-CSE-MsgGUID: EMV5THeNRWGNxP43iaW9mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="95082128"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 05 Dec 2024 17:14:23 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJMvE-0000ZD-0V;
	Fri, 06 Dec 2024 01:14:20 +0000
Date: Fri, 6 Dec 2024 09:13:57 +0800
From: kernel test robot <lkp@intel.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net v4 2/6] virtio_net: replace vq2rxq with vq2txq where
 appropriate
Message-ID: <Z1JP1Xt7FwYcnQpv@48df2600aaea>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206011047.923923-3-koichiro.den@canonical.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net v4 2/6] virtio_net: replace vq2rxq with vq2txq where appropriate
Link: https://lore.kernel.org/stable/20241206011047.923923-3-koichiro.den%40canonical.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




