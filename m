Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC427480EA
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 11:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjGEJeN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 05:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEJeM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 05:34:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041361713
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 02:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688549650; x=1720085650;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=yEmpHI45wYMuw9pSc0dk9wNynDhlBbqB9Q1dSv9P9PM=;
  b=JduGZeSeRfnLbwuQH6mmyBbM+UGx/kLAQk5px5LGtLUQJW23pFyt21Dn
   UoMj/J+WcfCID2gWGng9ueTt6hJ1r/LqL3B8m4txgTd4pf7h5RAKwjBWj
   qNbQ0rDpj+wv03i+439EnlQaL102E7a0Sy9A33W7yxiTcqyrU0vGmNUUk
   yfBrpnNJxap/fZ/tf6norqHR2x6SrUDn0rK1phwE2Dyx2yxNFWcgMDYJi
   lc/q22WvMrwiqega2oG94on0DCpkMazKLRie4bhk1Vh8idMd4wMhp/06/
   VIwo4peFH8BKnbddD8xYT4VappDH7ZAu+SYyEG/IIfoWrYCsi+bZYuKE/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="348082810"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="348082810"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 02:33:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="784472441"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="784472441"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2023 02:33:55 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGytW-0000YQ-1g;
        Wed, 05 Jul 2023 09:33:54 +0000
Date:   Wed, 5 Jul 2023 17:33:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net] net: mana: Configure hwc timeout from hardware
Message-ID: <ZKU46+qyuF22wy9s@a1daa7802ad8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688549578-12906-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH net] net: mana: Configure hwc timeout from hardware
Link: https://lore.kernel.org/stable/1688549578-12906-1-git-send-email-schakrabarti%40linux.microsoft.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



