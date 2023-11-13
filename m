Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3327E9567
	for <lists+stable@lfdr.de>; Mon, 13 Nov 2023 04:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjKMDUp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 12 Nov 2023 22:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjKMDUo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 12 Nov 2023 22:20:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F041704
        for <stable@vger.kernel.org>; Sun, 12 Nov 2023 19:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699845642; x=1731381642;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=qXMova+Doo2vJVahJwAaReiVlhiIRW+2rK0QU+dGz/A=;
  b=ckp3qknC0tZVdOvwgRm4Y/NGL8wEeyOgn1lZxXzPgNsVYM0VaugCA18O
   elBonY6PBtrgpRuWo2y0fhEc5v7t884fzoVmwbPAj1sjFRzS3GtDmEqFB
   EI+L53EfvkP9syA1XaY6OVUh45N8MNUkHdbsYxxjiP9ETEEDWZmt2aJUH
   7GdfDQfUpjNqNdEFeXnWtJTsN588ssUGbhDe1akEWqh9C3gzmMCJzrPAv
   tr/R4WXOa3th4EY1/jg/vG6nRQm4AzB1xgVobh+ULa7cqwjCipbEWxDpR
   9yQ6uPnRfZSVo/EJ7YCWTkz3+c6Ewnj5n4QaWVao2DOrOShLKpjmZ4hHz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="370571391"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="370571391"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 19:20:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="757683000"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="757683000"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 Nov 2023 19:20:40 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r2NV7-000BkU-2t;
        Mon, 13 Nov 2023 03:20:37 +0000
Date:   Mon, 13 Nov 2023 11:19:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net] ppp: limit MRU to 64K
Message-ID: <ZVGV2hIhSNWU9ylR@a9cca7fa5d54>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113031705.803615-1-willemdebruijn.kernel@gmail.com>
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

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net] ppp: limit MRU to 64K
Link: https://lore.kernel.org/stable/20231113031705.803615-1-willemdebruijn.kernel%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



