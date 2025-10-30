Return-Path: <stable+bounces-191718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADA2C1FA52
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 11:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F6F188794B
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C01F344037;
	Thu, 30 Oct 2025 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJtgvvcG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA54D2F6912
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821519; cv=none; b=KmpzZckhSlbCKSpeFLT8lkTBElA8rvfiYo7PW3IZX+/iNM15ZK5Yo40zSFXcORYfshLjnRkE/RPI84g9Z17sytqQkUAeqQ9qgkRdoCh9xd9zZLnDC8z0pab7zF9zkn1jBtJ8lw2Ic2fv3RzCFbsaiZbujVuHUQqNqWMofAuWu7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821519; c=relaxed/simple;
	bh=alXfXWJ6X8w0m9N/tWQ+/ZfXvVfauWcWFtq4KBnlErc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rMIPE08/we63BPHySbcyFlmMLcSY2zCqR+4iBAOyXMzXXI14CvfmmbTgkkGqG9jEGNRj5/AfEGp9M5vTmdGPiEEj+ipC5VKb4wfQJcUNNdc8AKYDMmLplDgZntg5V4lp7JnKa/uh+Rotev4ig5ifL13tdz5glcW/QCKHmQGbVPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJtgvvcG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761821518; x=1793357518;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=alXfXWJ6X8w0m9N/tWQ+/ZfXvVfauWcWFtq4KBnlErc=;
  b=BJtgvvcGG7hcbFeiR9wcmHNBN0O59tfI8lw0E1rF0jhM1oDb8dQUU9Nb
   Q39AIAll86ErVo1GErT3r3g7cTB6FCZJHgVjBVVvyY1DU1C2uKvNBrbrm
   cRacggU1CPr/SRWGUZp63twxB3fj/GmJlBJ6df1Kray6KSZdtviAuBFrt
   iGVjY9Br4LUYpiNihiCVNAK9cSnNWMt5KwT5c4Wqnb2IWHj1bX9ekN+CZ
   mbDp40NYMZFoxXXzy55tSVtbZTVQC+ZleFxHMuPSPLsotRN+Zt3oxL5oj
   SLPagnYNUPp01yXU2N1G/s75H4wGGrPh13xHz27qUhcc6MK3gnX8BPTfe
   w==;
X-CSE-ConnectionGUID: WA7YNqH8RcCVtMGxcEUQ8w==
X-CSE-MsgGUID: 5oNyyvBZQ9aJQrA8SzyV9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81587569"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="81587569"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 03:51:57 -0700
X-CSE-ConnectionGUID: Gcx246s8QzS1hlSo4QaiYQ==
X-CSE-MsgGUID: LOQAsz+nRp+cPfHvqxY0Eg==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 30 Oct 2025 03:51:56 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEQG1-000Lqi-2L;
	Thu, 30 Oct 2025 10:51:53 +0000
Date: Thu, 30 Oct 2025 18:50:54 +0800
From: kernel test robot <lkp@intel.com>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] net: core: prevent NULL deref in
 generic_hwtstamp_ioctl_lower()
Message-ID: <aQNDDs9GWt73ekNu@fb33b90f3739>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030104942.18561-1-r772577952@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()
Link: https://lore.kernel.org/stable/20251030104942.18561-1-r772577952%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




