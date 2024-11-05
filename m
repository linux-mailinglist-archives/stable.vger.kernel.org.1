Return-Path: <stable+bounces-89783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606BC9BC3F7
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 04:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7261BB2157D
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 03:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A3B20B20;
	Tue,  5 Nov 2024 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrUzs0BC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AC73C39
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 03:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730778065; cv=none; b=Nx2iul/2fu2dCU2VkaB6I9q8MSqdxOvdG5CyP+ZdO8c/5wCsM1CnUUzb68pwkyV5dGBENURttg3ArMYdPYTf1VYLzLVL0u0N8rVYyEuZgDjNRVpKqy3sczMS6oV1KL5wtXzqKa/bnMBeXGjsI1d2ghBS/Oqy+GXNhU49EUNZxIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730778065; c=relaxed/simple;
	bh=8ZUVFTjTpIHcAw26biLwyjSlKLWzk0wqsGQf1zfqi0c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rEp8gqqkJ56tqLRg8bZhzpAjyH+ax2Uo7oTEuOFq63sJ7aFmX6ed9D1XDoxDPuOX+OPYUhERGmELu9+9nr1j7sJdOg4t+7H66fgwKH3hQzvycy34dmgIJ96QhkTDZ/vtP6xP2WcGMCcl8eGHjUf07Wm6TOr0gO/6GSVIWGWXc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrUzs0BC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730778063; x=1762314063;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=8ZUVFTjTpIHcAw26biLwyjSlKLWzk0wqsGQf1zfqi0c=;
  b=MrUzs0BCSTq0FumOk7nv/L3Rz+qdPZ2WvsTMXKv1wCosHCb4jiw/bU+s
   0GqXY9lzQCamNP8Sy/TBSL90pEgzFjI0LZ4ap8vXHiDaK/HgEC6p53fUQ
   4CHCH7EhpYa4STjSE/R9etvy6Rz7odpdur4+37yXRtmB1oWyr8/q6u3EA
   feVw/viC/as9kSUqak6CQHIWcnaMjXWY7jajSA2Y9jiYLf+pRkR6neTaM
   EjcGJEcw67UzkkO/hucUoyrMS2EsElWqx76yo/wEyJkLcwumhVuf0+AiO
   Fz8pf7RI3snlktXZx2vWpBG068E0EeQpUja1wnwSkjtcAHYP0hsb47PT5
   w==;
X-CSE-ConnectionGUID: wvKEaMN0Q6yZhutrD8uPHA==
X-CSE-MsgGUID: PFlP8KaLRSqle4Yat28viw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34194692"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34194692"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 19:41:03 -0800
X-CSE-ConnectionGUID: HWU/HEwFTPa+sw3fgPJ7ug==
X-CSE-MsgGUID: Kz6bp21TRNCC2X+LJtiPUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="83799065"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 04 Nov 2024 19:41:02 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8AR9-000lZ8-0q;
	Tue, 05 Nov 2024 03:40:59 +0000
Date: Tue, 5 Nov 2024 11:40:23 +0800
From: kernel test robot <lkp@intel.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/1] [PATCH] mm/gup: avoid an unnecessary allocation
 call for FOLL_LONGTERM cases
Message-ID: <ZymTpxyshT23oNUm@7f78dee4e976>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105032944.141488-2-jhubbard@nvidia.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/1] [PATCH] mm/gup: avoid an unnecessary allocation call for FOLL_LONGTERM cases
Link: https://lore.kernel.org/stable/20241105032944.141488-2-jhubbard%40nvidia.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




