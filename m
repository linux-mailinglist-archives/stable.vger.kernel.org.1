Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A167AD87E
	for <lists+stable@lfdr.de>; Mon, 25 Sep 2023 15:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjIYNBU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 25 Sep 2023 09:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjIYNBT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 25 Sep 2023 09:01:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2A79F
        for <stable@vger.kernel.org>; Mon, 25 Sep 2023 06:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695646873; x=1727182873;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ZkN0p2Soq8XMUh+o99Wn1yc0hzf8lSpVouGsN39VDKQ=;
  b=d2Vxx6Ku8K9/8t8pgWrurBC4sxGTt1KiSDf5Xz5/6L/bvhWdx8gEU7aN
   Z91pUZc78MHvh8soQSi9k6yMzW0ki1rQ2xx1w4Q5OaKV29g4vIq0mQZl5
   beEpC9QCKnNX97aa+7lSWgHErbmJvhiZPPmau+sLAh1l+MNCH0EbLE5G+
   N8nhPLScbnvsjccQr20yn7H7r07C47qYpVWcwGE/1dY7Z2sI6ac19EzAy
   6fHn4sdmGcyVHxJGApi6uAj0DcHUzlkMTufYmWxrlXjyk28puK3jdc1Lm
   XVbQsqqZDIWMEaa885/f+XYmH4uX+lmwLr8Df2tWgkTtr8k4nhPyDyWfb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467529150"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="467529150"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 06:01:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="751664086"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="751664086"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 25 Sep 2023 06:01:11 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qklD3-0001Wv-1Y;
        Mon, 25 Sep 2023 13:01:09 +0000
Date:   Mon, 25 Sep 2023 21:00:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] binfmt_elf: Support segments with 0 filesz and
 misaligned starts
Message-ID: <ZRGEZcVhvI2YKx2/@845c4ce01481>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzsemmsd.fsf_-_@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html/#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] binfmt_elf: Support segments with 0 filesz and misaligned starts
Link: https://lore.kernel.org/stable/87jzsemmsd.fsf_-_%40email.froward.int.ebiederm.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



