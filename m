Return-Path: <stable+bounces-200820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B78ECB6EC0
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 19:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55CBF3001C2E
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 18:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FEB27B349;
	Thu, 11 Dec 2025 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X44xZnwe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C33064A5
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765478323; cv=none; b=kRQeMGYuhuJNnujeMSMk86TM+RlzCt/lUWJR7AkEEW742wBbBpEw9XqzugiKB4Gj9WrePdRJRUV9m0xHNtesOYF9taPX5YCWPRX4jdvrKndRQmz2ecJ3aQVOh1dfJqnQ+0Frb3tze6B0IqOqYBOv8G5I5lyUdpt/BauX+HOjD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765478323; c=relaxed/simple;
	bh=55zxwtNCCQ5okfFDxnkDjPzE6nkcwOJs8l0+79xvA+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rCKLeuF7UBxYK0zElSfCjczBTf8Ve5Igu8iXgU/XOxv0j2fcEf8B0dQTec2IsswHs5/CS3E6sIDh/CpmZuHWVakYJPNdc58WQRZ0AvE+YNrkUzlHHAp38vmJc0SFp1mePjmgtGDHq/+AH2x6Pq9BVHmtm8jBofJR9YHKnv7VwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X44xZnwe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765478322; x=1797014322;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=55zxwtNCCQ5okfFDxnkDjPzE6nkcwOJs8l0+79xvA+A=;
  b=X44xZnweQfHl7+j1xi3GTqMnMfpqR1mzrRNxrfu1ObBTxsjj1cAGDuAF
   ctkJXqhA1UikxFSoQKFZRklqJExIJfq9+otfzZTExuvZ8EbVwOCKWE26E
   dsRmAouXFDTn64HF1dyKKqv7XLJk3u1yl3EzYP6GXMjcO0SfC0qWRYH/p
   FN3V7JAHVvhif+ObEiG8kkYHWcNVuMBCtnm5L9HX8VUPn0/U9TISjRgDg
   0rttROSncTy0yl6pu5D2dXK777H+V7wGVpjwuIP4piojEjaz5YnktSDqi
   w2wGUmm/Q+CbJkTOUv29Gj428k4DKsxILmALS2cMKYGe0GxZHHVKG7AJg
   g==;
X-CSE-ConnectionGUID: OnMgXedsSdWVVY0UBpUn8w==
X-CSE-MsgGUID: SqK2ntUUTK60fi6FUY8LNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="71335338"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="71335338"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 10:38:41 -0800
X-CSE-ConnectionGUID: QPpvmz5mRfuB/HqtxXsnZw==
X-CSE-MsgGUID: ABBCSylSS9Wuq6vy5e9rAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="227512390"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Dec 2025 10:38:40 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTlYk-000000004yb-2KDZ;
	Thu, 11 Dec 2025 18:38:38 +0000
Date: Fri, 12 Dec 2025 02:38:32 +0800
From: kernel test robot <lkp@intel.com>
To: Fernand Sieber <sieberf@amazon.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] perf/x86/intel: Do not enable BTS for guests
Message-ID: <aTsPqAjuZDLKLJKN@7da092942895>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211183604.868641-1-sieberf@amazon.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] perf/x86/intel: Do not enable BTS for guests
Link: https://lore.kernel.org/stable/20251211183604.868641-1-sieberf%40amazon.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




