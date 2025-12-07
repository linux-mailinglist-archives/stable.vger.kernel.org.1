Return-Path: <stable+bounces-200296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5395CAB93E
	for <lists+stable@lfdr.de>; Sun, 07 Dec 2025 19:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61A0930155C7
	for <lists+stable@lfdr.de>; Sun,  7 Dec 2025 18:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A512C21C7;
	Sun,  7 Dec 2025 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKqKfqN0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9918D272805
	for <stable@vger.kernel.org>; Sun,  7 Dec 2025 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765133422; cv=none; b=gnWPs7IYiVsHpWyo3zZGgKI0kSWeriNCfh05DUaP1MzsprJjFv5rFTMHyakIltxhTXQOrY+KcFhGHgddjVDPRgO/UTEPF6t//Y3EI9zf1vtsUnQId2dNxHpqRNeta7pqko6P+VgLN4B/J+Gn+d5Q2sbIxE6dXMtCTLBUyvLiPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765133422; c=relaxed/simple;
	bh=1iHiBl9eOiZ8GiUvxg8PW8iI/NkGhlRX20XfLu37T0k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=idJBeEAQms/YxaPXAeIuC+ojzxkwPCiQsop1hnsJYFouRyrAd6wn++zoQZjnuc75+wbZZcfRLdrAhRjbf6yucevGRRn3TWwuKMUkXUHAGnGeVDRhVJ1VDkz59Cn3bV45n1TEdsrN/7ofCub+U70rNb8HEV4QKmBQ62Rv6h15Tig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKqKfqN0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765133420; x=1796669420;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=1iHiBl9eOiZ8GiUvxg8PW8iI/NkGhlRX20XfLu37T0k=;
  b=dKqKfqN063NN3ETY1tpAwqUDp2WZRk52BxJ6H8hbp8r+VdbUkNhWROnr
   xyMTT2ibaJixLj4wDcJSeyUoVmUYUcoU89hL+NqBiFhcFhraCCq8ylk51
   RWTF7vy1WzHL2u0+UDUtPVvVAP4b/kMoUSi+8J9KcQaC9mvaSLwVcPeoa
   H6AL9O3CPHU/Mm5s6hlAZm1ZymPONvazvd1+U4oPdaUdp/NI7TYl61URv
   QUhBHH9EXVMUjVZhQGTBb+3hLjAFLGb5Ee0AgL1Xu2SNZgQZzsU9HlvqU
   THYRn+C0bH8QhqtOCo6+s00Wm+83woukuenV52jpaRIpXoEpCbf+sxKvE
   g==;
X-CSE-ConnectionGUID: KZoZ1MrrQHitlcmZZz8NCw==
X-CSE-MsgGUID: uixn0rJMRW+E+hgOZ+el+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="66091498"
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="66091498"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 10:50:19 -0800
X-CSE-ConnectionGUID: 9g3z/UH4Q1qiJa0bctWybw==
X-CSE-MsgGUID: /01aw75JRImn+8VFrd0wzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="196524426"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 Dec 2025 10:50:18 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSJpn-00000000JWv-1irE;
	Sun, 07 Dec 2025 18:50:15 +0000
Date: Mon, 8 Dec 2025 02:50:00 +0800
From: kernel test robot <lkp@intel.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.18 regression fix] dma-mapping: Fix DMA_BIT_MASK()
 macro being broken
Message-ID: <aTXMWMPHO7Unju2J@407caa6f7dd2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207184756.97904-1-johannes.goede@oss.qualcomm.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.18 regression fix] dma-mapping: Fix DMA_BIT_MASK() macro being broken
Link: https://lore.kernel.org/stable/20251207184756.97904-1-johannes.goede%40oss.qualcomm.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




