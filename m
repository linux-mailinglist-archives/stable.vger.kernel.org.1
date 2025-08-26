Return-Path: <stable+bounces-173736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C7FB35F08
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEE53B303F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FBE3375DC;
	Tue, 26 Aug 2025 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fa78bA/X"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C1322DCF
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210801; cv=none; b=dnpt3paaojhr4mEQEV/Q7RoQU+rP9SBT+SXa1ZKVh6BI46bbeiJCph9I1QAVzmH4Evybs5fprVm4auRaRwpsp48b41pK2zU/x+WutqVzvBOFH6c00Ila7DZTlvipB/NXgfhMMQ7/Yg6Q/NTTBEsO8H9pyYVfDea12MW0CDShlrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210801; c=relaxed/simple;
	bh=6aREw1bHCV9KrJzMBj4OMKwm1bgr3aDUSaapGbfEHdk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MS1y8LZGwJlMytMvLap7vp2ZyxbuGFVC2lVDbouzorbT3Z9/15MhfQ5+pFuHtrDVN8gNL1t880VHnYY8XmFrZN8j86SfNqBt0Lcyj0B/UG86ssiRt8fOrVbu5+6VfRsmeXsjxZKoJvSdswjDw47mibUNXO3b3Gz4FTmG9Hcywzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fa78bA/X; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756210794; x=1787746794;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=6aREw1bHCV9KrJzMBj4OMKwm1bgr3aDUSaapGbfEHdk=;
  b=fa78bA/X8ZQRq/7g6+itJE2Tn0F6bM8ntH+g1hQIBHZkhCae+okJ7Ee2
   1yIkIpgwDcrplaIsVdUbs/XeLBKJyCoEgqgSw50mCeMGFAtkL8rqCCs36
   wyrb9Fjz+jpwQEhbyFyrzBvhsV8DvHz+YXCfMet+T0KPWKyWkeHNPEGM3
   5U2paU17iCyLvvd8tpjGgKH0JtAnjRv2bQg37WgMdvDTGggX1kYC/a1RW
   YcsRBg95WRw0JpgtInDdoY+ktFf2ug3ip4VqHdwGW9vxP8yZ1vTX41EUj
   UffZNujlqU6Fw4qwCiuJ2uXGQDBq4n6zLzgmf8SiVBzYUUt9CGhPaE8uA
   A==;
X-CSE-ConnectionGUID: VJostUlGRvGmyUMeqqU8cw==
X-CSE-MsgGUID: 5myXI1XxRbCbEHCHib5jFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58384228"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58384228"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 05:19:52 -0700
X-CSE-ConnectionGUID: soED8o4ERKeydM1ye2sWAw==
X-CSE-MsgGUID: yzbwzEmRSD2gzsmwyj73zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173872456"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 26 Aug 2025 05:19:51 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqse1-000PIp-0p;
	Tue, 26 Aug 2025 12:19:28 +0000
Date: Tue, 26 Aug 2025 20:19:16 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net v2 2/2] selftests: net: add test for destination in
 broadcast packets
Message-ID: <aK2mREroGgOwN4rp@0d8035a08681>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826121750.8451-2-oscmaes92@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net v2 2/2] selftests: net: add test for destination in broadcast packets
Link: https://lore.kernel.org/stable/20250826121750.8451-2-oscmaes92%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




