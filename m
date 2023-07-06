Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1224F749B90
	for <lists+stable@lfdr.de>; Thu,  6 Jul 2023 14:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjGFMR2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 6 Jul 2023 08:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGFMR1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 6 Jul 2023 08:17:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D288C172B
        for <stable@vger.kernel.org>; Thu,  6 Jul 2023 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688645846; x=1720181846;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=tmboW8yx1/+ZQqBNV+MR5wQoq2TPiTukKq1gxHNahg0=;
  b=c2bETAKrnMgzw3PbQhh9GHZ7SkK/kxOGhJ57aXo99kvmwTUTb3/Np4L9
   cMkBuuFekFJDxDp+Y6ue8/RngZ+lCQO8sYnzSrk7MWI6jMvkt2Q27FO31
   72ygGTLALkEdWQUAB2k6wVw54hOykw9o8YVIntIJf5dmiKZid6dd2KZle
   FoP06saoJJB6ZQCLfrfjPCPHWc3YU7lgOBCV3OHnXpfXGD5RomwyuF2Ai
   QyhU8ZiczjbSnkl1HgAFkCR2NYLc6qAyo6qfvHwJX8mjVs5q0Io+J+hq0
   EZbpJZT2+0IKy1QfDIRm72iaj1rjJKDtViLoShYm+eoJu8uODbkv0/E/n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="449945463"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="449945463"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 05:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="754739045"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="754739045"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Jul 2023 05:17:24 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHNvI-0001J8-0H;
        Thu, 06 Jul 2023 12:17:24 +0000
Date:   Thu, 6 Jul 2023 20:16:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V3] PCI: qcom: Fix broken pcie bring up for 2_3_3 configs
 ops
Message-ID: <ZKawt2xzy0f/bzxe@a1daa7802ad8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706121537.3129617-1-quic_srichara@quicinc.com>
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
Subject: [PATCH V3] PCI: qcom: Fix broken pcie bring up for 2_3_3 configs ops
Link: https://lore.kernel.org/stable/20230706121537.3129617-1-quic_srichara%40quicinc.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



