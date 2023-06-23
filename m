Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC07573B1B4
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 09:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjFWHcF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 03:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjFWHcE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 03:32:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788E81988
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 00:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687505523; x=1719041523;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=6i6aS5or0UbyJjQKq6Mwkei167b+Q8Ja8wfDrpOhhhk=;
  b=m5C41HzDqyWB06vRGq2nZCrTpkR3CQ/hnIC+EhUCQ719h36YBPvwJo6V
   rqC/6M6VZRRlW8wx5mVKZh6u7gH67NOJYzU1JzDCU6MIhmGxlc5//i8ad
   QKxOhhxC/ueufXzjCHYUp0qUoiAVwV81LIBmrVdwT9QbeT5xOXdO2jHKm
   GfavDP0AEMynXjHinAB+cJQ370CTuesAwtAqOcimvcAPgX76RKEVwnJ9u
   HpKAX/DYC95huWPD8p/QJgvI67Y81OUzmqUnkkMU1kTrV5Z/UttfWPY2j
   hu2KTMnWvXFeHQIfuf1blULEQchXaaSB7ZaXypZxD3ThpN1a5ysqwitZZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="358200553"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="358200553"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 00:32:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="961878180"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="961878180"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2023 00:32:01 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCbGy-000859-1v;
        Fri, 23 Jun 2023 07:32:00 +0000
Date:   Fri, 23 Jun 2023 15:31:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     souradeep chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V2 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Message-ID: <ZJVKWe3QYybrme8x@65525e8f8615>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687505355-29212-1-git-send-email-schakrabarti@linux.microsoft.com>
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
Subject: [PATCH V2 net] net: mana: Fix MANA VF unload when host is unresponsive
Link: https://lore.kernel.org/stable/1687505355-29212-1-git-send-email-schakrabarti%40linux.microsoft.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



