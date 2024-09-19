Return-Path: <stable+bounces-76754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062AA97C8BE
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 13:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4623286AAF
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 11:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1899419CC39;
	Thu, 19 Sep 2024 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESb5EA1E"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8915E1991A3
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726746404; cv=none; b=qSrCNbXFpo41DpG3hTekS49Prt1Qeh0XXCP1TxUvVdvwYs6lyrWVE5IyRA8B4d2VWkqF2mSHMhQjrssM8jfkiUz4Rx5c0cOz1FQxAQ94pkSqXAK+Qtb5ANihmFaew6+saj0M7KD5Nj5vNWYffkLSIjyycawm0KoC6AHZTTLq02E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726746404; c=relaxed/simple;
	bh=k08b+OT/HJlt0rBXhJBLwNrI8FY7EskO/0YSEnrkm90=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sMWxSO+F17mP+Xn9KF9Uzn+PdsEmWSGxOgbkDYxSrZBidpXC6EDwiQHCSUHm7SBpV/kOET18m67CqAZZufhwt9t8XWxOAdYWR2yd/MBFL6zQ/1w34atxJci6JRdDFft9Kv4Su3OWaGtz8VHJ8w69Dx7N4kcce/3gqvPvhVzDmeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESb5EA1E; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726746402; x=1758282402;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=k08b+OT/HJlt0rBXhJBLwNrI8FY7EskO/0YSEnrkm90=;
  b=ESb5EA1Ed09jNjY3cdBVrQjYHbduk6ucN6JhDTxfqm4p4dcqJhaAyt93
   wcoEIVSmEGvKLqPPcpFnkzcCb2zOQoePhf9T4GGkNazd/qKZtBs/Z/ko3
   xdTSd1jvU6WtgABN4xUsNTCEByBdrL5/lLrMkdFIbYQxmPOt6/XS8lBxy
   u9C6zEilT9wVH6HTHeH/D0KN7YdkfSrrPXi3Jf4XqzhMPua1UqLmhViL9
   3JyGDpafVHPux6rf7riG5N3w65W7Pe48aaMHS5RAftcJook4QzoQljn+Q
   CY+3w2d5sqFYKcRUOJ7staUbps/kLFh1V7VvdTkXjsjmvj0D06hmOnmDX
   A==;
X-CSE-ConnectionGUID: MRObMo5aQf+gv65sJMbQXw==
X-CSE-MsgGUID: EC3KEknSSGOpm2HQ4/D73w==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="29444796"
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="29444796"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 04:46:41 -0700
X-CSE-ConnectionGUID: PLWS/YwbRuiXOjS/dz9xYg==
X-CSE-MsgGUID: rC+QpwnIQD6IbJ+HVUkpZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="70033782"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 19 Sep 2024 04:46:40 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srFcL-000DDw-35;
	Thu, 19 Sep 2024 11:46:37 +0000
Date: Thu, 19 Sep 2024 19:46:36 +0800
From: kernel test robot <lkp@intel.com>
To: Danny Tsen <dtsen@linux.ibm.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3] crypto: Removing CRYPTO_AES_GCM_P10.
Message-ID: <ZuwPHBxg2mlhEgQs@3bb1e60d1c37>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919113637.144343-1-dtsen@linux.ibm.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v3] crypto: Removing CRYPTO_AES_GCM_P10.
Link: https://lore.kernel.org/stable/20240919113637.144343-1-dtsen%40linux.ibm.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




