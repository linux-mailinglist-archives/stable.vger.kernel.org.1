Return-Path: <stable+bounces-18783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219D0848EF5
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 16:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57CC281D00
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30668224E8;
	Sun,  4 Feb 2024 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFkYU9CR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03166225CF
	for <stable@vger.kernel.org>; Sun,  4 Feb 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707061208; cv=none; b=rgPWBJcutOQhrjdXnBjYtHdToobRMdPWHBid5P67G084CxlAsXnQZqDaoF9RxxMtRqGvd3l+JhcumaFN1dFyTjNYvFVBVF1Ks4uq0srfOwEKFYwe3nvalLbgnil/szzdUiQwnx4vOdahR2ev1wvDp2+IM9AOtZ2ZFvf/DACXI+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707061208; c=relaxed/simple;
	bh=JCr1pCGlVgKqUk1zF1gcqAf9POPZ9MYR2KUNzXr/Q9g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kljBRcj0Kwt4t9tKmwVedP29G9qYY8QGztWVguOZSUhwxLYhO86QiBDv0kTkU1Wb3bc3AkvvPM+FLXEYFaT4Q1RFQ9MAuISHnP7T0CnVkFoVPH97DQdKDWeQRSnsD5QkZ1cEWhCodoG74PuZfFWWrm1d9nR2o4BcxiKJpOUCT8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFkYU9CR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707061207; x=1738597207;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=JCr1pCGlVgKqUk1zF1gcqAf9POPZ9MYR2KUNzXr/Q9g=;
  b=KFkYU9CR2GCoUWqc2EVHwP5TE0CV1o3+/K2PLeqy3/f5QVv4SQCCC1vJ
   swMNUS0vUutVQE+5ZBHV0mOVtfZpvUTHs5RTfqkh5U8py6K2jPyRgyPKf
   CDjlAksFsTYKXEAJBIWpzUkVt1xi49vLc5VF9ns0Zqi1I2uvvZwGIup+H
   kmbgW1MRKblnmuvuBrw0KjBI62W4CSkYZXyxXcKuxSetVJKyAJBJ5/efW
   s4cKDS2ZX85NVR5xj5YVWOJuOccdJvOnkLyJwhMOLfOdxDE6DTfWXW/r6
   sgsTmlErK2eAPuUjIfDF1bCLRybn7PmTxvhkZ54uavWdAokvfl95jyRht
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="11759052"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="11759052"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 07:40:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="823653889"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="823653889"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 04 Feb 2024 07:40:05 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWebC-0006Sa-3B;
	Sun, 04 Feb 2024 15:40:02 +0000
Date: Sun, 4 Feb 2024 23:39:35 +0800
From: kernel test robot <lkp@intel.com>
To: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] netfilter: ipset: Missing gc cancellations fixed
Message-ID: <Zb-vtyrh3Q7FzJ_1@a2a592e9b9e1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204152642.1394588-1-kadlec@netfilter.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/1] netfilter: ipset: Missing gc cancellations fixed
Link: https://lore.kernel.org/stable/20240204152642.1394588-1-kadlec%40netfilter.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




