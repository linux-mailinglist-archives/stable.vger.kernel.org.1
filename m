Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07577704BB
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 17:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjHDPbc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 11:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHDPbS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 11:31:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EB54ED0
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691163017; x=1722699017;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=RXUgXJ460/N3w4ixn9YIAH2dxiya11UE6bCAGMuC4G4=;
  b=LJZ3qMteTRf5bYljBMY6DCiR/Vi9Yq25dL0vsaehBb5tFJGXruVra7ue
   DEsl605Uq86d7Q6TxSqy/GpvFv6wJBDRMWwknYs2roIMpeUF81OAvtNoK
   5g9wVxogreJ+LbPVpC6jSSyWhVhKwh5r5N0x/vYSh4jU/7ZfV7zJmOcBD
   ynpCTxJnr8eoEylYDsh9GZ57Poq6Ng5qgTXOnuwF/sIYneZCKEUmcXyAc
   GX/Y/V77QLGPN0l9O9DKIc/LN8CIxgz+lje8mGlywpw4PxAiEmPEtFzhU
   QFuWWtPStbPPuHJnADuEMdhVW15/A5yvhjb9hHgourMVqI+TFLnHGlS8+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="372924417"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="372924417"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 08:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="976622864"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="976622864"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 04 Aug 2023 08:29:38 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRwkD-0002vN-0v;
        Fri, 04 Aug 2023 15:29:37 +0000
Date:   Fri, 4 Aug 2023 23:29:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 2/6] mm: for !CONFIG_PER_VMA_LOCK equate write lock
 assertion for vma and mmap
Message-ID: <ZM0ZTrTtj/McL+FT@11d7ca01dc46>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804152724.3090321-3-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH v4 2/6] mm: for !CONFIG_PER_VMA_LOCK equate write lock assertion for vma and mmap
Link: https://lore.kernel.org/stable/20230804152724.3090321-3-surenb%40google.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



