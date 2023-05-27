Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62B713362
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 10:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjE0IbB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 27 May 2023 04:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjE0IbA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 27 May 2023 04:31:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD826E1
        for <stable@vger.kernel.org>; Sat, 27 May 2023 01:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685176258; x=1716712258;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=spHlOhP6XJ5XUXeg5lCJxnJUQ1S7p9+r5h6LsC0+EFg=;
  b=fhHKABOcwARYiqNHeJsDHvS1ljclvckP9uADpg9NoPUiVHqaNM5Ah2Sw
   ipZD+fUwtQSnfMtSltDIpvTN8gBwr65woCKFUo7/5MB8MAL8qVqWYSaCS
   H6bwyjAGX+UCtYpsiFnaKM5xTwgzK+nu93D+n9p4dI1lM715RzVDoxVOE
   wMiN/h9a87SsnfZ7ROT99jBcvuwvUuQUBeBYGNN+KTXVcukNM9jUz0uTM
   uXQTj9NHvolHu+oGbmBy7edSNGgFRWBazziAC4leHpaLggi6IBW2lvhzu
   JdsfpELkChp1XHPBPiHEYFcMVSjrUwsqCGQoMiAPOyvAt2XyPljOEBKNB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="417859604"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="417859604"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 01:30:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="708646563"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="708646563"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 May 2023 01:30:57 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2pKC-000Jre-1l;
        Sat, 27 May 2023 08:30:56 +0000
Date:   Sat, 27 May 2023 16:30:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/3] wifi: rtw89: remove redundant check of entering LPS
Message-ID: <ZHG/t/dgpF807Z3u@3bef23cc04e9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527082939.11206-4-pkshih@realtek.com>
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
Subject: [PATCH 3/3] wifi: rtw89: remove redundant check of entering LPS
Link: https://lore.kernel.org/stable/20230527082939.11206-4-pkshih%40realtek.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



