Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0918F7DCF68
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 15:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344314AbjJaOfO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344241AbjJaOfN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 10:35:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E1BDB
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698762911; x=1730298911;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=8w7c6BBe7AjyQrYw3zHDFRdS8YyIZHynKw8kEOWysGY=;
  b=h56T+gpUIqWTDyOY/p73V0yuXUomFaOoRHJkFWGyIsPyIXH5rRvLuTQN
   BVgL/3k1QB1saY9Cn8nJrrXlth+IKM+8JD0sNiAUdFidNMdeblEewcqvW
   Kls/IpyTLcr5qnCgDKtcCUv7T7LNv+0fqvF2IinO8F95Nxe8QFiLEqAAc
   ObquLI9gcr4B5T8ZepFCh7tbBhlq9W+Qpreu67q1fo83hqVYiMBl3JzyC
   mS3RbZH6IVgTxSeY00mnDfQRcOmZjldMdDK4T1Zb216QPKAOTTbjIiAiJ
   gxpNfxi8bwvq9ohEeqm+qIBH0ttPj09s8cJSR+KkQ+FdoAhBNGq42KbBy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="387185363"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="387185363"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 07:30:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="934128709"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="934128709"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 Oct 2023 07:29:58 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxpki-0000Ce-15;
        Tue, 31 Oct 2023 14:29:56 +0000
Date:   Tue, 31 Oct 2023 22:29:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.10 1/1] btrfs: fix region size in count_bitmap_extents
Message-ID: <ZUEPXYZXOZ/ibftr@093228d915dd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031124900.19597-2-abelova@astralinux.ru>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.10 1/1] btrfs: fix region size in count_bitmap_extents
Link: https://lore.kernel.org/stable/20231031124900.19597-2-abelova%40astralinux.ru

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



