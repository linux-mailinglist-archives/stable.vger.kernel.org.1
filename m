Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D933B72B1B9
	for <lists+stable@lfdr.de>; Sun, 11 Jun 2023 13:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjFKLnN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 11 Jun 2023 07:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjFKLnM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Jun 2023 07:43:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C8E1FF3
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 04:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686483783; x=1718019783;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=E5tnMPR4ssl0yl4TxLO20zos4fGwPMgMcFCqzhrnMD8=;
  b=AvltVyZbn6HZe72+7K5v5CnL3V2yzli/m6dhH7Bw/HL9s/SZQJZRQTy0
   nCTg8bfXBvoONKYa2qJAnrXyuLEjEPKjnAcK/Iapet/7WZuL7XI3B9tZb
   hszib7ZMbhv/T2YEsUajXHwDSEj4WmGK6jwcpxpm91z7nmbeuwE0q0WOq
   VWT3PLqEEx4EwJFEhlzP2/K1ow4Nnnk955fd6hITyDfmWdvy/8tvGgLOT
   YvWmK4+plIZ9APunwKxEehixyZ2K8dQGGa/4BYa1fgZjHCUEEIxo7INHm
   RyPP+udJDwnufR/DHOD9PDGU1yMgr/2WASMw36TXj+816N8G7d59HDoW9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="356738506"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="356738506"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 04:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="800717759"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="800717759"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jun 2023 04:43:02 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8JTJ-000Aq4-1v;
        Sun, 11 Jun 2023 11:43:01 +0000
Date:   Sun, 11 Jun 2023 19:42:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nils Kruse <nilskruse97@gmail.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] nvme-pci: Add quirk for Samsung PM9B1 256G and 512G SSD
Message-ID: <ZIWzQpH8poJc9nL9@eeaf1f6db856>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b99a5149-c3d6-2a9b-1298-576a1b4b22c1@gmail.com>
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
Subject: [PATCH] nvme-pci: Add quirk for Samsung PM9B1 256G and 512G SSD
Link: https://lore.kernel.org/stable/b99a5149-c3d6-2a9b-1298-576a1b4b22c1%40gmail.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



