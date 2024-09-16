Return-Path: <stable+bounces-76513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A8797A671
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 19:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058171C21482
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 17:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCE2142E77;
	Mon, 16 Sep 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBeka3HI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B610A18
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726506386; cv=none; b=ExxYegDk6SZnWmszsDklXmT+hh5Q8k4mjDHc3VbKjUmZn9Ve5RURp0JX+aRveXyfRN6wexOMvSCbtZrJdVnVqliYURooL3blhCYridJZIU+rKjtQC1xrHRXoAZpICHUD+aC/y8/LK1nbxkQOgME8MYCbIL5U43K/JWhyyPcneM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726506386; c=relaxed/simple;
	bh=U1mnWBtQb1ZiV8mOJDscZ1Y99BEJlPHKsHVdbhnUbyo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jzAY8q80/6jkUZHRLMvzotGLBRe/sYYkl5wGF1MaiYIBwEKlc3bZupLTK63hEWq1HmlPXfztvevrdVETbG+72sRasZqcV2DbedANgGR5FeBcFbhWnm2u+d7KRZaZszP3m1MvjTA5uDqI5oeyB+BdQcx14MBAqWm8EDtI22eXUeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBeka3HI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726506384; x=1758042384;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=U1mnWBtQb1ZiV8mOJDscZ1Y99BEJlPHKsHVdbhnUbyo=;
  b=OBeka3HI5tjmn5Ptkid1QIMJ+d+s25147lYivxCd3WnFtI2d4Nlod7dv
   +EwtXVE5N45Woh4a6eiznGvHiuXsuhSaxlHaAS29d7Azq452VQX1M8bb6
   asonozrGybu3kZ4MYle2psfIMJb0wbJK/wekiG0hEzJiwHuO8WpUObkKz
   S13QQCCpV644BsD6nfhIPY5W+4KjAHDgIib7ymv31XZMrmBsBPm9emEIK
   KRSJkeqyvCgYSjhzpXslzhH8n3b8EKcMw9TaBqs4ZdMiDFjXWTApxvDOq
   Kb+NqQNhqNZoX4WLcbr1fxp+bvdOGeo+DS5dpca1t8nbmbJmHYfDFHN8U
   A==;
X-CSE-ConnectionGUID: N9dYOrxbQCW2yiuuAjJ3xw==
X-CSE-MsgGUID: U4yTgVAXTWOLVYJr0TbaaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="35921801"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="35921801"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 10:06:23 -0700
X-CSE-ConnectionGUID: CNEUFBB5SE2gX2fh0PtF3A==
X-CSE-MsgGUID: qtt89Hp0QN+ANUV+3TZIDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="68802990"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Sep 2024 10:06:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqFB2-000AKU-1y;
	Mon, 16 Sep 2024 17:06:16 +0000
Date: Tue, 17 Sep 2024 01:05:35 +0800
From: kernel test robot <lkp@intel.com>
To: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] RDMA/irdma: fix error message in irdma_modify_qp_roce()
Message-ID: <ZuhlX8eeJhpKLU9h@3bb1e60d1c37>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916165817.14691-1-v.shevtsov@maxima.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] RDMA/irdma: fix error message in irdma_modify_qp_roce()
Link: https://lore.kernel.org/stable/20240916165817.14691-1-v.shevtsov%40maxima.ru

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




