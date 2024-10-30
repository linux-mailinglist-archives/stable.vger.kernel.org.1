Return-Path: <stable+bounces-89336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0CD9B6599
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6861C24792
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14BC1E907F;
	Wed, 30 Oct 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkQ7WEjb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB7E1E47BC
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298077; cv=none; b=SJHrslRrt8rfi5hF1oi66nFCo4+IXgAoRPbowNtQ/3e+eC/NLrDFQYB8UgpkIem442ZEYuyY88T4J5wXcy39PmV4cE/0QxgqOZSk1X/jxqBA4iD4BkCzAjMiUZLi5fmEdqwur4dVnOBKGpEHaBrIw4q62w2U5MppcK8pG0VPnLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298077; c=relaxed/simple;
	bh=97b8mld7VPSGB4X2IzAd5UaGmHUxEICq010VGDa82as=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zs6q5O3LpiJd/piVXPE74p/a6Q8wfQWapMZaRchQPakvxMoVQGbE5svtVZgZXV17a/zNLbxuJRyWx5CkiStrrHufhRRG7t2fEKFS8HmnEYgF7Sf2J2fmxv6gul7i+jbKL4dIt8+LHh5MNewiRReMCo8X9VLkv/w0Jen+V8EpplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkQ7WEjb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730298075; x=1761834075;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=97b8mld7VPSGB4X2IzAd5UaGmHUxEICq010VGDa82as=;
  b=PkQ7WEjbmoCdcxNHHTPwPJYIX86NoPnKK6USauGyhDKEj3v6RuEnscIw
   sV1HVJQJ/3xXNsdnnTF6kVzXNSVSA/4PqHkdqcAWl4lrKWigAn0QKWDuu
   Pzbee7x5PoLdjgCwzbBmvfvB5XNsxxLuKIxNTvJzHrfwzFcf4fyRlqTJv
   4Q20Kv6iIrbBtHFEJ5MEETc0BQcT7KY3DXGbg3oEZxlEqiWkq2XU3X/hB
   ev3Yi87BoFDuC06Q8c6q8GpG4J42tPvRHfTjbvUQT11PDGgauWB1FAkHs
   lvRiL1wJb+NQpANaUo3IZSWcN6MME2LQW6asy96DS0d635mynBjhFKy+f
   w==;
X-CSE-ConnectionGUID: CWvCdUjyQnieik1KCNM7Dw==
X-CSE-MsgGUID: ghQs61eHQ4679YUy94RSqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52557954"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52557954"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 07:21:14 -0700
X-CSE-ConnectionGUID: 4KlIC5PdQf6lxZGq9oeEBQ==
X-CSE-MsgGUID: cwVX7rVHRve276Glai3PZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="86260724"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 30 Oct 2024 07:21:12 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t69ZO-000evq-0f;
	Wed, 30 Oct 2024 14:21:10 +0000
Date: Wed, 30 Oct 2024 22:21:04 +0800
From: kernel test robot <lkp@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 6/6] phy: core: Simplify API of_phy_simple_xlate()
 implementation
Message-ID: <ZyJA0MOrP0HdNbD3@96212614dfde>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030-phy_core_fix-v3-6-19b97c3ec917@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v3 6/6] phy: core: Simplify API of_phy_simple_xlate() implementation
Link: https://lore.kernel.org/stable/20241030-phy_core_fix-v3-6-19b97c3ec917%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




