Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71835793761
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 10:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjIFIsR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 04:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbjIFIsQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 04:48:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E8010C6
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 01:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693990080; x=1725526080;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=TggOEzEDryBlOwrPosesuTsOkoaDpapkrKi2Dhg7Ems=;
  b=TdOv/1Lfwe6e+qPSfah8z1CNIugYH/EkJ65nirXXkuXe/meM3tib/tpq
   /VDo6Aq0/mtEZ+NXaM0zRfynel6Waog4wkSBxEGqD/Dil+EIyNJAZ+xxJ
   hthoFjp32e4L0WxuqhO6hoNyfGAfbD6K8hE8LTdEz8RXOwlu4zciUX9wl
   NU5k7ELQFgGai71o481pRedql3Jvi6JSSWpCdtyd1c79Pwk+RNLE60igg
   SYIRIzQ2VtpoWlB/E6Yi9kpJObYP9szh26cf7iwcFkpkT5qfaDwYtfhIR
   vK3JeYE7mIRp3ixq+c759hvoTeYbs7qFODW96dpgLUWGwBRkzrr2TFEyz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="463391343"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="463391343"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 01:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="915186176"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="915186176"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 06 Sep 2023 01:47:58 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdoCS-0002bm-2l;
        Wed, 06 Sep 2023 08:47:50 +0000
Date:   Wed, 6 Sep 2023 16:45:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] LoongArch: add p?d_leaf() definitions
Message-ID: <ZPg8Nx11gZQrXUKK@e5f9ae3a7ebf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906084351.3533-1-zhanghongchen@loongson.cn>
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
Subject: [PATCH v2] LoongArch: add p?d_leaf() definitions
Link: https://lore.kernel.org/stable/20230906084351.3533-1-zhanghongchen%40loongson.cn

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



