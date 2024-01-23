Return-Path: <stable+bounces-15489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0518389B2
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 09:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89BD28309C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37E756B90;
	Tue, 23 Jan 2024 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CYppeZkm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DF957868
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706000078; cv=none; b=cet+kHp9j8vonj1oM5iE9qat4UTltY04CTCGiNAKhvunP8t5gDgv7TRNWWM1FyFszdfN74q0Vj6WxQGYyo3Y2087imZ0fzd9gVKHKK3RuYAI+4XXpc8+Z8Aon5Lxv+tzIPrWw065V2MjNDgIcaNWfdvopqYyo0Bf6iH0DoBdlbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706000078; c=relaxed/simple;
	bh=yc+1LX1lTaAaWIpOySfm0IVCN1/WGQHPUvvgyJNWY1g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RiERCpYY0XCcj3o4ZaqRAr44JVi+hLba8M0MleoraKhNCc173/pC66ykvMXkhUkfn1RMmiNrt6DJTCpRk2RCpKgGtyyu13OBmVNgf2TSaqenBpngxcjZa7vB574ChgZqw9d6sGAeUOJQ5DkZ6TAkoBj5W4rGkx5HOIwp1GWJL6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CYppeZkm; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706000076; x=1737536076;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=yc+1LX1lTaAaWIpOySfm0IVCN1/WGQHPUvvgyJNWY1g=;
  b=CYppeZkmtXoycMJYjNFnOZ4nb7xhlO6oYxuNaMASr2aasSsqAwj9lm5W
   xyDTlanvRlQdX0CaXLydNxt148ADPYyH3g0y0u+ANPTL+1DkYzvE2NSaK
   6opp/tM+ys+My6JnT+Iyd7C11Y52TV3N2ex0SwmVrUlv/k1n4F/cWHvUd
   sCLGI64rIjKOKQBQTLXjryM/sC/uwzCqDRmJpqQoeWSJc+n0MvRsu5bt+
   oW2JxUZOVjA+klWwt6mC7dMF0bbaMRHBFYh+4xm5VeDOYyVMZQdxZLURw
   XW8fw89lTBegm7ix3ZXTkVowmQvRMJvu5trP3d9MjWjPSTtSwkkUaEV1t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="401114219"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="401114219"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 00:54:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1600459"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jan 2024 00:52:07 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSCVn-0007J9-1Y;
	Tue, 23 Jan 2024 08:52:03 +0000
Date: Tue, 23 Jan 2024 16:51:13 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Sikorski <belegdol@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Add a quirk for Yamaha YIT-W12TX transmitter
Message-ID: <Za9-AXXB_kV-eYPZ@35b4c9174663>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123084935.2745-1-belegdol+github@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] Add a quirk for Yamaha YIT-W12TX transmitter
Link: https://lore.kernel.org/stable/20240123084935.2745-1-belegdol%2Bgithub%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




