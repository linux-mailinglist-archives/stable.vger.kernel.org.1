Return-Path: <stable+bounces-35986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBB08992DF
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 03:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4351F24A09
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 01:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB010B67E;
	Fri,  5 Apr 2024 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZJxpTA8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70139B64B
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712281523; cv=none; b=atb0lwfIOWdzW79fhWIpipIOMtysl2dF9QsN/Gwou7kT0+DWgwFzLRjzHR/V9ZiayOdJCl1xjE1Gq8D54VYiP1Nhc8m5qS4YfRc+2+BwKaxbpS94msnP5ubSgnpKdKUOXeC+fp8JkCHBfErSziS+DoVfJMFyYN37F3+UOLI0C68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712281523; c=relaxed/simple;
	bh=lGpzE+7NWORN/z9r8pI2einjC4VMXzHEX3KwJEgISVo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nDLKKfBekGdAo7BFll0NEE+FqwaEW4sgG2B/d3vNtACZ8ptCRiSXdA2omVUU9OnWZSTBAZY1EDS3IlG4Qaj+Uow9JtI+XlNfTZAr/IrPC8SvTRsNUxmihXWJvLcDGL2u0WGvZiQdB7Zf+d1qxrEFi1/E98vias2arCDH4wkJ4xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZJxpTA8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712281521; x=1743817521;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=lGpzE+7NWORN/z9r8pI2einjC4VMXzHEX3KwJEgISVo=;
  b=FZJxpTA8vWdhivXAOZ79Zk6LyPUEwJu6CnyALBUjcYwGqVFmZ//YM3N/
   OR3CpywUSo7RFE8NU6VLYUu3qp6FXirM4R79d6BPG+8qPrQ9EZSArdOCO
   reBJxIWso5kldr0/vv9oMaxCo1MU8XTYgJ/tHNZ0BNTuQGkPPL/QBrJPW
   zSMOfH6iSw++yHl7gGakIB8DnRcyMlTclnLazSTPqV43j4Q5aeJAIsVh6
   B02nYU47d0vvgkxT/HQwtm9KZEGXa5dx8fTw/wmE1XDu+vGUdDkGLFtMM
   5woes5claGXhrlPJU/HDan6pesjI+JfafS3TScALSyPxy5vy57F/x7KIY
   A==;
X-CSE-ConnectionGUID: mTL/LNisSXywHT+lKUz1hA==
X-CSE-MsgGUID: qf+VlIJPTBuDou913nQY5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7483248"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7483248"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 18:45:21 -0700
X-CSE-ConnectionGUID: TuJU2itWTE+EXQHNC3dOCw==
X-CSE-MsgGUID: tOq+nJWxQyicKOHyw3iHew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="23678532"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 04 Apr 2024 18:45:20 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsYdp-0001k2-1m;
	Fri, 05 Apr 2024 01:45:17 +0000
Date: Fri, 5 Apr 2024 09:44:31 +0800
From: kernel test robot <lkp@intel.com>
To: Saranya Muruganandam <saranyamohan@google.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] block: Fix BLKRRPART regression
Message-ID: <Zg9Xf8r8gpEuyoBs@92629a18465e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405014253.748627-1-saranyamohan@google.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] block: Fix BLKRRPART regression
Link: https://lore.kernel.org/stable/20240405014253.748627-1-saranyamohan%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




