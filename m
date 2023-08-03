Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280DF76F0AA
	for <lists+stable@lfdr.de>; Thu,  3 Aug 2023 19:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjHCRaS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 3 Aug 2023 13:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjHCRaO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 Aug 2023 13:30:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301CF4206
        for <stable@vger.kernel.org>; Thu,  3 Aug 2023 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691083812; x=1722619812;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=/m479Gf9DM8UvN+7iA752rTQD0/JRdzJK0yMI+eJ4xs=;
  b=ecoGCAdb3/obxWSJP4utCcpLrQMxzXO1WvX5i+tk3Gx3o3C/uv4RFsgA
   GiSthRJxnb/n+fRd961moQ9EzVI+Zb5XrA3notoPYBfZUiS0lXsD5KZID
   kLOP1x6Q8RpTRpLW/jIu925pGAYJ9s0VFeUJwEu/mgMUtOv1EDt3P4yGp
   5ToYWEG3Ev6OM9QOJVJ5Uzuu73TiTK6VVb862TSYDNewubMNrIXGqX9Yg
   evm8jdMCHKWToykjv0vtUGnO0+I8MHu5oBhfsm5e72NNFbpDTKy3yBF9v
   XIBRE2i6G3QJZyt1L0XyEnySuoLVgnT5zjUkfL7io5sDvp9prPARh4suB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="369940316"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="369940316"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 10:29:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="873032614"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 Aug 2023 10:29:47 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRc8t-0002Fn-1i;
        Thu, 03 Aug 2023 17:29:43 +0000
Date:   Fri, 4 Aug 2023 01:28:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 2/6] mm: for !CONFIG_PER_VMA_LOCK equate write lock
 assertion for vma and mmap
Message-ID: <ZMvjzYln81BVcxjy@11d7ca01dc46>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803172652.2849981-3-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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
Subject: [PATCH v3 2/6] mm: for !CONFIG_PER_VMA_LOCK equate write lock assertion for vma and mmap
Link: https://lore.kernel.org/stable/20230803172652.2849981-3-surenb%40google.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



