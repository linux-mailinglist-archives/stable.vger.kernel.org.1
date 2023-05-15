Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A4B703015
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 16:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbjEOOiV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 10:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEOOiU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 10:38:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6F9FD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684161499; x=1715697499;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=vlscW+F6IkOqTCbIHzUtl95EflBOJXMHjXnqSlfn9RQ=;
  b=NBvRjkJ+F1kf5VfOLvrty66d9lb2ORTm8tOX/bahojpSgl9N3IuSnZoP
   MKEzidFHMbDIFbQpfV+DcANr4xHHLYPSX27x0g4byoXsZUwW7Ruv894pe
   UspGMZt2rXv+/vw9Tn3xcGVtpJlPzu3ZCJkSjWCRnsbukj9iLx+FDjH4q
   lvTbTiJfleJyPNtQtF2h84OMVEfITuFk7L/UELmIFIGAy5DRWHwKhb+Rk
   VGOKZtbgQL6T7aTj2GgWN7blQZX8p/PR0+G/gqDqUCKl4IsINfSOXAOQZ
   rBQ7anW42Y6EIckdd6X/paLvwdzgzW9+fG4w2ebZSfJQW4hYUj1YNZnEr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="330836088"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="330836088"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 07:38:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="1030922057"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="1030922057"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 15 May 2023 07:38:18 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pyZL7-0006Ow-2N;
        Mon, 15 May 2023 14:38:17 +0000
Date:   Mon, 15 May 2023 22:38:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/3][For 4.19/4.14] spi: fsl-cpm: Use 16 bit mode for
 large transfers with even size
Message-ID: <ZGJDz2+JPvdVoBfT@e0f96cf4e6cd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9363da33f54e9862b4b59c0ed97924ca7265f7a4.1684158520.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Subject: [PATCH 3/3][For 4.19/4.14] spi: fsl-cpm: Use 16 bit mode for large transfers with even size
Link: https://lore.kernel.org/stable/9363da33f54e9862b4b59c0ed97924ca7265f7a4.1684158520.git.christophe.leroy%40csgroup.eu

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



