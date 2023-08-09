Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBA477652A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 18:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjHIQcl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjHIQcl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 12:32:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1564010F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691598761; x=1723134761;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=LVlHBeINvP+Af/RAapRpeWCgtcWBzcpWLuoWQVhZnVE=;
  b=GHotRpTn6fL8XR/dwmdACurs5vrlBPUhBpXe2wO4V5t5pMyeCyS+7O21
   vNn51RQfiEc1sWYrK/j6RSwNHcmMF+VlCGRZ3cm2tktX5OVxC484VsmcN
   wGqg/TRqvFW0PbGmP1IHEmzD4Evzb1TTaL6Ps2GWtb+PLuzGhFWpLPeRG
   rx+UBMnzI9oEzdYTXQKKRVFlBrVqdeW2wsFggTcJSYum13aoAqCnIiXSp
   AS7PTpOJ7XGbL/cd2P2kZBKFmbOejZORJ2rgBpcgzYMfgBjq0yuz2VDOD
   BAU4tOORvw4b+0ny81NLllRD/6zYEHgQa1wQu8T0MVTv0ZwO7foGMV4tf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="402131340"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="402131340"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 09:32:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875328485"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2023 09:32:42 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTm6x-0006G8-0G;
        Wed, 09 Aug 2023 16:32:39 +0000
Date:   Thu, 10 Aug 2023 00:31:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Documentation: stable: clarify patch series prerequisites
Message-ID: <ZNO/a5at5umehbti@11d7ca01dc46>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809162941.7769-1-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH] Documentation: stable: clarify patch series prerequisites
Link: https://lore.kernel.org/stable/20230809162941.7769-1-hugo%40hugovil.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



