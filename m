Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AAA713059
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 01:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjEZXXv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 19:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjEZXXt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 19:23:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B38EB2
        for <stable@vger.kernel.org>; Fri, 26 May 2023 16:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685143428; x=1716679428;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=vZw7XFb0poPB6g958cKcQC9zcUDzc8KuxqyaWW3o7AU=;
  b=PLtXdiFpgBPKwOhbchw2R1N9TKq7zKH650vh40lYNouPHjYh5SWJzkvx
   qpUBigTx6Hzm+tXVJaaRpZUZLRLctN1IYi/e5/YgVWTQNogGdVSsIUime
   SJ6OgDwH5dSLi16XKPY4Fc5gH1DYEqiYCmmjCzzLg1Hy39hlUtphO9QZq
   o8KCRRASsNQDHwhOK1/8Ks/i2+GNEG33jZlZ0+6OeeNxvjMG3IbtM9FNk
   rf/lsm5x5o+Szd49vswWvPqReoKz8DQ2JF2cN29RX/5i9ouA6zKm/wI2y
   KMWWfFrVmU8+P58ivJVipVaxXBSN+U5Aw7kG+gcKBzv1JV3KvZx+9mEKD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="356711761"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="356711761"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 16:23:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="879692378"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="879692378"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 May 2023 16:23:47 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2gmg-000Jf8-1L;
        Fri, 26 May 2023 23:23:46 +0000
Date:   Sat, 27 May 2023 07:23:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hardik Garg <hargar@linux.microsoft.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.1 5.15 5.10 5.4 4.19 4.14] selftests/memfd: Fix unknown
 type name build failure
Message-ID: <ZHE/avMpv2Sjqwxf@3bef23cc04e9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526232136.255244-1-hargar@linux.microsoft.com>
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
Subject: [PATCH 6.1 5.15 5.10 5.4 4.19 4.14] selftests/memfd: Fix unknown type name build failure
Link: https://lore.kernel.org/stable/20230526232136.255244-1-hargar%40linux.microsoft.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



