Return-Path: <stable+bounces-33051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8667988F813
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 07:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7011C247CA
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 06:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693AE4F5F2;
	Thu, 28 Mar 2024 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2EIs1fT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC829CEF
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 06:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711608359; cv=none; b=Jts9B7x6ieFBMzp9Gsmxky17epLZYljcrydTHk5B+3awqj/OXGvzwJ8JTyj3Ik0vrIV0WcyLCLeVmuQXBuz0cNfpb+kVA/9TkMswBO8K8R1NV7xMoTciYWPCrfqgh5d9rZ9qp+cyBq5r5Tx22XJPa6OAuTTNgDO2ghkuWL8PydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711608359; c=relaxed/simple;
	bh=U1nlaOg3dEldoBy45T0fcwC2u8GkV8HHtTUeH4gyen0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s6a6sf/uR5MpFsAR7Ltl6iXfyk3YhCMJRlrQ1DY3J/E5rEbTL2oCEpxre2KmFCp9gO8sMYWSXFCWWsGn9CK+NieN0UZ+H/YCaK/5JS5yGgqoxaOgy7zEvpMz1mRpwwdXCf5aMGaLnUthct+4GOPnJTx6JF6QTlseexcbrOTpcNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2EIs1fT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711608358; x=1743144358;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=U1nlaOg3dEldoBy45T0fcwC2u8GkV8HHtTUeH4gyen0=;
  b=V2EIs1fTYNdlxzIdY1uqBU0BkzGl/PX7nSua1YUNsBwj0ItgCj9ryALE
   YRmDer9oUxAPX/KU/a/cvvk3n9feCpXVq7iuES6wxxZwa7YxnyEWbz6fR
   8uXH2Ie1jGgMF+fdzDSwqlz/p1fD/+fKbyAbc+rj3Mvk9hRjgXk0ZRFej
   vnZszzafemTx2Vkmjk06RKbVhI0Ih6PYJpBrGp+Tt3ygrrrUisoUVoDbQ
   LSprlkV9Kbe6nNl4IS3jdSDn2RYHdAp4agWAHr9kJU3/HRk10cN83XCvy
   Sf5z6myXoSqV25CtazYiEaOz0XsmSYNBzBsuhrixl5+RWrL16e1nVEH6Q
   A==;
X-CSE-ConnectionGUID: fg8kvXSOTVe4adGfoMhamg==
X-CSE-MsgGUID: F7bRnfK2QdCJ9MSwY60Uaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6856615"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="6856615"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 23:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="17159729"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 27 Mar 2024 23:45:56 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpjWL-0001sU-2Z;
	Thu, 28 Mar 2024 06:45:53 +0000
Date: Thu, 28 Mar 2024 14:45:16 +0800
From: kernel test robot <lkp@intel.com>
To: "mingyang.cui" <mingyang.cui@horizon.ai>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] sched/fair: Fix forked task check in vruntime_normalized
Message-ID: <ZgUR_A6p__32Mfx8@f34f6e606ddc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328062757.29803-1-mingyang.cui@horizon.ai>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] sched/fair: Fix forked task check in vruntime_normalized
Link: https://lore.kernel.org/stable/20240328062757.29803-1-mingyang.cui%40horizon.ai

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




