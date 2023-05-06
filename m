Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602C76F934B
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 19:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjEFRSY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 13:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFRSX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 13:18:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53CE15687
        for <stable@vger.kernel.org>; Sat,  6 May 2023 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683393502; x=1714929502;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=HnVE3xiw/NBQ6aMBPon8O7ZNvHJfXRrRdt75Fc09ZfI=;
  b=feCTdmaVdkGmnlf+5AubUw/Edq5GtIyt148MCLefEMFXfn4YKNPiPT9g
   1n9j9qnwEl+yWkC/0DGHS7eQZYwlVwz+NOCCQEAWoOXZ3Ept6gcJDj70o
   /HWjA3lotgSLzt3cwLhgzXsM3pb4Kc5WSh6m4NUAhXO7q7iv0It2j/8/H
   DVMRv9QShZH6B3F/YfBtc6e0k3DWHds4WSl8X60Seh+0U+VJk32Wrxp2N
   HH835y7ggOv3HeWh1NTLHhxLrxzvmow9Y3UWn4TxpGWOLAJPqUcdKBGZK
   et3tGdHWKgynZOzVQIlClmug3hPQOqhTFAGfTqneihGWsqJLjwEDvmd++
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="349434269"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="349434269"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 10:18:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="762867875"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="762867875"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 May 2023 10:18:21 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvLY4-0000Pu-39;
        Sat, 06 May 2023 17:18:20 +0000
Date:   Sun, 7 May 2023 01:17:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     frshuov@163.com
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for ASUS GU603ZM
Message-ID: <ZFaLuB2ztV6EJ1I8@e0f96cf4e6cd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506171546.50815-1-frshuov@163.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Subject: [PATCH] ALSA: hda/realtek: Add quirk for ASUS GU603ZM
Link: https://lore.kernel.org/stable/20230506171546.50815-1-frshuov%40163.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



