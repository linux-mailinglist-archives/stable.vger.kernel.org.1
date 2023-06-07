Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE903726769
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 19:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjFGRcW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 13:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjFGRcU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 13:32:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EED1FE6
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686159126; x=1717695126;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=EKLBh5452rTrtnSW4hcfYbaevBvLnjIuyMkRY6643bo=;
  b=mZDGfwKGJ2g7RMN+glGmwJMIN+oMY34snf6pqAgJCSgCyiQA1PvSTXXY
   1OmKPtPYwrcenWDi0yTN5tG97VFX/8X/HZ/3uC/0FsECT8S2VI6EZWTft
   NNzZF/oxHob92d0m0gKnOSkQ8aOBakKpWmFW+GQNLmKNZFinJ6P4chMQB
   wTRnDiO0l+TkjQIcPIxfYYPShJSD6lsVglGwpOg9XE9Fobji47SA85t7k
   ReColzLhh0n3tLHJ+oWi9+42y03jSgmP2ugH4WM7G2MjYzqMLnBXfluMN
   nKRQcpdsJyWifSh/EFy958v+l6GT0tpcghiJuFxDoISF17of1ePLolsrX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="337417454"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="337417454"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 10:32:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="709637597"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="709637597"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2023 10:32:04 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6x0t-0006m7-2n;
        Wed, 07 Jun 2023 17:32:03 +0000
Date:   Thu, 8 Jun 2023 01:31:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] fs: avoid empty option when generating legacy mount
 string
Message-ID: <ZIC+7BpKkZQIs6hT@a93e062a6cea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607-fs-empty-option-v1-1-20c8dbf4671b@weissschuh.net>
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
Subject: [PATCH] fs: avoid empty option when generating legacy mount string
Link: https://lore.kernel.org/stable/20230607-fs-empty-option-v1-1-20c8dbf4671b%40weissschuh.net

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



