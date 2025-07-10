Return-Path: <stable+bounces-161589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CC4B00548
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 16:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786081C40B77
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 14:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB4E273801;
	Thu, 10 Jul 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSUPZSLO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE2C22E3FA
	for <stable@vger.kernel.org>; Thu, 10 Jul 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157817; cv=none; b=cnCJRAJ5QmjMgxj8/XJqIDDexax+5xwpd8VtYvPW7/k/kA0xV4wT1BgwxNRuaF/ETTsVVvBAmGu3TUaiIJDpSvGgORZ8Taa4noqlPn73mMadwMioWH7N7tqZUYTZL5a/PmSXaxxqNH7G9ZKM02CwdMotqJAe+VyFRR5flL7EKns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157817; c=relaxed/simple;
	bh=g5MwrCI6sk832lhryi4KgtNtnuCrduxIO6sRbESPEoc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Z47CRDBewxmTa+qRIQneH3Tmg0h+LA3ArwkazykigEUIVcJMKK82MIYlq8PusIWg1/a+5w12w0gXxzHZFmSrzyeS/n385spcKKBeRWQ67fExllAa56T05VX2H0yLuZD/13jko1Y8hT91Ki+GmH3ZrXC/MNuDCrLHc/T0csXyZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSUPZSLO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752157816; x=1783693816;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=g5MwrCI6sk832lhryi4KgtNtnuCrduxIO6sRbESPEoc=;
  b=dSUPZSLOFrr/9pQD3q6eU8htJcwLAos+ilC4I58nMbEE3bKY6H2guIup
   GzJaCBcv+ux5xJKgKzYUtCECTJnlE683i7DNJqbO6sE/8Eqnvu4B9XCZ0
   8KrtPB1WS61JCtJTJ6DoPp5F1lv6c4lVTKu2diCY79j9CyS9x9hMzu2Sm
   siZs8DcB2phYZAnVlDKXnnbx5cq9oR3W4isFE1hsZvMf3dJXhUxNITgvx
   d8eTT9ZervJJYUH6Mr+rITIs7tTaNGJZRPicE3sYCae7IwCf76m3vGCx7
   s35yKhap+hxuxvzc9RgLMx9SSFbY+flv0QCCHd26eB7c10tj3kqcsOo2u
   g==;
X-CSE-ConnectionGUID: CAaNask5S9eB9xqVbn1bhA==
X-CSE-MsgGUID: 39dmpgOkQGaMt7Si1PWlwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="71891306"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="71891306"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 07:30:16 -0700
X-CSE-ConnectionGUID: 1rWwfLNoRsqucLhvBUaTMg==
X-CSE-MsgGUID: TEgytC4iQk+CxN74GmzpSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156584903"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Jul 2025 07:30:14 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZsHs-00057v-0j;
	Thu, 10 Jul 2025 14:30:12 +0000
Date: Thu, 10 Jul 2025 22:29:23 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next v2 1/2] net: ipv4: fix incorrect MTU in
 broadcast routes
Message-ID: <aG_OQ2K-ubHM4iey@6c88aed3eaa3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710142714.12986-1-oscmaes92@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net-next v2 1/2] net: ipv4: fix incorrect MTU in broadcast routes
Link: https://lore.kernel.org/stable/20250710142714.12986-1-oscmaes92%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




