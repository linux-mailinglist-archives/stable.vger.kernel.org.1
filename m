Return-Path: <stable+bounces-25309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BECB786A433
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 01:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 255E9B2AA7C
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 00:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583E7363;
	Wed, 28 Feb 2024 00:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3DikvmA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80DA1FC4
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 00:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078482; cv=none; b=RqPM01G3cmK4Csvx+GnzWv0WiZiLoUOH5Cv/D1gwde+5thQrYcwogdN2oXAtgvQFnQ9HbkPQsDjupjYnOgi8MEA4bG/1x6sowbxcfQ1+k/02cfgTdCGxXc33cDAO1khRhe34AJ4tbjM82dG89mSnut2YYUM+jNep0ZwO9fU1pZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078482; c=relaxed/simple;
	bh=UXjOkNZvkQAVDVd2jZEbdOY8MJ/Ova4bIjlZT8eQVO4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QiC5zC7hllrr7GjgSy7/dnW499mJ4eS2XerAroHCQbgDI4MfePz1JsdlQ9N4SrBThfwemqOXlGtz6Nb8SQBRDHarvvxc21SUg0IZAp5Xl0M57U5W1dfGEXB8gPL7LWhtRJ6tnDohiyXMb6xmFCzno+5e5dovEu1rdEkRHocD4y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3DikvmA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709078481; x=1740614481;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=UXjOkNZvkQAVDVd2jZEbdOY8MJ/Ova4bIjlZT8eQVO4=;
  b=H3DikvmAgWHNIpHjspijcBpT8ouIa+KNo3QrkoyXLOwZk3YC1cccd2Kh
   giKjbWxqqC2fOiS8IlwhwpbENpwfJCx2DC8HYi+2jfFLNmSpiqzMv4h+9
   Lg5MRMvhNU9qHom+qBD0BUXAwwxPNQT/Zf/5cacEp5cFlWs/9a0812YQu
   8bLcMJXRRafgooZBS1/sfmf0ROuKKdOx7rcpKgrP85CuZnVihG+3QdByM
   Ys6t5n8aGB+/5MVYKH0eyg3rjPGcHxs3+MNcCXpxhzl2QTPJiptatC6im
   4pWovwp8aAMVTA146cmYTRpd9zsrNWxjGbBl9uBnGoPO/9JRiiDFVfbIf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14876731"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="14876731"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:01:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="38044511"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 27 Feb 2024 16:01:18 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rf7Ns-000BcN-1i;
	Wed, 28 Feb 2024 00:01:16 +0000
Date: Wed, 28 Feb 2024 08:00:29 +0800
From: kernel test robot <lkp@intel.com>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1] usb: typec: tpcm: Fix PORT_RESET behavior for self
 powered devices
Message-ID: <Zd53nWRnXBECCAbd@fdb2c0c3c270>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227235832.744908-1-badhri@google.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v1] usb: typec: tpcm: Fix PORT_RESET behavior for self powered devices
Link: https://lore.kernel.org/stable/20240227235832.744908-1-badhri%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




