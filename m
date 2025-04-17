Return-Path: <stable+bounces-133091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B60A91C64
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A2416B267
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956921E49F;
	Thu, 17 Apr 2025 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JY0dNg9s"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8A51EB2F
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893323; cv=none; b=X1PQGB3XlKVk6P99cTpb3Kr8WOuDjH89tUrqcOB9Ma56yIlWvWp4PXG+774o/2/3n3UEU2Qey9UW1F456nsBqFMl+OvS+BgY1MIzUkiphCtlwd4yxLCR1YrrRANCWbn4yf3fU0QCVDUzQvdOsOpzJJMmMos3oq7g235iWLcMRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893323; c=relaxed/simple;
	bh=td/hbJ+RDA540jE0CPb+5Fv/fHhFErIOTIl77PT7yC8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UwVZdK5Dec6cE6a27PfH48+lRuXtXAEqFYt/5X8LpKUCPRhzfbfgPdNVLTVpWm5GPZyvlc8aNqPuHy1jQ3rLo+TiEp0CPorpMO/87K0965xu6A/ezL3oM1mr+g8zTeERORg9ct/UdzJFNT+PaQmCfb0Ihm7+2CUCtAuVGwW84w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JY0dNg9s; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744893321; x=1776429321;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=td/hbJ+RDA540jE0CPb+5Fv/fHhFErIOTIl77PT7yC8=;
  b=JY0dNg9sEX5unoQ+p5RxYVPf+9zK2DK9LI0vCWiTJTjtBBFBxG5mQ1on
   Vb2oVuS8b7dnoBDdtdy18T0zGdatW9XXTYzHwSgx0a2igQ+J4bVbvqKzJ
   x7QQ7KimUkds1JXkmMfh9bHd6Hrvr58PssG5b4h0p1tzHCeaqYjkffXbh
   awJEfEkBYa3ljaqrE7o+Mv8y37Rghv2OGqCNKPff+NVw099sx7vhHWKSA
   zUvuACeo2WicpFJEVIXjB6jvNQHCltXOFp6j9aFc9uNh7aLu3446gt1LK
   YIEZLzfg4wO7Z8LKDKkcVnSYmeFNSr4xBG5e5z8yoVmPA2699KV2+wj1O
   A==;
X-CSE-ConnectionGUID: J84ZKND7TKyM6ffm+USmSQ==
X-CSE-MsgGUID: FEAqCJtSRrmf7W2Rrxibgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="57862177"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57862177"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 05:35:21 -0700
X-CSE-ConnectionGUID: mZNAHNWEQ4qg0Blj4BXGFQ==
X-CSE-MsgGUID: CilCfYPnT5qLsvTFEVdV8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="130735988"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 17 Apr 2025 05:35:19 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u5OSb-000Mi8-18;
	Thu, 17 Apr 2025 12:35:17 +0000
Date: Thu, 17 Apr 2025 20:34:17 +0800
From: kernel test robot <lkp@intel.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 3/4] arm64: dts: ti: k3-j722s-main: don't disable
 serdes0 and serdes1
Message-ID: <aAD1SRN8CkYEvIof@4cfa58227a13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417123246.2733923-4-s-vadapalli@ti.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v3 3/4] arm64: dts: ti: k3-j722s-main: don't disable serdes0 and serdes1
Link: https://lore.kernel.org/stable/20250417123246.2733923-4-s-vadapalli%40ti.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




