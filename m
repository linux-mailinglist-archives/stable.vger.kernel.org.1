Return-Path: <stable+bounces-114987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D01BA31C2B
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 03:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A050188914E
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 02:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD6A1CDA3F;
	Wed, 12 Feb 2025 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdRc6U2p"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE09617996
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327982; cv=none; b=RQTeaNgYRf18T+0V+4T1dy3Uxmtkktg1hMF1EaL++4JeUYVhKrL6SMfU31vCspMU61S61/FAJVrNelpp2nA49A4sfppVrDwJsQ8G0UYTBJEBWTFuTICQzdbvEgaThdth39dSJuAbK11MJ3LvakQe/UGqct94cB9ZrzuZur4d1Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327982; c=relaxed/simple;
	bh=nI4XRlN0jStqj6Yw6TdD/0/5Po7zTnCktid4Zs3kiI8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V663ESHMggJTMTn9DumxjEfiqoHmmrziZragwZYe11rkpIDh1cqMQyY8ZSGsWWU4+tByjTnnD8NVzIRtisMaBFo1bjpCD/WYtTbG6eNnraZPkNCTeFC/nkjPkHqGpWsyp0ozaSHfT0IpV7xjDSjLFkydHTTi83S2Hvm8v29yI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdRc6U2p; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739327981; x=1770863981;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=nI4XRlN0jStqj6Yw6TdD/0/5Po7zTnCktid4Zs3kiI8=;
  b=DdRc6U2pXYSRFMhgp64aoQfLR74E2S2/roL86upzzB9t4KEuRapb4pkx
   8mWpihfUdfRXg1FD0jSyWaweVPw3kmg7E4gkNJb0j6jsYKf0iNFImC1Oy
   7GnLlR1sfTZdpgZXpRE5lGJZhGp92JTQqVFJQ33JPWn5zT3ZInYjZlfPp
   Bi5dlevJxhPp9MP9nz3qBQaOT3ARUaGnABd/eKPWvB8tBldRiiAtpskVL
   KKgyByRbVKmGQoqaMMhRUcdNGWVxHPxdqd/eZVUbDLUew5r1S86xVRscp
   KuDi5JSQPwOjuA0yZKBGEU6xJ5bvuYiAKXpjde/hD8NduCzG9Kenmhwwm
   Q==;
X-CSE-ConnectionGUID: +DA40inOThuOk3w2/4M9Jw==
X-CSE-MsgGUID: ykoPDeGRR2ilq2IZyz1SkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39990509"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39990509"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 18:39:41 -0800
X-CSE-ConnectionGUID: PEz7lSoRRnaml7Xzx51Hgg==
X-CSE-MsgGUID: UoEtSmg4QQiov4comxMCXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117771805"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 18:39:39 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ti2f3-00150t-1S;
	Wed, 12 Feb 2025 02:39:37 +0000
Date: Wed, 12 Feb 2025 10:39:09 +0800
From: kernel test robot <lkp@intel.com>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V2] net: stmmac: dwmac-loongson: Add fix_soc_reset()
 callback
Message-ID: <Z6wJzfiep3Y6gBjH@a4552a453fea>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212023622.14512-1-zhaoqunqin@loongson.cn>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH V2] net: stmmac: dwmac-loongson: Add fix_soc_reset() callback
Link: https://lore.kernel.org/stable/20250212023622.14512-1-zhaoqunqin%40loongson.cn

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




