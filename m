Return-Path: <stable+bounces-86942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BA19A52A9
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 07:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E2828506F
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 05:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39299D26D;
	Sun, 20 Oct 2024 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHmywVLY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED212F56
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729402343; cv=none; b=SO2pDxwAjI6kx2ZPPfnUJw8DgpKjv93SX+vQdi80tA91qCyQcpVg9CijaWx2VwAo4F3MPuwyGXsJJqxIMghyGYBzaKP8jBBEdWy6G2alOKn2SHQZe9kpdEo2IUxF+CeLvLLvdIl95ulovpEaJxGV032wpyLF7NU090nG4dy3S1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729402343; c=relaxed/simple;
	bh=yZCqxG5R42INNFNaEMIEKwdDT/m0aje+NOBWdMt2RwY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c9bIny2/A1DThBLe89mklnlfYUA2T5MR0qsksHM9ojE3U6qR3G3fij+ooxxxdKbTr0yT6OyGftY+pzBOESQQ1k5HUj7ejGDHEuUpV+nKnqaroZ532sIu795XamW5YvHH6z8bsXCJwH1YtZUSOFGJ6xWJkX2o/3EaFVUuJZ6/NA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHmywVLY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729402341; x=1760938341;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=yZCqxG5R42INNFNaEMIEKwdDT/m0aje+NOBWdMt2RwY=;
  b=XHmywVLY4+1PSIvyeym2hYmW0QL2EkGHqiqSn8BzTJ8gRNGaWM6xHfIp
   +UeyJpuhRuq5MEBU2AUPna06cIOVL2GqvhILMk2ki2SiAaFeoe9YSPWsb
   5fFnf12ykQBofQHoQFuGg+YOf7PUFtzUl+B0Y+mXDqy8r1WYLtuLIL2Bp
   wEXUZZen3r9anDmlEpE/vKvmR10iR+le9qHqGernCa8x1cTZF6bTXLmu+
   d3bYxqicgFWLhTWNXjVHm9Zwa6rMNJ2td6X+MIBJKpOj+/ekHiOIywZZ7
   A8rj4MveK2Wy7PUC/S9eK09yLBnvMfmo54wsJSXMyvSDFUvodQ++MbmF7
   Q==;
X-CSE-ConnectionGUID: 7aATnm+gS2OlkZ8c5LkL0g==
X-CSE-MsgGUID: Tadg6ryXQTW4Dd6IQdB35Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32580640"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32580640"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 22:32:19 -0700
X-CSE-ConnectionGUID: /h+G6XxJQgCtxJOuuNHbVg==
X-CSE-MsgGUID: MJe3ZUt8TpWr9+35xap6Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="79182321"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 19 Oct 2024 22:32:18 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2OY4-000Pvt-0D;
	Sun, 20 Oct 2024 05:32:16 +0000
Date: Sun, 20 Oct 2024 13:31:44 +0800
From: kernel test robot <lkp@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6/6] phy: core: Simplify API of_phy_simple_xlate()
 implementation
Message-ID: <ZxSVwD8qn6z2xIDj@91d35335b805>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020-phy_core_fix-v1-6-078062f7da71@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 6/6] phy: core: Simplify API of_phy_simple_xlate() implementation
Link: https://lore.kernel.org/stable/20241020-phy_core_fix-v1-6-078062f7da71%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




