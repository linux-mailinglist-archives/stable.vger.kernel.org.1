Return-Path: <stable+bounces-3810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8328D802691
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 20:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF101C208F8
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 19:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB8A179AC;
	Sun,  3 Dec 2023 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECuFZvJE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C13CD9
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 11:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701630726; x=1733166726;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=AwLIK8J5ESG9AHU+Ow4GlsB1m9qs/3Fj4qZzX2C1AjY=;
  b=ECuFZvJE1WExL4CrlQfIRApcKOmmryV1ETaJA2jnTnpJP61zqDBS/7H2
   2+edAFCdpikqyYq0t2IU1XP9gtgHb7umnqmPEQN7ef93Hg0g91Z8KTnU4
   nLmFpJ9x+6FIRW7GgC9jS8n/joWpkiAGuCQK97u7eR1P4eAUujKT+64bx
   m1McfkHZo2BLwkqnnPO1o7maw7YjNnTV1hTudjU2W8eR+dpr++F0duj40
   FBFP+NSBcA4AyNJ7W3HufbcOQWlBjQDufjnWU3jhD6OMNaYZGMNpp6Uhs
   Jy6n4O9j85ZkWYRQrJ92zZWndUURhoMSDEhvjWLybP/nt+UxoWkRvl0Vx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="479858832"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="479858832"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 11:12:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="720098799"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="720098799"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2023 11:12:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r9rso-0006zs-0w;
	Sun, 03 Dec 2023 19:12:02 +0000
Date: Mon, 4 Dec 2023 03:11:35 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.1,6.6] wifi: cfg80211: fix CQM for non-range use
Message-ID: <ZWzS5yuKKYCVIxz9@520bc4c78bef>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203190842.25478-2-johannes@sipsolutions.net>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.1,6.6] wifi: cfg80211: fix CQM for non-range use
Link: https://lore.kernel.org/stable/20231203190842.25478-2-johannes%40sipsolutions.net

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




