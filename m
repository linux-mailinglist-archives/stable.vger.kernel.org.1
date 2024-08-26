Return-Path: <stable+bounces-70128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4295B95E7AC
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 06:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39BA281644
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 04:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB3F58ABC;
	Mon, 26 Aug 2024 04:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7NRUYYz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C76A3BBE0
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 04:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724646616; cv=none; b=jR/AgOHut8FFl/vCGUWK6hrRoIc9P0kH3VGd2BTdeI68HfxsYh3j0EQjWII9REgryFGFGn7YF2x/apdrGR1hg4S5n1gZOKheh1njwWJrv7YjUnyTDSJx/KEfqauXMCSCfM8dLKt8DGS1YNHBLL3IF3ce2KFbzOXUvjL4DNJ9XQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724646616; c=relaxed/simple;
	bh=agyhQfcNQ1E9nu9rmPP3nufi62taH7fRK1odNqqE+rU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jDdFVzVQV3XbhkZ5hfTvGk3FYlLnrNKchsDavlidZeuCoQh6mCS+sF329v8yXlZcbc+m+okQBpse6vx57z8iy7qEJoCK4k0hatQ/AMfs59aOUSVFJ7ziXgj1NuAI0JP7Lq/6y3iW7ijDCpZ+gFmAPlP4pLRK77WiFhOGc+T4/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7NRUYYz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724646614; x=1756182614;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=agyhQfcNQ1E9nu9rmPP3nufi62taH7fRK1odNqqE+rU=;
  b=A7NRUYYzE3ejSCNwR2LICEBcTuaEgzzup3zeSJDied+lu+TLG5yy4oTw
   fc2EeSzkK3diLY5CvvdH8J8pncb5Ipy0M3stqzGgWTi7VZUUm0c+C6wk/
   VPnmzyT3gQC8s50tlSebAL4oqfjldURHp44LQk+p24l7bYF+4nlzMMWx/
   7ywyd2egcKbX36ZhddmYl/+z6GO4t3nOQT9OsRomS04eTtlmFPtF4tL7C
   5gV0v4cacdasSDEBqcvnzjI9J6ssWmF4X1IDD2bKg2Osv5Qx3ktBobBb0
   HK3gCKYsyD1cSxqeTgKf+L1hS0FRSnCPTOymfkKFDWTiMtfV6e7AMSdLz
   w==;
X-CSE-ConnectionGUID: /+bMuxccQBmtPKtAlgj/Zw==
X-CSE-MsgGUID: QlTS3zDXQgOGiFTF90LzWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="23217461"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="23217461"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 21:30:14 -0700
X-CSE-ConnectionGUID: fuI5+Ig7QV+yJKwYFjIxvQ==
X-CSE-MsgGUID: lGemIZ0LTnilUHe/PGp90Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="62221403"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 25 Aug 2024 21:30:13 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siRMo-000Fuj-1g;
	Mon, 26 Aug 2024 04:30:10 +0000
Date: Mon, 26 Aug 2024 12:29:18 +0800
From: kernel test robot <lkp@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.11 regression fix] ASoC: Intel: Boards: Fix NULL
 pointer deref in BYT/CHT boards harder
Message-ID: <ZswEntCXPpKdXxgY@82455bb29b92>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823074217.14653-1-hdegoede@redhat.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.11 regression fix] ASoC: Intel: Boards: Fix NULL pointer deref in BYT/CHT boards harder
Link: https://lore.kernel.org/stable/20240823074217.14653-1-hdegoede%40redhat.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




