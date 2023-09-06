Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A04793C7E
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 14:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbjIFMVN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 08:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjIFMVN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 08:21:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8291717
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 05:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694002869; x=1725538869;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=fHYfpkIsS+BNTwBAGWqNHnu7ZNRge45RP0BTI0HTUWk=;
  b=HGItOAVa0MI5REtrSFw5oQHgPlZFf/jmZ7tFPPhIqPRwrOtIJBQs+0dq
   I3OpdeAFjOBAwvKtaQ3eSNP0N/495llSK883YyeYn+LPtKNvbdBsDZdvL
   o+wIHGPm7UlfkYtReboawK4Gl2bIuJSaapfUYE2Bz/UyY1mMq7q6Ft8Vi
   eads9Aj0clZcndrcWICpN4k7Kkgr8Qa3MOxF8YXhBg6mQwA3uMR2zn3zp
   sbO/z3+AStQ1evZlGs5/8uMFnLIhmwJ+MZ40OeiGU8og4+LofdvurLaXI
   Rk5ds+6w617Iz97hjWEWob/ek8hybhFGWDNBxgRSEYiqtHcH6lydKKV/s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="356536361"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="356536361"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 05:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="806985490"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="806985490"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2023 05:21:03 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdrWn-0000CF-11;
        Wed, 06 Sep 2023 12:21:01 +0000
Date:   Wed, 6 Sep 2023 20:20:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Deepak Rathore <deeratho@cisco.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Message-ID: <ZPhuqHNxhF8AhdL4@0091dd92274c>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906121525.3946250-1-deeratho@cisco.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Subject: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition
Link: https://lore.kernel.org/stable/20230906121525.3946250-1-deeratho%40cisco.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



