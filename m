Return-Path: <stable+bounces-142853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B9BAAFAD1
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 15:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7034F1C01EED
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 13:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A93A226888;
	Thu,  8 May 2025 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k00JjSYb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1941FE47D
	for <stable@vger.kernel.org>; Thu,  8 May 2025 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746709503; cv=none; b=UF1wWFC3F39eFsUMiUc7WizgE+WJiavDtE3I5FU4hFdM79xM8ywi3pKVeY0TTYZsFcZIKfKDSfHtXEsYr/CkxFai0LnjD6rAmdtYUdSp24O/NJiBfFQi19TdDGsYbcXMSOjxn5IoRlrQuLWvIG/mQscxcNhnxD0/WuiounWKBzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746709503; c=relaxed/simple;
	bh=7RplGiRvLwhV+LI4/aYfGxMXInwuhlF3bwKi2H8qc4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BIH+Qw76rFKOXHjvkdxCkf3mUiirNL5kVVOy9S48RZdXKWyawvXqOEankq3s4vWa6zy0w9nWm1E2yYTedd/AQrRCqwOZQnCTQZKxj+l6rPhAIOR3Iz9nZal8XKL6pW+jQIn+eL5lBP99nMJWFZtHdrJTUzsTK2aFnNHZcR6verk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k00JjSYb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746709501; x=1778245501;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=7RplGiRvLwhV+LI4/aYfGxMXInwuhlF3bwKi2H8qc4g=;
  b=k00JjSYblw38H8UMNAkZLyOONBWYGHPNgPisRj+bsxF9xWD13MbmMwg2
   0Yq3zcc9dQig/2hw7vWPABzwALVOVOKsWq2B/lwGH5Jx+CB8BFMUgTn2G
   Rj6xDdUyUdc9a6OgC62z/fPOe+POCxNriqUjKfW29XhrW3WbSwJJsvP16
   Jm4Rb2l6qCOaiIV4H4JhJ9tPEBD1M2zTSX89/WZPtVByNUwwBthLJAY0k
   IlVze8KuN3b6VuHOuLbul696h3dKZy7k1xM0WBMTvt9m/nBgVTimv2RkL
   bC5aYSJzM/5MVELWkGH0wCmUrw6BTiIFG4gPYGbsi9ONsEKnS5yTPt1vB
   w==;
X-CSE-ConnectionGUID: OXTGbKaUSvyMbSjg0X5G5A==
X-CSE-MsgGUID: 2kIFCSv9QzenlugmtsoIMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="66024269"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="66024269"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 06:05:01 -0700
X-CSE-ConnectionGUID: supcJzgSRGKDpS+KTw93Yg==
X-CSE-MsgGUID: 3ya/7VrWSceADL89OgEeGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="137281196"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 08 May 2025 06:04:59 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uD0vp-000Ayp-1v;
	Thu, 08 May 2025 13:04:57 +0000
Date: Thu, 8 May 2025 21:04:11 +0800
From: kernel test robot <lkp@intel.com>
To: Zhu Wei <zhuwei@sangfor.com.cn>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] scsi: smartpqi: Fix the race condition between
 pqi_tmf_worker and pqi_sdev_destroy
Message-ID: <aByry_7Qf0DvnniP@c5bf816c9d15>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508125011.3455696-1-zhuwei@sangfor.com.cn>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] scsi: smartpqi: Fix the race condition between pqi_tmf_worker and pqi_sdev_destroy
Link: https://lore.kernel.org/stable/20250508125011.3455696-1-zhuwei%40sangfor.com.cn

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




