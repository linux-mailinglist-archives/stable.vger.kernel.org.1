Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A11975157C
	for <lists+stable@lfdr.de>; Thu, 13 Jul 2023 02:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjGMApN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 20:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjGMApM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 20:45:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5FC1BFB
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 17:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689209112; x=1720745112;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=2JSW+fqxtpaewM6OwjihilivyyFzTam+eb7IKME5l8Y=;
  b=CNOeXvb0DpdC6qfOz4uFiTL0vEKfFUmDUVc/Y2HvSooPsOLylGKKZLEj
   gYjB4qdwE6G4izFVvCLAo/BuHXUD+5NQYyiw8l7GUHTUA00cBZjgJgT8L
   NDhg84VlngfJ3oxYqka4IhVHtwFBRv9oBGj3CSIbVmJBsq1JoCzlmbs3T
   nVm4M/JBwyt3+wlmgpTQT7PXq39+NmiVJAgpHWWU3UrlGnDEFoB+K+QfM
   Vp+/jy0A/gKyZ8B5BFQqCMeihodKLST4LBRnnAwBb2Y/8l6VrjPu8cFLp
   jyGDS2kicIg0Du/qyBiuWzaMxH8ah4wcI79VHfjYoJ+UwJaWi1axNCgZ9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="365072771"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="365072771"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 17:45:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="672064085"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="672064085"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 12 Jul 2023 17:45:10 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJkSD-00063t-1Z;
        Thu, 13 Jul 2023 00:45:09 +0000
Date:   Thu, 13 Jul 2023 08:44:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ruihong Luo <colorsu1922@gmail.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4] serial: 8250_dw: Preserve original value of DLF
 register
Message-ID: <ZK9I7A3xo+I8x7fo@a1daa7802ad8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713004235.35904-1-colorsu1922@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH v4] serial: 8250_dw: Preserve original value of DLF register
Link: https://lore.kernel.org/stable/20230713004235.35904-1-colorsu1922%40gmail.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



