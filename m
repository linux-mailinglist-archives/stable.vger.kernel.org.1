Return-Path: <stable+bounces-132641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA1CA88754
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 17:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98132171286
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C7F1A5BA1;
	Mon, 14 Apr 2025 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="At8bj6qX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE0E1A9B48
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644925; cv=none; b=Bkr/Ov2iBtXgITl7vFPmzv20IcIGZXpheqYX8T9Z4lPESGoeBXoKV+jUsCGBPQx8FcoykL7oRb/h65MERE2xMpdU1ERWJ/hryRT/5IOIIrdGnQVhg1bQHfd3+NizeFB+kAVfp9dRM+QalGXL4nrdtf/4r+P7zW+x0EaBk0XDMpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644925; c=relaxed/simple;
	bh=x3HZ7Q9hlJOlliRCzcXOdVBco1d9F8kilZ4xu20KKVk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y2Mu2jmV9JuuvlPV5y12MckX3Lss+cRz/MLkJrRmLfrf7Eyxz4Z5PpHaBe7kVyC5tEGvlt28/R1Sfz6NIWnuEck4few81gTQ+7WiKpnSp/+vyiwksw8t9kJrE+CBaiCpUmtenXFwfWgaflldw2y/59Vml0v4/DpGc+Gaq9uXMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=At8bj6qX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744644924; x=1776180924;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=x3HZ7Q9hlJOlliRCzcXOdVBco1d9F8kilZ4xu20KKVk=;
  b=At8bj6qXXpo2Sd3YH89tUMkQZnW949gcmtT+jdXNib+p6YRZDsQG7cLS
   sYTY7J8z13GnygMXCASMvevFm0VrEWhwIv1uvcq6Gq6qtBSOj10dc2qFe
   rMo+WH+QFA8hO4+SodzlBpaeUnmkgz/sP7imlXwEdwPgnU3fYb38Z7Der
   Vra2eKjVgxXcFPoGyQbKDO+uv2IFB015796OQLm53Nm/DQpnFa1QzB2xl
   jt1M3LJ4bIbezXq8wCPPCnr65IXA+DMxoEkyDGeN8i3vYvRAGL7BvHQg1
   HjEm7bvWqfAK66pabuj/oUJakYWcf/BVCtMPfCuRHWX/lzwQdYqKgNn9r
   Q==;
X-CSE-ConnectionGUID: /yw/jSwdQLy8BiwWTvJqOg==
X-CSE-MsgGUID: jRi6HgjST0e6bLJwbe1pnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="63526972"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="63526972"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 08:35:24 -0700
X-CSE-ConnectionGUID: E2ndFyA4RS6YZETJPgp6Xg==
X-CSE-MsgGUID: GTIK61RsTjCWJQyCi5/A2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="130402909"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 14 Apr 2025 08:35:22 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u4LqC-000EOY-0l;
	Mon, 14 Apr 2025 15:35:20 +0000
Date: Mon, 14 Apr 2025 23:34:32 +0800
From: kernel test robot <lkp@intel.com>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] iio: adc: Correct conditional logic for store mode
Message-ID: <Z_0rCMZoORguJHqV@e81de7ff9121>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414152920.467505-1-gshahrouzi@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] iio: adc: Correct conditional logic for store mode
Link: https://lore.kernel.org/stable/20250414152920.467505-1-gshahrouzi%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




