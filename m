Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB2C7F3387
	for <lists+stable@lfdr.de>; Tue, 21 Nov 2023 17:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjKUQVN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 21 Nov 2023 11:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKUQVM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 21 Nov 2023 11:21:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59A5CB
        for <stable@vger.kernel.org>; Tue, 21 Nov 2023 08:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700583669; x=1732119669;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=bN0/tT3ID9thdu8ZN98YMx6TIdYYuKDHnRlzb6COkHQ=;
  b=QPegALvi1gW/M+zMi7hWqvYnmeUT5Wcyn8vDftw7nKDBq3ve6CUtLeNo
   7zNNUOeUVQC3VKwu7L6rkuPVz4p/L8iTXOzWfFh4HaeseRlXPFg7f4aBg
   u0HuOEI29QTB0EZFZWw1Gps8SPySiv2M18XxI5XZKhiafg2xKjcXwfxUv
   I/N5biWmd/ySRS1uOFj+rilkFuLl/fLPUCoCP0EMVQtxnnjgwEKw5KWAv
   DR8u3jE82WKtNBVaH2Wh+1TLmByde82i6rFkaNmCZT0qJiaUFnb534izH
   UmpdIRdf4Ye3Z15jBWADcm6jZJyiJNo5eDASt9Nn686is2wbatX6n2TIj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="13415763"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="13415763"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 08:21:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="716578646"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="716578646"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Nov 2023 08:21:07 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5TUm-00080w-1x;
        Tue, 21 Nov 2023 16:21:04 +0000
Date:   Wed, 22 Nov 2023 00:20:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] netfilter: nf_tables: split async and sync catchall
 in two functions
Message-ID: <ZVzY02pFIdhp4TEw@4c37e47e6016>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121121431.8612-3-fw@strlen.de>
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
Subject: [PATCH 2/2] netfilter: nf_tables: split async and sync catchall in two functions
Link: https://lore.kernel.org/stable/20231121121431.8612-3-fw%40strlen.de

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



