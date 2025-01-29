Return-Path: <stable+bounces-111110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BD9A21B0B
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 11:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567761611D1
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1BA78F58;
	Wed, 29 Jan 2025 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="meOBMTI2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BAE19D086
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738147128; cv=none; b=ec8sFkLSpxPAnPG+a0NMzoOeOw5GCEPRXDTSW1r1bthxb4zNqKYvCTqPAWpBJDNH5FxiCgNEaThbedyso7pQvJOH/uBNlOv1KicAQBIfaXSkW0B93h+HT1dJ2FZOS8ZcDoFPKIsWjhlZasM3zNoPUYeWi6wcNE28hRHrR+0Pghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738147128; c=relaxed/simple;
	bh=McyX8WPL6m5p8ByaTUQOPsLYccp1Q0uq8qtrY/0fJzc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PcCIL7XIFHw2wSv1R7hExB+4uIQCHOs5v9TveVjz7bPzRJhkUAOGWV862WiCo1GgDFhBvcCu7lc1eL2Vmsi1ASzuHkRfr8Qh2ijOLzYC9671wyplXc3kHhhoS0qh/ojn4c1m/WmYucnJunZSt/AtMT+vLaQuXPCitVhW8haQ6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=meOBMTI2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738147127; x=1769683127;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=McyX8WPL6m5p8ByaTUQOPsLYccp1Q0uq8qtrY/0fJzc=;
  b=meOBMTI2j4dR6pMBSMeh+GexkGbPyFtQH7dnGN890mjk5AgNvOVVf64C
   2p6rQv5GNjmzBnb6YTljFLZVH5U178YeDdgxK0wVaMx8br4cvbvtxibi5
   w5mdaBPqRGYvjNKRu7Q69+RDJGm4EuF7/wOeUHCea/St/5L3Vz9ggB/1L
   WA1WP15/3PzLfuMuSWTGf2cBLsu6/E7X5D1hez+rKRyQKxa457aEbKHs3
   ALgTD3ApQv2ifLDRSv0ozsfu7JRtVNPZ0lU3ba4S7+5hUQaJF8dro4JHP
   sUqWDWnM8tOYoC8Gen43SonjA5N8m7sEwwIvDCOy7KYGJpCsZseGRhRi3
   Q==;
X-CSE-ConnectionGUID: Ibox20agQkq2B51gKUroFA==
X-CSE-MsgGUID: G238unnwSC2qyEcyl17M5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="38540396"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="38540396"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 02:38:46 -0800
X-CSE-ConnectionGUID: a1n3+30bTsqzkFBRtfKTIg==
X-CSE-MsgGUID: bUFHilGnRWWmcAvVS6Wbdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="108783469"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 29 Jan 2025 02:38:46 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1td5T1-000irv-0n;
	Wed, 29 Jan 2025 10:38:43 +0000
Date: Wed, 29 Jan 2025 18:38:13 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.1] wifi: iwlwifi: assume known PNVM power table size
Message-ID: <Z5oFFfQOSIgoMZb7@fbd72656772d>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129103120.1985802-1-dmantipov@yandex.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.1] wifi: iwlwifi: assume known PNVM power table size
Link: https://lore.kernel.org/stable/20250129103120.1985802-1-dmantipov%40yandex.ru

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




