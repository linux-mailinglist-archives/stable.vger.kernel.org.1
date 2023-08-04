Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F7976FF1D
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 12:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjHDK7Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 06:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjHDK7A (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 06:59:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E5A4ED7
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691146657; x=1722682657;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=QPNpGrplDFi/bkhbG4LeRBXgYmZRvH4AZEuR5h3iZ5c=;
  b=ABEplz7fAharHBS1I51LhXvsu5yJ/VtqqK41YmxXWe1LoyB9DvkJha6V
   xfsNjLBbina+b2bqSlrOLYj7dgvZHBrBum/xjAx4n6VTQ4pxIcX9uodOw
   yhYo6QQgCG/mg2pEGj6qwUeldM9zKMHGHI1U32+UscnPtugdNPivZYDPk
   zS/qHWIMT3H/lBSJ0g8UTZ/jZruOw5//W+Ywt50MaAQtgSchNREIJrr+s
   1iVzf3Xel9MdCz0a/DaNKmH6IO7bif2kKFTg25QCouJ/FlQ8eRa9rnblA
   x/pV5kU4eYjJuZ9zuQohnbZzDQ7PZ8PqfNj5kJvqJq9Bj3ayR2IDcXEmo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="350429197"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="350429197"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 03:57:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="795376160"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="795376160"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2023 03:57:24 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRsUl-0002o3-0p;
        Fri, 04 Aug 2023 10:57:23 +0000
Date:   Fri, 4 Aug 2023 18:57:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     max.chou@realtek.com
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for
 RTL8852C
Message-ID: <ZMzZgAI8XBD+8aP5@11d7ca01dc46>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804104735.9281-1-max.chou@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH v2] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C
Link: https://lore.kernel.org/stable/20230804104735.9281-1-max.chou%40realtek.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



