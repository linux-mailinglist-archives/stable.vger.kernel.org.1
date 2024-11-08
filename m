Return-Path: <stable+bounces-91886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0959C13D4
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 02:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D922283D3F
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 01:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D440EE567;
	Fri,  8 Nov 2024 01:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQJAhPR/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAEEAD7
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731031124; cv=none; b=i9b+eP8NsOxyn3SgUID4jyVYcBMvfIqmXs9km15dsy+ESEojFzRu57gzqDyenOpNExr9mckIkJrPZTjrQJDuyp6QSx2G09k/wMKTPmuCI85lnL1g/S71DmE5myZAPU6ogPilHDr69U/pZcRrlSdAeIpAlyPPi99yoThvdoDPXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731031124; c=relaxed/simple;
	bh=APx7S2iwhkFNMCfnT1N5cwEhmuDAK2ENJD93vlLQTnU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sRl7c5tjeVtKDN25HP0epXV8sCizAdgw7KjhQJOYUeki4umEE+N1IZwqOEjJu/tEgMiCwstyfAeCAThQJsyhEZ10bWusqFRCct9zlOeP5TmpUQQjTBD0qVZlduvBMWFrchEliSnHAnOQ7ehNEUHwt1tL9wZGfGwhHwGlMNKQ86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQJAhPR/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731031123; x=1762567123;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=APx7S2iwhkFNMCfnT1N5cwEhmuDAK2ENJD93vlLQTnU=;
  b=VQJAhPR/LzrWgRSrb6Eutrz8/Y9yftlGuRDg/+1CwebO5Bq8p/OFdJxj
   EJaAWRdHwXv3yOPzn3Np3UF7XN6KiExnZ8fZC1+ll+G9CbGiAFduyYJRs
   +gJS6aSnLRHQ572MFiZS5W3x5Mb76wnuRPcutx1sf9bldt8Y5rxdeqKyB
   89vmKA73UBERUxMGuktmsQnlGZG5MyxsF4braul4LBHtcY+ksnG34NQJP
   SMc0HhS0zRLkGDoChBAVQCcVOcYZmmoVDUNf2bBBPsTAckAYGIHdEN3Rq
   XEHdl10i35Zy+C8Ub9VjU7zbNLQy6YFII+UTF5o3MkGMNO8S+jtb7Palu
   g==;
X-CSE-ConnectionGUID: SgX+DWNsRtK9Ad6my5uPZg==
X-CSE-MsgGUID: hynEZ2rQQji788mLB/Sw9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34827147"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="34827147"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 17:58:43 -0800
X-CSE-ConnectionGUID: dMjMl039Rf6NlAwtjAZ1OA==
X-CSE-MsgGUID: 0eU5+vv7T/2LEI9/lZsiww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="89965890"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Nov 2024 17:58:41 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9EGl-000qu8-1h;
	Fri, 08 Nov 2024 01:58:39 +0000
Date: Fri, 8 Nov 2024 09:58:06 +0800
From: kernel test robot <lkp@intel.com>
To: chenchangcheng <ccc194101@163.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] media: uvcvideo:Create input device for all uvc devices
 with status endpoints.
Message-ID: <Zy1wLnnauo86VmBK@141619988fc7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108015658.471109-1-ccc194101@163.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] media: uvcvideo:Create input device for all uvc devices with status endpoints.
Link: https://lore.kernel.org/stable/20241108015658.471109-1-ccc194101%40163.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




