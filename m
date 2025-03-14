Return-Path: <stable+bounces-124414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1976FA60C13
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 09:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6804F3B748A
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 08:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338EC18DF8D;
	Fri, 14 Mar 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bb930m2u"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820CB192D6B
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942203; cv=none; b=U+l0xqMCurPFUx1/yUaQWu0v8J5Vz1+rbHQs1mVO/4TkalCT7LpkpqsfMaR/+/jxsKj8w06Onxw582vPuEKbxczX9AfQTFcbSx7kwWU/d5GLIgbglvw30PHeeGGDLOej0EDzbbpv1gS2ARF9BY+5/4Ne3mjgULex6IEzkFc+zhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942203; c=relaxed/simple;
	bh=t2Xvgkviw6BKWPs5pZKkYN089SPhHWmEvzBiUmwsONI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nNmyHnpY8wFrgzNEiODxekSXNSYdLF3cIDOC2KpGD3Rjtp1aXFhu6Yqpf1Fke6wnalRoKynsLNQmrkFi9YTnOW7a46MrR+qwjL9xcGS5ZItfVZZYMaIxEwITCkZrjSGnUkQ+AYrgCQNyOwSxD1utQnQyBxogAddU2hjKZL+fvMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bb930m2u; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741942201; x=1773478201;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=t2Xvgkviw6BKWPs5pZKkYN089SPhHWmEvzBiUmwsONI=;
  b=bb930m2uDL8L6mthBrWs9NlaFkzJBV2FCRrfojsM8RKobJkpJxqpVgpN
   mFl09KEU+cY53TIl1Ja3b1WButSpiIgahbHufOnMHFZ7Hd9k2lDiVYab9
   AVj5LpxptLG/o1bb+oqhxBqTNq7hr1JVv6UFHfCAGC1iI3GxItApnGVu+
   f6pLcwbn5r5ook/GP8xL0tBGrnhZoVVvM4yZLliT1kTCxyogieZqIksa9
   CMptX9w1ec9nNG9dusCBoDOfNmschsfefSAsPzv79jO1c0foBebVT1Lyr
   V9XKrYML+HLE2L40u9P7rywC3xUHb800h2ocnff64+Cwkw2Ppt5G9xEXp
   g==;
X-CSE-ConnectionGUID: mUN+ftECRuyhUSimLZv3jA==
X-CSE-MsgGUID: QQ/YJ2q9Qn2xgxpYqKx+WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60626006"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="60626006"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 01:50:00 -0700
X-CSE-ConnectionGUID: R/3j1HsiT2yvsqkcmpsVdg==
X-CSE-MsgGUID: w8ABgcQIQ1ihbokP+pf6Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="152145399"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 14 Mar 2025 01:49:59 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tt0jt-000AF6-02;
	Fri, 14 Mar 2025 08:49:57 +0000
Date: Fri, 14 Mar 2025 16:49:40 +0800
From: kernel test robot <lkp@intel.com>
To: Akihiro Suda <suda.gitsendemail@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] x86/pkeys: Disable PKU when XFEATURE_PKRU is missing
Message-ID: <Z9PtpLTOMn9F80v2@8c81fd183747>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314084818.2826-1-akihiro.suda.cz@hco.ntt.co.jp>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] x86/pkeys: Disable PKU when XFEATURE_PKRU is missing
Link: https://lore.kernel.org/stable/20250314084818.2826-1-akihiro.suda.cz%40hco.ntt.co.jp

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




