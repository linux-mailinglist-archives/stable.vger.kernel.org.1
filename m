Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159907EFDF4
	for <lists+stable@lfdr.de>; Sat, 18 Nov 2023 06:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjKRF6u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 18 Nov 2023 00:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjKRF6t (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 18 Nov 2023 00:58:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07981E0
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 21:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700287127; x=1731823127;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=lETp/Jk+i+KkMU/hVVA0F4jxV/LptTSso1wDlfVLERE=;
  b=Y1zn6fml4uSw9KcOs13gn3X3mcdFEjefH4dL0ff9xH82g1iHENw3Us0P
   C/yGEKnMtffyLrnuNeGr9A56jyLsLCLmClvVXC7XQhOL0il9S2IGszReB
   kUD1eNLJg+kaTpqlHoD5PkVTtfPtQ2cWeJLWkUOFcyur7QTUY+kg6OGZS
   OVAIBHkktayBdQgkRElqTn9ZmDMU6P5FRwhpaqZrWG1oD+1x4zm5mnLkt
   24vZzO6uAKOdAunI/us0qTvsuPWkIp5xRMocNrXh9nwXePdlYKm4JzpVk
   e+/oEM+/VOfmV6IzaDZeAuIO9WEqzwKaqMCJ3AbMmYqovDrr4EGSkfNlh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="455705521"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="455705521"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 21:58:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="13679738"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 17 Nov 2023 21:58:45 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4ELq-0003Zn-32;
        Sat, 18 Nov 2023 05:58:42 +0000
Date:   Sat, 18 Nov 2023 13:58:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] dt-bindings: usb: snps,dwc3: Add
 'xhci-sg-trb-cache-size-quirk'
Message-ID: <ZVhSib_6PwRw4Bz1@6473735b5665>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118055455.249088-3-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Subject: [PATCH 2/2] dt-bindings: usb: snps,dwc3: Add 'xhci-sg-trb-cache-size-quirk'
Link: https://lore.kernel.org/stable/20231118055455.249088-3-quic_prashk%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



