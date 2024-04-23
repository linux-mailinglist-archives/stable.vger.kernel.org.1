Return-Path: <stable+bounces-40710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A79A8AE866
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 15:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86168B22D7D
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C12136E2F;
	Tue, 23 Apr 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5E6/EoA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB900136E05
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879635; cv=none; b=qGtSn95u20POgopo/GO03vpUfUv8HoPGtyVvuCUVnl8yXdcCwTMzcbA2153t7X1zXLQrlVRKdYHyPW150F8t4R6pToTfdixy5CZUDrb1KH6TlaeL/hTCJOdbIHeAz44/crx1/vE1CHe6ruV7GpHzjud64MWBD7dZN83fOwHxuBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879635; c=relaxed/simple;
	bh=POjHCPvznE1oxaNvbe2aZrgfu9AtZIiNXguD5Qg4ohY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rAkKMsW53p1YgkDShXe5sH8VPiI72I4Pstmrnz0p3m3WDBWh+5MwjODzJ6n8JLsCuokJ+HhAOLzVqzgLE32IFMgHUW6P1hREaeNuLUrPzt9G8F+DQvGeXkhR72efOs0+ekaEpS8iKeGBQbO3ERpgipZPQy7iUrGW/wye39jmyKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5E6/EoA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713879634; x=1745415634;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=POjHCPvznE1oxaNvbe2aZrgfu9AtZIiNXguD5Qg4ohY=;
  b=h5E6/EoAFWFud7uBIn6gE1pk3k9/spAv0TaVGrrDi0WH4bPuAhS7Z1s9
   meeCdO/qpCIIpT1NC3L8hfaQhJ3KYvypDuz5ldq3/O28oCzaFIouEcte0
   tL2EYQM0AbexGQUVdELcGm5+fXfx+z5L4sirH2ipkLTlHOUP4Ad0r1Wbf
   9ogBQTzUnkWRN6QtiHUd3RbLnkTKmLNT1s65H6ZyunwT7RMsmiTXUMmaN
   yvYHg/pgQXv5lN2Ob/di2DJQM+KNzU2PS13vtJqkJ2kEDgdFV59j6hr4u
   1m6yNBSKwPoMhxP0HWMHUoaPZojwokmFqcGAhE5+K1DV/DjReW7loSafc
   w==;
X-CSE-ConnectionGUID: CeRlfMnZSFSsUx/hJ1rm3A==
X-CSE-MsgGUID: sQOMnjrlTwSh63kT9XJ0eg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9327530"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9327530"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:40:33 -0700
X-CSE-ConnectionGUID: YxbcsK/7QYakfF8boYX5pA==
X-CSE-MsgGUID: pEANNhsmT3iL9Dg4TzjMVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24972010"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 23 Apr 2024 06:40:32 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzGNp-0000DU-1r;
	Tue, 23 Apr 2024 13:40:29 +0000
Date: Tue, 23 Apr 2024 21:40:12 +0800
From: kernel test robot <lkp@intel.com>
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] efi: libstub: only free priv.runtime_map when allocated
Message-ID: <Zie6PLl0bSO3ZdoY@c8dd4cee2bb9>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423133635.19679-1-hagarhem@amazon.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] efi: libstub: only free priv.runtime_map when allocated
Link: https://lore.kernel.org/stable/20240423133635.19679-1-hagarhem%40amazon.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




