Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478CB7692B2
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 12:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGaKGg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 06:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGaKGf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 06:06:35 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A52A4
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 03:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690797994; x=1722333994;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=IaxYmHm4EZaKSgC5suwMmVZEvDpb9ol6gvHs5vhMcaM=;
  b=jkkdsJxWmYkwD1qmow4SCXrFnqQGGBHaQRLibq1M62UIfo/vkAyGup88
   LTom/FfWiGsqUDJUTDcmW54k/B3xvjPwdg5BhB7L0NbVqIFAAquF8DZHj
   u+EhR0HSxH5IwgI6tYnAAwA2B3eQopS6WNjnIOpepB4xvlZuwkBfLERwm
   WuaIXGPQZzep8jmQl13lAX7QD9bB+80o4L2iZTD6CypeOj4Z/jCUzzn9L
   Mv7xtMbBvtpmZW5PN64AkjBgSZJgiqL3ZIk0crqwbcykHMEgKoojaIXnE
   26IoPU6T7s9/opj89x9K4fM+Kv4E8CF2RTrg+T3l9o0NIqakJ7mSJ3Kuy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="435281146"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="435281146"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 03:06:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="793667637"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="793667637"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jul 2023 03:06:32 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQPnL-00053b-2j;
        Mon, 31 Jul 2023 10:06:31 +0000
Date:   Mon, 31 Jul 2023 18:06:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3] riscv: Handle zicsr/zifencei issue between gcc and
 binutils
Message-ID: <ZMeHiXvIBHAn3Ugo@c507f7d2ae6a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731095936.23397-1-xingmingzheng@iscas.ac.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH v3] riscv: Handle zicsr/zifencei issue between gcc and binutils
Link: https://lore.kernel.org/stable/20230731095936.23397-1-xingmingzheng%40iscas.ac.cn

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



