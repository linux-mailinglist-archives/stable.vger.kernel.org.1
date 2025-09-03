Return-Path: <stable+bounces-177642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2075B426FB
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 18:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75481542001
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37E32D372A;
	Wed,  3 Sep 2025 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGHBKJNI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED0D2D3ED2
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917225; cv=none; b=ItgctMXBYBPU3CRPclgJy4XegUqPl9RsktFQCaP44YEc8sdLP8FEXLEFhOY7hDyMiFdhruzXhIekBU3ECgXU/Ua+0OVVhxPwHCztKNe6lSjG3VBri83k+XJ6ovI8meHkNLJJo6W4wjP5nNCOLk0Rogoo9WNb+qbv3Y6AoE2I2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917225; c=relaxed/simple;
	bh=wVmguet6Y18ImorR5iJz0YOu5aft7KpEU7pY0KQDr8g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dJtfaQVCWs8dbbxVvh+O9esMBHHTokWJZ7OQNa9oBvI7nX9S1cY+v58m0wT1wSka+kFnTrUhybYSgrSJxOuFO8Oj4XmgzhlJ8GUlimqILk/dY8apZk0LACkYUx9+Uc54DIR0OiYWIMHUzufaylrfQJhgNqS4O5Sbsxl1PBCxNqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGHBKJNI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756917224; x=1788453224;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=wVmguet6Y18ImorR5iJz0YOu5aft7KpEU7pY0KQDr8g=;
  b=WGHBKJNI/dJHutlEBxJoG7IVN821CRHxebJZ9ZWERsOmnEZBZFtWUwmj
   +eAuXps+j4wppEvD2Ust3FZaRYbkgKFUwrhwO4povkvVA7yGvm96vBxTM
   k9GCJMVpKzwH+IyG9i1W4q+6AO1MkVjhRZT5rGxcpr/ZfqPG1Cz3FBMux
   ze9vFs8np8JEE9Lohh7pJKIee08aLLTjuoIcqlgm60aPm/XgJX32D+DiI
   4DHI+zIrYTn6P9ajpz1968q2vqyoy7TkChlO3IG9AgBwIYfQWh49xlvLV
   RH5aliu0SoUai1FsN5TD35z6atxbT6Edvw2FbVbHTBDiIYSVk5LiNKtsr
   g==;
X-CSE-ConnectionGUID: wRt0rfGfTmicMWf9qp6Vvw==
X-CSE-MsgGUID: A1SfVsGvTzaFtYJNHE/SEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59306362"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="59306362"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 09:33:43 -0700
X-CSE-ConnectionGUID: AGe3Fp7LQGCrP56rvHdcIg==
X-CSE-MsgGUID: pzoqwtenSYOMGWuChC/C6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="171576600"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 03 Sep 2025 09:33:42 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utqQV-0004C3-1U;
	Wed, 03 Sep 2025 16:33:39 +0000
Date: Thu, 4 Sep 2025 00:33:08 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net 1/2] rds: ib: Increment i_fastreg_wrs before bailing
 out
Message-ID: <aLhtxGn7Geb1naL7@94157fd02e22>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903163140.3864215-1-haakon.bugge@oracle.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net 1/2] rds: ib: Increment i_fastreg_wrs before bailing out
Link: https://lore.kernel.org/stable/20250903163140.3864215-1-haakon.bugge%40oracle.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




