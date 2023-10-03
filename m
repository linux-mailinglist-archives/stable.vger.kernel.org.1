Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D96A7B7531
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 01:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjJCXij (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 19:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbjJCXii (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 19:38:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DE6AF
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 16:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696376315; x=1727912315;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=iR69J5Rz1bvKe+1Wiwx3rNhfw9Erpqr44/gXLQ3m50Y=;
  b=X/7ekxaAKFjA8YK6l9wLJIggJzN3y8+z3An74rJja7trEodAp+BFMdG6
   cEtf2T+mXxUmONlv59/Dd8+Qju9ZPLHyMyEPcZXKARlF00+0mYW70APq8
   VuJcWxN5nhKBm+jrp92WxRGZvhb5MgwO7Qs79njQWjlph2+cavkX9CHbW
   AQTaz69kCYhxzTP7gkkDY/tmCGjPmaT46tCUmeW0DUPoF3O2kprQHMfjc
   mJ7EKvWS3Crz0sONDCBBvMQQxtTdUfGqW4p0GPqZPOnq+zlnbIz+3sqA6
   fxwAOfSiOZ0rJk1qZ5XoVknZh8J6Dvs1/ojCagtC8yyaqZYqnxTdyuNoB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="4568050"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="4568050"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 16:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082211072"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1082211072"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 03 Oct 2023 16:38:33 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnoyE-0009nm-1K;
        Tue, 03 Oct 2023 23:38:30 +0000
Date:   Wed, 4 Oct 2023 07:38:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH][6.5, 6.1, 5.15] iommu/arm-smmu-v3: Fix soft lockup
 triggered by arm_smmu_mm_invalidate_range
Message-ID: <ZRyl2w4k9dYQB70T@f61ccfac960a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003233549.33678-1-nicolinc@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html/#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH][6.5, 6.1, 5.15] iommu/arm-smmu-v3: Fix soft lockup triggered by arm_smmu_mm_invalidate_range
Link: https://lore.kernel.org/stable/20231003233549.33678-1-nicolinc%40nvidia.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



