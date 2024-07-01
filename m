Return-Path: <stable+bounces-56205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EF691DC14
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 12:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D31D1C214FC
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA9C127B62;
	Mon,  1 Jul 2024 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGMCLV9B"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858F685956
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828508; cv=none; b=Jfr+ujzkPfNGG0BHIhGVTFPfVAl2rBSbpbXLmf8gdI+mcUpcDK6P9smlpU7NHrmMVZSTUVoO6m9WzGIMSo8NUnj7lt07/YlJvAbKOubOkTk18fizgi08LO68eTYJUoHFcbcgw/eFDQcSqyynSojoCKvQ6V+kyUmqcV2/R0MS9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828508; c=relaxed/simple;
	bh=8rL2IL0W+mPK592C6mWYFGjuJzfcAOvCVkO2vpkdCpI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NB/2qwZgzVHKHV2S7XeJ1uuoZsAW3vvBAnnENqzcCEkwt68faBNYielkdZqMmnWEtwyFD6MuJg2hNmoQWHi4Qw6kiyurTzmVcsLzxEwi7ZQdR5l0SIcgqxIy3UNzD8VWZKlkkoB63xNW3gQ53gMarZEN3hlhxFFwLzY2ATUp8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGMCLV9B; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719828507; x=1751364507;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=8rL2IL0W+mPK592C6mWYFGjuJzfcAOvCVkO2vpkdCpI=;
  b=TGMCLV9B0q05biE1Bz/HVyGBh8iCpZqZc2BNF9omBZsB49QUZZ4C26Ue
   0eikma4hjhwyvp0ExjQTFfTIdt/Gu/uv+RrBEYT9wi4mMPoTZml3a/Usr
   fuXKVxyocbbbH7d6Sb0P2MfM0aGQsGL/bh1ADlAsduibSxp6Bi91wqdp/
   C8i5TcLWjSayvxZkGyfuLLADj3N3q6osr+hgEFkeIjt+/ICac7/PLaKRN
   fUEm0b4nRYkNWpclqrvsS7Pa071n8D41gwaxSEWImGOjgtuf6ck1R0cZ2
   5Z4X4cLO8Oc1e7z/AecIN5QjQRkR2WP2y8MwcP7YKKBcY8lzHjVwCCMLD
   g==;
X-CSE-ConnectionGUID: UjEGyvyaSPentK7KKfV8Sw==
X-CSE-MsgGUID: W3Q15LatQ3S7DBLmvvRnEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="34488790"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="34488790"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 03:08:26 -0700
X-CSE-ConnectionGUID: JbpYq9/TQJKQsXKfBYrS2Q==
X-CSE-MsgGUID: 95VrGyT3Tuuh7uxDgoThVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="46134359"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 01 Jul 2024 03:08:24 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sODxN-000MiC-27;
	Mon, 01 Jul 2024 10:08:21 +0000
Date: Mon, 1 Jul 2024 18:07:36 +0800
From: kernel test robot <lkp@intel.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/1] igc: Fix packet still
 tx after gate close by reducing i226 MAC retry buffer
Message-ID: <ZoJ_6HxxmeoDh0HS@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701100058.3301229-1-faizal.abdul.rahim@linux.intel.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [Intel-wired-lan] [PATCH iwl-net v1 1/1] igc: Fix packet still tx after gate close by reducing i226 MAC retry buffer
Link: https://lore.kernel.org/stable/20240701100058.3301229-1-faizal.abdul.rahim%40linux.intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




