Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F6E74A9F4
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 06:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjGGEdz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 00:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGEdy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 00:33:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F60C1BCA
        for <stable@vger.kernel.org>; Thu,  6 Jul 2023 21:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688704433; x=1720240433;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=vytT7TEwKhYPHkiJ3LpIi4rGC7Ld22/i2DIxPAtwzuY=;
  b=K7sJ573GohJAPRE8ar4NKTTU5dUhWxi+K5+583PC7UpADLqhyMi4QZmP
   W4/ZkVQqOp2yklUHCFL0jadu5QJtLydYpcQKfxgBPA7cYIrN3Eo5nTY6h
   avaxpGtJl/1GNdvfz3rOCdP4ibbu2GgBCjuzEcCa5AYepg8zIDGifxeHx
   6cS5FyVVdmxOlLtqvLOhM1Yh/ipMnw9p4R6tTxXFh6PpQcCAns7TN78Qb
   RQcuqDPT0nag1IB/I/SLVS28+npFJXvtRJpBZW6jVJ6DCIGXsYN5PE27/
   T6T+GojXb+C7NYPS7nIjXuv83gvQcQV+TvOiU/S5lWyePAfcbzqs8Dt1Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="343386832"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="343386832"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 21:33:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="713846027"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="713846027"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2023 21:33:51 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHdAE-0001le-2S;
        Fri, 07 Jul 2023 04:33:50 +0000
Date:   Fri, 7 Jul 2023 12:33:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/2] mm: lock a vma before stack expansion
Message-ID: <ZKeVq4oIFqT55cZw@a1daa7802ad8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707043211.3682710-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
Subject: [PATCH 1/2] mm: lock a vma before stack expansion
Link: https://lore.kernel.org/stable/20230707043211.3682710-1-surenb%40google.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



