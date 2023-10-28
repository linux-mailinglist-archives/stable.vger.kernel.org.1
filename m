Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDAC7DA8B0
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 20:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjJ1Snj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 28 Oct 2023 14:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Snj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 28 Oct 2023 14:43:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F1DD9
        for <stable@vger.kernel.org>; Sat, 28 Oct 2023 11:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698518616; x=1730054616;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=daerNB+pqMoZz3rIwMQHluf9yEHB6BqSCS9N12UV2aM=;
  b=GtS8PLjN8vDAeZ5bI2N3zqRhNVvY2MKkWam0ZowYZDHdsov1Qg+nDMsS
   Zw2lNWmCsA73YVkhsAFfIygy/LGVF5TxoPjeELPY29stGHUFqqZP1mFAi
   H1CRAHs1D9AIuQ8jerGHWvdjcwED1OjZ6w9gR/emlg7xH98yj6HzBtNAv
   lQExavPCVjbFyxZoJSrhvM8/l7clTBuIVEjrMZVdrQwMM3fBR8NTztiz7
   Z+G32MOiURJIJTy4jk/4E6xfLQDXIKKCrfZFrtzTL2nLDY2D3GI5sDGHx
   VmQSAFr1phJNns7yK2vOT8/IHK7ZLw3lyRti9ZiMtcQFQdjwE/sEWaPVp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="390775262"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="390775262"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 11:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="753418159"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="753418159"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Oct 2023 11:43:34 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwoHU-000Bzb-0Y;
        Sat, 28 Oct 2023 18:43:32 +0000
Date:   Sun, 29 Oct 2023 02:43:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Sperbeck <jsperbeck@google.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] objtool/x86: add missing embedded_insn check
Message-ID: <ZT1WU783srTI75zt@dceb3e7df498>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028184131.2103810-1-jsperbeck@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Subject: [PATCH v2] objtool/x86: add missing embedded_insn check
Link: https://lore.kernel.org/stable/20231028184131.2103810-1-jsperbeck%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



