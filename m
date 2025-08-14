Return-Path: <stable+bounces-169527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7A3B26413
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 13:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD86621F88
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 11:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067128EA72;
	Thu, 14 Aug 2025 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2mHGj/a"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571BB264A65
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170280; cv=none; b=DLj9q1pXuU0FRJ7+SzPtqImaPjiKDtZ7NlDn2oOAPKW6lit/fROwlzSxKyEytBMWuYjF7z6MwzMRa/u/4mkfgnJ3WaDr9uEtlKw/bwX5fPmk+v3Ue+giy2t/S1jYotRnlQKAb1L3QumWza/jMGcWoyqcMHn8v+LsuobxhVUvSGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170280; c=relaxed/simple;
	bh=u+qdBBggu949YYeAXuPAdch6Q5KtVzYL2Kf6ivZ279E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uyQDdD63DNQynQRvBfrjt0PKkbFichCkuoKpBrnRXBWAiLa0nc9GOIwu+/Y86V9OlzMexX/Ll1WWsoiOC+SB9woQ17BwN/bY1purAmPuXrWobi6zSdcxGZHRsuJDa1mCI5A1ioIYXkZjW2n3IBX+hlGE/54M3UNGJ7mmFBOvrYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2mHGj/a; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755170279; x=1786706279;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=u+qdBBggu949YYeAXuPAdch6Q5KtVzYL2Kf6ivZ279E=;
  b=l2mHGj/aWuOqqp+d94qgmzg4oXpWwzx0qo/cxu8poVut5iG8n7VHnhS5
   H4txRUmu5LrIS8Fmv19h5KJ3cHHZ6DX0HMGbAjfN/gnx1nsRlUrhAFUnn
   QUs9YhQM+VeaA9NvubRMNX1eQNGKn4ke8BmBfyBJTK9bwsqOgxzEU3PNF
   Y4qC5Q1Om9Ay19kqxW89yLAfpflcvil9Wxb/fvP4om4TVoj1qWMwS/wjq
   DI+aXTA/sMcGTaSsAPyx39IrrLktA3J6HsR63HVM8S5cRkU/hDayuFSSR
   rdTwdCnakxhIDn0P3+jLSrcrNNgAo5jXQurfyX4OZjTUj+9pwG21AXXun
   g==;
X-CSE-ConnectionGUID: CmUsbh9aTkOylh72oR3zBg==
X-CSE-MsgGUID: rp3Chny0RHK9BMbHAA8HGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="80060326"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="80060326"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 04:17:59 -0700
X-CSE-ConnectionGUID: hoea9W1VS2GCgKxT3PXAvQ==
X-CSE-MsgGUID: ciQ5X1nSRuuvIZkAQIKw6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="171192526"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 14 Aug 2025 04:17:58 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umVxz-000AtM-2R;
	Thu, 14 Aug 2025 11:17:55 +0000
Date: Thu, 14 Aug 2025 19:17:51 +0800
From: kernel test robot <lkp@intel.com>
To: yangshiguang1011@163.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] mm: slub: avoid wake up kswapd in set_track_prepare
Message-ID: <aJ3F338VexFiaW9o@1a863d778a0f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814111641.380629-2-yangshiguang1011@163.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] mm: slub: avoid wake up kswapd in set_track_prepare
Link: https://lore.kernel.org/stable/20250814111641.380629-2-yangshiguang1011%40163.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




