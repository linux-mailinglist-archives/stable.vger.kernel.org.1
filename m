Return-Path: <stable+bounces-165659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8852B17153
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 14:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2445D17C061
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3540F22A801;
	Thu, 31 Jul 2025 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hg3X4ZzD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0E221720
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965291; cv=none; b=mF4Sfg/ff9+t3mTLOvsa0j3yooAgY1XQ2fFKhh4uAM3NwhjChSVEdK8+owL+P9ow60DX+l4WofsZnggQYncEi1wE7kOvwylDELpwjCeTKq/srys5hYgejDrOrcVyJGpU5bIED2o6E+I0Sys9b3yHgVA+8uPHUtpS9ed5YJ8+0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965291; c=relaxed/simple;
	bh=2gu6cfYj8vAX0i99xBVixXHZz+4R0OpZvhoZUDoAfSs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JolYKFxZEQrDnCSNIrmhtpEdamCS6PuwoUISjCCPMJ5X2AA3lDT3lbSuTB13FrssnD2/LMkd8uB0hj+UDQQRKTJlDgKlM7RbJaCFCzSezeu9cREWZPJ91VcRJQZiSd4TN+NQ4QUHt1HiZO1F3SMqEGtcv5Szm6civggRj+OLbx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hg3X4ZzD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753965288; x=1785501288;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=2gu6cfYj8vAX0i99xBVixXHZz+4R0OpZvhoZUDoAfSs=;
  b=Hg3X4ZzDwLJb4EJx8olYi6XohFpreTQVviawRJO8p8/mMbyiYEj7YvKQ
   HfS8zi9Ky04UQ0V7I3oa3ZQ/k9pp4ZLzRoV93HQKp1d9ZMXCYbNZ1UW6H
   YdvuDQDzG0nR8sw0HYC356Me6ncRuasKTtm9yti+NKs7AcXFjj1yXJdYQ
   pejoYa0qsF2Qpr2Pbv3h/s12DjwR12225Mvk6FCq58iymVqXCm3TU/iwR
   zFZP3M6VeSyu9axA9HyK6qVodbpu15fYtHqMwiLENgYCOnnnu4uoObJ/2
   RPOvXixdNcEioBVZBpBzy7WhnYnN3zJvMtvMT/vG62ozVe7Q72HjppLlR
   Q==;
X-CSE-ConnectionGUID: 8mNFzY0ISrGmdhKlh/qFTg==
X-CSE-MsgGUID: NDJTPJZrRBuPQedp/3eekg==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="66852914"
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="66852914"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 05:34:48 -0700
X-CSE-ConnectionGUID: Yd3pDRtdSDadPGu/V4b+0A==
X-CSE-MsgGUID: gSSshkcvSAOOKP3/qK6XKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="194245871"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 31 Jul 2025 05:34:46 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhSUe-0003lk-2J;
	Thu, 31 Jul 2025 12:34:44 +0000
Date: Thu, 31 Jul 2025 20:34:01 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] blk-wbt: Fix io starvation in wbt_rqw_done()
Message-ID: <aItiuYO5PNhhUxl_@e754814b2865>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731123319.1271527-1-sunjunchao@bytedance.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] blk-wbt: Fix io starvation in wbt_rqw_done()
Link: https://lore.kernel.org/stable/20250731123319.1271527-1-sunjunchao%40bytedance.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




