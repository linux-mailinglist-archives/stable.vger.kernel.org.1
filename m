Return-Path: <stable+bounces-176898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5FFB3EE2E
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 20:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26CB2C0C5C
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 18:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A2D251791;
	Mon,  1 Sep 2025 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2jJQjdN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2172242D90
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756753077; cv=none; b=ZEHbbKzwXo9GGW7y9FGo9Gqy/XxYiNyw5PqgKZp1KT6KV82ANoclkYkmlrCmfYH4SPHd51x15WT55wdnrnlBz2bzmFtUo34tN8kQgedugie4BTHKTQSLx5RELhmk1n9XyQ0AFdbGiNttPplImeYmcrokBKvv/H4caJqQkzrnJ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756753077; c=relaxed/simple;
	bh=xMqcOt3ELvvgyapfI+26vNbtMX9ySont1YEMK3Za6cs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hEAqktBm8wm1sXT7BFrjyuuq2/cUkSzyBQnbbIgINQNJOqLvO3fv677Jh1KIsaqNW8Taxph3m7PUkz7XlwICIL6C13A5cSXvyrDxMlTEW9jrClrRrorweHXQgQy6/EhK1297nTL5TUpp6xvHP7BGkYOi6vBGqfR7csyFsXpYIgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2jJQjdN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756753076; x=1788289076;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=xMqcOt3ELvvgyapfI+26vNbtMX9ySont1YEMK3Za6cs=;
  b=V2jJQjdN5s55CAMctz8sf3lUS0+WYcPkdZtNJWRR4ntpeWBT1dJtBTsC
   GGdy7fWqnZH5+gWESaZ3194ZR7bZEl1qOwnq4xw7jPi1DUWzxuWWwm2hg
   dnASFOYRaFvJ00cl0pu6eVb9fPIQzJ0+agSnBePkn378XyZmJqmzzUyEm
   gY8+mIkhJzZiGvS4+UK6dBPQdIDjzQmJKArpwisBtOVmAPDRdmCRqUC32
   33tgV6BmfJdxt+XKuBAVffhWsKrXp8qYz5852uV+/r+HI1C0seMY+2B1J
   o7kuCDQg4R6pqxj7Wd2p8k7RjA01qMGWXXd0AmjHJ/e1/ZUXSw9PWi+Cy
   g==;
X-CSE-ConnectionGUID: +dzRTnhLTBq+cII+TRYOMA==
X-CSE-MsgGUID: vvdxH9YAQS2nDc9Dy6nOhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="70447865"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="70447865"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 11:57:56 -0700
X-CSE-ConnectionGUID: m7264n5rTNOAo5vM7jqNzw==
X-CSE-MsgGUID: GmtwzmokR02G99iTrUX5zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171940815"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 01 Sep 2025 11:57:54 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ut9iy-0000wd-06;
	Mon, 01 Sep 2025 18:57:52 +0000
Date: Tue, 2 Sep 2025 02:57:05 +0800
From: kernel test robot <lkp@intel.com>
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 1/2] drm/buddy: Optimize free block management with RB
 tree
Message-ID: <aLXsgf_b-uftt1if@c51ed5950d49>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901185604.2222-1-Arunpravin.PaneerSelvam@amd.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v5 1/2] drm/buddy: Optimize free block management with RB tree
Link: https://lore.kernel.org/stable/20250901185604.2222-1-Arunpravin.PaneerSelvam%40amd.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




