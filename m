Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DDC73137D
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbjFOJUw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 05:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244119AbjFOJUt (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Jun 2023 05:20:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE5E2135
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 02:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686820848; x=1718356848;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=HCMZV61d40ss4fhHLQyJcAaJZgybNYEat4Jl/lsYfNg=;
  b=WkTwl78wTAWkru1GtyWI6jSCMjmOCmoawTGJUosDfEqk9TKEAhAO7s73
   3Q0io1Owm+kmyiqiTQv3NSXkMYaIeeiPqFD5Ef/3M3Qwutsl+ktzl4Ilm
   x6vxhH0LUpeyCJdwJZ0adddSeqAqVPLsqT5VA13vPE7OuOlXMIc62RfAo
   2F1XQtbtqc8R8F/RVoMV3b44yXARp4PAQlitcIz8KXu2xeGQOBLteQ+56
   qvgd62b77wufGycyriAsIINOkxFr0n3DZgUnw4/LfqaEKo0YaZU1Cb4Zn
   38oHJ7N8WgjV6Hlsq76eKx8A6qj9ldZ7aTptXuReJdV9CGkpjnCVTz0w0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="424753566"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="424753566"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 02:20:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="742164171"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="742164171"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 15 Jun 2023 02:20:45 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9j9o-0001h7-30;
        Thu, 15 Jun 2023 09:20:44 +0000
Date:   Thu, 15 Jun 2023 17:19:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] tick/common: Align tick period during sched_timer setup.
Message-ID: <ZIrXuAcuD3ifejE2@b4e643f4d690>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615091830.RxMV2xf_@linutronix.de>
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

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH] tick/common: Align tick period during sched_timer setup.
Link: https://lore.kernel.org/stable/20230615091830.RxMV2xf_%40linutronix.de

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



