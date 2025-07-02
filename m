Return-Path: <stable+bounces-159244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C58AF5AE6
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 16:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466C7174605
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C2D2F0C6A;
	Wed,  2 Jul 2025 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0MmZMBN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494152F0C72
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465844; cv=none; b=dSTApreSJlIR3btMYw+ddXNRHZR5PmViPcVeyNhiOmkgS0nDOd4I6xaBSw3DNg5mx7lwTZSga5C7LqAHlWFFFWB3muwggCCTzr7UPq2G+vcisSe5URdCONnUpx0zt0/vL9Hs6MYWXDyldSmkZPLiWuyzgm+P08XK7vOmyfIwCrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465844; c=relaxed/simple;
	bh=6lYTc4bPMGTThEsVIf0UH+JJddow1ot2X7mNbb0hAx8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mVy3uwTbeH6adlxV1tUPoQcw/Yufo66QSs0lQPocaEBV++IoVmYHJpF3bVwONwMVYOzQRhIhMojernH+eaBR9ZyUN1tSo/kpl8c1KSwOn7TjxyOw4g4Ofsg8rAX/0Gfaek41zdHf0HJjGwGJvaKPQaib/UaVVRiN+IYy0Pl8QHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0MmZMBN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751465844; x=1783001844;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=6lYTc4bPMGTThEsVIf0UH+JJddow1ot2X7mNbb0hAx8=;
  b=B0MmZMBNTiBOLq85TF1VVQIe8Ej5GQ28ihYOMdcFGWKpd4wDmuvaYk5t
   876J1MZkmEt7no3c81wIR0B8TPOfiQdkR6B3l3VHU1HTkMQttjFOci12+
   E810F+Aj9HAiVgCgAi6UPFoaBQKsJI+WEL/3VYugBnocg1+c0fNIctJz7
   O57+BMM+iQyGrKEIwF5RqPEsZ/nsZy5QyM46ltCD6IsJkb2nz+R6Lx67l
   a9uL/FGIL4WUguKP9xRFlYjFsKClRRu7Bp3F8WFfyK/MfbgKxBErSDkN4
   o/H5EOJZ2AnjGCTrQRypmSqYOBKzZ9MRGK07vOYDWqltdBwLYdSb0sZRo
   A==;
X-CSE-ConnectionGUID: 1bO32KO3R22H+tcHePy9pQ==
X-CSE-MsgGUID: v1k5dd49R6GeEZMDxul43Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="57542986"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="57542986"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 07:17:23 -0700
X-CSE-ConnectionGUID: MJMw/FrdSQ64xG7rY4J8lA==
X-CSE-MsgGUID: qU/kPLY0TVSkFdzaf75+vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154646803"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 02 Jul 2025 07:17:21 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWyH1-0000j9-1s;
	Wed, 02 Jul 2025 14:17:19 +0000
Date: Wed, 2 Jul 2025 22:17:04 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net] net: ipv4: fix incorrect MTU in broadcast routes
Message-ID: <aGU_YEQkZ-ZPo4nm@08871597274f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702141515.9414-1-oscmaes92@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net] net: ipv4: fix incorrect MTU in broadcast routes
Link: https://lore.kernel.org/stable/20250702141515.9414-1-oscmaes92%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




