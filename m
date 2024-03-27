Return-Path: <stable+bounces-32464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276C288DAE6
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 11:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E0929C89F
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 10:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B8A38393;
	Wed, 27 Mar 2024 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/m/7pyD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4D84C9B
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533745; cv=none; b=a7mgQkMHOt2jPwsTIJ87NVxOFHZ4mzd53eqJXguWenID5B0KVscRxNDMhpeksuZBPH0O1HT1n3DVVyWKC8TYzOPmIvv3l1B2zlWM/wrBgbBmZ52DHlJuPRIDbyX/EyXYj3ADXzttSQM28KhvnyxY56RQm8lIIYMlGzSXZBrKDy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533745; c=relaxed/simple;
	bh=9iW5xJx6WxJBBWiNO8jh4MBDSDzA5wBamW/td2VqX2A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pM0svd8WQHr8pNJkT45f9ypY7XsEpSMpf3jmglmXwLuzIVBySqt1wcYkE7fsoRzwYbr2UgunfwIgk4OeO3lcccfa521SD+zD8zEA9Ip/XTTIXgTMsrmFgMdRB/tEqFqWO7ny13bX72UjC6UyOrrbg1JDk/gL81gYkB6vigS1fnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/m/7pyD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711533743; x=1743069743;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=9iW5xJx6WxJBBWiNO8jh4MBDSDzA5wBamW/td2VqX2A=;
  b=a/m/7pyDNFSJr+Am0Zi/zc/icnV4wEe9VMZWJWpcJdYYZJW6+QAttT3l
   c9zJ3XJZCWIiSeKbBB2ku5i/SOqvqoTcyNQtRaWsw//x+1BA73CmpAlQs
   YuFN1f/waFwIK9/mAYQsmkVP8aQ8mm5QBfnVwA8Ts7S7lqtbVEc6XXTFZ
   5aYS4rjd82AnImnqWr0O20XzhE00rfEsqa2ehqy0bui6hrT9hmwsLsrsS
   kFIKUF0DAAAPp/jGcU2OTp5vPRztUC0Chjih1soFdvN6tteLTDdR3Ixpp
   Ohc2BP4UMK4ekDQ4Hq1ROp+FxzYlT5to87eNoyycNItlfWbz1dcA7GVkP
   A==;
X-CSE-ConnectionGUID: c93P1bW2TnaGSlXJyBKy4g==
X-CSE-MsgGUID: wmbTZ40YQjeQI5ad/nc2aQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24114290"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="24114290"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 03:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16230410"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 27 Mar 2024 03:02:21 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpQ6t-0000x4-11;
	Wed, 27 Mar 2024 10:02:19 +0000
Date: Wed, 27 Mar 2024 18:01:32 +0800
From: kernel test robot <lkp@intel.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/3] dmaengine: xilinx: xdma: Clarify kdoc in XDMA driver
Message-ID: <ZgPufNGKBqE9HN-u@f34f6e606ddc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-digigram-xdma-fixes-v1-3-45f4a52c0283@bootlin.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 3/3] dmaengine: xilinx: xdma: Clarify kdoc in XDMA driver
Link: https://lore.kernel.org/stable/20240327-digigram-xdma-fixes-v1-3-45f4a52c0283%40bootlin.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




