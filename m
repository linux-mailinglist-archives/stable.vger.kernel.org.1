Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8773C7B2395
	for <lists+stable@lfdr.de>; Thu, 28 Sep 2023 19:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjI1RSW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 13:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjI1RSV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 13:18:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83364C0
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 10:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695921499; x=1727457499;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=pJQ3AWv/+COP8pxKIb3bIOi4NYL+H5ugrXiX7BRfTGg=;
  b=K8vN3oZfNwc3IErLMWgNU1w0QLKyenfqg+aw1YQRenxxAcQdEW79UJYh
   AQ3UDFDhfrniDhkYdCLG+cFzrTDm4GEXn1LjdokNjZgE0SsNtWBiRITk8
   HA467DZbj1aKP0mrEneeKP+YsVsaZP9AYCuIMl3SXhwP5cVMKM+henum4
   CMVFKRy7aITuIlcULh98ySexcWNWr90T4+0VWF6aPLWdGQJJr089UNqVs
   NUBULGbUqdy2tNIy7cIF4Nt5NzQJK36NLF7QB3bQnOMkB9o/R174s/Zh1
   WosjpBZrkCaWPn4drMmD1D7rfPoLEeT7eSxg4CtJENsLIYaSej5Wq5MPi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="362367037"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="362367037"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:18:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="726305651"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="726305651"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 28 Sep 2023 10:18:17 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlueV-0001jk-1y;
        Thu, 28 Sep 2023 17:18:15 +0000
Date:   Fri, 29 Sep 2023 01:17:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 3/3] mmap: Add clarifying comment to vma_merge() code
Message-ID: <ZRW1MBvWCCFevIg1@f61ccfac960a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928171634.2245042-4-Liam.Howlett@oracle.com>
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

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html/#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 3/3] mmap: Add clarifying comment to vma_merge() code
Link: https://lore.kernel.org/stable/20230928171634.2245042-4-Liam.Howlett%40oracle.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



