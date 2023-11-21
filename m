Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358037F337E
	for <lists+stable@lfdr.de>; Tue, 21 Nov 2023 17:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjKUQUN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 21 Nov 2023 11:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjKUQUM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 21 Nov 2023 11:20:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8AE1A3
        for <stable@vger.kernel.org>; Tue, 21 Nov 2023 08:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700583608; x=1732119608;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=8COA40gxobNJ9DMR9+nnf+Hd+4M6Rf3KFXGGxda+6ak=;
  b=gBdZAsBpf+tYBLHDYDdx3so2JuarmklLc7wnol9+uqtFIdvvmX5Q9Gy6
   aWZzZb/AUpeR3y8T01CUpdcpso/emY9OTXcm09HpBjvJyKD6WfIeiw+zi
   c7uZYbX0RNk5TIV01vlafZqGN6Vv0BHUqImxfA1R9S9Z6kZt5+RYzNG8B
   SffTHtOCdtklHicoZEOpRSUlFk6AY3UkgdtwwVf5v3FGGuzL89LQlCyuf
   xyOVNkDT/5JtPeev6ilS1DscQrn5gA0Q07zH5w2A5mmqPCv8XcOSGuEFL
   OU9EVlytQiuy4oFewJJRAOS+E7dB+ct6HTRR8wPkAlG4Xb1cHatqXN4ZC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5069264"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="5069264"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 08:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="7948366"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2023 08:20:07 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5TTo-00080i-1Z;
        Tue, 21 Nov 2023 16:20:04 +0000
Date:   Wed, 22 Nov 2023 00:19:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/26] netfilter: nftables: rename set element data
 activation/deactivation functions
Message-ID: <ZVzYiDY9olALNuMV@4c37e47e6016>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121121333.294238-3-pablo@netfilter.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 2/26] netfilter: nftables: rename set element data activation/deactivation functions
Link: https://lore.kernel.org/stable/20231121121333.294238-3-pablo%40netfilter.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



