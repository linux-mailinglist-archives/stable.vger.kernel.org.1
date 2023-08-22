Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3288F784CB5
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 00:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjHVWJV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 18:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjHVWJV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 18:09:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AE4CF
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692742159; x=1724278159;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=j+9TAz65NR9x8sN8e/5bYTTQCD3dgfkDKeLaOToZmfM=;
  b=BByOvSVB3Se2eqIoFjjOtEOJBOyWC07hBDtpf3nw7qO/SeF7SmwSBZB3
   EV1ZoB7jIgNUSDrQoNH7kepm4h43zWwzIsOCYYiwX9f13XSL4fpKzj9mN
   fEbCi2zq3e5CjH5n4Z60Ex1efzQbt0TVPxUOkZrGIXS0ohK8/X8T/EnDo
   wsc6VtPLBf8SZJaBJqiu9GVsWlpk9Jw1Yck55ARWyp/QU4eZfJHrFJxzw
   einvue4vSEajB9CWbWItucBiECLGcyib5GJXsO3FdWe4WJLxFWQoXejoh
   vCKglP0fIN64nOXLE1rAZqIsounpmi9O9YlrmEhKj+F7eT2LfR7CRFH4a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="364190142"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364190142"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 15:09:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="806447531"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="806447531"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 22 Aug 2023 15:09:18 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYZYr-0000Z6-1M;
        Tue, 22 Aug 2023 22:09:17 +0000
Date:   Wed, 23 Aug 2023 06:08:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hardik Garg <hargar@linux.microsoft.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.1] selftests/net: mv bpf/nat6to4.c to net folder
Message-ID: <ZOUx7Q7mB3mC3Fe7@24313c2339b3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822220710.3992-1-hargar@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH 6.1] selftests/net: mv bpf/nat6to4.c to net folder
Link: https://lore.kernel.org/stable/20230822220710.3992-1-hargar%40linux.microsoft.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



