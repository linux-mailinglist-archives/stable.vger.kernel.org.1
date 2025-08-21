Return-Path: <stable+bounces-172073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B5B2FA4E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C485D580C3C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D5B32C32F;
	Thu, 21 Aug 2025 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhBFJcg7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C241B32C325
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782531; cv=none; b=Syr297uAzF7eAv5B5L95UhUV6FdYMiyBM06bXfADObWFgNs3i3nInIr0jFqMI0RcsH7vd9WkJqK3L7AAn912rsH/wcxz0t8d+9qIzXSJ0le5y9gnSoSeoxAKgO3Bf2zTQEeisv2Osu4c5dSjbK7+gtaZSVEr23a47ZZHCKvzz5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782531; c=relaxed/simple;
	bh=Zt1nyiK5WSkvv3Xd8A0WsZNCL1xMVFcEyVV3xMAemj0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bmrDGGfgrXcuvsxOA/3TDHffZHmeOdhKpP1t5qBJL1iaLOx02S66a+CiZoPvBj7uC3+7rw/m3VhN//REncz6i9y/yCXXRoHeihNsMFpgnOFcWNZFF+qCgZRuuNo4hPDP5ELyt7TYI7U1LzcwGbfbI/nqSvufD6Kjbt6OuxHEmhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhBFJcg7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755782529; x=1787318529;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Zt1nyiK5WSkvv3Xd8A0WsZNCL1xMVFcEyVV3xMAemj0=;
  b=AhBFJcg79NWbpfsgrU2nNoMWNJK7e7jOMtzRatmittIl8v0wTGg0oVhF
   mosSzJGpSsmvXHNr7QYgxRDgY5319+9JCJdOHzl0P+0VTJ9/RY/l/jKlY
   MIUp68riGfvxxi/zDLt7RgboO2luX9cB4sOvf1VU8gTsCnRoeFkZeEx3n
   4zquA9Q2NjbyGWLRdoL/id4gh7ueXw6jRHSbWUZv7pT8u+5wjFeZE+uvI
   3YvvjaGLmMl7Wv2SIBGknQXeN1qeCxj4YYPtGncxlNHtmosWxqJY7uge7
   gy9RkufqbJubBUMcXeBX55Ydboa5rvVVeGym69n2HSYIblk1xJ7IZxhL+
   Q==;
X-CSE-ConnectionGUID: 5eoyaETkRS+qYsB6I1TIYA==
X-CSE-MsgGUID: uqtUCw0qTaqtWxKMTa0JbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57781535"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="57781535"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 06:22:08 -0700
X-CSE-ConnectionGUID: 1hg/Fwi3StmLEN/1MaQ1XQ==
X-CSE-MsgGUID: loso2DB1Q7SVJRZ4dyPhaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="167918730"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 21 Aug 2025 06:22:07 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1up5Ey-000KJP-2y;
	Thu, 21 Aug 2025 13:22:04 +0000
Date: Thu, 21 Aug 2025 21:21:25 +0800
From: kernel test robot <lkp@intel.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5.15 2/2] x86/irq: Plug vector setup race
Message-ID: <aKcdVUU18M9Mvo_b@85d67d3e4d56>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821131054.1094506-3-ruanjinjie@huawei.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH v5.15 2/2] x86/irq: Plug vector setup race
Link: https://lore.kernel.org/stable/20250821131054.1094506-3-ruanjinjie%40huawei.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




