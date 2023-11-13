Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B727EA0B2
	for <lists+stable@lfdr.de>; Mon, 13 Nov 2023 16:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjKMP4Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 13 Nov 2023 10:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKMP4Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 13 Nov 2023 10:56:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD4FD67
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 07:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699890982; x=1731426982;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=/feM6pVIMQebopU3CFsy1N/rZxYLlmIsrWXnoGaVGSk=;
  b=jPpAkBJt9D41n77/GrGychkLvlGi5IZqyZ61jnFVpVMd0pUAbe7HxcKH
   ZyMxwlIrV5jYfgnaQUtlUr/zewJAB+S3lw9CPYrw8X9ofBUabKpa3z2NE
   umKIW6yAVULrcUsDkRTTiWq7UcW0r68Ck8budIPqaHFgRUtAGtbwlFzKb
   UT180na9xtRUsTj7Hu/s2jqz5053S7qKljyZadw8b228wkOqrzYS01xwA
   gyEyNxqhPA8JIrfbJj3t3sWejeNNIgvKhfNcUehDDBZ1j4gJx8EV1kXzv
   +QfpR6a+Om1Ent6KsMw+Jr/ARuaoaONVfzinwtqU/LR8PFftr/FSR42cy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="3540315"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="3540315"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 07:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="887953233"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="887953233"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2023 07:56:19 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r2ZIP-000CEY-0w;
        Mon, 13 Nov 2023 15:56:17 +0000
Date:   Mon, 13 Nov 2023 23:56:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ronald Monthero <debug.penguin32@gmail.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand
 controller response
Message-ID: <ZVJHFbhYdzte2uSz@a5f2b1974362>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113155354.620298-1-debug.penguin32@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Subject: [PATCH v2] mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand controller response
Link: https://lore.kernel.org/stable/20231113155354.620298-1-debug.penguin32%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



