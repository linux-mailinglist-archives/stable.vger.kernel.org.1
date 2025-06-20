Return-Path: <stable+bounces-155074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1BEAE1851
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04B01BC39F3
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEDC229B1E;
	Fri, 20 Jun 2025 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvI6Ec6m"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F7B23371B
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413118; cv=none; b=h5KNzMi8xL4kFZRt0LYso1uUZP+7qqIYPLJn8M4Six5wGcyjqx6C5bumWhWEmkMAe6MCa3iTpb5uayHUXtwv11oYfkRaSGwWeADI54WITMa+OEBKP0qRPP0hLdA4E7CRSclWtfcbiR9OeYmPwMJKuVIZ0wkgckixzZYUV4/1m0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413118; c=relaxed/simple;
	bh=6pqoLcoVkqcsWbj+rYBQ6jgIATabYG6H3J2+Oasj1tE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y1xn6gBvLxwjoOiElLwkRXITJlYxid6a2GQgA0EW5z4xHMfT576fRgw5ja86w+d0wLn5trKMo+dibGPqBKizmnW2+XIFUelGsZ2w2WJ/i2p1PsRPdm/U6Sxfep4VI10kh4TJsuCFxQcjCZ0b5kWTPRnsb2b6oaggBdLtLC3NoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvI6Ec6m; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750413117; x=1781949117;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=6pqoLcoVkqcsWbj+rYBQ6jgIATabYG6H3J2+Oasj1tE=;
  b=kvI6Ec6megnxhibtwBSn2BTiLSda0hkwlWvfg0PMbkLPtTwYFntYjYXb
   HKiPgvzJHgmkSLlPsjotXUXcwTJaoVqpqW3nwFFoWPVH7QD6SINGk9uSn
   fq0TQ4uumwsDWb1WM+FcDZYIJcccOVTjPSnhMfp2Rt0xfATksP74ahTZT
   VgE8kfO2noYjY4KJReiLWnrxUjJCuXhsfSiymCgguvI3pbSQoR5lXh7++
   ubO0i7P+xlmIdFSeg38nfZN4T4QE2fk7CyZHOnn+TpKEpKqYVAifXuFYv
   6C8L9Zp0YPBtF0vis/DQeYwV3oRhdX791HQqpLRRZGh22gWggaIW7zBTi
   A==;
X-CSE-ConnectionGUID: bd0epxL/SbyKzLACuTfN6w==
X-CSE-MsgGUID: EULed5a9RDWv4IEXCqiWqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="56347622"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="56347622"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 02:51:56 -0700
X-CSE-ConnectionGUID: 2OzmFP+GTyO4A8FkXKyOmw==
X-CSE-MsgGUID: VP3du4+8TGCYZF755aC8Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="188086243"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Jun 2025 02:51:55 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSYPZ-000LaM-0I;
	Fri, 20 Jun 2025 09:51:53 +0000
Date: Fri, 20 Jun 2025 17:51:37 +0800
From: kernel test robot <lkp@intel.com>
To: Nick Chan <towinchenmi@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] arm64: dts: apple: t8012-j132: Include touchbar
 framebuffer node
Message-ID: <aFUvKYhtnu_2jm_c@4553461508fe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620-j132-fb-v1-1-bc6937baf0b9@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] arm64: dts: apple: t8012-j132: Include touchbar framebuffer node
Link: https://lore.kernel.org/stable/20250620-j132-fb-v1-1-bc6937baf0b9%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




