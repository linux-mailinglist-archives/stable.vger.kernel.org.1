Return-Path: <stable+bounces-59056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8780292DF1E
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 06:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94691C2155D
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 04:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5870B2207A;
	Thu, 11 Jul 2024 04:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kiw0qdRU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA264D
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720672327; cv=none; b=nPz5HvN7yNdSzge9+X4KtTNdsZ5cB9J9imfm94UwvntKljxrNd3E75CSNWYivEjTVktzDHJJ2XZx2U0UZaBD5Gbss+qkQxDcoTg9Iik7EMvOwtMPcs2ZJOoN2wcYaGnFO2G/bg+JEhajR9SLWismf+3CqipE8vWcVPzNo/Enex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720672327; c=relaxed/simple;
	bh=2wL8HGRY7DUP5MIZReLyQZbrO1yxV65cyBn0vzR2ww8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dfsgSbzoaFyMHQHBGe7ZbA7uYJNVu7hZecKm3h9+TwyExk1PSiZktAJzhwCy6d6DO2iQc+uFcd9I4gnXGA8EggnZR3pEI3+tUeVoqdUxW7VRRZ9chjAYri3Foc7yypxrUdRcmvrVUDZkCHUASL42mwY+n0Me4czLl+xbGtvyeco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kiw0qdRU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720672325; x=1752208325;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=2wL8HGRY7DUP5MIZReLyQZbrO1yxV65cyBn0vzR2ww8=;
  b=Kiw0qdRUl06ab7DdXQe++VwMprOWhxSRJ+MgCz45c6xG4AArPp3y62iU
   G39oRRJlYfbn13gPN2Pfj2X5Qx+LWiGq+AdUmRlunxeQCaaC1IME+T1VE
   BQmI5NTKTSG/i5mvbdecoY+IlwmWnBPdB2So8trr4FkqW6w2JSfiTlotm
   JtjfIutjpLLpeiGO6pp39fn6fczRfWgeeSMC9DGdVyJSn98pQqakZDWMd
   6/Ms4IWjaepltrLI+7eOVwe4RuTIT2QzkY4fiV/oa3zhtMZ0H/iw+xWbN
   WAlzXeqPTb7xRn3COeaQ9iIAy4WVHyeLpTYtU1jIj79J/p8HA/dpatOCi
   Q==;
X-CSE-ConnectionGUID: ZXOmEtgwRM6S5X/Qz/CydQ==
X-CSE-MsgGUID: KS58TpFhTv6pYq2mw89CiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="17871319"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="17871319"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 21:32:04 -0700
X-CSE-ConnectionGUID: ozal0EhISaCSQ0j8S2pM1A==
X-CSE-MsgGUID: MHon9vjPSgCKBwro6NYgzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="79152390"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Jul 2024 21:32:03 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRlTN-000YmE-1j;
	Thu, 11 Jul 2024 04:32:01 +0000
Date: Thu, 11 Jul 2024 12:31:18 +0800
From: kernel test robot <lkp@intel.com>
To: Pei Li <peili.dev@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] btrfs: Fix slab-use-after-free Read in
 add_ra_bio_pages
Message-ID: <Zo9gFtIM67Zs33BW@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-bug11-v2-1-e7bc61f32e5d@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] btrfs: Fix slab-use-after-free Read in add_ra_bio_pages
Link: https://lore.kernel.org/stable/20240710-bug11-v2-1-e7bc61f32e5d%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




