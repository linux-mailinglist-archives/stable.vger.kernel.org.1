Return-Path: <stable+bounces-181570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F3EB98574
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 08:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8CE2E72E9
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 06:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB0242D69;
	Wed, 24 Sep 2025 06:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B28hUVWG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB223D7EE
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693816; cv=none; b=IDwpOf9pviWUVnQ3ZyPIGCIRbcABnqZIum9PHL4BRTsI2JO06IvNZjR4FdXVWRBwTrc8Iv3vjz5NhgIrSocm5mfmqBVLDvPzKE9haFeBVsmqDq+wQmlnxQ4FEp2iX+HT5zv83JTLwhEsN/+yxdYDmJJOKx98EGAK6F5UOZTmbYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693816; c=relaxed/simple;
	bh=qLw/XpUDNjydbKVJDmSYD8KeiUiwlVa54MhovWDpivY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BLsMSOkFosGEn5mgXqvjq12MSNX4xQ4BqVMgeMt8LdO/deS8qWI19zA5yP2/dQ1F+3grXp9rFYM19rEAiFfkbzkkW2KQS6kux7FwKP0vuHnOq3u6I1Pv8gbwCqMtG280xzqaI8tXpj2YIdhEsKPZueGX6vSmmaOfAe9g5hKD168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B28hUVWG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758693814; x=1790229814;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=qLw/XpUDNjydbKVJDmSYD8KeiUiwlVa54MhovWDpivY=;
  b=B28hUVWG3vI9sSZWPq0Up0ce9RBAIz6LplA7kHOv8DbZt7sq5AqaKWYY
   jTibYVjri2TT57Ft1ZxCUcJjzJMKW8+jHutpvLuHFXV/wUJsJnbmidCVn
   HOpCBA0jrNPV5vG74T+XYBLtp5Zivx/2XG8Iu0MrwYzg27tNR7iDSAOKL
   E6DUEM/mVHwjVsxwABy01lx2GLqHhuSKoWCs1NzZETPbh8dP96mGQhDle
   d5hwzYmpfzkB9oK4XOjZZTWqkTeuB2eUGy+F4HotEhni3nLPUfAQk/xW6
   RQskF16U+VIta7a/zGBZPqPnOsHSOe0lZKCZE3dCk6zUKrZfsToNNfg7t
   g==;
X-CSE-ConnectionGUID: pGf5s4eWRau/xzbzVukMiw==
X-CSE-MsgGUID: olJKQKJiRgifArvEMTPdQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="64823431"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="64823431"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 23:03:34 -0700
X-CSE-ConnectionGUID: dTgNB2VQR6Kl0+4jak34rQ==
X-CSE-MsgGUID: 5jFWPLkYSpCRWVfEPBCMwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="177729591"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 23 Sep 2025 23:03:33 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1IbC-0003q5-34;
	Wed, 24 Sep 2025 06:03:30 +0000
Date: Wed, 24 Sep 2025 14:02:47 +0800
From: kernel test robot <lkp@intel.com>
To: Xinhui Yang <cyan@cyano.uk>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 2/2] scsi: dc395x: improve code formatting for the
 macros
Message-ID: <aNOJhwUQDD4AP266@ffd18205fa77>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924055628.1929177-3-cyan@cyano.uk>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v4 2/2] scsi: dc395x: improve code formatting for the macros
Link: https://lore.kernel.org/stable/20250924055628.1929177-3-cyan%40cyano.uk

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




