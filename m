Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA78D72E040
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 13:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbjFMLAH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 07:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239377AbjFMLAD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 07:00:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4D31727
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 04:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686654001; x=1718190001;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=CgeOb7YfFNT0oc72DRtaL4aP+N7E0yaJsIXhXf4UAqA=;
  b=JHgkR8Fm23nfB9UtVAS7O1JwDaAMz1ZiqHi9hp+w0MsmQkTbMcP3fMmI
   EAhrU0/jZ0HSiZX2Jl0tzyfHQOdSy5UNa0Cu6X262nduGUAOrcfxjkID2
   4fyhqgTEdfcjfc66PrqWONZ5pO5jcmE7Gt3L7hH/0IsKcWH8M78hNKgO0
   yY9kL/9N3RKpmecPcqg4hTzotGZT6D0kjsvriiDFsw95lhPK1vENcazj3
   p3c9prVHWIYmPSsMCbGeJ+h2yTaXutfMaMe6POOCNAmOdcNbTFJDKp3Z2
   kcuhS8qoXxAMQwIyjyoGqtgKWcCnAWzsxA4LTxKqOBBH6+odpjll4yl2j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="338657856"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="338657856"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 03:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="1041726237"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="1041726237"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jun 2023 03:59:51 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q91kc-0001H6-1u;
        Tue, 13 Jun 2023 10:59:50 +0000
Date:   Tue, 13 Jun 2023 18:59:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] perf/x86/amd/core: Fix overflow reset on hotplug
Message-ID: <ZIhL96ombK2BwQiH@eeaf1f6db856>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613105809.524535-1-sandipan.das@amd.com>
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
Subject: [PATCH] perf/x86/amd/core: Fix overflow reset on hotplug
Link: https://lore.kernel.org/stable/20230613105809.524535-1-sandipan.das%40amd.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



