Return-Path: <stable+bounces-100014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CAD9E7D59
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 01:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E1A281DE0
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 00:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAA238B;
	Sat,  7 Dec 2024 00:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wac0D5JU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14F322B
	for <stable@vger.kernel.org>; Sat,  7 Dec 2024 00:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733530479; cv=none; b=i/3KoOsYTFW0DsBvn1K11yoYA13/fmtyj14hcKXO3qraXqVnrkrb7n3UmuXRAM/+qW+DSsbUHbJc0WEgNCCgnDPWvVu0dywwj9QpsvhD3TedUehRXGzPUFNMwmBIPM9YQnuGt2iSjM09HUAG/fymEldEQN9OUTfBUxTPIyXJx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733530479; c=relaxed/simple;
	bh=QG2P32OMQcu6dfxpG610tPhqJZxWz/rie9XuqU1WCYw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BSTC83W04yGfWjfBJyY5AW5gr/Jg2coaLits3xR/fM5T6UYQSUx7G4jzyKeUbkd4VNKBUU6oyuFcPoRTfNfsgPjbYkugBcJxuEPxRzJmJ25gzWXfKetReqPeditTUtcadRSCwqgxDltuidmG1ix9WfW2zkoBoA9wEy/MUxmkOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wac0D5JU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733530477; x=1765066477;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=QG2P32OMQcu6dfxpG610tPhqJZxWz/rie9XuqU1WCYw=;
  b=Wac0D5JUPQjVMWv5g2G/muOR1R8hyy683zQAU0nFUoeCeA0pTXTTSCtu
   G5MDv/E+2VRixu4ds1OqPUgRkn5FQg9yBfqJBMd3dE5o9AFO+wgKCJqz0
   NS5iVUR3mRPUeh0I5Wtgp7sPg0Z8nhGaO9pz+KAckJWKhe2lYll2ORS86
   AJ1TTsOUvGnv8sLkj4bkY28kBXJOIukwVoDO5fLzHIZ10OG5iCMA04WLr
   CB3/1NJdjAT42ka/BL8V2WvHbIExexEuHosI+RJ/azIFdINNTvQJgYOop
   4vdFKVbcPFRduXkz0Q2Y2NzpWFik1wCZTYQuLKWtWEjIoUMD7PQrOipcl
   g==;
X-CSE-ConnectionGUID: RVrNsXoWQI6D0j/QjmLC/g==
X-CSE-MsgGUID: ctfff2o7SXu7OohCjBW82Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33629109"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="33629109"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 16:14:36 -0800
X-CSE-ConnectionGUID: rMRQ/aGhT1msi8BjXEzj4A==
X-CSE-MsgGUID: WMwddMe8SzCX3tbohfM5ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="94993064"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 06 Dec 2024 16:14:35 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJiSu-0002N7-0K;
	Sat, 07 Dec 2024 00:14:32 +0000
Date: Sat, 7 Dec 2024 08:13:32 +0800
From: kernel test robot <lkp@intel.com>
To: Hui Wang <hui.wang@canonical.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [stable-kernel-only][5.15.y][5.10.y][PATCH] serial: sc16is7xx:
 the reg needs to shift in regmap_noinc
Message-ID: <Z1OTLDTI7Hbl66G8@14615566e63a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207001225.203262-1-hui.wang@canonical.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [stable-kernel-only][5.15.y][5.10.y][PATCH] serial: sc16is7xx: the reg needs to shift in regmap_noinc
Link: https://lore.kernel.org/stable/20241207001225.203262-1-hui.wang%40canonical.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




