Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889EF7548E1
	for <lists+stable@lfdr.de>; Sat, 15 Jul 2023 15:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGONsC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 15 Jul 2023 09:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGONsB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 15 Jul 2023 09:48:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC00110CE
        for <stable@vger.kernel.org>; Sat, 15 Jul 2023 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689428881; x=1720964881;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=h/HgrvF3zglUJAjb3DAYgi/AlNNTXbQJ1hTrRY4kC6c=;
  b=iCQSLMbLxNJiXhbJNj7w5+xFn7e68e4es36T7w6P8yXY31upjgoGKLBH
   lj4yn2IT6+APJtx4MDHomKH7zZSUGQFpgKZf0I0KFYJttdSlAB9Iv995x
   poSWREffHUuxulpwXhAmbG1VIbuaZBe1wh5qtEKrtDr8EdYPDaRUAZEdr
   gON/OPCMf2ovvMMsVRVmRi559ja0X39QJeUV1xPKmZlrNN1Uy9FdUBqzi
   PAhV/Op/mFrDu52yW1ZUxz4XVnNqgssnnGHJNsxWufu2YReYPtcSQW28i
   DNIu8nuglrHBbpGFmL2rJB+NqFSujgvzEBDqKWq5rO+rwH15TUSGFOQtz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="368304467"
X-IronPort-AV: E=Sophos;i="6.01,208,1684825200"; 
   d="scan'208";a="368304467"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 06:48:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="969325972"
X-IronPort-AV: E=Sophos;i="6.01,208,1684825200"; 
   d="scan'208";a="969325972"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jul 2023 06:47:59 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKfcs-0008BJ-28;
        Sat, 15 Jul 2023 13:47:58 +0000
Date:   Sat, 15 Jul 2023 21:46:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     guoren@kernel.org
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/2] riscv: stack: Fixup independent irq stack for
 CONFIG_FRAME_POINTER=n
Message-ID: <ZLKjUh2YTdjsgK2M@a1daa7802ad8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715134552.3437933-2-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH 1/2] riscv: stack: Fixup independent irq stack for CONFIG_FRAME_POINTER=n
Link: https://lore.kernel.org/stable/20230715134552.3437933-2-guoren%40kernel.org

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



