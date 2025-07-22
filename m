Return-Path: <stable+bounces-163635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA58FB0CF24
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 03:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7B8188C75A
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 01:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DAD1805B;
	Tue, 22 Jul 2025 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHx1r8W7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8DE2E370E
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148209; cv=none; b=JHx92cVS15YBno2NIYOj8YmPIa1Ic5U0ilRHfJ/Ax/EbzzEhqG32dwdAh3OdMhe618IINmH2VlgUtUiGdi6mIaac8Qbu/pOLQQNLWagYfqAWmR1M0QS4nRFoLzTDOoJI25LnPEee74YaQ1H3XTgHRqvprqlITy2SrTueJlq9kdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148209; c=relaxed/simple;
	bh=bDmDb6ijS9Vz5SxD04f9hJAcVByAMTPV62zxAApbflk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UrP3EjeV2Pfb9QOrdvB3z0wSK0FFKsLR0EAdLIdrJ+T5oiKIBYWLhgnb6HJzZv/6lHhFOP3uk77B476AhpWBqptKWRH+wRCZ1IDpk/uDtzBQlK6BzNhKJ3K7bi2IrM3941yeJDUNr3dgPM/tfKcmFSd8Qd8z59/1F39H67oE0HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHx1r8W7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753148209; x=1784684209;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=bDmDb6ijS9Vz5SxD04f9hJAcVByAMTPV62zxAApbflk=;
  b=KHx1r8W7A43LyxG6EC5bMj25rdbvPv/ZIjgfEwqWhlrLSkf2IAIYoUZf
   5+jgHhweUMgBeSn0fNCXJWbyu1BuM7hyvt0+JJ7nmP4bMJybk8fMAz82Z
   FzCHt+ee+Xz7lS2Gd6paxi17DmKXCKvK6utCUZUGsywcDPEZfqOx68tpl
   +BX/HapDEXEQIbexYk3QLDlXnmgDyUcYTX70JarfoatZqQUF9/ayeEUDH
   kM926k8tkUtBUCGh68qAVmKo5QPbFvInHxUQyX4p40xEJtswv8IczYAKV
   8qJbWFiqe5H3e6oODedPulYIA26HhlYniDQEyXdz6+m/NanEVsbaYLhrd
   A==;
X-CSE-ConnectionGUID: eoTOi4qbT8WtrqdJsaLFVQ==
X-CSE-MsgGUID: b7y2UJUXRl24FnRskSjC+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="72835032"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="72835032"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 18:36:48 -0700
X-CSE-ConnectionGUID: hRGV+PYCRbmRvUks/X8Nkw==
X-CSE-MsgGUID: eRXtgb+VTKug8KXV6u8rug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159549357"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 21 Jul 2025 18:36:46 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ue1vw-000HK9-2s;
	Tue, 22 Jul 2025 01:36:44 +0000
Date: Tue, 22 Jul 2025 09:35:43 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Zhivich <mzhivich@akamai.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] x86/bugs: Fix use of possibly uninit value in
 amd_check_tsa_microcode()
Message-ID: <aH7q7_B3LC1TgN1t@6f60a8441bb9>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721230712.2093341-1-mzhivich@akamai.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()
Link: https://lore.kernel.org/stable/20250721230712.2093341-1-mzhivich%40akamai.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




