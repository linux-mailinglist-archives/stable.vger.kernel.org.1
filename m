Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08C4769F3E
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 19:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjGaRTI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 13:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjGaRSx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 13:18:53 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69994268D
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 10:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690823833; x=1722359833;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=t/kOQoyzK3nu1Futg8B7/Dv6FaL89RylOYNnhboqiCg=;
  b=MOytdrWSxsTarpQ1vEVTUVBc7i3flvXZzwywtn5B6c4M2QmzOYK1xIvx
   IfzcAZsRvWHhfjbHoIhhXtevXHKDVBhxHqwHxoGqXdYruOQM4o7jjVitR
   1fHlDwdcpeyAZH+t3jFGPr9FogtjRn17dlmsVzTonRt32Y9LCHkOzN6cb
   rr5zqnGKF6fmJX9A6dBBTkshuYIZZdlAMW2GSzXdbD6r/EPFeccKMGanu
   mMeJIKnAMG1XmTCdjO8XYuNOWEBrPt3jONylS4e38PjlyFNKe+YpyKkvh
   +iO9bCX7VXN3se93sEDV5xnHXOMF053EjMyBi6EG16kKk/DpGSz0fZoxW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="432902160"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="432902160"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 10:16:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="902217006"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="902217006"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 31 Jul 2023 10:16:10 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQWV8-0005Fh-0I;
        Mon, 31 Jul 2023 17:16:10 +0000
Date:   Tue, 1 Aug 2023 01:14:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/6] mm: for !CONFIG_PER_VMA_LOCK equate write lock
 assertion for vma and mmap
Message-ID: <ZMfsESOmBdOl6v8L@c507f7d2ae6a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731171233.1098105-3-surenb@google.com>
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
Subject: [PATCH 2/6] mm: for !CONFIG_PER_VMA_LOCK equate write lock assertion for vma and mmap
Link: https://lore.kernel.org/stable/20230731171233.1098105-3-surenb%40google.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



