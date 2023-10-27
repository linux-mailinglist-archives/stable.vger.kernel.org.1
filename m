Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF4D7D9F07
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 19:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjJ0Rs5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 13:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjJ0Rsz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 13:48:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2085DE3
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 10:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698428934; x=1729964934;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=/7SjA1LpJ8qWzgG9ARbe5wAImR6tfU/v7q6M7oDJ9b0=;
  b=cAyc8HEnIOl1aNe86mbxE5ssSFekixKr85S2+5WKprBDjv5jRCZa3WaW
   Ayxe6l9NrAJHmGmhvayaf3e7EXW/FVKurSbbtJDJINOReF6G+MxhZPIbX
   wOcM0/zxE0iBWbvldvy1WR3ZDh99xakKE13+U8x6s8DMgQBG+HMlrbPS5
   Ds1iQrmZoRH38dh7FYdiL6EDL+3fxLyKSN5Nn7fJcTYevhauR1XO0Ejqt
   3qhP2nPKspI8BZygso1pCykyyutCIR1lshB15FZYwceTEsGnFETd5lgzM
   gZYjIM8kREysmmE/WevlA+MeCX1rmdvYqlDh56ip56DkP1uoslXhvREfa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="372875998"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="372875998"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:48:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="825417952"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="825417952"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Oct 2023 10:48:52 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwQx0-000B3n-0m;
        Fri, 27 Oct 2023 17:48:50 +0000
Date:   Sat, 28 Oct 2023 01:47:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: Apply a1e2c031ec39 and e32683c6f7d2 to 5.15 and earlier
Message-ID: <ZTv3y8NB7A3KrFPF@dceb3e7df498>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027160144.GA232578@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
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
Subject: Apply a1e2c031ec39 and e32683c6f7d2 to 5.15 and earlier
Link: https://lore.kernel.org/stable/20231027160144.GA232578%40dev-arch.thelio-3990X

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



