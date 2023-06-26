Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0DD73DB45
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjFZJWY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjFZJVz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 05:21:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF20B8
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 02:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687771210; x=1719307210;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=UAr7VLhqd3G4sFGx64mLdlDTgYzrAy/Bn+bdErb2mgU=;
  b=EJ1jHTjKREE8ItPRcprMYGukefuEeGFh0mpzzyWwHWrd49kWOALu+3V1
   bZ/i6zvgZ5NKb6m9R8pz2/ptYvwO7gb5AY1ZBvgyHKccCP/xl6ZhvNag7
   QIERgrhDIRzwDKfYrQwbH9gUGbpJlkq8gMqvnCfBryn7CoJgh0e5w3WJA
   Czo2/dq92NrJHI+JJdVmMqei7nDoECmgHBi+D0Cz/PAxBsA0sOZTHVBSI
   HiMViXsxbJSRhRGPSdKyWxOjHVeczGzRLkjaoV7mIXqFmjWDLwZgIBXyA
   OEA5uWgdKVOcrUnBU/QNRlQLWTJt28rc/in2jFSjrbjyJUJFLDHs5amhA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="341559518"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="341559518"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 02:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="710152402"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="710152402"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Jun 2023 02:20:03 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDiOA-000Aar-37;
        Mon, 26 Jun 2023 09:20:02 +0000
Date:   Mon, 26 Jun 2023 17:19:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     souradeep chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Message-ID: <ZJlYCCClK4GzblA+@65525e8f8615>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687771098-26775-1-git-send-email-schakrabarti@linux.microsoft.com>
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
Link: https://lore.kernel.org/stable/1687771098-26775-1-git-send-email-schakrabarti%40linux.microsoft.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



