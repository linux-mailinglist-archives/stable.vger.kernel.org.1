Return-Path: <stable+bounces-61353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7365993BCFC
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 09:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCAB1F21FE9
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 07:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CCE16F908;
	Thu, 25 Jul 2024 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SyVTW0Dz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF07171E5A
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891817; cv=none; b=qkD7Bhcputw9Ue5XczUL6XtdWwjRu/YgMryblTBdLpb+MzF/RnibTP9033/Ku0WqtocHpwE/QgzpgDJNuZaj68qogbPYptbxWMUIEqmir2WX+gE5ccdCiWXD2FsN9COu5QpLl4w89zxxlyvttUyDhepXEJRL7AaZ1ceE4oPWFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891817; c=relaxed/simple;
	bh=MSC5W+q6VGKGp2s6tNlTEFT6oyT1kWGTUgHFLbaIp4o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kvKQop3W+xyYzSXraK91lnyYULBb/voeowfLd8FpghEz2UHsQZ2NCa3rUkQEAHnLKfVYYf67lBEJi6MuXBbaQ67+sqZ29tbFlHxc+UNCn17ngv64uSf7HTuNViUksmr6REhviDxrsi0j3p0XTrWlBdAAITSMxz1jyW/aCoxtTSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SyVTW0Dz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721891816; x=1753427816;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=MSC5W+q6VGKGp2s6tNlTEFT6oyT1kWGTUgHFLbaIp4o=;
  b=SyVTW0Dz1X4qRr+OMpGui8cAm2Ti6hQck0ZgGJdTJCYDr9zb7afngoNk
   cUqd7aRIyGa/q7PQSIztT9UoHsXsDbWShbL4B/9fn+VulYL49x8zlTEVI
   oWtaPaIPrTdsTui5ZnYIBUwLR5EgjJnfSkLATA230VHiVWYcGXxPMGT3b
   p+DbqDmtit3TJoDMgKJ66IG/GnVfw/AhkKalyRbvqozBYBtNCXUJO1YU+
   Fs55krDqBwiIPMIU9/P0nD1TOZocZolm5drmX+imgyDFKr30RYvEizP3F
   LgWlBi4FvEOCYPrz+3TL0VqA6VbC4xWefcBW4u6DkEy3vMjbZtGQSeTz9
   Q==;
X-CSE-ConnectionGUID: l1G6IVf6SiiPD2Ld08lTgg==
X-CSE-MsgGUID: qONJeeKWQD+0Pa9NkpTNqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="12705108"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="12705108"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 00:16:55 -0700
X-CSE-ConnectionGUID: PxSWNiH+QrSxwBIWoIRnxg==
X-CSE-MsgGUID: IrvJW+BuTYqFdE4BVSo8lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="57400638"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jul 2024 00:16:54 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWsia-000ns4-1U;
	Thu, 25 Jul 2024 07:16:52 +0000
Date: Thu, 25 Jul 2024 15:16:11 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net V1] net: phy: micrel: Fix the KSZ9131 MDI-X status
 issue
Message-ID: <ZqH7u2ZXH3nzqIsn@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725071125.13960-1-Raju.Lakkaraju@microchip.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net V1] net: phy: micrel: Fix the KSZ9131 MDI-X status issue
Link: https://lore.kernel.org/stable/20240725071125.13960-1-Raju.Lakkaraju%40microchip.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




