Return-Path: <stable+bounces-110938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D3AA2068B
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 09:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441963A3C51
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 08:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB131DEFF5;
	Tue, 28 Jan 2025 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2+H+eD+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD221DE891
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054281; cv=none; b=AvaZCIOFk7GGroeQpBQfyMkt9RkkdPva2mrQaoDJ8lDM//lxqCz0pzW5o9TriZPpnDdqluqdGoXwyMm4ry7AK3yj/XTgMzn1z35oguZWDDdhdWhBePc/soe78sw2UciPkyvhxiUYsUOauLrH8dJNUeTQv/5ecTjBuL0/OhZssX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054281; c=relaxed/simple;
	bh=A+Q8O0o26jlQCvbSgY1s0bS35Mbjzz2jRwm0usJi3dM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qnxCQdPK44nagtbLXOmMRm9X+L7fw4Jn9WZxFsevIE1xF77c0i/9xSsvA2fUwN5YrG62wczXdsHjbCJ3tOsOMnu5ZhDRlJBnyQ0UaLQxZ6K5yIsSYKB93OAp4SH7kW0vRyeAuwYiEom/DGjfTxWMtEHv0lQ9qTJi6xLVSnDCK1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2+H+eD+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738054279; x=1769590279;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=A+Q8O0o26jlQCvbSgY1s0bS35Mbjzz2jRwm0usJi3dM=;
  b=d2+H+eD+MzsHYpjDiXQXo+A0zCFjMxpCiaK+Po8d5sQQYzQ+bDLBSgU4
   xZ7rcZIOynlKImlFc1jJFu9ocDgtmnjEm0/928ig6QN37hQXgNIsUWsKr
   ukG3DpIGeoNC+gLrkXnd5zPGzGmBfYpAwqmgOXgzGg7gH+cADY+sslQ0R
   9wAW4i640n+kN2pQPg19liRhPrqrXWn5WxiqQFAdbJaIYpmbdPDBn/KZW
   8mU1Xi3m0TUtH9GJ7q4+GKNKcy5PKYUYqwclqj+1iNqx1ASowdo6LD0vw
   8ozn6ZVlPIpP4nI63GFF/FLcaCviQivUixurvKbK8cDCo+FQFbm1EfrRY
   g==;
X-CSE-ConnectionGUID: TG1xOrlOTvS6q7cEfgKY0w==
X-CSE-MsgGUID: K51vFe5MQb+2nxWSGWp7Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="26129873"
X-IronPort-AV: E=Sophos;i="6.13,240,1732608000"; 
   d="scan'208";a="26129873"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 00:51:18 -0800
X-CSE-ConnectionGUID: 8tNA1nh/RI60yr5ArAjXNA==
X-CSE-MsgGUID: /mGIgVTlTEqQ4Y9LfPDldA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="113649185"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 28 Jan 2025 00:51:17 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tchJS-000hcJ-2e;
	Tue, 28 Jan 2025 08:51:14 +0000
Date: Tue, 28 Jan 2025 16:51:08 +0800
From: kernel test robot <lkp@intel.com>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6.12 hotfix] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
Message-ID: <Z5iafG5Y7LN88lEh@fbd72656772d>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128174938.2638-1-42.hyeyoo@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH v6.12 hotfix] mm/zswap: fix inconsistent charging when zswap_store_page() fails
Link: https://lore.kernel.org/stable/20250128174938.2638-1-42.hyeyoo%40gmail.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




