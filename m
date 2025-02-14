Return-Path: <stable+bounces-116418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25280A35F10
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 14:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C437817603D
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21FB2641C6;
	Fri, 14 Feb 2025 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bO5Ic6a0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1648263F4E
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539278; cv=none; b=sj3zGSgDHG6nYBPyw1Ssrd+RbpNXDNDL4q6r0/Bw18PFCef//ZzYNJy8Gn4F2F0F0vAknda7Yyfpt394XsEoAGP3+dRaBZh/9OW/VbHH6AYgEfNBHMZ94UOLXx7e592PZ5FXP7Fbadsu9p2DR6lKQE9ETZKSN1lyAdUugrZ8bZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539278; c=relaxed/simple;
	bh=bbkW/I9ztmZgI/e0AwKpxzN7KUiCMxygp8302sY3DIU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oNxzfG3r+A2lgYvWuQrqWtTJdFrIvDW3pDvfPLQao/dS8qhV4BSl9XlUBrHIuGNpSLFABro31gkhY3q3pDmzgJSiW7Qsj5mucG5S81K9JxoMRMLmvIjxRL//HazOBwFKFJUXTWYEoEpvDupyoh/6TbWQAoLOtAz2a6tLYqogLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bO5Ic6a0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739539277; x=1771075277;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=bbkW/I9ztmZgI/e0AwKpxzN7KUiCMxygp8302sY3DIU=;
  b=bO5Ic6a0jTj5hxp05YYrOziCiGcvEhXnd0zt3B9ZYlXTJ/I/M9ieTQeo
   YVi+mrOHOtUlut20hm2Wt/aiQDKT7GIXgvt8+01owKIxFG5DxB7mZH16X
   YadgCxbrl685ZLLmxZxzWsJASROxUpo0hDB6kteCrYG3K2obWQGN/Pha/
   0i1S27kUPZPT4rHZovXOp9kWW1bDVIYKBIWoBe6d1zhd6ncfnTk1pRm4n
   4Enst1f0mq0o0vrMZntTO/M2NdIvkIIoceWYIquzhFMq6u0syblfY8E03
   DYkwL9Eyuo8DVOmS/USI02aF5cftpG2iJ7YxIU/Ts9LpzQlwIzDt+WRUL
   Q==;
X-CSE-ConnectionGUID: Q5x8ReOsRlyVExO25hID0w==
X-CSE-MsgGUID: XTKbkCndTsmD2VkoB5h46A==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="65639872"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="65639872"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 05:21:16 -0800
X-CSE-ConnectionGUID: /oSxlP/5Tx2sBNlbAOCjlw==
X-CSE-MsgGUID: SmgWB3p1SWO1uukeC8VVLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118388825"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Feb 2025 05:21:15 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tivd3-0019Zz-0A;
	Fri, 14 Feb 2025 13:21:13 +0000
Date: Fri, 14 Feb 2025 21:21:07 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6.13 v2] fs/netfs/read_collect: fix crash due to
 uninitialized `prev` variable
Message-ID: <Z69DQ-0FtgJxueCX@4f51b8f948e0>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214131225.492756-1-max.kellermann@ionos.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH v6.13 v2] fs/netfs/read_collect: fix crash due to uninitialized `prev` variable
Link: https://lore.kernel.org/stable/20250214131225.492756-1-max.kellermann%40ionos.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




