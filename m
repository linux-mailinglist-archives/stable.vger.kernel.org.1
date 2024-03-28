Return-Path: <stable+bounces-33101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B8489052B
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 17:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DD61C2F3E0
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB7E130AD4;
	Thu, 28 Mar 2024 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVUULs0B"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7572412FF96
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643298; cv=none; b=elBoRGRP/e2U1BDFxPn2bGInMUTq4dz3cYYW4J6wlz63xdD3pGojjJiZrk46FbhV125o6ehyFTOkzKQp0nGQlgXT85KGh1KOvP4HQlD5aeKCgvckrf415NH60sMetvpqor/IqiUFu+bD8eBDKNIvdOO6isGDZTqTzzinYPI9jOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643298; c=relaxed/simple;
	bh=choMBFtkmj6+7+fYC/4s5/pIwYec5KUcH193u4BpNQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c37Re2xfwJGMpVcSMR96cQ7uD6p6v1v2p+PFHe7me3BPAcktYqxIc+cX4o7kMFpwQ430QV7CJ4IZtD0T56fprJ7QSVuXMU4oIoL3fG/7842/JutFDMfEKhvPTcZnTAajBq+t6IWZefQToLrKKfK41JKrX6EHzqOrvL1HPX9mpf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVUULs0B; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711643296; x=1743179296;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=choMBFtkmj6+7+fYC/4s5/pIwYec5KUcH193u4BpNQ4=;
  b=LVUULs0Bjw8ao/gtiO0vFGSFw8BN3Ti32iSAvqwFM1B/ww3P/tdsq3GL
   5UJ3KxRIQPTiYs3wbjb6XJxeCeel+g3cUvMajqpm3vWlw/ZH1skdS4jeP
   49wm4ic3o8vNBM6VKOygX4B3Llptd8SDWPW4lB4CK7fqKLeezFwbahbjI
   I8HqEikoM2USMog47WpKZ8gToGq9JwlE+q1Xwx50vshOJkn2gUDbkbtyf
   UPyGVC2+PldeQl9RCdZo2kIQTvKWJRp7koePdmQ/178B6GDrl+ROpb1TH
   Zlt/MOwmgBngJdSk+hwL8C1kLjynIpkSvv8hf5kEBE1GbAhOcjgmANXAR
   Q==;
X-CSE-ConnectionGUID: YDSEyH2uRIOILYGa9+fidw==
X-CSE-MsgGUID: 0z0PCy0USw+LTps8mJyBBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6703626"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6703626"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:28:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21202645"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 28 Mar 2024 09:28:15 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpsbs-0002KM-2M;
	Thu, 28 Mar 2024 16:28:12 +0000
Date: Fri, 29 Mar 2024 00:28:09 +0800
From: kernel test robot <lkp@intel.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH RESEND 1/2] usb: typec: tipd: fix event checking for
 tps25750
Message-ID: <ZgWameBil6fAmN8T@f34f6e606ddc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-tps6598x_fix_event_handling-v1-1-865842a30009@wolfvision.net>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH RESEND 1/2] usb: typec: tipd: fix event checking for tps25750
Link: https://lore.kernel.org/stable/20240328-tps6598x_fix_event_handling-v1-1-865842a30009%40wolfvision.net

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




