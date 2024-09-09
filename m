Return-Path: <stable+bounces-74000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54261971588
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 12:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C7528400E
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40AC1B2EFA;
	Mon,  9 Sep 2024 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nl5HU6a4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68151B3735
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878467; cv=none; b=ahXGFzb9uAdb0nEhlfS+mJMAaq8AXh0M+ri12NsUsj6UZSPARcb+RPbs6jLiLEpnp+yzej8aj/SaSa4lp3OMORH22hk2E/TdjRGiEV4BjX/iaLu5x4OUW88XyNjeVsU0Yx+y51Irsx//i/xBEgDqSb6tYnOrRZM4GGisoW3G1qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878467; c=relaxed/simple;
	bh=bkkVOFPMzK8x0H7vn8y6CLobx1jEoXgleqBVwLGiMlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=igwDB+CVMGONBfCrV+6PBzcMpLECyIFWYpwW5xNhiQ7E8DZqPb41yO7CDyald9vB1jSYn/bSZi0+Le65QC5aj/PHUFFG7e9YGAp+vsixRz9BJJWAKCpAXBnGGeP5C46bM2nZVXeliIxFUvt6qDhj1XlN2nIddbsEobjb3VkPaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nl5HU6a4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725878466; x=1757414466;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=bkkVOFPMzK8x0H7vn8y6CLobx1jEoXgleqBVwLGiMlQ=;
  b=Nl5HU6a4J/v07bg33rOphtz20jnnt+qKtAXdjTgKQkxuhZdHjWm4j26O
   vWSlyhF3lkwyeFYJo4PAccDQ08xNwOk7FYFoyV3ICfnMcfHrHpO3ydfOq
   cPAL2VJ0ymN9sF0UTHVT76B3BZ/+LRL0l7giquomzKewJHj4Ox12vT3u6
   uXKROP/6ViRCUYWdhGd3mJqlHUspMCcNyI3v/0JLkXUjGpzWStFNd1ibv
   T8zybuGt3bfmw4MPnUaoOiW1Eq0WdE19VRbuL2XywE9Nny43CXLWR1qD+
   ozOveKx+tSbfrlOXJv0WN/1ExLn6Jgx77d77VX6QOjKVHdEAwNjMhpx9y
   w==;
X-CSE-ConnectionGUID: GBXTMF8BR/CmETIsMOhw6A==
X-CSE-MsgGUID: oX+cnNVPSbuhAJAkJ4Iq2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="13438309"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="13438309"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 03:41:05 -0700
X-CSE-ConnectionGUID: y8vGagTfTz6pU83Ib8RXzg==
X-CSE-MsgGUID: 9QznlKdDRceUjvSw7NLvAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="89918976"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Sep 2024 03:41:04 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snbpO-000EcW-0Z;
	Mon, 09 Sep 2024 10:41:02 +0000
Date: Mon, 9 Sep 2024 18:40:55 +0800
From: kernel test robot <lkp@intel.com>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] arm64: KVM: prevent overflow in inject_abt64
Message-ID: <Zt7Qt4o30hU4TY95@b20ea791c01f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909103828.16699-3-abelova@astralinux.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 2/2] arm64: KVM: prevent overflow in inject_abt64
Link: https://lore.kernel.org/stable/20240909103828.16699-3-abelova%40astralinux.ru

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




