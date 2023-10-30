Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B827DB909
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 12:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjJ3LgM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 07:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjJ3LgL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 07:36:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01002C2
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 04:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698665768; x=1730201768;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=niK4jLVseIMGFlEgNQKmfalRVewRDRR5eW9rIRJd8wM=;
  b=KANzggZVEo5/KusI0pyB1PzUweBQu+mSGBchOQZfEj7c9prRTOSl2fPu
   wsUp9vpxsR22FOfHGfBVRFJR553ptVD3gSREL8CTlaVmr0bLXsS0TQlLh
   lhb/mQyW56p+VDstwkIDDNw1rxdcqbHxELDbsUW8aaTMto4K1RADXIpfr
   ls9sVWxU+c8U1wyYPAahWCycz8Otw9vtt+7aoJji+jyZukkjZUE8dDDay
   6U2mpuBdWUYH439IZTDpgDnQLM4EsVeGKQQuB9COXJg7VJo76dx3UUKp9
   xkmXHQDuwPSMVV5m0PmXnu8/hDsNCarruBMnrh+r7p6j+wVBR4mlY7VKA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="454518970"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="454518970"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 04:36:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="7930726"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 30 Oct 2023 04:36:08 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxQYv-000DEx-0L;
        Mon, 30 Oct 2023 11:36:05 +0000
Date:   Mon, 30 Oct 2023 19:35:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] can: isotp: upgrade 5.10 LTS to latest 6.6 mainline code
 base
Message-ID: <ZT+VBj4RhTxjBbG1@dceb3e7df498>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030113027.3387-1-socketcan@hartkopp.net>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
Subject: [PATCH] can: isotp: upgrade 5.10 LTS to latest 6.6 mainline code base
Link: https://lore.kernel.org/stable/20231030113027.3387-1-socketcan%40hartkopp.net

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



