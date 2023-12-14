Return-Path: <stable+bounces-6729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFCD812D3B
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 11:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9C51C20AE5
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 10:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887A03C465;
	Thu, 14 Dec 2023 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYdAzH3M"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53CF106
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 02:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702550558; x=1734086558;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=V7IuKL/SSyamqX/xSrLW5KXDTTl9FQjW+VnJq5UOCVs=;
  b=ZYdAzH3M6Bl67t/4RURj79QZ5S9Os+XovPQFeeIeNXqU0Th2fI3Tj9Ku
   W1K53jtF2UmWRZOrpTgrHxw80VrI4gXh2G8iYpx1litDfctfCpVfCGMCw
   xQBo1UwfTVj5FGklc3Yx+24iJSKTx/jAc5/KWH5RhXQd8QccGp+u7tX5P
   Ozu+Ds0KF4NyXMGOic1NUt6gmiAh0ntNf4oc+v+WUJOEAnB5WWI4Y1hfz
   tHy1QiifcBBREUkqMpO6LfyGo8zh1Y+BdP5J7d8/BZ0/ywS2XzkmTmQKA
   baTe0QSkdFlT5u2MPA7qzSLndeP5wKhvt0C5PKm2GIytPWL6zn9CP1u5U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="481297798"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="481297798"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 02:42:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="803243774"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="803243774"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 14 Dec 2023 02:42:36 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDjAo-000Lvb-0J;
	Thu, 14 Dec 2023 10:42:34 +0000
Date: Thu, 14 Dec 2023 18:42:20 +0800
From: kernel test robot <lkp@intel.com>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] regulator: qcom_smd: Add LDO5 MP5496 regulator
Message-ID: <ZXrcDFV11ih830s3@171f04e7aea4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214104052.3267039-1-quic_varada@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] regulator: qcom_smd: Add LDO5 MP5496 regulator
Link: https://lore.kernel.org/stable/20231214104052.3267039-1-quic_varada%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




