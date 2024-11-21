Return-Path: <stable+bounces-94479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 387509D4540
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 02:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC4BDB23522
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 01:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907E01EF01;
	Thu, 21 Nov 2024 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U89ZIvyM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394392F2A
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732152068; cv=none; b=MHwkryIj8eiKZt5a+3ttabkCxUgegf8PytqhoF5+K60/jhyY0IzOU8bfebX3DvMHBAKxIX/p4u0NGOAcBywR829KHlq+NR5W/Kovwhh9VRGmIBijPxN2Jd36pFZUFWswkhQTErTmctR+dW/oPhqDmsX7FkHX9fgQ5L4qP5ahT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732152068; c=relaxed/simple;
	bh=M8R1jnPSjtYGAciqzceo7Gi2RQKgT4Dd1gSAXR4iqYw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CEhVUluIyjV0I8fX93EnZWBVW1w0Y0GEcrAkl1V1dyhHX261Mi+WlKUxdxOwciEKvHW2iakORcZYac8RgkNgqkTdpniBLZgOMEjwAKd5FuVKSWYi98zEK10RIPEtIb7LiDglHRErZENv1GbH6IJ47sKCgrsGEaRBfEUlco4h8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U89ZIvyM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732152066; x=1763688066;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=M8R1jnPSjtYGAciqzceo7Gi2RQKgT4Dd1gSAXR4iqYw=;
  b=U89ZIvyMsaSMei0w1fqdKGqlo6uNdWaOHyILMP9Lm+XA9YoxvHzcsD3q
   /2lR/QfkVDcXnFKpT0fkzj7w0ruvD/LqnYe/UlFzyWKFKi0Zqp38TpUuz
   482i/JzJ7LgM7Flxh+7jVdF2tkGHPrlCMn+217MuEPQ1BS7S9PPOKQ8lL
   ecnANr2kG1BowoiiXjMdzYIimzDty6lGS/K/lEkv961RVthP0voPlEosF
   cH2oBZH3F+Nao+w6SxH7J6blpU0grFsE4uecg3C4ZOsLLyn/idpwwT8zl
   YKu/GRWieaws+6a1jQP4SCZS/WZHXrG2rObQPSp0kBbcaQ4pXxC/al7i7
   g==;
X-CSE-ConnectionGUID: DY5K/tQuSOqomFMBl6yReA==
X-CSE-MsgGUID: aiBqEwftTBG8B0wt3MrjwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="54740662"
X-IronPort-AV: E=Sophos;i="6.12,171,1728975600"; 
   d="scan'208";a="54740662"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 17:21:05 -0800
X-CSE-ConnectionGUID: XY/1ICAkQpuF0AwfNjMIfQ==
X-CSE-MsgGUID: +IDzKGpQRD+/miJuJQWRvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,171,1728975600"; 
   d="scan'208";a="90477267"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 20 Nov 2024 17:21:03 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tDvsT-0001HP-1R;
	Thu, 21 Nov 2024 01:21:01 +0000
Date: Thu, 21 Nov 2024 09:20:28 +0800
From: kernel test robot <lkp@intel.com>
To: jiang.kun2@zte.com.cn
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH STABLE 5.10] RDMA/restrack: Release MR/QP restrack when
 delete
Message-ID: <Zz6K3DNMUM6Uu7dp@00883b76fb74>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116175748571awvOCFyR9lCLwe61IhOXL@zte.com.cn>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH STABLE 5.10] RDMA/restrack: Release MR/QP restrack when delete
Link: https://lore.kernel.org/stable/20241116175748571awvOCFyR9lCLwe61IhOXL%40zte.com.cn

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




