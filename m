Return-Path: <stable+bounces-69606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24468956EB7
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 17:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568461C22192
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE29145957;
	Mon, 19 Aug 2024 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kC6DFfsJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA57F347C7
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081271; cv=none; b=AQw2g69qiw17hmdS24ugKwsugnau48ay+J1S4f8juBqmxr1d6YUsXeJm3Qh+PnYwSWcU0/4ke/zZ3l4owb39hfQWmW36HqKnwK8dNK0e5IMQzzRASwWmVafSk/SQzwqokinBJorxYzq8NW1ZN5D5hYhKgjBljqgh3SwWsT0Urw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081271; c=relaxed/simple;
	bh=kH1afBbb1+woJl5gOCcjAhsXXauiHEE/LLBPatDcxdg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oJnfU1IKD64XNOVVmAEHZBP5MwWzsmEFj/9UR5qC64HMiYi7jR0kgkDRvUb9nkJR9actizBySPf0jsiTSH65tXTUIDKyrExrBlTYbJOBBquyAoHfDN7o+zgYRMF9oCKe3xgeEgtaGmpCZUyXkgvHdc6xoT+oVaNW7CCcA4TfHEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kC6DFfsJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724081270; x=1755617270;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=kH1afBbb1+woJl5gOCcjAhsXXauiHEE/LLBPatDcxdg=;
  b=kC6DFfsJXPcYX9XRY5WZBluZx34zlBGUvPnBVYcru2jqW/UlUhAI+mxB
   zLLtd9aMS5YgZETrkFelxkeSERPTJ9pN+UeuK6jq9xRd3ySDUIVUIVChP
   r2sNbYKkHaPw1d4zMTo+bYErfjUvqIza3YKiWKkDzU1hVmmshxgK5cyl4
   mwqadl9+7v5F4aEpD4RqBQgJlBHy9Y6fdu5G4Z1PLVz7yia8SU3RIzwMn
   WDXfaJn3SvB/1iJ6eFHtkqN0hfzc/FrHrRXjkL8z3u2iYQ92NfPgACG9n
   Bzh3pqDELI627EexAlniVIJZ4gPdfjW71hLUfM6xdH355kxitA0QPLaHG
   Q==;
X-CSE-ConnectionGUID: AzjqOfCwQ9GsoraVnB+BoQ==
X-CSE-MsgGUID: o2TJ+nv3S5GctgAtg1HV6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26202599"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="26202599"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 08:27:49 -0700
X-CSE-ConnectionGUID: 29NX9xPcTzaBnfpLrMt1Lw==
X-CSE-MsgGUID: QzZCDVEMTdqNm59Ad3kQjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64806714"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 19 Aug 2024 08:27:48 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sg4IM-00097U-0p;
	Mon, 19 Aug 2024 15:27:46 +0000
Date: Mon, 19 Aug 2024 23:27:12 +0800
From: kernel test robot <lkp@intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] remoteproc: k3-r5: Fix error handling when power-up
 failed
Message-ID: <ZsNkUG0zQcD5iukH@19332f7c2499>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f481156-f220-4adf-b3d9-670871351e26@siemens.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] remoteproc: k3-r5: Fix error handling when power-up failed
Link: https://lore.kernel.org/stable/9f481156-f220-4adf-b3d9-670871351e26%40siemens.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




