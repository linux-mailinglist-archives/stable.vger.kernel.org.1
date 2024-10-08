Return-Path: <stable+bounces-81538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E229942B4
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214731C242D4
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303DB1DFE34;
	Tue,  8 Oct 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="My0RTAUC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930FD1DFE2E
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375827; cv=none; b=dfJwDdT11RYQrLOYW3OjkiBEHx32L0sK11mxxkXrUSwH3FUSVDOLRWQU2OzxiE6GGkZ/VITIr8D/9BsXO2MW5OG/TZ45B64S49QBDEb3I8G1q4RM6pqfz5C8uToLLep94ed+u3Qo+TUaLTsUoDrwmITuJxvelVaQhwKnXbVjqzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375827; c=relaxed/simple;
	bh=A1L/WgNaV7J3fzpEqZMltpRqcfSEgMFHoESOl6NHrAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l9fGYpFis7bQPShjluFsrhAU2GBiXdOrdEiZ/7b6a8yUpWWR7zxoaCOpWtjBzCs54HBVWv6t4Df+BuStGcXskzK9ZZHH9RWnVyLjxyZ+y36U/Z6jU5lCQE59pn5mhbyQWEH+MIH9Lzg4JsPq9dcUZ90dOJ/hm23lziiXJ6Mdbd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=My0RTAUC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728375826; x=1759911826;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=A1L/WgNaV7J3fzpEqZMltpRqcfSEgMFHoESOl6NHrAU=;
  b=My0RTAUCZ2DAi/GtOY8HdbRpCRGT/iBl1UjxxghbjWzTliOjDrRxi8f7
   DFVbYjZZ6trPn0r5Sw8Ujb56E7VyM5nJEPma8ZRMKiqOT0WUQbbtu8uDv
   TCG2GPqdrH62aErVuL5MbRbFZN5uwGzg+8e28JlkQtVi40m671MljQDO9
   TfMNuLDdeYEj5MgXL5ffkwvihbtLAIIKVDBDelulCyed/Ljiebkrt0rNx
   mDt6LrCZNcufhFfMRI0vAvskHCTuO6E40l3rwiRYwVfDNp4/WLAU/yIFt
   Wl+PyCx/+fSpo5vx/g1boqJUEpShIDV/RXg6cWTIJREpLoaPYmaYzJhbj
   w==;
X-CSE-ConnectionGUID: UiEO6y9JQSiNxq3Ff8pHLg==
X-CSE-MsgGUID: AKZvAdhIQOmRnQGrWrWk1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38118712"
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="38118712"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 01:23:45 -0700
X-CSE-ConnectionGUID: chgoQY0YReqNikuZ4DqAeg==
X-CSE-MsgGUID: nsOW/BlNRnelt5QKhgxJlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="113216829"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 08 Oct 2024 01:23:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sy5VM-00065l-20;
	Tue, 08 Oct 2024 08:23:40 +0000
Date: Tue, 8 Oct 2024 16:23:18 +0800
From: kernel test robot <lkp@intel.com>
To: Yonatan Maman <ymaman@nvidia.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 1/2] nouveau/dmem: Fix privileged error in copy engine
 channel
Message-ID: <ZwTr9gS7G7_T-mNP@b1422e034610>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008073103.987926-2-ymaman@nvidia.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v3 1/2] nouveau/dmem: Fix privileged error in copy engine channel
Link: https://lore.kernel.org/stable/20241008073103.987926-2-ymaman%40nvidia.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




