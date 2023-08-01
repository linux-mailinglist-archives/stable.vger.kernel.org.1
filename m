Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1526F76C030
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 00:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjHAWK6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 18:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjHAWKs (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 18:10:48 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816AD212C
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 15:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690927845; x=1722463845;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=2d4lG0fus+HJi8cGREN2Uz4QkdRHZi0TfIDeGkQenwA=;
  b=UK7fwO+ep8Mmqpr9G2+lJJDFVBpY1FiXRD9p5fTpaBNfZIS8fFW6/B3P
   pJYr2/9evnQ6SvyjnbuReUANc9nqFU/JPvZV8E1KfL5fcjr/bUviYSuS6
   FUz+csTXMRs3nNGkYwfvpBWT5TVFujnOmqzPDBV6TEHnPR6qF8kgrDCqW
   VytmpBFzRAvMp9Q/k9slng8PEIzxeNACuJ74nyFL0FLykCaS+tV8FwJz/
   M73SBRUtvYUbm87CTr5Z4x1YrY6uBD9uUa8fawrRShlajP7Md0WSeIF6B
   jw3cNjYYXJH25mys+n7ts8OKqqJHeQB9bSq4VTSxNZRTxWu+xyz5i+RzW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="400370010"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="400370010"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 15:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="975449063"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="975449063"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Aug 2023 15:10:44 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQxZj-0000cl-1c;
        Tue, 01 Aug 2023 22:10:43 +0000
Date:   Wed, 2 Aug 2023 06:09:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/6] mm: for !CONFIG_PER_VMA_LOCK equate write lock
 assertion for vma and mmap
Message-ID: <ZMmCq3W7ayKzmZcD@11d7ca01dc46>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801220733.1987762-3-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
Subject: [PATCH v2 2/6] mm: for !CONFIG_PER_VMA_LOCK equate write lock assertion for vma and mmap
Link: https://lore.kernel.org/stable/20230801220733.1987762-3-surenb%40google.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



