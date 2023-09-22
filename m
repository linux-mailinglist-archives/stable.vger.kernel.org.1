Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F4B7AB60C
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 18:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjIVQdI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 12:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIVQdH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 12:33:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBBC114
        for <stable@vger.kernel.org>; Fri, 22 Sep 2023 09:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695400382; x=1726936382;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=n2tpziZFCVuyN6rruA1ZmLCh2RYhKljPGvsKB6KiRu8=;
  b=fm8x5K4Lh3tLc2WKqCVKHHnKz7ZSuWAaz+zfrUK+GtzvvxBEiv5I7fMA
   axaIRFHtYBhbsa2ioGaTPzffnwiTzNzzTVyyvSzlKZjdrmgRVRwKBesCz
   7Hsj1xmxpucTGi8n0nMx3jOFvjJkaMx7wakkLqpqH03YVmcghlyC9lIaC
   aj0C0xBsfLHmMBXg1HJW2gJ8Vt3N3lRPc0YAD5ZR1FGNh6rnCmTAhiAKz
   7msTC0epLPpYd3IWRXTXvK9DeyRwq0clRbNHJuJOOYC4BfGfORv29MnD4
   BCv+fpZS05PmMhYWJmsaqdWURnZgAxwirH5yaFXx+wUUQxyy5QzAjrASV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="379757033"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="379757033"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 09:33:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="890873689"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="890873689"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2023 09:32:06 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjj4q-0000zB-21;
        Fri, 22 Sep 2023 16:32:50 +0000
Date:   Sat, 23 Sep 2023 00:31:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [-stable,6.1 01/17] netfilter: nf_tables: don't skip expired
 elements during walk
Message-ID: <ZQ3BUNNkLY2EPB1n@845c4ce01481>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922163029.150988-2-pablo@netfilter.org>
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

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html/#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [-stable,6.1 01/17] netfilter: nf_tables: don't skip expired elements during walk
Link: https://lore.kernel.org/stable/20230922163029.150988-2-pablo%40netfilter.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



