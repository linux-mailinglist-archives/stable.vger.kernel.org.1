Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759387671B9
	for <lists+stable@lfdr.de>; Fri, 28 Jul 2023 18:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjG1QTB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Jul 2023 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjG1QTB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Jul 2023 12:19:01 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E12F1BF2
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690561140; x=1722097140;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=8GasTYLXUj9zHrXEmK6pezB61udamlYFYxz443NLwFs=;
  b=F+ULVjJsdrUCnrMc8KiQP5dK7nMkFsa4C3+BLD3oXwYEbXqid/qpVWV+
   2NlMEPHzasT/9vadOVO6dAD4OpFGKPQ1cpd0bXDxvoyQRzXRIERBOYMvR
   WK1IIraP2spMHR/4KW9Nbwt45TSUdb5qTqm4q0Y4w5ieR26/+NkXZGvbQ
   +nGBDao5IwHRgFqLv06uD4CuBVMkSbgGxKr6XsUzuFAwz30v286JdAZYV
   hKNf3hKrijx1XY5IxOlldALybheDvYOChBR46QdMvQHmPS1/+aMaZpUN5
   OIoPSyDijU8/AogAyAivJCXBnDDIcEwgx07k1e4oefy9TpINqumE5bMmL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348918306"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="348918306"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 09:19:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817564068"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="817564068"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jul 2023 09:18:59 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPQAn-0003Mh-2U;
        Fri, 28 Jul 2023 16:18:44 +0000
Date:   Sat, 29 Jul 2023 00:18:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] madvise: don't use mapcount() against large folio
 for sharing check
Message-ID: <ZMPqPUc4ZyypNWeg@c507f7d2ae6a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728161356.1784568-3-fengwei.yin@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
Subject: [PATCH 2/2] madvise: don't use mapcount() against large folio for sharing check
Link: https://lore.kernel.org/stable/20230728161356.1784568-3-fengwei.yin%40intel.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



