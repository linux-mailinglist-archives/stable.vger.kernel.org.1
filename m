Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480487AA0F6
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 22:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjIUU4I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 16:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjIUUz4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 16:55:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3A4720F5
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 13:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695328400; x=1726864400;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=iLjy9nWYiDfEjO8IDkKLFjNEHW4QIXVu6B9F4PvQ0jA=;
  b=SSsvzcfwKEM3zMwNEfhGnAz83bS6ZgT+k55biL2jL6S9Koon+qYH/jnG
   MDjF4BGC8wX0Q6H5T8Qz0jwUcRa8DLJJV7RUmgVaIK24QfTIadob9EXTs
   e1dQIGaldlqxVnsJV2lMXUxG5cmt28m5OWCHuYdY7OqbjkDmCFMsEl2Ro
   mWnbskKIOO3JmTzLwXlztRxWGo2aGMjS5xdyG5odDBbRy64uyulLxjfJv
   XGEBW2Gvk2Fbgppc1JGNK+AGxMJbSf95vDtW3bBXQ03TtaCCfK1LlzsuH
   76/kp9bmdEHmJk3Mu5I0Gv2B8U4SKUd+l6yLDIkZ5BCNDKGP8FVZbWuvE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="384496511"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="384496511"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 13:33:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="994237709"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="994237709"
Received: from lkp-server02.sh.intel.com (HELO b77866e22201) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 21 Sep 2023 13:33:19 -0700
Received: from kbuild by b77866e22201 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjQMP-0000NP-0Z;
        Thu, 21 Sep 2023 20:33:17 +0000
Date:   Fri, 22 Sep 2023 04:32:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] block: fix use-after-free of q->q_usage_counter
Message-ID: <ZQyoUx9NpWfL4ED4@a36b5d0e9c41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921182012.3965572-1-saranyamohan@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Subject: [PATCH] block: fix use-after-free of q->q_usage_counter
Link: https://lore.kernel.org/stable/20230921182012.3965572-1-saranyamohan%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



