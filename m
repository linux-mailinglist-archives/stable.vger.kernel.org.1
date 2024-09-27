Return-Path: <stable+bounces-78107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4977698851C
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6FE1C22E75
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B79D18A6C4;
	Fri, 27 Sep 2024 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dek+i9aH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8211A18BB91
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440583; cv=none; b=bDlp5a0evlk5Iz476gRhMUpb+Fds+xRCZ0KKvoICFQq1UWxLXKLbnQh7FIrKLE7+j+OQxtfHsGU/+/C1q/4t7GmF1hhtWzNiULr0OSnKuUknMbo7LGKw3Gntoj0ktw2fk5ptMKeD4nsE7e+/mOc4XWiLfiYz2DUO62ngvXcmues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440583; c=relaxed/simple;
	bh=leXil3idYbJEMJ9/ZEWFlUQ3BHkuCImSu8XTukgiTv0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SXkCw7zBfA8CHO5nnlXU+guKtfS9vOxscEa/KiZf1otomLkk5pIgsJwLFt2tP1R6QwlpU9ssN5+6237pR/iajhKoCmV+94aNz3hK2S6Ab7jNArdODuoBrOOiZ+iTgaqmvoqJpjxkWXHtcZQ6j0nMnd3DtQjIol7/P9GW3doVexc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dek+i9aH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727440581; x=1758976581;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=leXil3idYbJEMJ9/ZEWFlUQ3BHkuCImSu8XTukgiTv0=;
  b=Dek+i9aHbYn8dagF3TRwc0vIy5xMuG2QjyOktxGP5t4ckP6lsQLvkvH/
   aDpr91qWBpbhlhUWmpm3nEBLAa5hZD5kDo+JY+mactYmvClDSGyW87lcE
   1kOLN2WV8pw0zzf5ecNJnFsF+RGIi9F4UG1OD3Y5d81VpCtD8q2BcJ22e
   sukjLtMa8gjiAtQo1ChRaIm8OdiJU+Ln5mhR/fKkp0skUPktbax6scDbW
   cUthGOKO6R62zMMjP80XlXgjMYt+IdAZ/EoD1ABRP3dL+TAL8wu80V9K+
   sMh4bi+N/G6enUv3ouvPoomdvQoc8v/KKgSeTrVvqf15an9/oKRqH7FM9
   Q==;
X-CSE-ConnectionGUID: iVhnV3iRTkajEXmfO1Mnfw==
X-CSE-MsgGUID: JkFDRhMeSuavpmNNuoia4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="29464751"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="29464751"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 05:36:21 -0700
X-CSE-ConnectionGUID: c8RL6270SXG55bt8/LTIUw==
X-CSE-MsgGUID: Qnp1oKRwSAmPQvt09sDQqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="76595687"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 27 Sep 2024 05:36:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1suACn-000M6R-2s;
	Fri, 27 Sep 2024 12:36:17 +0000
Date: Fri, 27 Sep 2024 20:35:58 +0800
From: kernel test robot <lkp@intel.com>
To: Daniele Palmas <dnlplm@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] USB: serial: option: add Telit FN920C04 MBIM
 compositions
Message-ID: <Zvamrm33TYsUaRb-@5849f93d069a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927122816.1436915-1-dnlplm@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/1] USB: serial: option: add Telit FN920C04 MBIM compositions
Link: https://lore.kernel.org/stable/20240927122816.1436915-1-dnlplm%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




