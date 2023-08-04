Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE387708FC
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 21:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjHDTXs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 15:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjHDTXs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 15:23:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D681E7
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691177027; x=1722713027;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=hsjEaubB1Q7fOXKWBUiJULce7LHJktJCZnS8XGv1GBI=;
  b=L8Edar08974xTdTadembJ7rtKz9Hk0otVnOaCvDBTKKmx8QW9pWVM6BB
   LkgTYZuK71VYs27Vj3yPoM9s8o1hf8oAFhjl0Og9kp40MlijbNYm4+Gv2
   zCpMsagUGFTpkqAuFZXjMTmvAHD58ldOKc7XfnPo4TscxTmHGIf6lyxga
   Q5e1nr+o2odkY0GFIsUC/W+CV/LwIeTNkxnYPzRGna0uiXzPI/sLQWBe4
   3mpanS4AU0rKp5EzUov4HXjJSwb19PXOcmOJk5lXOvcUrpOexWy2PbDcS
   qWC45q89c7I6FGSmwBSdBBwWBwf/WDzikl0nWPqSmNo4NvFJiagQlvnge
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="373884385"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="373884385"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 12:23:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="733378053"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="733378053"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Aug 2023 12:23:45 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qS0Om-000347-1y;
        Fri, 04 Aug 2023 19:23:44 +0000
Date:   Sat, 5 Aug 2023 03:23:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] selftests/rseq: Fix build with undefined __weak
Message-ID: <ZM1QJ1E/iqnIXtbP@11d7ca01dc46>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804-kselftest-rseq-build-v1-1-015830b66aa9@kernel.org>
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

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH] selftests/rseq: Fix build with undefined __weak
Link: https://lore.kernel.org/stable/20230804-kselftest-rseq-build-v1-1-015830b66aa9%40kernel.org

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



