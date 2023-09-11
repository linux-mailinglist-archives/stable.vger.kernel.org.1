Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC4679C3BD
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 05:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbjILDJX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 23:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241694AbjILDJI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 23:09:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213506CD3
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 14:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694468584; x=1726004584;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=mWgtCVmKPqA2E8zQpkjF3rRyXTVHC18ScxYxOWRMjd8=;
  b=hfaSvV6IYtC3ppiZIDMBhWkm/SQGEnHQf3tRYsN13Gwt9jr55KQllxbl
   cylxdWHhZQdqzw77HOmdkQfPndx84HYWyBwGptPXw1umrZe568lw6MsUH
   m2T9oDr+WQswM8ir3Ag1gO9x8ALbVhcFnxEe9qZm2u5SriQQNQX00eHNu
   raEWxG6tL00K5GsLKiCddikbqiR1Fds4RpI7XWR+quwlkQmS4CpVLM0Pb
   zUB4InoZ2vx1WuG0/u3bWarGnwm+Oye1n32K93Q1nJ0MS4nMnex6osFFE
   0naPKL0WBHxTE7aurxulFtqE4jiaaptw4ME4+HMMBXpdwdzy/RMG+ynOG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="363239068"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="363239068"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 14:11:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="736904137"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="736904137"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2023 14:11:42 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfoC3-0006jY-32;
        Mon, 11 Sep 2023 21:11:39 +0000
Date:   Tue, 12 Sep 2023 05:11:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] Documentation: stable: clarify patch series
 prerequisites
Message-ID: <ZP+CgXGAN+Rbdrnh@0091dd92274c>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911203628.20068-1-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
Subject: [PATCH v2] Documentation: stable: clarify patch series prerequisites
Link: https://lore.kernel.org/stable/20230911203628.20068-1-hugo%40hugovil.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



