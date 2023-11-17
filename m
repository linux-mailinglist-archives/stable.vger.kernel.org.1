Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC277EEFE9
	for <lists+stable@lfdr.de>; Fri, 17 Nov 2023 11:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjKQKQm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 17 Nov 2023 05:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjKQKQk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 17 Nov 2023 05:16:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D44BC1
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 02:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700216197; x=1731752197;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=yJPsPhF5wclSrG0ibvMi58FrGM0vcjhtpxV3DNG0rhg=;
  b=N6VsVOYDfjOQFFZ1HlLwp/bG4qNi+QCUqxEUWM13lHK5+JfKCF6Bnzj0
   icR8RfMxHK0tsFgAYSxQ5nYbNeHVsClz4p3rhgHG3ZudJcn7gpWL0Qz2u
   AmbV09CTmPaJXZPi8Y2Hnn3qwRmuXR+veY1/GgRZ0/h6CDHac5AoaecKP
   gMXf3Ri8E8jGoNrM4iJisqVQQASG62m21R5esiehebabH3rYxs8QUPn2u
   10jAh4XuCgIrj0XU5DjlCtCMPj+7CgWapWgB428XpKSk+BFmLv8uF2/v/
   HtMPUExCJlZLqkvyrUzWSbnIEGN9Lfs786D+7ShQNlsQwS/s9niISPbUM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="455573335"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="455573335"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 02:16:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="6803264"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 17 Nov 2023 02:16:36 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3vtm-0002bR-1W;
        Fri, 17 Nov 2023 10:16:31 +0000
Date:   Fri, 17 Nov 2023 18:11:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiawen Wu <jiawenwu@trustnetic.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net] net: wangxun: fix kernel panic due to null pointer
Message-ID: <ZVc8UrRhUXzzE6FV@6473735b5665>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117101108.893335-1-jiawenwu@trustnetic.com>
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
Subject: [PATCH net] net: wangxun: fix kernel panic due to null pointer
Link: https://lore.kernel.org/stable/20231117101108.893335-1-jiawenwu%40trustnetic.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



