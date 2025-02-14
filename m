Return-Path: <stable+bounces-116435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDABEA3642C
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 18:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5355B3AF425
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 17:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8917726868B;
	Fri, 14 Feb 2025 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+VBxOKT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78728267F4A
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553230; cv=none; b=CpVzA0EMem+LWE+ZPwxervtzK9EaizSwCBUpMd51S1icMWHoQjBgQdy40G8F7xv0UIBbn8tfmfRb6isDv8MX0OTeUj7PArgUyOtG2PmQwrGie60BGKCBPTTrnUWBFDA6EzCb8DPwrmg2tj3rRzsTB211btD0RbhgPEJdP+2K1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553230; c=relaxed/simple;
	bh=7lgUyvT/2w8+/7lRSPAQ9Q9Ui90g3Udm6SZCWSScQhk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Viuj7L0gkaSfrWKNNiPxIKgnFsOJYXdwBAAgiLFZ7qcLX4vPfDd1pBABzv53GzbLmhM/9HiP+UfA+jCtUqZnWqLYwgCuJH04scsAuIMBXnOFeyVmoD0DcIL/UPR+v/g+HlJqduAudvj8cWHwIDXE0rs9GDKmsmJcbC0j+L5utp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+VBxOKT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739553229; x=1771089229;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=7lgUyvT/2w8+/7lRSPAQ9Q9Ui90g3Udm6SZCWSScQhk=;
  b=W+VBxOKTCZtEJzz7T03NoPtMycaYXOpMDx3gKMpVo3W5Vj23qRTJ0184
   2cPYp4bpuwN5VAzAx6lu31KQwPU4u7ELBvt4EIyu4MNtr/o0NFlxzQat3
   OgUVTfIdGB21uJZg225d6Ce9hk5/2jOwZ0ubQCKo1eMP4k0ZDohYPCSXJ
   v2RU9sxFHVwWQ5BzPq2ZbSrs9trgII+fZUWcJCM+ffrfPjdCHoDhVC9iN
   7QxXu8E2h50KUCA3JBIBw4DCTq3uVYU0fCxVsgcHHbVpY+eUknoOuLQeO
   UKvQgg7MnOseXD79gPIbaVVOu6KVZxQIBGV00cRI3XsFDDu1l/hVb3vPd
   A==;
X-CSE-ConnectionGUID: ZNx0uWLKQA2MaCtj19Fj/Q==
X-CSE-MsgGUID: wxYwcggpTPWMXKfQJO7VRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40016505"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40016505"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 09:13:48 -0800
X-CSE-ConnectionGUID: QUwumAKvSgCI0S+Iu74YTg==
X-CSE-MsgGUID: 0wfPIYmaT7igDBv39Y0CaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113370547"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 14 Feb 2025 09:13:47 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tizG4-0019vX-2X;
	Fri, 14 Feb 2025 17:13:44 +0000
Date: Sat, 15 Feb 2025 01:12:55 +0800
From: kernel test robot <lkp@intel.com>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] sched/rt: Fix race in push_rt_task
Message-ID: <Z695lyvrIE34EP6-@4f51b8f948e0>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214170844.201692-1-harshit@nutanix.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] sched/rt: Fix race in push_rt_task
Link: https://lore.kernel.org/stable/20250214170844.201692-1-harshit%40nutanix.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




