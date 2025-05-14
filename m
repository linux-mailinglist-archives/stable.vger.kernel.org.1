Return-Path: <stable+bounces-144354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D6FAB6878
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 12:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8726A1B67E08
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 10:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1869426FDA5;
	Wed, 14 May 2025 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHQ+h9Du"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1A26FD97
	for <stable@vger.kernel.org>; Wed, 14 May 2025 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747217497; cv=none; b=MrD28V2K4ZOs8KcY2rCb5RtUgZEVfGShvxwpiS4Gx2djxHUMGuW5voDJwOArqpANY9B3c+VrZPtMWzkkTMzVkiVFgUopqdSYYkpOLFqRSm2ppr0XytclpbXfPxmjrlUTUJCu/oGjWOsivnCcKHFsvqqkfrJZ4yclbwPjyKtJGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747217497; c=relaxed/simple;
	bh=4Vtds0hwI3LDmk/86DMFZX5cXzxYcMtpjbPruMi9Z0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gcPo5bs9ZIqQ6J/b5pxl9uaJaJV2hiLpz6pBm0JUKOLZAT37PZSdtm+axgwzOgLECmW5Y0aDEoMC4AIimH1AT13GNoiTyYEoV9Sq3YIH3mA5jfGOe8aQYc9f0xUvKxISUhXike4YoOvgTCOjhd9YYzcB9T1Q/YQ5729aQl2jgQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHQ+h9Du; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747217496; x=1778753496;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=4Vtds0hwI3LDmk/86DMFZX5cXzxYcMtpjbPruMi9Z0Q=;
  b=EHQ+h9Du2dcCPj9zhRcjEMvRFE70EFGJvlaAWJ+50YO5OJvkDZ+Wi/dq
   Cxh+s5DuWRj45noun4mFy9EaqyksMM8t+U7+KLeIlsJhwjr+v8+LDaYum
   jOn6qR2PM0xBLstogJjMiI07UrqY6MJ9GhWuRocHvHccjO3Ta8YJJU5Sm
   sua6M5HpceRiETgFQQk6wmbc45Wd92Tb8+IF5r07ckstLrUshaK87B/3S
   iPReNOXZ9Fy0FaOC1EJI0AL2WqimSJWc8+L+Q4gqSqZbzQWunaeVBvv8C
   T45prsOs4qB4f3XwdUxeO4pgfE52kR+B7qfEV3TaeaYqW+guujj2pvUCr
   w==;
X-CSE-ConnectionGUID: WtwbgJH/R7uen/tdBkpR2Q==
X-CSE-MsgGUID: BMptkgixT1Sw0bxiB7oi7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="60117528"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="60117528"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 03:11:07 -0700
X-CSE-ConnectionGUID: 1FCfArSySdmL73ocm+Ek/g==
X-CSE-MsgGUID: mnFUl/6WRv+AgI27p0/bhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="142028148"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 14 May 2025 03:11:06 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uF94p-000GxX-33;
	Wed, 14 May 2025 10:11:03 +0000
Date: Wed, 14 May 2025 18:10:38 +0800
From: kernel test robot <lkp@intel.com>
To: Andrey Kriulin <kitotavrik.s@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/2] fs: minix: Fix handling of corrupted directories
Message-ID: <aCRsHqG0ewwRUIt8@3b2125c66474>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514100536.23262-1-kitotavrik.s@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 2/2] fs: minix: Fix handling of corrupted directories
Link: https://lore.kernel.org/stable/20250514100536.23262-1-kitotavrik.s%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




