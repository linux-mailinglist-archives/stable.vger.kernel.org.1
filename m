Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918C26F688D
	for <lists+stable@lfdr.de>; Thu,  4 May 2023 11:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjEDJpX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 4 May 2023 05:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjEDJpW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 4 May 2023 05:45:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1975B46B0
        for <stable@vger.kernel.org>; Thu,  4 May 2023 02:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683193522; x=1714729522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xXxKdtNC5aGnqQZK70eazDiZwZew3BpBgKA0azwk6Ig=;
  b=fXKThyVzgs1agv123vNGJ5hw1cJ0s+8iUTf2tyCAPbZxlOeGX2sME+hP
   kC/R729sSC8akX36PfcpqsWubNj6HKC7Q4oUqH2H6bCG9EILsfR3aWTt2
   y8GBYIEWabRSe1IUI+DmaF+WgrvMccr6KDyYdyeIkiEMHDyEx9YOpammS
   R5RYxgMZlDYKUfe/SnwtoPFJZAIdqex6q36bE3u0oYgyS5hh1CUy7Vo14
   ryo6cD7tXWv28qt2OnMh+TM7axOvUYjopzOnkOHyUs2Py+1nJOUdiFbnU
   RDGfL40BfL2eWtBIXJfIVC2z1Mr5bUPAzc9pICclFIGJ0X0J/D+Adzqrf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="348929914"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="348929914"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 02:45:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="841074862"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="841074862"
Received: from dmitriyp-mobl.ger.corp.intel.com (HELO intel.com) ([10.249.37.93])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 02:45:18 -0700
Date:   Thu, 4 May 2023 11:45:15 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        stable@vger.kernel.org,
        Maciej Patelczyk <maciej.patelczyk@intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Matthew Auld <matthew.auld@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>
Subject: Re: [Intel-gfx] [PATCH v5 5/5] drm/i915/gt: Make sure that errors
 are propagated through request chains
Message-ID: <ZFN+q9xEyuRFrJp4@ashyti-mobl2.lan>
References: <20230412113308.812468-1-andi.shyti@linux.intel.com>
 <20230412113308.812468-6-andi.shyti@linux.intel.com>
 <ca796c78-67cf-c803-b3bc-7d6eaa542b32@linux.intel.com>
 <5b7f82db-b9dd-e9c9-496c-72995469d699@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7f82db-b9dd-e9c9-496c-72995469d699@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Tvrtko,

> Another option - maybe - is this related to revert of fence error
> propagation? If it is and having that would avoid the need for this invasive
> fix, maybe we unrevert 3761baae908a7b5012be08d70fa553cc2eb82305 with edits
> to limit to special contexts? If doable..

I think that is not enough as we want to get anyway to the last
request and fence submitted. Right?

I guess this commit should be reverted anyway.

Andi
