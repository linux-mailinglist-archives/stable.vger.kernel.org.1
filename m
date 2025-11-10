Return-Path: <stable+bounces-192960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 261F4C470D1
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 14:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D90D54ECD67
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8D13126AC;
	Mon, 10 Nov 2025 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B09CKsKn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B631282C
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782953; cv=none; b=qUQYDr4P4H5deJhCb17GQznX2bFPndfRWc0qSrm0N3tHUyJQprSinrKdV3PTlIJScP1+S2N2DnofG9UETeNT47ooi620GHJbij652H8IKb7Mp9nigYlWrqvdaPdQnoOs9FF8+ev0D9iWAo5KPtZIPuXmdQfbg1lu4mJnbAqXdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782953; c=relaxed/simple;
	bh=gW2ZOdjs69+a5A2fYMNn+Zk5oLIl6pB/BV3i3DzqR/g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pcpRBRSdY8uTMpuL4tCA1qGnrgZh2cN8kf5fwgwMiDxoIs5nJJNQV7FP/fnGKnkF+CadgfN3gZI49VxP/VP0fISo12duKeeffpZSRlY4g2zwZ8GXykU4nryl+Dx111CyKAi8GOJiwIpF6C3oikXwOrUok9SgtjXw0slbVTML53g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B09CKsKn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762782952; x=1794318952;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=gW2ZOdjs69+a5A2fYMNn+Zk5oLIl6pB/BV3i3DzqR/g=;
  b=B09CKsKnLhTf+Ulzw2N3hs2a1mS5C/xDnZv/geZNDckkkaAya5EZIeQi
   5PcfqUV6RdZ2yHQPpY5qwufZ/tx0FD6LA2/QjspAa6kK1M0Kuod++xemI
   ezuFEAzhe3KjhFMiuv4DsC1PQBpq7NmjXkqciGE25jSGQmfGDwgyVlQKC
   EY4Nm+FEDHWWicUNXR79ZBV7TXS2cPG8S9xL32/9Azx2c9iMebVfKm9ov
   gEsVv6umuBAjWYX0mIgik78y4g8GZ3GRFcMpZVOAkLl/PSaYIChe3HMD2
   chvWKWRd9PDVgvwiu+6TC8m2mzD23nq23xX8FnfmayFyM6wBJ83zoKUY5
   Q==;
X-CSE-ConnectionGUID: rCP8Tm32QEOwJwMvt+pe4w==
X-CSE-MsgGUID: eUAoJ03yQqKUoeSlDqPqQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="63837283"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="63837283"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:55:51 -0800
X-CSE-ConnectionGUID: TdTopsaORKGHoCToYgkMWg==
X-CSE-MsgGUID: 0KECLLQTRW+M2kqFKbnm3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188514733"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Nov 2025 05:55:50 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vISN2-0000Ul-05;
	Mon, 10 Nov 2025 13:55:48 +0000
Date: Mon, 10 Nov 2025 21:55:19 +0800
From: kernel test robot <lkp@intel.com>
To: Ilya Krutskih <devsec@tpz.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] net: fealnx: fixed possible out of band acces to an array
Message-ID: <aRHuxxHBpRnPmkGO@8d1a9004a541>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110134423.432612-1-devsec@tpz.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] net: fealnx: fixed possible out of band acces to an array
Link: https://lore.kernel.org/stable/20251110134423.432612-1-devsec%40tpz.ru

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




