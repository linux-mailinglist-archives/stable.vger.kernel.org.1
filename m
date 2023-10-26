Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5837D8BFC
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 00:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjJZW7v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 26 Oct 2023 18:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjJZW7t (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Oct 2023 18:59:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406C41B8
        for <stable@vger.kernel.org>; Thu, 26 Oct 2023 15:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698361188; x=1729897188;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=7t4ByVswuCgIk74mdZAuhqokz4zBY6KqjAb+1YRMgLE=;
  b=DuBe3qAfKxpTP43r513dul2zUNcM0ug6rums1n3f5aC5jmhaYGPFM6Hz
   MPKrhAN4qsSrJ6v8cpNmEH2DXQTkpppaKR7xIcSSZx9HVKtPyDg2BE1Pg
   nrbVh5QAirMByGUOUrDhqyyZ833Yc1q+1wzXMTy0WCNlpErTeuwGSizHq
   NpmUb582FBpiD2urRWhgf0ASE8/e84mBbU2v4MvK7LrX7W0P6HX4GE8Ne
   IM0RE+RsHadFSE8UEg9wTskD3w7i9RZ8ttppm4+Qusj4mNk/opBW7wtto
   kcH3+aSL8medbtRyMW2+VbPupZNsXV/b87ztKOf47xpSRAEEOybCGRKU5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="391544598"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="391544598"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 15:59:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="7036453"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Oct 2023 15:58:24 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qw9KK-000ACh-1n;
        Thu, 26 Oct 2023 22:59:44 +0000
Date:   Fri, 27 Oct 2023 06:58:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Revert "x86/sgx: Return VM_FAULT_SIGBUS instead of
 VM_FAULT_OOM for EPC exhaustion"
Message-ID: <ZTrvLTBjjhLyUAL0@20f93f21cc77>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026225528.5738-1-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Subject: [PATCH] Revert "x86/sgx: Return VM_FAULT_SIGBUS instead of VM_FAULT_OOM for EPC exhaustion"
Link: https://lore.kernel.org/stable/20231026225528.5738-1-haitao.huang%40linux.intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



