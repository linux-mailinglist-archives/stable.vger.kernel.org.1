Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0767250E2
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 01:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbjFFXkY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 19:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbjFFXkY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 19:40:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B1110F1
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 16:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686094823; x=1717630823;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=SkN35VoikGXQ+wHaVA2USN5nZ2B0gn8hPQtHaZ97DiE=;
  b=X4v++CPXwCy/Jwe24vhxeoaEmOOx4JHruQE0WVS46HMI0aDO58f03isM
   B6349zQPppANnB0nNMqoE4R5azKV/jSuhDAytedylK+dnCe4Jqd7AXgpN
   3BbkBMvteIdPosksnkaQ30RSMecbfXG94l+mKJ7+8lLWoiFMpqEVysmjj
   ztO9YM/5Qn6Z5AZbsq5s8FchChPNkHUnvhipAM5RFrSaaQP/N9tj689Gs
   PthZ47+4N7sYykdsAmQpLQgBj47XUGRlye8vzkjyYOwoWeoShcE+8oxn/
   UPBbsfRUjLymFLjwtjR+kU1tugWLv5ltWNI/1Ty9WUPR8iuZIumhiCXJA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="443195498"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="443195498"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 16:40:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="703381039"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="703381039"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Jun 2023 16:40:21 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6gHk-0005sZ-2f;
        Tue, 06 Jun 2023 23:40:20 +0000
Date:   Wed, 7 Jun 2023 07:39:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] writeback: fix dereferencing NULL mapping->host on
 writeback_page_template
Message-ID: <ZH/Drf8GGc+7Ys9x@a93e062a6cea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606233613.1290819-1-aquini@redhat.com>
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
Subject: [PATCH] writeback: fix dereferencing NULL mapping->host on writeback_page_template
Link: https://lore.kernel.org/stable/20230606233613.1290819-1-aquini%40redhat.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



