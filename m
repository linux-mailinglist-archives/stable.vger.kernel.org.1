Return-Path: <stable+bounces-191711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCBCC1F59B
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 10:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61DB188358C
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 09:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF75733B6D8;
	Thu, 30 Oct 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gov1vJmn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D133B342C92
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817287; cv=none; b=rZfL1NhnGQLlNr8y1LYfPFzu3tMKIPg1y5VZUy0JYIzqIWuJANgO3DHBaxAh+xXhDFDWYpel4ste2IS2Fvb65pkSL29l8sHyXPaIANsjg5D4Fa8nlSC01s4LtcG7pe8TJ/l2bAZXT/PTMebJ4bXNBKuFCV3sm21Qc0jCtH3Syzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817287; c=relaxed/simple;
	bh=VpKuEGsc8+cU3qGsVrgTzzoJabd8hZAE0zE8U0WEEOI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dkRmvI4pZAnnTAPscCbp3JRD3UKTwQbwao4oQOhM2th7VEUFHlb4Zl2M++H57l2z/Q/UAXD1IIkaL5yClrnCdEpMOTFSIt021COdgQXeTt5xS5qu1xfGWuoS9QVs0bJcrRWEiaQK1w2kRloLLOp09qoagVtdoyB7kvPhYGR3Dgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gov1vJmn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761817286; x=1793353286;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=VpKuEGsc8+cU3qGsVrgTzzoJabd8hZAE0zE8U0WEEOI=;
  b=Gov1vJmn8195pEz1ssPYPguIxorKBJUgNr3BGwKoryyvx19eekYvvL0S
   bgHU7fsTJmJKamLhZvGpZKKFpzuiE4+APdKXAaA/NMpBjd32szlEreybR
   c/ca56x+KnyFmaZXaLKRxljdubb45G8yd8EsF4AFCw6tRhhoa/dhVFp1x
   V7xDRCLWTGCQv24//3x5pffyXtvKqrwIOVnB9RTIIG/z+u5tnbv8BsVXW
   uY7G2miKp7gv8+4Eksh4ayYvK97ROH/GI3qhL925Ooxk5H+lYA77ngRKM
   WRy5FeBH3ojBzFsoa4DWVUmpe3EfFBvLKDZAwdd6LoPp70ZL+bEYqsAda
   g==;
X-CSE-ConnectionGUID: 099jkq6+RpG3lNx/avnFiA==
X-CSE-MsgGUID: i6e9ZtORTQav0BXK0mtGIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63883218"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63883218"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:41:26 -0700
X-CSE-ConnectionGUID: 5mVGKP6YSSOvBJCy3w3z/w==
X-CSE-MsgGUID: xiUzlSVhRo61T0w4+Qt+hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185167805"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 30 Oct 2025 02:41:25 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEP9m-000Lme-0o;
	Thu, 30 Oct 2025 09:41:22 +0000
Date: Thu, 30 Oct 2025 17:40:37 +0800
From: kernel test robot <lkp@intel.com>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] net: core: prevent NULL deref in
 generic_hwtstamp_ioctl_lower()
Message-ID: <aQMylRbHQNDMb1PS@fb33b90f3739>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030093621.3563440-1-r772577952@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()
Link: https://lore.kernel.org/stable/20251030093621.3563440-1-r772577952%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




