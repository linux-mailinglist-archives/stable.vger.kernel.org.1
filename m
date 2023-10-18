Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145787CE04A
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 16:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjJROnE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 10:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjJROnE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 10:43:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E39994
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697640183; x=1729176183;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=nmDMp6vui9J7GGgaUmqVI1J/abW7L+xpXrDJ3RYgWD8=;
  b=GvGN98oUBfWHPfx9AMF15Y0GvTHLePvi+lw5Cp7miNGFgGQT6B4VNNao
   dMQpCsqxb+i0sWi9+O0HK7wUNizLD8OHIlvZ6/7Kq0DEXrtMoDyzP99ZW
   ExF9S6H238io4OKFDXmu5Uv9oTCYyk3Fm7gWAytbD3D/eIaI2reiOvGcZ
   6kDIru/O8kdh9nsOBtHNXFAJlsDSUqC08VFIFOz+PUpxqyWP+FUU7BEHh
   Q9gtpsG4IMvrXLGwx6q1VlCNNXiwtaMc4QXkwUpbNNQTMz5F2ls7YO7ls
   8Pkr0jOnwtP14wvJm/uS4iUGl81H0fPKWB2ZhmxwkoMb+stAg2sdeH2hH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="472252937"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="472252937"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 07:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="785951705"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="785951705"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2023 07:43:01 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt7lD-0000Wi-0I;
        Wed, 18 Oct 2023 14:42:59 +0000
Date:   Wed, 18 Oct 2023 22:42:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 1/2] tracing/kprobes: Return EADDRNOTAVAIL when func
 matches several symbols
Message-ID: <ZS/u0o3R3Vj2JxTJ@dcec3e67a8dd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018144030.86885-2-flaniel@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Subject: [PATCH v5 1/2] tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
Link: https://lore.kernel.org/stable/20231018144030.86885-2-flaniel%40linux.microsoft.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



