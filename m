Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBE67EAAC5
	for <lists+stable@lfdr.de>; Tue, 14 Nov 2023 08:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjKNHKk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 14 Nov 2023 02:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNHKj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 14 Nov 2023 02:10:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8CE194
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 23:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699945836; x=1731481836;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Wsd1dNobSgH5+Vj4kvT0DqHCzxu1TzV1I8J+rJSJoZM=;
  b=h8x2Ox1WYcw+bjkSLrOr/wEyUGm5RnpLkBAhzM50rK17pG9urlZ+pqYj
   7JzbMiXU93ANtKAlFHSjlYoPtVGEF0mFIcffgXDNpiKsa203eh+kf8/WG
   IK1DPfYb8A9KkkeXyFzEHAmb4uk0p2Yc2SxLPuL0kfUNsOTHhqxpdYh6z
   tuODz95tw4e9o3bXhW7ewOujEIUBGlJ5/xUvnGdNU8sH3jAaxdtEvwq0w
   166AwCXtcpFCBXaHXar09jaYyC9nTpoQiTAWO5MX6t782lSlqo+tywziN
   X8m/BNpUpfmO2XMb+RSbYCIKETidsW5JGNeoGPLm7ujUUgoOsoYBm/Hlk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="380995764"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="380995764"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 23:10:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="12704609"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Nov 2023 23:10:35 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r2nZA-000CzG-2j;
        Tue, 14 Nov 2023 07:10:32 +0000
Date:   Tue, 14 Nov 2023 15:10:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] PM: hibernate: use acquire/release ordering when
 compress/decompress image
Message-ID: <ZVMdS0CPNHC3lMhL@a0c8cbd5f24d>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114070553.1568212-1-zhanghongchen@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] PM: hibernate: use acquire/release ordering when compress/decompress image
Link: https://lore.kernel.org/stable/20231114070553.1568212-1-zhanghongchen%40loongson.cn

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



