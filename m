Return-Path: <stable+bounces-176598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBD3B39BEB
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 13:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24390188E3F4
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 11:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BBE25EF98;
	Thu, 28 Aug 2025 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5lWBADp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7167205E2F
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381579; cv=none; b=kIkR8jXW3MjsvTZjMId6kKX2CHKIgnM0b+oDupkOkl7NUMF8dLCX23a9bFPEsxZfXIwqwf/KCflpcghHj++5oI5WwdVyzPgXKc6VOXI1y+s6Zj2NSilD+NLvJCO8U0zhE3FYWsgdh/c2WILNhc/cm27sjeCIVrsb8p5RmB8uYQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381579; c=relaxed/simple;
	bh=LpKganOcvojsrX7TySVPBzcgIg2HkBZx0zqnulQS2/U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gkqxlfPLBmRB4BuwVfNFNi4UBr0gG8uoGdR/Ofamx+96ry7P6eEZLisl9SPwHnj1rk61HbXb9izcKs1cK2+1M6OlEXhJsb1XuikmWppUWbsNkuSsZPzt5AH26+eDvmJhk8e9AfEHpu5T74qvboS1tUbP0AlO6SPCp9lAVbuzw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5lWBADp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756381577; x=1787917577;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=LpKganOcvojsrX7TySVPBzcgIg2HkBZx0zqnulQS2/U=;
  b=W5lWBADpHHpQdpca9O5cAul3MF5hW/qRO7thq9L/vRzvpQwKdPMpmAYo
   CIf8WF/ECykKMy5c2QXvbikpuxik4oIzrH83nYjx5ym4AjZeOeRqoDdrH
   aCUQDWxW163ZysdcfnlBLIMKPZn3AXjI0VRardAvf8gGl5NS7unj5iIr6
   uk+VUm0U5ihEbJrajEhDKEPsY2hN5RciCFDu/guti1hkd97onGU3RW8Ae
   b5xwApVd6Nm7VuLNXowWRC0bpQmtxitJnO+oX6HuJHtEMw/BLrq/s7CTg
   y4y40XEjA5iyNuobnm6ggWfZKtw7D3i5zz/okcy7in+r5E2DtqffamA5R
   Q==;
X-CSE-ConnectionGUID: 1m8P3vDkS3W1D3gsLRTFcw==
X-CSE-MsgGUID: sN8OtVqRTOqXJzdkaTApBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58590319"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58590319"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 04:46:17 -0700
X-CSE-ConnectionGUID: obxTyTBLSVqg7yyDTFD8kQ==
X-CSE-MsgGUID: U6ujH8DJSNu6jTEq1DdVWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="175385539"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 28 Aug 2025 04:46:16 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urb4N-000TgJ-20;
	Thu, 28 Aug 2025 11:45:47 +0000
Date: Thu, 28 Aug 2025 19:44:56 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net v4] selftests: net: add test for destination in
 broadcast packets
Message-ID: <aLBBODddUFSVxJMH@5fc77bca29d8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828114242.6433-1-oscmaes92@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net v4] selftests: net: add test for destination in broadcast packets
Link: https://lore.kernel.org/stable/20250828114242.6433-1-oscmaes92%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




