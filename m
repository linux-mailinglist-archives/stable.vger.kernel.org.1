Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77384744881
	for <lists+stable@lfdr.de>; Sat,  1 Jul 2023 12:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjGAKeN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 1 Jul 2023 06:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGAKeM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 1 Jul 2023 06:34:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D857A3ABD
        for <stable@vger.kernel.org>; Sat,  1 Jul 2023 03:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688207650; x=1719743650;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=rDlCz1aRhlklJkVRNL51fuaHPFb1rfjbcDtn3SwGVFY=;
  b=cmtztHzJZbmHF/CtjFiGphLig/DOS3cmgP0aEDH9QTMEDu8yko9b439O
   ZuvBe8HgH8hO8h/4z3oQrc1BP49Ayb/+zl50OkVgTpr5dDzC4bCIIbLVC
   0u1pzUmCuIlRBfxCp7avVy9UvxeieFBfuVxQZIi2OLoCyzg+unG7b99so
   R+fhETGfYIUrEVJmsLJxG0Swq0D9VNTZE6qIBiiQbOdo2SELHBVRAWtBg
   2UKtH1WGvXzFSHJlInQp9zFcLxciZTLoZDYxA2DQ8qbXaLpCR3xKsOuyX
   zaGaSI45NC5wVd5GKTsAHBJHohRW7QX9P1v7qr4ccoUOcIAWvnc19BM6J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="362622118"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="362622118"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 03:34:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="862560177"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="862560177"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Jul 2023 03:34:09 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFXvc-000Fy9-2Y;
        Sat, 01 Jul 2023 10:34:08 +0000
Date:   Sat, 1 Jul 2023 18:33:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] xtensa: fix lock_mm_and_find_vma in case VMA not found
Message-ID: <ZKABDJ/qASOzMGRI@65525e8f8615>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230701103155.1209274-1-jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH] xtensa: fix lock_mm_and_find_vma in case VMA not found
Link: https://lore.kernel.org/stable/20230701103155.1209274-1-jcmvbkbc%40gmail.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



