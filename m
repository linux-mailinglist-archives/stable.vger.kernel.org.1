Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE277EFB13
	for <lists+stable@lfdr.de>; Fri, 17 Nov 2023 22:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjKQVxX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 17 Nov 2023 16:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjKQVxX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 17 Nov 2023 16:53:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5B9120
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 13:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700258000; x=1731794000;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=XfRK9CbmnDT/JoiBfxphuvqDLe9o1PMhJ9EfQAHyHSI=;
  b=Qqkn7u+oBvZ7EMt961BQHaXFd/eZz3BFFla58CbLq32iJlEmf21S/d8Y
   jLiwSkchrA6MolSJnfHj9/N9vAmRa22aHxUYXFoSsEbRTcbr7PrsKItvd
   Ckgi8x9RJHQTB+xEw2L5Vjf3Oj6xCgQhpXi1SrR0HTfCYd/RnTrUD9PH7
   4p8ofrwHmkXmSMzIpBbtgqVHLzpz2xt50Lw1Hid66MwWQ1DiexffDk9SB
   nro0JfTaFAdBzZN35KbfuLttlwHn91AJswhvEHimD5/vbcQO1nglq/BIz
   b0fMc1V5hDhT0ttoHy2sUMuSSshRj77I/x7vaAinRXFXS4jKGG3Pf0fOF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="390233830"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390233830"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 13:53:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="794939787"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="794939787"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Nov 2023 13:53:18 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r46m4-0003Bf-1G;
        Fri, 17 Nov 2023 21:53:16 +0000
Date:   Sat, 18 Nov 2023 05:52:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v7 2/3] drm/panel-edp: Add auo_b116xa3_mode
Message-ID: <ZVfgteWalvTIXj0r@6473735b5665>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117215056.1883314-3-hsinyi@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v7 2/3] drm/panel-edp: Add auo_b116xa3_mode
Link: https://lore.kernel.org/stable/20231117215056.1883314-3-hsinyi%40chromium.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



