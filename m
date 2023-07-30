Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD2E768360
	for <lists+stable@lfdr.de>; Sun, 30 Jul 2023 03:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjG3BdS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 29 Jul 2023 21:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG3BdR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 29 Jul 2023 21:33:17 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7008DF
        for <stable@vger.kernel.org>; Sat, 29 Jul 2023 18:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690680796; x=1722216796;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=gy8t2VvZzhoSFIgkjth9Vc54fK/BhJChXX8gCqxm1WQ=;
  b=hmgOS1lKugXun3JKN6z+bIP/GCGTfDruKWvS09V/lX/A/fk0yy+nQmWr
   n19iJe3uFtJtbY8uVQ/kN/WZe4AyrUiSXRz1yfsUEYHPZ8Vm0ejGQDN3z
   OJ/rVECjmLS/HFIGUUmk1sywEKIUJ2PFC6Q0M2Gwrtneorc9/+zgdMHgs
   lQF3w+U9aW2YnueUrs10wHElOkNu7uhaYyZGCNDfvK4VwxxCUaK7exGOf
   rrDzXCnLG55dpuPgdrxtzuvvY4jKQZnLglzZksrDb0fJct4UPL8cuRVFw
   hGur7Dc7TuaLpNaGq6dxSDqSCs3Ien9JcRGoDdtV4ZrhbBzjnHWRm6aC1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="455164582"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="455164582"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 18:33:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="727859919"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="727859919"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 29 Jul 2023 18:33:14 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPvIr-0004N7-2V;
        Sun, 30 Jul 2023 01:33:03 +0000
Date:   Sun, 30 Jul 2023 09:32:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/3] rust: allocator: Use krealloc_aligned() in
 KernelAllocator::alloc
Message-ID: <ZMW9qB3Bw6KFCUdM@c507f7d2ae6a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730012905.643822-3-boqun.feng@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH 2/3] rust: allocator: Use krealloc_aligned() in KernelAllocator::alloc
Link: https://lore.kernel.org/stable/20230730012905.643822-3-boqun.feng%40gmail.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



