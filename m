Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4DC70A33C
	for <lists+stable@lfdr.de>; Sat, 20 May 2023 01:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjESXS2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 19:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjESXS1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 19:18:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ABB12C
        for <stable@vger.kernel.org>; Fri, 19 May 2023 16:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684538306; x=1716074306;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=3Zixwlol1xE0X5p41L5oQGRGFktaH19NJOc32BD1ZPQ=;
  b=iYXJr1EtfneuRTLzjZ0krBUW8nFZf6nsqFjYKWb91fuv/bFYZzmpXqso
   dZzMx3ycyWDUMzfFwIMPIPDlta3+zgR51uzpeQ72c5hl/WktCzKU2vIqV
   lW4r+VkblDP9R8px77xMTiCjSPnv8s6OPvsyIfg6QXReP/r+f+Q0LpcE3
   KVs8q0v29asZBBglHbdb4brFTJesnbVyAxlbIOX4keGEOqCNgf6hHe/lx
   WHfG4SB2WkIiyxz+xC8V+RgTKHDy6/ryEYDQdgtQZk1YAsLftEbpTIEV5
   D9bdch18Uix5t+UJ0cg7LkH8ECWKM6/xpZXLqKwv6lxV0O79Hp0zrSZhl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="352526293"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; 
   d="scan'208";a="352526293"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 16:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="696888613"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; 
   d="scan'208";a="696888613"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 19 May 2023 16:18:25 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q09Me-000B9o-0S;
        Fri, 19 May 2023 23:18:24 +0000
Date:   Sat, 20 May 2023 07:18:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sagar Biradar <sagar.biradar@microchip.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4] aacraid: reply queue mapping to CPUs based of IRQ
 affinity
Message-ID: <ZGgDvnIQUh6uI79l@e0f96cf4e6cd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519230834.27436-1-sagar.biradar@microchip.com>
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
Subject: [PATCH v4] aacraid: reply queue mapping to CPUs based of IRQ affinity
Link: https://lore.kernel.org/stable/20230519230834.27436-1-sagar.biradar%40microchip.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



