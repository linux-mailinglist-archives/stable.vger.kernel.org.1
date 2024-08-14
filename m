Return-Path: <stable+bounces-67655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F204D951C8C
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 16:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5142832CD
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 14:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2C01B29C0;
	Wed, 14 Aug 2024 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhBdQ/l/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5171B29CB
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644363; cv=none; b=AsqcXDGep537l/VVUnqr6lxf152VHLQmZOJ2vN/D5IO6d/wKSmXf3gfQmkhOkGPSZUwkj7K8dhJJ5AzhuP+2yG8oZ97k4UJommX4a69UNyaX2hMY9BAUK48GOJCZO3J/stWNqRDXMiNhqJ2GiP10EV2UStcVwhEV/yGM2G77wX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644363; c=relaxed/simple;
	bh=mpuZAFPN8vkPUMDfNWSsdQeOXoI9vdU/HIgWc76FyIE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LgSjd1MTeWqKImIoKd6UpbgQUsHsqukdEzgILkT+FlDmK5gk8by3ueSELvKEifs3Mmm+6XYAlElViVoF/pphKACBYvpkxgVU0On1pVFnqJ68JLLUo9oVBLb+LTfullAN8o2yqBDaZgqUsIt8cfwHO7nBJzcuJr5+QNxYcapadHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhBdQ/l/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723644360; x=1755180360;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=mpuZAFPN8vkPUMDfNWSsdQeOXoI9vdU/HIgWc76FyIE=;
  b=XhBdQ/l//PKhQ5f02UdMmOzn6XjKQw5wfFcKjd94Dvrgfwd+wwnB1ZG+
   Ut9fmA+DafljU1VGUOpoasPEr0FAGde9AKgD9VH7AtRK4hQdTCXAI11aE
   Eys+O7WKR7xFhvEOPntMUcuuLdO2tvIi84NmXmQb1lJdg9yMWKZ9p0Mw6
   hwJAtPoPU4JnmGIk35nwTjDsljRZbGL8qWENIOQBpPQhw4souFR/ITG6t
   a78WO2xrDw2Le7Wg2B9sx/Y5THmmfzrsiSIkefoQ6e89L1JewEhanCyBk
   1/swfwTgQcTkWXRxWbpfWvpp682kQxVHA3WSmNYIPjjCnoCuUHLeEVh9C
   w==;
X-CSE-ConnectionGUID: WYft8o9USaWU1/cFbCqTDQ==
X-CSE-MsgGUID: 3WBGjDKgSDeTx9HkgWsI5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22031358"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="22031358"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 07:05:58 -0700
X-CSE-ConnectionGUID: cfcuYBrSTv2R76S2+Fr9fQ==
X-CSE-MsgGUID: Zf39/lerRLKBHFB9amhz4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59026981"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 14 Aug 2024 07:05:57 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seEdP-0001sM-2j;
	Wed, 14 Aug 2024 14:05:55 +0000
Date: Wed, 14 Aug 2024 22:05:44 +0800
From: kernel test robot <lkp@intel.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/1] nfsstat01: Update client RPC calls for kernel 6.9
Message-ID: <Zry5uJyCB2qlU27z@6301b87c729b>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814085721.518800-1-pvorel@suse.cz>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/1] nfsstat01: Update client RPC calls for kernel 6.9
Link: https://lore.kernel.org/stable/20240814085721.518800-1-pvorel%40suse.cz

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




