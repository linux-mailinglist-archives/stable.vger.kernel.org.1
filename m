Return-Path: <stable+bounces-152637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8038AD986D
	for <lists+stable@lfdr.de>; Sat, 14 Jun 2025 01:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC283BE226
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 23:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010FA26B774;
	Fri, 13 Jun 2025 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DB2T1qG5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102AD2AE6D
	for <stable@vger.kernel.org>; Fri, 13 Jun 2025 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749855810; cv=none; b=LLiBdOm7L3SaWMvvAlLs5J6uhcUzpIrPAvPjezFhu1bI7hn1x1DgKAEEQaMiefajrMIZ9KvSNnXxRqLNX6fTqA/tV8sLNG6DL4tr2CAEBmWSCIneyLUa6W/RVN0IvEFPr3JuDnEqxRgce+tLroEAsxA/mJO3zAG3ttxj6brZXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749855810; c=relaxed/simple;
	bh=o9R/sx2f39J8GmkU6AoxxwG2q+QiRnlD3yDtxkYfVkU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PZZ2VjRIgYBknqXGZsMyM7aYP2UCh7zx8sLaqGaYOJR7X79O+amk3kdc5E47MiZ05UN61n3ikRFU0U6vwi7XglaWqx8nF0QKjcUMMqtPWpawnUeJ51+ikRqQLq7SEaLdOEoEIpTgf4DZlEiDRn5hL+Q3vXPeId3sJ2QLmEXd+O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DB2T1qG5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749855809; x=1781391809;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=o9R/sx2f39J8GmkU6AoxxwG2q+QiRnlD3yDtxkYfVkU=;
  b=DB2T1qG5JVEN6Z9J6CUCBbMy5QWHTPS70vMT7l1iN1M/5AzI1+X8HRxO
   HHHKZnci3Wh32XTO09/NMlpCcNU/STgBLFfP0MUPLXSJVI+Id1aheECGB
   PAVOw+gdz0gFSV+35bZFK9pgvhcAM5NFAvPcfJtNEs3q0Wt4vv3t30EXV
   YWnhfOYWYSEcZ+LxmGHdTxZhxuSP8UaO/CvTn1yPUBHipBs/AAQ23O6d/
   C78zhwslTtEMlHsZobOYrDfLPXXHd7HEDVh5iJN79fMjw2bWTTVxJXLRS
   Pr+HVge2+L4m2MUjNl4Wrk1nACUhcXKXWpewGkpQmpr46MV4Rx/pbrUFI
   A==;
X-CSE-ConnectionGUID: 7xnm8Ud+TVmtEcPGcq+7cQ==
X-CSE-MsgGUID: AxaHx/d1QoKqyjSYqVe2gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="51194773"
X-IronPort-AV: E=Sophos;i="6.16,235,1744095600"; 
   d="scan'208";a="51194773"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 16:03:28 -0700
X-CSE-ConnectionGUID: yAhMgi9KSFeiRy48GcNfkw==
X-CSE-MsgGUID: IrWewGDvRe26Y8m+vQjKUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,235,1744095600"; 
   d="scan'208";a="148485482"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Jun 2025 16:03:27 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQDQi-000D42-2q;
	Fri, 13 Jun 2025 23:03:24 +0000
Date: Sat, 14 Jun 2025 07:03:12 +0800
From: kernel test robot <lkp@intel.com>
To: mhkelley58@gmail.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] Drivers: hv: Select CONFIG_SYSFB only if EFI is
 enabled
Message-ID: <aEyuMCuFsZ981cEr@9978228ff6ac>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613230059.380483-1-mhklinux@outlook.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/1] Drivers: hv: Select CONFIG_SYSFB only if EFI is enabled
Link: https://lore.kernel.org/stable/20250613230059.380483-1-mhklinux%40outlook.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




