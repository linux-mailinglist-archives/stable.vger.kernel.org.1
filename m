Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AC67457BC
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 10:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGCIwF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 04:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGCIwF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 04:52:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E1ABB
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 01:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688374324; x=1719910324;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=/uvkMeGZBQFbU1x2ItiP0ExuJhY1J2uD/khcJMBV4Ac=;
  b=mQm7FLQ3BesHKfts/X0Ahog09hOnVy73cyTb8hmnjVtW2QOGYWLOP4x/
   xLRCh+1pWoqk/5aHmu4aY1T23dy2eh8oEPaAwjDbtpDR4Xi2Wcn18fyD9
   4NPPoGzbhASjh1Y+MG0iaG3dAA9KODcYVKqTbbRyIuQ0nz8AhCFIVgQYo
   ASE9Kbrp7ojFmpf/oKyfUOZiZwTT1yQbMRYjPrW6IB/BBxGe5Fe9QapdC
   eBMkGzznVuduhnqr33xgNuqGlSogCmV5vcoEEnt6tTpoy+/VgpwRToXqz
   X9dCkNvIg8GNi1Kk3rgUzHqH5Lylt1Zorn73Zv3dDTMaZc0Z+VUGNdI4k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="426514282"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="426514282"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="718532773"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="718532773"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 Jul 2023 01:52:01 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGFHs-000HIV-39;
        Mon, 03 Jul 2023 08:52:00 +0000
Date:   Mon, 3 Jul 2023 16:51:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     souradeep chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V4 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Message-ID: <ZKKL/a0qDLcTfi+A@65525e8f8615>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688374171-10534-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Subject: [PATCH V4 net] net: mana: Fix MANA VF unload when host is unresponsive
Link: https://lore.kernel.org/stable/1688374171-10534-1-git-send-email-schakrabarti%40linux.microsoft.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



