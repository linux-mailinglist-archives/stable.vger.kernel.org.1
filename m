Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FBB7BC46C
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 05:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343517AbjJGDcs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 23:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343492AbjJGDcr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 23:32:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE69BD
        for <stable@vger.kernel.org>; Fri,  6 Oct 2023 20:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696649566; x=1728185566;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=WUqeZc/H1BQgiqffNeWMm0UbIPCoEHACpAqSGtLnBX8=;
  b=NDcv8XlvePSunUGUbiLTrHeR7LERZ1fuyx7WysUSDykuOqE+X6CY/NIC
   mj0gKEG5zi27dSYtXe+ZHsK3Wiu5tqb3HiA/x1UDa06DezIEJTrvLnbln
   Ipmwh9tbvtCX4t+aSJ+zW3UnwsUKUfXm0KmsNhcAsoz9defL4sU9RsJ40
   MPLyya3m0M90dJyWOrSqByhyEKiqbeMjubw5Hy0Zm7xuC3384aFYrpGk/
   LZqiJoPQ+T6+Wi8CY68NwbCj4PKslQ1zMq29XslzN8qvJiKNTIbTv7Siw
   RJNpUm6QNk8Ld6RlzjpPpHS8U6kEy/PYDRwCvdcuv+Fn6h6zeK8F1tzDJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="364169569"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="364169569"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 20:32:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="752390894"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="752390894"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Oct 2023 20:32:43 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoy3V-0003vn-28;
        Sat, 07 Oct 2023 03:32:41 +0000
Date:   Sat, 7 Oct 2023 11:32:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] [v4] ieee802154: ca8210: Fix a potential UAF in
 ca8210_probe
Message-ID: <ZSDRV9ZW/5GgJuW8@ded96c82e756>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007033049.22353-1-dinghao.liu@zju.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Subject: [PATCH] [v4] ieee802154: ca8210: Fix a potential UAF in ca8210_probe
Link: https://lore.kernel.org/stable/20231007033049.22353-1-dinghao.liu%40zju.edu.cn

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



