Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A98378702B
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 15:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239590AbjHXNX4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 09:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241152AbjHXNXy (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 09:23:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7381F19A1
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692883432; x=1724419432;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=4Q9K6P4vwc1oLvCJ3m1fHBD0HH4SALhn4Uqx9s5+pKk=;
  b=VNuhuyuGuJg31HQKEojcIH2Ctz6ucm3UOK/EmrJVQPmVK2K1LwYrSjLa
   vUyN/vSZQiNjWe459qNcYy+jG6teCBV2bNZoI5zgnpmXv0f9/VyDDGXr4
   4Juez8wLDvUrUr4i62J+ghXBXMLdgQ/WtrGCJPHtCpYBA53QnOU9AEIxm
   b+7H0HX/LllIPhpLlBQEV0bbESrIwr6muVPPIrgnGp0sxKerf2ivDcK74
   NKd7BH17gIyOYllTU0FV9qXhMKHEPXCIoQ/3xkjsbMEpiEbn4A1BZFGbO
   JmK+r+CB7nzYc1wwekVQL5kBPq+wYFWzQ4VDEbzNLoYapcza396cnHCBb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440784056"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440784056"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:16:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="766540999"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="766540999"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2023 06:16:09 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZAC1-0002hM-01;
        Thu, 24 Aug 2023 13:16:09 +0000
Date:   Thu, 24 Aug 2023 21:15:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandra Diupina <adiupina@astralinux.ru>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] [PATCH 5.10] iommu/mediatek: remove redundant comparison
Message-ID: <ZOdX/4Sqkr7y5v5D@24313c2339b3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824130954.29688-1-adiupina@astralinux.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH] [PATCH 5.10] iommu/mediatek: remove redundant comparison
Link: https://lore.kernel.org/stable/20230824130954.29688-1-adiupina%40astralinux.ru

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



