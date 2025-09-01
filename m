Return-Path: <stable+bounces-176900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994ADB3EE33
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 21:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8747F3B18B7
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 19:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E76C1FAC42;
	Mon,  1 Sep 2025 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcGidYbD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830082367CE
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756753198; cv=none; b=FsJMU/xIL68axx1iNYWvq2uMD46T1Pfy2J/9pmh7bJczHctfcggc7dZyP7IF4XDFOONibG9yL4snQ2gBocZdjQSw/FNQkWXLURARWJ2v4QsVze2vimc6EyVO5rRdFNMqHBJD4YMD97cGXV55aMBo1XVlB7QPfj4T6v18EIauYn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756753198; c=relaxed/simple;
	bh=C0jCNE9oApowV3qHKBeP+hKPR2bgbwm3mkivK0QxiAc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JvKanjnvNL02mHLhuRJWHBA/uDOnEZi5CaEWHZhk501wWrCscC6cYC8OPquh1OCrpaem8F3VccbhyYy287du3GajthaGM/ytjkmQ3LNJOdXqJ04yZqwXdvFyEbrpMY2pF4X6gnGkkXrnJJcWal3nB4N+gg1aK5pwSm4UEapP6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcGidYbD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756753197; x=1788289197;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=C0jCNE9oApowV3qHKBeP+hKPR2bgbwm3mkivK0QxiAc=;
  b=hcGidYbDq4d1R6tp3Yg/pkeybsxMkyccWAU+PvXEe8mQvO3U1dcYw+Q5
   8OCNjUQ49vrYt/ZF5IR1gpGto7Ww1JKIE7zmW5Vd5jzLfYediLmZnjNZR
   8SuWdYJVG2bejAXvhl5hcwBOp/dEY0YLYVy5dLINc6NJyswHe/2ewamhW
   hNBAMNpxXVMcT2AtcU5rP8fwghCSw42CA7v8colyw7eP8bHN3ELvjidVQ
   ArnLgTyPC93bjnLYOIwDZKhJZIsAKnZZMUDT7oYZgdaXaZb8hXdqqrIxy
   ubHH16l+QrMef/2lLQoPXlZkg1tcN/3Sr1v29V7ZWndC3GA+HuhlpZBcG
   g==;
X-CSE-ConnectionGUID: w3bDoqRURGa/ZZQuLidQTg==
X-CSE-MsgGUID: lr/8GDiOTZeR0U4HeIGlmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="70390126"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="70390126"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 11:59:56 -0700
X-CSE-ConnectionGUID: VwzbkzGjQOelnFvQUx7imQ==
X-CSE-MsgGUID: UKO3zWVeShiZp0K+bLIfqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="175438991"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2025 11:59:55 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ut9ku-0000wh-0e;
	Mon, 01 Sep 2025 18:59:52 +0000
Date: Tue, 2 Sep 2025 02:58:55 +0800
From: kernel test robot <lkp@intel.com>
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 2/2] drm/buddy: Separate clear and dirty free block
 trees
Message-ID: <aLXs7zEwGijr0cBR@c51ed5950d49>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901185739.2245-1-Arunpravin.PaneerSelvam@amd.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v5 2/2] drm/buddy: Separate clear and dirty free block trees
Link: https://lore.kernel.org/stable/20250901185739.2245-1-Arunpravin.PaneerSelvam%40amd.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




