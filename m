Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A176217D
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 20:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjGYSg5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 14:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGYSg5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 14:36:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7186A1985
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690310216; x=1721846216;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=O3WNw1IomdWkDJr2ZIyRjZ7kayR7RhsTlPQToycSmts=;
  b=U07SK9M5iAwmJKhMDH3E/RuyJZVWLKCrXuct5CWs2TguAjVzdvr/zMKv
   6URCFg2E0JLmiOwZ6SK5J+DLNBa+t/5P8fRmx6IGJAjBlzHfnCl7zhElI
   g0XAUTHNuEGmS4U5x4sv3jxquPAuFJl7W/rQb8AzNjBEh5W341O+fZA6L
   N3TDubuY3T/dz6dRJEFgBr7EPxa2WxUajcJye0+pOwBVMH1xHDJaWLJts
   /ym95A+r6THm3MmNysIUIka8FWfHR94jDml3jtTQJeyPzVMW93ysDGKqK
   ud2GIi+if4s2uFwFyqM47y+KxO9QGZWQiDXIdxO72IHQni3rJqcMnrZ6w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="398735650"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="398735650"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 11:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="726196882"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="726196882"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 25 Jul 2023 11:36:54 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOMtx-0000Dz-2R;
        Tue, 25 Jul 2023 18:36:53 +0000
Date:   Wed, 26 Jul 2023 02:36:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mat Martineau <martineau@kernel.org>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net 1/2] selftests: mptcp: join: only check for ip6tables
 if needed
Message-ID: <ZMAWLwU5CVEksBoI@c507f7d2ae6a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725-send-net-20230725-v1-1-6f60fe7137a9@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
Subject: [PATCH net 1/2] selftests: mptcp: join: only check for ip6tables if needed
Link: https://lore.kernel.org/stable/20230725-send-net-20230725-v1-1-6f60fe7137a9%40kernel.org

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



