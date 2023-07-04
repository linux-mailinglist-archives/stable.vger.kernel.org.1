Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CBB747571
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjGDPie (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 11:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjGDPid (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 11:38:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA71DE54
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 08:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688485112; x=1720021112;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=BccB/jLG0jTsPhFXGuSY5h0bnIwFRBA0N62/vzxLcIU=;
  b=eih2NRjnQAT0aQJqMcnPNzzi0ahAcH3WAYhj+Z73UJoK0OoyfaPoI4mf
   oyQ0NRwdf6w3lv75cYgeAJWs7K3nmeNEIgiRiY4eNejgRP9EJXC78QfA7
   7xnnMZK63c/xnj9VPBom3QS6pu7ycRTvfXRIYRsprS/jRX2lsL8KTuzHh
   TCMRZK7FMoGIohFipgOU0RPdkbI+2bpXYlj95DJMVG0mfx+YjnSO0MdW+
   zzl58kRXiOrtkWRC9g5qB2+bjceut7OjJX84xoh5F9qt0Pa4YCGfIxfJ+
   c2j3RhHGzzZsW2Yrr2s3LiNFCsuXe/e2nPY86rHFW5vRb+/6HaChUOHIc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="366628471"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="366628471"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 08:37:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="788889465"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="788889465"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2023 08:37:58 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGi6H-000IKl-2X;
        Tue, 04 Jul 2023 15:37:57 +0000
Date:   Tue, 4 Jul 2023 23:37:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florent Revest <revest@chromium.org>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
Message-ID: <ZKQ81doy5ARaykJs@65525e8f8615>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704153630.1591122-4-revest@chromium.org>
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
Subject: [PATCH v3 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
Link: https://lore.kernel.org/stable/20230704153630.1591122-4-revest%40chromium.org

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



