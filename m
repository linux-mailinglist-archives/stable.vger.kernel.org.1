Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FE3763F4C
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 21:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjGZTOJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 15:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGZTOI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 15:14:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53F8131
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690398847; x=1721934847;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=0Zos+9257AHvhuMFGmdTmn1FriMWxOr1r7wksKzT3h8=;
  b=EoO5VtudQ8kM0zkozkILz9F05jvbvlqO3T1KntdLrdFfRr9HnAxpL6Hp
   aU41wnKWGVXOmev/+O/KxiwPXeDtwIcHSEWSqgRoqOnpSZv2zqH8zV6CX
   t2dsopWgONktFN1tCqI9L5jY5GBMEnhuwYOAFnJKKPqIUYtTDkpuSd5B5
   /ivaI38mz0YjDvISThrAq1SywU/FAQmqc97Pzz73BHYBI0PwTtikESHxc
   buZQjyeZtcxMbT9iYoWZ2byh2nCuYA27QAH7KpwstpOLE0BXAuO6sPMiS
   /o0cR7aqMO+vjh10++U8yR8Y38MJg3+d6VhM2wfrTN/JWBrHpuzfgM7nM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="358107439"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="358107439"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 12:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="761778740"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="761778740"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 26 Jul 2023 12:14:06 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOjxV-0001E3-10;
        Wed, 26 Jul 2023 19:14:05 +0000
Date:   Thu, 27 Jul 2023 03:13:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] virtio-vdpa: Fix cpumask memory leak in
 virtio_vdpa_find_vqs()
Message-ID: <ZMFwYn54cWWGIYvo@c507f7d2ae6a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726191036.14324-1-dtatulea@nvidia.com>
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
Subject: [PATCH] virtio-vdpa: Fix cpumask memory leak in virtio_vdpa_find_vqs()
Link: https://lore.kernel.org/stable/20230726191036.14324-1-dtatulea%40nvidia.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



