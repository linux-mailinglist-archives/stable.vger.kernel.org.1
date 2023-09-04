Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F46E7911EC
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 09:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjIDHSI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 03:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjIDHSG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 03:18:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37774A7
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 00:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693811882; x=1725347882;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=CZfa7okZ9u7Q4xEj7VCT2FeXrdZevXunt5nebSjqor4=;
  b=A9UKRKzHm5CcwNn3UFVt7JEczV7WUR67nf3pxSgLyF02rHbLMisqrkUK
   UzFD5vY42TG9we1pMeuQgLm86oLRT32IR8zcLF/GVn2IntOiKxzAmOwiF
   UCJWGRmJv++WoIGs7FWo+Z3gtc8gttOpX4BlbJQzYYYk7g0sDI3jsbxte
   VUcy3rsYOxr3eGlF5jdrAP+4NWIRtao8I/94eOmPhKy3VhmRWL+bCJrtG
   6x50Iknu2fr3nQ5zbEcgHXAdMOenvUA3NFTFnLRxz0XY6z3mOX0Qu6LqE
   km5xfgcO/JSkp3SICLl7rCO/R3n1jpe9U7fil/x/wL8W9KyY2IdoUMirB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="442932466"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="442932466"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 00:18:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="743836896"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="743836896"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 04 Sep 2023 00:17:59 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qd3qP-0000FL-2p;
        Mon, 04 Sep 2023 07:17:57 +0000
Date:   Mon, 4 Sep 2023 15:17:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomasz Rostanski <tomasz.rostanski@gmail.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/5] usb: dwc3: reference clock period configuration
Message-ID: <ZPWEpIy9ijfgtNyU@e5f9ae3a7ebf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904071432.32309-1-tomasz.rostanski@thalesgroup.com>
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
Subject: [PATCH 1/5] usb: dwc3: reference clock period configuration
Link: https://lore.kernel.org/stable/20230904071432.32309-1-tomasz.rostanski%40thalesgroup.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



