Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCD77939DF
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 12:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbjIFK30 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 06:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbjIFK30 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 06:29:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6A8171A
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 03:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693996161; x=1725532161;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Cpqn67BN9jBtR7ECYs84RA3KIUwXd7muAo4t/fOmV7I=;
  b=DmiUFUnPyoU2PG3EOnCjsS9+oUjFazxqbGmqfbNooGVJiYhK1Y73MuNg
   VRikF2gaCzXfZO4UOieGH7M/09Jbim6NoKsWRgT4+v9VVp+c4ibVaUNNB
   P7TC1HIq/wyG2bYJxVKh96yk3xYOPipaf60b1XiNIePJxntZb9zwr1U4k
   w7mXh2a34wFCigYr76HfYjWIeNgOhy/FmQeQEcwy1KF7o9z3YY6bzOU2J
   NGOr2JNOy7/2hsV6r/mUsiebhgp7s2YoJxZmBvhfTsttOJ1Wqk5ssi4IA
   GnzBVRe3RvhQjFIGJJ+aWUEbuqO/hifNxsQFwT2kVhekxkTv7D2QOGMqn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="374423837"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="374423837"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 03:28:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="1072332886"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="1072332886"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Sep 2023 03:28:53 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdpmF-00005r-0c;
        Wed, 06 Sep 2023 10:28:51 +0000
Date:   Wed, 6 Sep 2023 18:28:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alfred Piccioni <alpic@google.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] SELinux: Check correct permissions for FS_IOC32_*
Message-ID: <ZPhUSwb+srKodCQ7@0091dd92274c>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906102557.3432236-1-alpic@google.com>
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
Subject: [PATCH] SELinux: Check correct permissions for FS_IOC32_*
Link: https://lore.kernel.org/stable/20230906102557.3432236-1-alpic%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



