Return-Path: <stable+bounces-81316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D3B992F0F
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0901C237C3
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B11D619D;
	Mon,  7 Oct 2024 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3fiLlzK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C7188588
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311157; cv=none; b=bKlAXBb3Yi6bzsiTaRoNxcx9388ZSFEq1SUYtdXARbbZugSW+NzLx6icmRJosK+3iqDCi43dobpmGUwvz73UMuk2Sx93QkkTGUeDOxQ7keRUo2LA3vZrKiSfTMZhqpOoZ8AOTT2UutW3L6AZzj5u5Y881tgFNGCDx5AO4b5Iqwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311157; c=relaxed/simple;
	bh=ZnMWCebUvIXpErwhTJha4bt61ATpr5E1Eyg+wlPB0EM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ldiIEdKIp0+Jy62RrUHJXXawPsf/LsSmSXh24wxj652pjyvFDLRXlZMUy5i0CCATQu6L4+2i5P2d5RCvL3bRqS+suYGnF2ms+MQCdkd/Pw9iO6VbmDM/G+lV8owx5pkAhMfaKGUoDcRjrQmjqdF6OnPURg3jHAFxJHLR8x69LCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3fiLlzK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728311156; x=1759847156;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ZnMWCebUvIXpErwhTJha4bt61ATpr5E1Eyg+wlPB0EM=;
  b=Z3fiLlzKLhpoyYBlWXeNxW3NSAZjFAfRcz/WNQOhsm0yesSvhntR8pMi
   pB7i1A1gxUadCPEAW3/RJFH1p7ZXWpDtfKPVx4y8u3T7153b4Xi76j1mN
   0Il1+tYbPNDDYEUWbFznZT9KhWK5KOBBozrZ8dALlgIW9kcxp/7Y44fWy
   G51SYhvdHP5AyKHdqmcHCJW2k0Tab08ZyHvcUTOm1zPmFJd7mUKoqbZO+
   /czCREhshdJOfvrK3vYIkZXBz2cDpd+7JcC782zmn/txKox/WVA0QHCdS
   s6Q/4Ww1zPc+9TmjcWqPeFjxTvzd46xEL/YkGAgfSExVeZ5k3ixlp3E7Y
   g==;
X-CSE-ConnectionGUID: HksDfUTzQWO5bcQqX3MVQQ==
X-CSE-MsgGUID: alDmlOtDSVGj/QakfOrTFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38120077"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38120077"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 07:25:55 -0700
X-CSE-ConnectionGUID: o9pzUsqbTOeK4bMeZt4J6w==
X-CSE-MsgGUID: YymaFdXdTcqQRn5U27VtnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="98810213"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 Oct 2024 07:25:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxogK-00055i-1H;
	Mon, 07 Oct 2024 14:25:52 +0000
Date: Mon, 7 Oct 2024 22:24:59 +0800
From: kernel test robot <lkp@intel.com>
To: George Rurikov <g.ryurikov@securitycode.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.10] block, bfq: remove useless checking in
 bfq_put_queue()
Message-ID: <ZwPvOyCeBAHgLpfV@83e7b27afa97>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007140709.1762881-1-g.ryurikov@securitycode.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.10] block, bfq: remove useless checking in bfq_put_queue()
Link: https://lore.kernel.org/stable/20241007140709.1762881-1-g.ryurikov%40securitycode.ru

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




