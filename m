Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C33B703DBE
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 21:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243497AbjEOTan (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 15:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245044AbjEOTam (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 15:30:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA9D9018
        for <stable@vger.kernel.org>; Mon, 15 May 2023 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684179040; x=1715715040;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Ro1lxTqddGEbr8VV6bbAs81XVg6pn3Nk7tyRW/SRzD8=;
  b=HzoFWO13PJSSy5ip1OwcU4blYmfcKOGooxMmj56iWSL0lBLphWC6xPOE
   vwRNH+vIvrTghe1q5zZbnKopTCzx04+ExUWeLwGE+GInKwVP9UK6Kh46J
   v3bHVwW77SQ/plTgYXms6to+GaCtxKx5bJPZ6B9UBWZK9NwjnOR3rscIW
   8weSzn1VcKpdHzO0xC1kYwzVFVmrTp/cgh7KDmI2xVI54J2HJ7RwyEQiy
   XwNpWZPBTEskONhkuWTV+qXevSbTcWUAWdGjVf9bx6rqVxohUMyePXFck
   tA+cAWawIuJz5Lu3To5XHuK7shQ7air87BTQwbvb67CLEwX7STbu9qnDd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="437632772"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="437632772"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 12:30:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="845388028"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="845388028"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2023 12:30:32 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pydtw-0006aI-0G;
        Mon, 15 May 2023 19:30:32 +0000
Date:   Tue, 16 May 2023 03:29:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maya Matuszczyk <maccraft123mc@gmail.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] drm: panel-orientation-quirks: Change Air's quirk to
 support Air Plus
Message-ID: <ZGKILHTDLSRcUwt9@e0f96cf4e6cd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515184843.1552612-1-maccraft123mc@gmail.com>
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
Subject: [PATCH] drm: panel-orientation-quirks: Change Air's quirk to support Air Plus
Link: https://lore.kernel.org/stable/20230515184843.1552612-1-maccraft123mc%40gmail.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



