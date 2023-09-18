Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637AB7A50AE
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 19:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjIRRMK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 13:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjIRRMH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 13:12:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5806CBF
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695057121; x=1726593121;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=bhsO3UK/tiC8VZSa32uhHY21Knn6aajSceTjYxVjDPs=;
  b=d8GOSw/M811ENZuy5hNKqG2ieEBIUpZH6wKdYJQ5tFehysjeDnpl7zc5
   rsN7bRASs80XTn7PzU/A5QVmTapIY2HLXXCeE3Ih0zAJRu46f+7wugvpY
   C+AsO3D24EWTXiXKnl1fgFcDN1Y7O7ma/bqoRAFz4Q9QAhh9b+vC9oXgk
   8EW+8UqMdYCsppwrkvxVp6CDbmDb4k4P/MOkMNdiaRpIb9+Ki1jgbf4Bw
   /ralxPIRuLirXpvyyI/h60nKgF4XfbZxov+lNoXzYqwzq9rhFUTQOrASa
   940fkGC2oLX1VvZKZAC/4zBdZfBxL0rc70seZSd2zFK5A4vcUTRSAh1hw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="377038073"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="377038073"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 10:12:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="775204993"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="775204993"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Sep 2023 10:11:59 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiHmu-0006JU-2e;
        Mon, 18 Sep 2023 17:11:56 +0000
Date:   Tue, 19 Sep 2023 01:11:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jade Lovelace <lists@jade.fyi>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Revert "misc: rtsx: judge ASPM Mode to set PETXCFG Reg"
Message-ID: <ZQiEsy+j14XWevqZ@6fe19fc45f19>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918170831.1677690-3-lists@jade.fyi>
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
Subject: [PATCH] Revert "misc: rtsx: judge ASPM Mode to set PETXCFG Reg"
Link: https://lore.kernel.org/stable/20230918170831.1677690-3-lists%40jade.fyi

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



