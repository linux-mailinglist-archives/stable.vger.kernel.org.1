Return-Path: <stable+bounces-169939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 673E1B29D04
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942B51884B2E
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E137224B1B;
	Mon, 18 Aug 2025 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDz86RfT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01FE201269
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507669; cv=none; b=TaWGHtdcbC0cvYJr5OiVxQ5+LMk6NzLLgVOrzmypaaSyp0vuo9UrOTwXRZhlwQDkxc/TV0LhIMOLtJuVfeSbGXlazTBzXW0xGskHPBOvU4f7lQFQ8av4VgJRtcIboshCA4EEDR9IfnwqKD/x7AuttJPZ23kB1TSpGxbT5lRXUIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507669; c=relaxed/simple;
	bh=B5PWrvTZ+veG0REafwMSKFNRFMTXgweAjiWUTY6wdTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=smfwNiduHDpYfRVHILMxtRO7QpxMSRtlTUMOq0GieSoZVvQaC6H2RFT7DXjryq0qJZHMdSQYcCvs6YmtCURvHKKXRJ0xbmL4S5eakcq3DmEHxnmwPZHTtIWGNL3awlVkrs5AK8F6bVKmVTCYzoDFAzG3bLveK7s5FMInvXfCD7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDz86RfT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755507668; x=1787043668;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=B5PWrvTZ+veG0REafwMSKFNRFMTXgweAjiWUTY6wdTQ=;
  b=KDz86RfTdWVpeuKiP8+0sgXncseW+BvvJEGVs+aQP2h/lWysbeGNZvX5
   zV4w+gq7vKS5BssRFN2aQEdEW85XMGC89OO2GU27oKXcOe0cbsjMql9k4
   3+PwGYrkkktsC1TqGiXHCPyyoK/k3Hv8fd7HXDv6F1/5oEs7fLhH12zyf
   2xyE2twPAJzj7wMJotGuwkStdSs8NCKftQlmdGVQQ0cBJqJ2P3aN66xan
   aLnczkl4yF0336yIvIOBSSvRuk0XcaudtIGly2hdFa87KGNsiywVkKsVJ
   S/giduU5c577CpCyrYRsj3VsUn1MYDRRrGSyp00Fpq0fDrRc9pSKPD2q1
   Q==;
X-CSE-ConnectionGUID: c88P3FffS1KGL1JNl4GzNQ==
X-CSE-MsgGUID: DwUXw84KSme3QUByuUREJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57832561"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57832561"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 02:01:07 -0700
X-CSE-ConnectionGUID: HvVxzdK/SzSFhTe1Ej1tZA==
X-CSE-MsgGUID: GXMIfCQTSkK8i+o49ttfYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="204690744"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 18 Aug 2025 02:01:06 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unvj0-000E51-1r;
	Mon, 18 Aug 2025 09:00:35 +0000
Date: Mon, 18 Aug 2025 16:59:56 +0800
From: kernel test robot <lkp@intel.com>
To: Gu Bowen <gubowen5@huawei.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4] mm: Fix possible deadlock in kmemleak
Message-ID: <aKLrjOz3b6ovQRbL@769e0d9fd271>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818090945.1003644-1-gubowen5@huawei.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v4] mm: Fix possible deadlock in kmemleak
Link: https://lore.kernel.org/stable/20250818090945.1003644-1-gubowen5%40huawei.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




