Return-Path: <stable+bounces-5519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BBF80D3C2
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763CF1F219E9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 17:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FB64E1B9;
	Mon, 11 Dec 2023 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkaIBMVT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4697492
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 09:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702315724; x=1733851724;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=NJDZz+IhrsDXxnzUXmyxOSSzHQ1L12ZBRNk/YIoAIZc=;
  b=EkaIBMVTXxonWTh66eg+bqw2Ar4B3wJrllqDVPQbg8a1GHQlMMgLyZeB
   VHWSwblPKVpr94RHQvp3opPyMEcOimSeUvUEF6giaZSYgCjDdLvimQ4je
   c5iMf0Zs9iyFF2qc8nQ/hxZvzYPWBLk/cKPbdmxR+8r1IAyMEJxAFDsPx
   9+bGX+xzx9EM6Dko9tNpZWarzsmxTb7zbr2bbS1fBVHQ4SJCCpmelHCA9
   T1L8sUWpPpxR2g4d1yOOpmp9gMstU+uHhzT5NuOCO06nh2Il3Lf4S+BjO
   jgnGJgpwYMZOLqiK1c1fDyyRfUaRQU6Bl5U9DXY6/4dwheAvTBy9Z3yT1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="461159041"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="461159041"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 09:28:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1020326693"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1020326693"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 11 Dec 2023 09:28:42 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rCk5A-000IHm-0L;
	Mon, 11 Dec 2023 17:28:40 +0000
Date: Tue, 12 Dec 2023 01:28:36 +0800
From: kernel test robot <lkp@intel.com>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] ASoC: qcom: sc8280xp: Limit speaker digital volumes
Message-ID: <ZXdGxI0OrIUKrbcS@be2c62907a9b>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211132608.27861-3-johan+linaro@kernel.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 2/2] ASoC: qcom: sc8280xp: Limit speaker digital volumes
Link: https://lore.kernel.org/stable/20231211132608.27861-3-johan%2Blinaro%40kernel.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




