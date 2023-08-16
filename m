Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A7577D8AE
	for <lists+stable@lfdr.de>; Wed, 16 Aug 2023 04:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbjHPC44 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 15 Aug 2023 22:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241454AbjHPC4k (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 Aug 2023 22:56:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34B12136
        for <stable@vger.kernel.org>; Tue, 15 Aug 2023 19:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692154598; x=1723690598;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=BpadUsvJXDmAr0q0akrmpXCQ0ANUKEyvprrX6Az8xvY=;
  b=RbG/OosJQQLt7U2j1lvAD5ZYmwxEzxgU9h4EOWweKpedX0ySqnCW04h7
   ulrrjpKMKkJW454oOOLg+SLxjUqM8xes179KxfCyLpGTCZkIr3uGG5wRJ
   0sSC3OZ56lPRu8CsLWgqzrLXCRx18jM0FJVtovRYr6m+o5Dd9fddLq30K
   P5prNcdaogsIkJiRxZx7MQuhMKRl8neH2xh2Wbt/f3T1OoYjRGEoYUrmm
   OpuUQfj4X/7/TV1nRgrGn4nIPUXcO/5VpvtlLkWSREwMtArCUVrnzxAqq
   kASIdYQSs5r/5kQYGiHOlU0x4weF2ZX19HzbRjD/MMMtTmg4wsr59pvIJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372424102"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="372424102"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 19:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763486169"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="763486169"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2023 19:56:37 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qW6i4-0001Qt-1C;
        Wed, 16 Aug 2023 02:56:36 +0000
Date:   Wed, 16 Aug 2023 10:56:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yan Zhai <yan@cloudflare.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 bpf 1/4] lwt: fix return values of BPF ops
Message-ID: <ZNw603SSAV0rMiGH@de6b5a1e2688>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28cb906436e87eada712f55e63ae5c420bea0ecb.1692153515.git.yan@cloudflare.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Subject: [PATCH v5 bpf 1/4] lwt: fix return values of BPF ops
Link: https://lore.kernel.org/stable/28cb906436e87eada712f55e63ae5c420bea0ecb.1692153515.git.yan%40cloudflare.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



