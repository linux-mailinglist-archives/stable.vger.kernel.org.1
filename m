Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8C374AE05
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjGGJsE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 05:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjGGJr6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 05:47:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F4C1737
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688723278; x=1720259278;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=oPd2nUTKWXb/GYrlGNmOZJgr4Xb6z3uaDAKVz3gKDxU=;
  b=j9EWBTzrEaj5zRhDJWeaKoMuSevcnuW1arnO4AP5GE0TKS6UP6Le4naJ
   u+0Y9IkHXrb4upMzMnsEimzA07VsPLIHVrHJd8m/db7yl0NzC5ggNKzJR
   wMS3tX67/mnRsaS43iKwOUZZKeSZs9a6mVSA87En5h+TUU+stlYV7IOGV
   gs0BM2mlNBSpbnwW6DneXC9FlLrM3mt4TVF3PocXM1BhGmT+WY9DIFUfX
   PUlLJr1oNMArvnL627YCTveswCDg+XMNjwnelRUv7/FNaYfFdMD56Pky+
   f1x9oIi9fszYeSRmS3RBUdtjMhnz7aMJShFVfCwT/DbF/piWbfbo0GZdi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="427536984"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="427536984"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 02:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="723169223"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="723169223"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 Jul 2023 02:47:56 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHi4B-0001va-1S;
        Fri, 07 Jul 2023 09:47:55 +0000
Date:   Fri, 7 Jul 2023 17:47:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V2 net] net: mana: Configure hwc timeout from hardware
Message-ID: <ZKffK1iEYX3xo3jy@a1daa7802ad8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688723128-14878-1-git-send-email-schakrabarti@linux.microsoft.com>
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
Subject: [PATCH V2 net] net: mana: Configure hwc timeout from hardware
Link: https://lore.kernel.org/stable/1688723128-14878-1-git-send-email-schakrabarti%40linux.microsoft.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



