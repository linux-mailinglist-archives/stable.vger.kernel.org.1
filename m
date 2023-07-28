Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1D3766666
	for <lists+stable@lfdr.de>; Fri, 28 Jul 2023 10:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjG1IHu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Jul 2023 04:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbjG1IH2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Jul 2023 04:07:28 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B00D1FF2
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 01:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690531619; x=1722067619;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=rrYT9CCdhkSNefmeirL7ue1ZwzOjsW5kwHQ4XAoWSvo=;
  b=VLIx2z0T6KD1ojYceYMxR64Vo1VHvaJVgwZRtdG8YE6ErBRcp0OspdTJ
   iyAFL9fwpui2DGssZMOHMxekVLJmHiYMHYYvkYXsx8+J4hxX9HXyxOc0v
   4CgJGHapee0cc2mirJt0aRFazZCvRdmPoZLA2LkdS0NM9VLT7mGW8k4hq
   MEg1uWJD3J3PQrXAhUAGsYLeoPiIeej4aDeJfIS+8iNPRRUruSk8Usy3C
   PqHTLHQx/D48CCSokbq3sYc62mH1xBwvxxJe3QEDDIP3vFSWhDZNqZjwk
   bbpCADVVKNehND8gIDUFnijdPj8uEoOWHcqvDaU2y/Cg2+6LD6JsSjtXG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348138501"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="348138501"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 01:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="901136292"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="901136292"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 28 Jul 2023 01:06:57 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPIUy-00030r-1n;
        Fri, 28 Jul 2023 08:06:56 +0000
Date:   Fri, 28 Jul 2023 16:05:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net 2/6] net: hns3: restore user pause configure when
 disable autoneg
Message-ID: <ZMN2uXx/GXoC61VD@c507f7d2ae6a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728075840.4022760-3-shaojijie@huawei.com>
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
Subject: [PATCH net 2/6] net: hns3: restore user pause configure when disable autoneg
Link: https://lore.kernel.org/stable/20230728075840.4022760-3-shaojijie%40huawei.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



