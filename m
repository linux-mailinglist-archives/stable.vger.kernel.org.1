Return-Path: <stable+bounces-139525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCB0AA7D92
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 01:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51AA1BA694B
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 23:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0C0270565;
	Fri,  2 May 2025 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmkFkQp9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3425622D7BD
	for <stable@vger.kernel.org>; Fri,  2 May 2025 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746230321; cv=none; b=QZGPRipp/Xvz+uu6Rur2FwNH1tKhJRI8ocunFrIbjmH+zFhOe+d9GdyRq6oC7FpeWfzzaf4aovhS3V4XCekpmWgpez6th86UhmI/gbDHOYjyfCLy7c1xDseRDf30RXbmBN1CE7XGnSsaL05FGgUyWYIWPbYb9wuAS0agoAVQAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746230321; c=relaxed/simple;
	bh=4b0yRqo0rAxHy0l8qp/09UIiMn63xiGV7yOhM0W+d1w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HTIgbcWdPtBkYQQ+n4NyCWATBpLecxfvzOaYSOpPpaseaYd5567nh2ScwK4vCUAK13v//BUSzrzRMZlcoMIru6i+CK1DFPfk5oYyUnP1zPdjtrd4HU/TTTwdpEHt8gAFf9B2YICu6SixywNtVHWfS5mTZfqpzEst/4fJNeZM3ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmkFkQp9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746230321; x=1777766321;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=4b0yRqo0rAxHy0l8qp/09UIiMn63xiGV7yOhM0W+d1w=;
  b=NmkFkQp90BXiDdnZA6qi5nxPeDRqtksPGOLO8B4r6MVEiatR8QEkfABC
   y4FaLa9QgRSIpuc1T7fik45oTWSEGMaKqyZl6xO2kxoswEHkOzXUoCKaE
   ijQlmU0lXWxp+kX9ij8P4/wavMBD/A7FHl6Fi8st+xw3EZMdfY35pohG1
   w90dtYjDfXs/0N/zjCed58E5zUgOC2jywFraUAtNpMYO5pvgDc1No7FS0
   Y29HraNSA6sxLyneFGDf4Nmkjsq3ScqPHzjhzsYEEbr7Q8jU7jJijqPiB
   /xp11+J/6f0yi72VqiMADAGyo/jxXhAkcsUg5RlQW9ur1UcDEbxM3NVy/
   Q==;
X-CSE-ConnectionGUID: aXas21V1QQG8Srth4MuTPg==
X-CSE-MsgGUID: T8u6XnNCRNyYke+g/1/fbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="51735282"
X-IronPort-AV: E=Sophos;i="6.15,257,1739865600"; 
   d="scan'208";a="51735282"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 16:58:40 -0700
X-CSE-ConnectionGUID: veRvFMVKTIaFkxw2pvuf/Q==
X-CSE-MsgGUID: BxHNF8kuSQ+hn9L3/B6fMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,257,1739865600"; 
   d="scan'208";a="139914655"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 02 May 2025 16:58:39 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uB0H6-00055h-1Z;
	Fri, 02 May 2025 23:58:36 +0000
Date: Sat, 3 May 2025 07:58:20 +0800
From: kernel test robot <lkp@intel.com>
To: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] usb: typec: tcpm/tcpci_maxim: Fix bounds check in
 process_rx()
Message-ID: <aBVcHOF7oTPvk0XZ@92092d2942b5>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502-b4-new-fix-pd-rx-count-v1-1-e5711ed09b3d@google.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] usb: typec: tcpm/tcpci_maxim: Fix bounds check in process_rx()
Link: https://lore.kernel.org/stable/20250502-b4-new-fix-pd-rx-count-v1-1-e5711ed09b3d%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




