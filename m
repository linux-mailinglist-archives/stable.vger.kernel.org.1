Return-Path: <stable+bounces-183669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D8BC7EE7
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 10:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7E7421514
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 08:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BD825A2C7;
	Thu,  9 Oct 2025 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4xFPvl3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579B1263F44
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997114; cv=none; b=nR7LVih0oVPn6oe50Ra0xTgsUcfWw7IIlybJyvol36KkPsOQtpll3iVhwF45BicbY1hF9cjR9/E/pfbWT00x2/hFeTdfU5bQcDJnOBVCV7enngZPPprzomZh1UrLsQdglkzIpm3XS6VAAKtJlDI8ldhsli5e8SbyLafbLRr907o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997114; c=relaxed/simple;
	bh=OSRp9WjubR/QDw1eLrWKD5ZecNW7SDqjhkCpynhJBCE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=owpb1AaahPzSXbFTkpT3Mew5BDtplEaIy6bsPknTAvYmY6QhUxn+2cilKDaeejWqBs7O51WXpvQVqF8KZjd06wzhu6hjZbXLAUJQtEXmaJXnv0cdfOMynkibFF9mXSClXt9mQAuCQakJjtkvkcD3FFksZKqPIPJmC3EybQIQMlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4xFPvl3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759997113; x=1791533113;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=OSRp9WjubR/QDw1eLrWKD5ZecNW7SDqjhkCpynhJBCE=;
  b=n4xFPvl3aK7Ha79qB1kindvj1Mnc3rBVtBZUdQvpsOq9gF10pUAjSxAF
   c0Poys6PPURPtMK1enWQ3w+Scx/QjvGzHPCWFg4f27LmzFuza1opCcfN7
   TyKZgDUeqWfzVAShlGYEfOSk70FR3xWmdywpBnhK8SwQvN5l5osIAjybk
   mxvsVDU547jXNP8AzzO+CO+rJ2rNB7FnNdZCm5UIIsi41CDl4sg2Gc80o
   jHpB6pdowf/0G9mvMKZfm5iXJnlKb86COr3Ge5yK6+Q/lYXHlYKYjuXrG
   MHIkFr3lxA6BKAgjZeTplWhSVIXDv6SsGCzInqEsolaNo3maAumD2lXoM
   A==;
X-CSE-ConnectionGUID: gJ4vxC6eSJu55Zm5m6HQeg==
X-CSE-MsgGUID: myCGpEvZRQ+3jZry2452aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="65848961"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="65848961"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 01:05:11 -0700
X-CSE-ConnectionGUID: 6Fe5E9V7R3Clv/1t+LQA3w==
X-CSE-MsgGUID: YQi5azLRRmqZOPhLjRV4Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="179766297"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Oct 2025 01:05:10 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6le7-0000HV-17;
	Thu, 09 Oct 2025 08:05:07 +0000
Date: Thu, 9 Oct 2025 16:04:10 +0800
From: kernel test robot <lkp@intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Enable init_profile_id for device
 initialization
Message-ID: <aOdsehZph-R7YR9j@d0417ff97f04>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007103708.1663-1-shenghao-ding@ti.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v1] ALSA: hda/tas2781: Enable init_profile_id for device initialization
Link: https://lore.kernel.org/stable/20251007103708.1663-1-shenghao-ding%40ti.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




