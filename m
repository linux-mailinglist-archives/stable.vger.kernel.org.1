Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07475723215
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 23:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjFEVRb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 17:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjFEVR1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 17:17:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6B210B
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685999846; x=1717535846;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=aJemtPDOxeFn9N7eyTvWoH2jfM4pz7iAV9M5F64U1IY=;
  b=A9jHu7AfT15PRhwphgGSggEE8wCVcW9kQvYZggwYeexXZJAt7ctdewXM
   J8O4kyk5zNV9nFPVEjo+P9pjn7SM8ytW8d9PKYnmi7sM0u6Lx+L8xFLUM
   +tbYoVwyTtl5N//h1OOQhaC4J920+BkOBOuewewOLBUqVpJbc9/6f1Kl+
   0yRmAWI/QLwoOLXe8zusju6iH/8F1YA9of33fYJV1w8MnAnJQ3bJ2CunM
   /jqtGxZb6chOUewYHwY8X/ZcXC89xBIOimwV6wEBsFUS6IEGLAJx5+eIJ
   E+YysRMeQV8tYDm7US3hVnbty22D8JTN3BaGuboin4RDGFBkMHef7i7A6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="346084016"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="346084016"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 14:17:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="738495801"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="738495801"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 Jun 2023 14:17:24 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6HZs-0004Rn-0N;
        Mon, 05 Jun 2023 21:17:24 +0000
Date:   Tue, 6 Jun 2023 05:16:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.3] riscv: vmlinux.lds.S: Explicitly handle '.got'
 section
Message-ID: <ZH5QtX9fIX+ekrZ4@a93e062a6cea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605-6-3-riscv-got-orphan-warning-llvm-17-v1-1-72c4f11e020f@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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
Subject: [PATCH 6.3] riscv: vmlinux.lds.S: Explicitly handle '.got' section
Link: https://lore.kernel.org/stable/20230605-6-3-riscv-got-orphan-warning-llvm-17-v1-1-72c4f11e020f%40kernel.org

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



