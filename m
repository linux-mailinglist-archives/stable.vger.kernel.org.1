Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAE96FF084
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 13:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbjEKL2J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 07:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjEKL2I (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 07:28:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EEB6E87
        for <stable@vger.kernel.org>; Thu, 11 May 2023 04:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683804488; x=1715340488;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=LGTcFkUu2O2bNdVPjLIv5NydNt+bv7zs9YzW4TO5K0g=;
  b=n+CsfER116V8boKkOxWQtOkR8lKArnOc+5W+xxgnn3ICQZDIh/Yat8cr
   1AkyRhDBeidsBCNb+noHi2gK/ISaO4pflVa7dyOnbn6vYjKBqKgF46Wd3
   OG0C0/O0Dm8/sbPo8cp3RJBKnCi/Po9GFZptiz5XCNycR+oBxmupIWKmn
   AQE1TLeRtByQrEcJL/mqVm74D5xckp7997ejKqhluWmC39hZepVqEI4DS
   YZ6Z7xFR5nNUkNFGQiJjnSSraDZB+OtmH3Gocs7yYfwkc4G2crr6YCEqh
   HRtRS0lMx6362SF+fBvEpTXDnPy+5z5jXfuIQfwt7LowrYrxSfDzC3tvx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="350503677"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="350503677"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 04:28:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="677206932"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="677206932"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 May 2023 04:28:05 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1px4Sq-0003zI-2F;
        Thu, 11 May 2023 11:28:04 +0000
Date:   Thu, 11 May 2023 19:28:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniil Dulov <d.dulov@aladdin.ru>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] drm/amdkfd: Fix potential deallocation of previously
 deallocated memory.
Message-ID: <ZFzRQnguWILn/uaF@e0f96cf4e6cd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511112314.29322-1-d.dulov@aladdin.ru>
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
Subject: [PATCH v2] drm/amdkfd: Fix potential deallocation of previously deallocated memory.
Link: https://lore.kernel.org/stable/20230511112314.29322-1-d.dulov%40aladdin.ru

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



