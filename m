Return-Path: <stable+bounces-146077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EA8AC0A87
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 13:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1A51BC6D0F
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 11:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00470288C8F;
	Thu, 22 May 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCc52wQh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D4428642A
	for <stable@vger.kernel.org>; Thu, 22 May 2025 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912900; cv=none; b=F0pKQeZ5BbwFLbHkmFVvr2rDCKpuqUsk9UwJENOCu4MpgnPuKf+P2pVsEbJW53MVEcQZGSnmdMiItMa2kIodg/D+kwwbegto4EPBYjWHVk6BAAA072UE+GpN9eW8YOXEENNKGsiG5wwsZZe3Il4jDx5J942hYvpMrEa2rAtlaG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912900; c=relaxed/simple;
	bh=f1VSk8kjSvPfspbFnVDATNH/tAbi2YwK6c9qb9OE8Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k6qVWL449uziTCxDKULYKoGdx8xnssOc/mr+u1cVEevlcHWhAOljcCaLT/e6vEvMZuUn77wqUM6Ng+JDr+6gYTTKTtRd3SofRbf3XIg1MohQ3zd6YfV2MioGxitIsLH67YlJWzayth8nIHfvjTei+cKwS8KoRDc6HIkgGwF6Sts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCc52wQh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747912899; x=1779448899;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=f1VSk8kjSvPfspbFnVDATNH/tAbi2YwK6c9qb9OE8Bo=;
  b=eCc52wQhE4roVoqZQq3CH+nLHwmYMr7Oc+Bc4gsysDTZ0qxWStCz8Gyt
   clZ1FtoWz///lnalWdVcc3ZHhOqYp+mFQQ6P3a09Dbh57+Ja7X0rnqO1C
   FDFpPm7vkdzwDr/k+RLADmZjoGlLv47q50cArOW7P3mq6n2WnTdcEV7K8
   P2i2ksPBvzeV20RH19nk8faHdbkEe5qW5fZh7NJGqDxA54OfC2nGObRV0
   RIZrI6xPCsdLcWcM+VV1t355VBnh/vvpMVdEmXJnZhqXgmK3JuktBjDGb
   o8Ti+o9rqPg0hZIaO9kSKtzCXk5eKI9kbVI/CyXpueQy7H8hp6jIAw8wK
   A==;
X-CSE-ConnectionGUID: geOB9lVNRSKW8xwayc/QDQ==
X-CSE-MsgGUID: Zwd/k2bZTl65pJ3uJa83bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49050017"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="49050017"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 04:21:38 -0700
X-CSE-ConnectionGUID: qm6F4TDZTcWN9VZ4jUnO6Q==
X-CSE-MsgGUID: qkUEDMlITTyZMKeEhrSaHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="141087547"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 May 2025 04:21:38 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uI3zT-000PGi-0S;
	Thu, 22 May 2025 11:21:35 +0000
Date: Thu, 22 May 2025 19:20:59 +0800
From: kernel test robot <lkp@intel.com>
To: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] iio: common: st_sensors: Fix use of uninitialize
 device structs
Message-ID: <aC8Im5vGIbQTFtM6@99c60fc626cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522-st_iio_fix-v2-1-07a32655a996@gocontroll.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] iio: common: st_sensors: Fix use of uninitialize device structs
Link: https://lore.kernel.org/stable/20250522-st_iio_fix-v2-1-07a32655a996%40gocontroll.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




