Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF607747F66
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 10:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjGEIUf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 04:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjGEIUV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 04:20:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F54B1BFB
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 01:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688545177; x=1720081177;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=rz0v9QIUxLspvY/L3UqIDS0FVDS5+aMsMjXSkjqh5cU=;
  b=J9PGhKrybN/TYUjdRDp8/ch+h0MOUGnh/sKOKIXPMGlc7kY6oYF0O5+u
   Snd2Q98tGtkS7FMYzFCd3tDaZ210HW7vXJ75O31rlljulDiA1/J6QKHri
   ZcJ+y/DUNwneHcyE64ScLHhvyHF0Rdcf5MDLCw9ucg38PzRM6S+2Qa1lj
   roOBvsmLjeXVM8oXmkhd89dlJtbkmEjXqW31VofetNbJ/i7+Milu6tifZ
   5Jj7cq2zz/STfvsle79D+4DOEPilZrRvUWwf4cA2c4TYxhQC9JR68JJAv
   X8eZGXWMwdQd+2OdDtmoZQ+IwslMVmcX9cHcFDc1TsgtETU0nLxFUiMKb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="366764760"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="366764760"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 01:17:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="784442204"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="784442204"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2023 01:17:54 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGxhx-0000Vq-0P;
        Wed, 05 Jul 2023 08:17:53 +0000
Date:   Wed, 5 Jul 2023 16:17:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V5 net] net: mana: Fix MANA VF unload when hardware is
 unresponsive
Message-ID: <ZKUnLa+98qCZA5Dj@a1daa7802ad8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688544973-2507-1-git-send-email-schakrabarti@linux.microsoft.com>
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
Subject: [PATCH V5 net] net: mana: Fix MANA VF unload when hardware is unresponsive
Link: https://lore.kernel.org/stable/1688544973-2507-1-git-send-email-schakrabarti%40linux.microsoft.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



