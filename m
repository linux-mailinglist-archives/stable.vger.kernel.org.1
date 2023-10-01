Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AB47B457B
	for <lists+stable@lfdr.de>; Sun,  1 Oct 2023 07:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjJAFvt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 1 Oct 2023 01:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJAFvt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 1 Oct 2023 01:51:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A48D3
        for <stable@vger.kernel.org>; Sat, 30 Sep 2023 22:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696139507; x=1727675507;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=1Il7lXxxltgnw0Gsx46x1lNQDoJ/ZFdyp1U7Bwo8qHM=;
  b=a9+Cw371MnF4R0a9iV2hGclMQHWO2xVIdpshc7WRxv5lAiuzahtoXhRT
   X8kWYEXdYxu8Pk9kQuq/dRASCAKN/SSZyESMUtohJHbpprlTDOeujZV+b
   ijWhBAhHeyFkeFo/0cKVYRB94MlkxkPpJpLhwhzs1N2vw/f2nqVS+rx4J
   gFFPOTQ9N0VJwR9um5JlwqIhr/7ElOQIU6myP2sLtS3eL78jn/a1n9ILq
   4FXEeKoGXwcoYrnB8pW8QzAi55J3BLRPKr427maYyQVFHI3ZglLNCV/Mh
   +F/DggiW1O1fw1KAgHVxsp5OuZ9ZA4PRdrtcG+rGMGNq1dfGg8AWspw7U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="379780987"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="379780987"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 22:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="785472787"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="785472787"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Sep 2023 22:51:45 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmpMf-0004oD-09;
        Sun, 01 Oct 2023 05:51:41 +0000
Date:   Sun, 1 Oct 2023 13:51:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] [v3] ieee802154: ca8210: Fix a potential UAF in
 ca8210_probe
Message-ID: <ZRkI4j2+dXZ9sjQ4@f61ccfac960a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001054949.14624-1-dinghao.liu@zju.edu.cn>
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
Subject: [PATCH] [v3] ieee802154: ca8210: Fix a potential UAF in ca8210_probe
Link: https://lore.kernel.org/stable/20231001054949.14624-1-dinghao.liu%40zju.edu.cn

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



