Return-Path: <stable+bounces-185666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7111BD9B99
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 15:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E545F19A40E2
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 13:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FECB1DDA09;
	Tue, 14 Oct 2025 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVBZi4vM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C5E76026
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448253; cv=none; b=EJ78DrE4XLDAdOqXOMH8B319XvvMnRjGvoHRxG5I8kLg2CnSzw56FB4YQZrfqcUZk6LuGR8PZQGBdbvmf5S8DdGkkLw40KS5aTi7SYeMZ7Am75I2m2NvSEaCI3s9THwX0TeylYBKZ+z4/NPKtEA5TruBXopbD6UDRqso+hjJsTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448253; c=relaxed/simple;
	bh=opNPiQ86iTleJgV+aGACixQJGM2opT7eh2amXNqX9Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EcgSvFSOEx3iwu5w0eDlytgtWpHDODnFpiaLU7RLH+eqEtIxS5BgfZbeyBwfHeVD31CZ2ftujAJAHOUkUUeMXSVO2GkMD9d7V2XYKAbJiq0JnI/DBKLEjFsNoN1JExY8EQr5XbFokVJPOkQqr/Q9nXXjvf5p3DpgRWF+oKlDpGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVBZi4vM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760448252; x=1791984252;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=opNPiQ86iTleJgV+aGACixQJGM2opT7eh2amXNqX9Kg=;
  b=aVBZi4vMKk/Kz4KxxTdB0ucPAunsebQ6UOkekP70F6K22vTV9+rbcoF/
   Y8Nyv78jdfg1wO3CiQJntIvFBjusEYZxLDLC6o0IJRyNhFMarCVTfE02y
   lYZ3091jHt8teSRtOXysbr2f9i4ZsqP2tmrbdoZdoca8mA/ZKcyWUVn0o
   dfrUKWfm3FC/K6u18+rAR7HN0VRTY7ak80LBH+DgJ7ZUCxUD2zNI1wJif
   BZE1GF+mh1sVb+37Uy5r1tZ3a0+X2+NMMWT6K3w8d0awv5UQhfV28ovT/
   pkXR0P8vXXYZDOaRoUguvMpGBX6ahmRcRi5hcYMpGK3dTHzd8ss2MXIAa
   A==;
X-CSE-ConnectionGUID: tjpZjvZDQgOIHvXRlJgdqg==
X-CSE-MsgGUID: v1Uv37AAQ+S81w41JasN/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66432128"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66432128"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 06:24:11 -0700
X-CSE-ConnectionGUID: HTqzEosuT1yNh+5t7scU9w==
X-CSE-MsgGUID: ayYEJElzRP6tQyPDfPrHFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="181692135"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 14 Oct 2025 06:24:11 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8f0a-0002pT-0u;
	Tue, 14 Oct 2025 13:24:08 +0000
Date: Tue, 14 Oct 2025 21:24:01 +0800
From: kernel test robot <lkp@intel.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH for v6.18 v5 2/2] media: ivtv: Fix invalid access to file
 *
Message-ID: <aO5O8Ss4_khUvEAm@c783d09d246b>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-cx18-v4l2-fh-v5-2-e09e64bc4725@ideasonboard.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH for v6.18 v5 2/2] media: ivtv: Fix invalid access to file *
Link: https://lore.kernel.org/stable/20251014-cx18-v4l2-fh-v5-2-e09e64bc4725%40ideasonboard.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




