Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5445757706
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 10:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjGRIs2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 04:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjGRIs1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 04:48:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA28C197
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689670106; x=1721206106;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=7Zz0Xz8yvCrnazJD9Q2MvKsmtuuOzbymVBZQof/BUIk=;
  b=LkHJBtVpTb4xL/MGeojQVxVuRQXOhVwE/8j7kYUDgZ/+SgrKSyhGCdAp
   lSduu4JwKLw/M3OKYCTtJ5ObG68jKHprzVp2YnP4aUF1T3xvZ2hLUr3gw
   axBrFGZfY3mB54D23s5eKKORM4De3L23jh3QzV1YAYlXVnS5OK8d160On
   bUPrNgPoL77ldYeVmN+bx2okXSuo2GmvHccVnzz2tuErQsCM+/XbZQeJ8
   9VwhU4V6+xIxUcshrdeeFTQ+kGdXE5dgJv+ImC5owRNPzJELnQotafm/J
   E3jFyzPz+4JbkNdLYGXVM/B52QbzM+PnVY1EW9AUHP8xpTWRPvGNOZwe0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="366191670"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="366191670"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 01:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="723532899"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="723532899"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2023 01:48:25 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLgNc-0000OF-1S;
        Tue, 18 Jul 2023 08:48:24 +0000
Date:   Tue, 18 Jul 2023 16:48:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yunlong Xing <yunlong.xing@unisoc.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] ovl: fix mount fail because the upper doesn't have space
Message-ID: <ZLZRz9FIbT7KcJAb@c507f7d2ae6a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689669277-15291-1-git-send-email-yunlong.xing@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH] ovl: fix mount fail because the upper doesn't have space
Link: https://lore.kernel.org/stable/1689669277-15291-1-git-send-email-yunlong.xing%40unisoc.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



