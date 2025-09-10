Return-Path: <stable+bounces-179158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27012B50CEB
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 06:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA763BADD0
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 04:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3FF277CB1;
	Wed, 10 Sep 2025 04:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZkX+ifZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF37825A655
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 04:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757479710; cv=none; b=uunE+BDD6bU5Mb4xrXuG2RrcsZ2ZSHYPPpoQJhJaXoRH0GsvVvDZ8D5ww+cSl2J/ZLE4BKTXLlY1hzfiK4C87tzg/gj+TALms1RPuKRvbFBtmWPcQ3O6y/uyarl23N7/V2uw235UDUNyVCWJcvNwyPTY2BP7b1ckvH7Mrb/Rbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757479710; c=relaxed/simple;
	bh=f0SpJ2IrPwZF1LhmP94iC36OsdGVQ2ocyhgP3YokeuI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K9BWBiB1wZyHU3Ug5rNWZe0z/jR+l0dO6gr4ucNSdg0aToVmz+bQOzS/rPjVPWKym4tLKXQXL6ual/JvykDk8l2m8vWdObD9oM1vny4WCBeC50NysG5JKB2rqz5BmcFVYtms3SZ2fo+vcUUTfVWKayhKn2wDqd5ZR0n8DmHJN1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZkX+ifZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757479709; x=1789015709;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=f0SpJ2IrPwZF1LhmP94iC36OsdGVQ2ocyhgP3YokeuI=;
  b=bZkX+ifZepX0/gVW69s6cdx4/eestBGQymD14v8VMHh0Y1xLIGLv/kc9
   u23HttCt3foGFUeeOpl0OA4gEW0MaLJLluqiD1x/agg2ic9F2RFLNsTqR
   +HBpTggQ/N+YK8mMNq4VS5XO8dDWFTYf01HFjtnHt/q3tTHSXFhrTXHHT
   gdTgArYEz77Soy0VZ8L+8n29sPnJQkmXnyA89EiX5zb8w6R0tzWsvCey1
   aHpsfKNeEN/TmQ1/5/Q7DBVsMZU5nuXfXq+hHw/gWD30hrjcqm4hKfGCP
   SEjfNFJ3FQO+HLSXv6xYAfE2ijOdwRcvr9jwo+FKIwjKUAWtb+lHRSsdA
   A==;
X-CSE-ConnectionGUID: kU1Phl6pRyyEen2ePKCXEg==
X-CSE-MsgGUID: uiPrTSFnQzCSQpfLf8GiSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59635719"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="59635719"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 21:48:29 -0700
X-CSE-ConnectionGUID: 4I4ADdzVShmn+0auIfXTWQ==
X-CSE-MsgGUID: HKsfmBk0S4SmV4ZzdJ33xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="173726420"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 09 Sep 2025 21:48:27 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwCkr-0005XP-0O;
	Wed, 10 Sep 2025 04:48:25 +0000
Date: Wed, 10 Sep 2025 12:47:29 +0800
From: kernel test robot <lkp@intel.com>
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1] arm64: dts: qcom: monaco-evk: Use correct sound card
 compatible to match SoC
Message-ID: <aMEC4SyU7c2jZ3Pi@03ba77cd577f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910044512.1369640-1-mohammad.rafi.shaik@oss.qualcomm.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v1] arm64: dts: qcom: monaco-evk: Use correct sound card compatible to match SoC
Link: https://lore.kernel.org/stable/20250910044512.1369640-1-mohammad.rafi.shaik%40oss.qualcomm.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




