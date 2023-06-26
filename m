Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B613473DB4E
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 11:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjFZJYF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 05:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjFZJXm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 05:23:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428EA1BC9
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 02:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687771271; x=1719307271;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=OxoDYKes+yK7X6t6RqKhg0wpWRdW22YGq8MvZGmIHSA=;
  b=hQROzrllaGQyVqvaICXl1sbDUlNu2D+Zms62BjGVqVH2gsNj+z/ZWygL
   Zwew5c4Sv6WTrodPwqiuceSGI4T6NrRhs+zHy+wr1oL881lkasyDZi2e/
   0Daq+gzwLERqZIuqvCjXuC30B96F73gsvRfaqdag6XaJe5/6TDbyDJ9I1
   Vlcu3SydNeMTAtO13h7RKvtBQ/6U+EqXpiX4p0CzzotyqPkg95FsC1dt5
   rtfn01XNcuq886kIW9KeA0CmA9p9UU84DYjVv0NjyEiA8tOibpZGCJB39
   hrH5VDbYVwda++8qyOtzWB7eWA7tsVqG8g/iL1ro4YAzPYHoqVzVYWufk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="427215982"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="427215982"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 02:21:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="840198526"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="840198526"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2023 02:21:03 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDiP9-000Aaz-02;
        Mon, 26 Jun 2023 09:21:03 +0000
Date:   Mon, 26 Jun 2023 17:20:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     souradeep chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Message-ID: <ZJlYbnr2UzONeu5U@65525e8f8615>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687771137-26911-1-git-send-email-schakrabarti@linux.microsoft.com>
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
Subject: [PATCH 1/2 V3 net] net: mana: Fix MANA VF unload when host is unresponsive
Link: https://lore.kernel.org/stable/1687771137-26911-1-git-send-email-schakrabarti%40linux.microsoft.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



