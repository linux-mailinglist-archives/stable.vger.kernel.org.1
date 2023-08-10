Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F33777119
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 09:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjHJHL1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 03:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjHJHLK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 03:11:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A73E1982
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 00:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691651464; x=1723187464;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=XBEEZGw754pa/yEjtog8E1K4vPKE3iLtCaMnZp1I31E=;
  b=T3i3krzYisS4JyeT9EFsYp8Iy6qTX8jUB+cV9vw2Xd7zfnYZXwKSKZhI
   9Xh5xhYaj+WnIHC2KJYc8yMi2vo4qZKqHEkialV34uB7C5K/XsOsFmPRI
   a0hTzk2wCHBlpfkAuti2jBSyAi2ElJG9MWeX0fEqMse1WbKn3zfTDlaNx
   w9Gi5ctIrRiFsHa5LlHGGoaGJLKPuvOHyREz02uPnacCMHsvaRDV/wHDC
   onBluCpfaWhu9JxLHw1LvZ8wsLi7aXFsZzBdOy8DN07u85L5LTqx8oSSs
   eUv/NK9raB/FaEkc6dfvAr8xtm9i9+BZPJwBlAHvbSrH6K/NYSt6gWI0u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="375035450"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="375035450"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 00:11:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="709019093"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="709019093"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Aug 2023 00:11:03 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTzp0-0006os-0m;
        Thu, 10 Aug 2023 07:11:02 +0000
Date:   Thu, 10 Aug 2023 15:10:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net 1/5] netfilter: nf_tables: don't skip expired
 elements during walk
Message-ID: <ZNSNTI+r/EPb0ll/@11d7ca01dc46>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810070830.24064-2-pablo@netfilter.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH net 1/5] netfilter: nf_tables: don't skip expired elements during walk
Link: https://lore.kernel.org/stable/20230810070830.24064-2-pablo%40netfilter.org

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



