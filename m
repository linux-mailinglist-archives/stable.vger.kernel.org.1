Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE05703CFC
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbjEOSsf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjEOSsd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:48:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5605183D1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684176512; x=1715712512;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=WUb2X5IL4vCaMDplSvo43ilMU6qy7fovku+vqYS6oCY=;
  b=lThJW3az89V2RFwwabJQzSCXBHJlWN1WVQUUzPI1xMAw/2pKep66dzPu
   xW3wSqwkXPlJdoz48MP/EGLZHx/1qUu2SU82gLqfrZDyZY+w4lS/6X6Yv
   RbCKaDyPaAOuZLixKEssN6kzivaJ0irCLTtSlaXO7Uid6rcYoId8Fg7Ob
   NNzTNXUhctIRvZjBi6XMUM7+plW3A9JYcf8i9buYchQ4WF2j7xoW8MqfI
   7y/1mf+cMtERduX4/gwmDCbGweQdb8UMZ3dChUp6ViOP47/WwIcOLyJnp
   vYsodpr252GaYnTS25dQT+65EbXL0MCx8Iwnidnxs2Iueu8YehaUm8Lc7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="348779575"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="348779575"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 11:48:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="695132393"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="695132393"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 15 May 2023 11:48:31 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pydFG-0006Yk-1y;
        Mon, 15 May 2023 18:48:30 +0000
Date:   Tue, 16 May 2023 02:47:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] scsi: storvsc: Don't pass unused PFNs to Hyper-V host
Message-ID: <ZGJ+VOyjHUf7DvxB@e0f96cf4e6cd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684171241-16209-1-git-send-email-mikelley@microsoft.com>
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
Subject: [PATCH 1/1] scsi: storvsc: Don't pass unused PFNs to Hyper-V host
Link: https://lore.kernel.org/stable/1684171241-16209-1-git-send-email-mikelley%40microsoft.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



