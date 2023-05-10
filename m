Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6536FDA2B
	for <lists+stable@lfdr.de>; Wed, 10 May 2023 10:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbjEJI50 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 04:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbjEJI5Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 04:57:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D86C7
        for <stable@vger.kernel.org>; Wed, 10 May 2023 01:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683709044; x=1715245044;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=hsDroL5OJfwMcPeLPQf0whZvyXbB6eA/ti5XoHR6W7o=;
  b=KuKyP8AOozOrHQ4Y3EMIjk1Nhqkrn4wL1qWyDNn4rsJjcX2rc6DLBXNm
   5K1IdNn+INIGub0BZcbK0bnyZWnBn3qZcfqYbLi+uINUuOp87ZLpaq1+c
   xl0eoty6dIrlZw2SaPj0irMj7J1o/q8AJGbFiSYD7GfaamSA0X7kpy2Kl
   Zkc2H+zGEl/N/n49UEDIWzsTj2+wlq3sdwMJNEivR+zN+IEmQ/pZw51fU
   CdQlKZ58uDWH+ymJfL5ob0n1JkRu8Crrtwi0KzBDLNU1HXvA4CEFa6N+m
   31bsw8rgOHcVNhEUL1SgU4nFIp52WK0uIjueRv2s7V5oEicD/rE5U1tDO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="436486817"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="436486817"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 01:57:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="693315398"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="693315398"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 May 2023 01:57:23 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwfdS-00034u-2L;
        Wed, 10 May 2023 08:57:22 +0000
Date:   Wed, 10 May 2023 16:56:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jocelyn Falempe <jfalempe@redhat.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] drm/mgag200: Fix gamma lut not initialized.
Message-ID: <ZFtcS9tw7e29ylxz@e0f96cf4e6cd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510085451.226546-1-jfalempe@redhat.com>
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
Subject: [PATCH] drm/mgag200: Fix gamma lut not initialized.
Link: https://lore.kernel.org/stable/20230510085451.226546-1-jfalempe%40redhat.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



