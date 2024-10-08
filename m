Return-Path: <stable+bounces-82654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C7994DCF
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628E21F24429
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F381C9B99;
	Tue,  8 Oct 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2b1omZx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71D81DED6F
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392975; cv=none; b=IzgCMYA+4HJdjVEXhyZWghfOV56KpSmCu/5yoGr+Q0Jp3J8p1ObFTQeUrKbrxwpXUUkxv2syDxMk4mXUuwyqcq8oraFpIm3K4Q3J7AAbdIO7sycsB6yi8EA4ne5nAgbL806anJ01mdh035p4yfLJY6qbm0LXGZzBBUfEzWQhfKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392975; c=relaxed/simple;
	bh=DitKCkC+jbpKnaLI320XXK4aEx0Cdujhf1TGifz+AW4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CUASIM4DjLdKUYfdVroRR/5uxx9aSKrXNF7aRd/lIeLcIepwotTHZjyCIpsqzzRhRseeDCR5CQrytXKtfHqOPvs2NMEMxuBaTc71y3yTFJp3jzCIyUGX8qApM9AT1UETOGTbr/WUfVj97QyDQcQG1UhJMPUWzrlJ5IA4MncU6F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a2b1omZx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728392973; x=1759928973;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=DitKCkC+jbpKnaLI320XXK4aEx0Cdujhf1TGifz+AW4=;
  b=a2b1omZx3NUSHTkBKdQi/H/m9Nc8ljhffKFMdYscUJvd5W24HwybHb2R
   SeOigzyI/NPW0LQSAlfofsOgHx2kk9F7/VXp7f/9LYD7Z61VC3Wskjt5s
   SE+9MmK3/ltdPwEDAzUPxdnQBgkFWGWE7MbpnT0hCbf/NTqPliPiNovUU
   EmATgOvxBe9Gsuk9UIF+eFZSSgpUVX0VQCPTPh3di6AS2C1YBk5PX3aXQ
   3JzyyCfEyBfXjPf83K53xUvs0LPn+PINXjX/B1CVuCQ4JxIkFHwp+mIgi
   dqwHWNXwIsPge+Z3IXz7BpLqy93tpNHpkNRnt4z7NiSX/POvIb044wyaj
   g==;
X-CSE-ConnectionGUID: 4wJvPwUeTmmKH9QNjYxm3A==
X-CSE-MsgGUID: J8aZGalBRNuWZ5vBL8cjJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27718079"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27718079"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 06:09:33 -0700
X-CSE-ConnectionGUID: /7NBJPGkTAa0wBdLeqHn/Q==
X-CSE-MsgGUID: ok1q74dFRcSfVIGDnNu0bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="80618092"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Oct 2024 06:09:31 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sy9xw-0007Sg-38;
	Tue, 08 Oct 2024 13:09:28 +0000
Date: Tue, 8 Oct 2024 21:09:13 +0800
From: kernel test robot <lkp@intel.com>
To: George Kennedy <george.kennedy@oracle.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] [PATCH v3] perf/x86/amd: check event before enable to
 avoid GPF
Message-ID: <ZwUu-bYOIzWNrBfp@b1422e034610>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728392453-18658-1-git-send-email-george.kennedy@oracle.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] [PATCH v3] perf/x86/amd: check event before enable to avoid GPF
Link: https://lore.kernel.org/stable/1728392453-18658-1-git-send-email-george.kennedy%40oracle.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




