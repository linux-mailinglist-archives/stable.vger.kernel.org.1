Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168107C83CE
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjJMKye (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 06:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjJMKye (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 06:54:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EED7CE
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697194472; x=1728730472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I4mTdaBzMo0gJ8/uEvJUx4y+B+md+MSPNvQI7lsW2WE=;
  b=L1Xhpkbc9asESC4IqT2vGY8mUNg3MPNch8oEeRI8AZ1ZJzYaVdtc6hTt
   /Agod1xYJhwhoRq8A/uJ5Q939oUIn6Ce4HeGnaL0zgMV0QDWvN5fl8Ndm
   9PuZgiW8V1mDrLnN7xB79ihfjQkFFno8g7eqAQuZBcyq+CPpya3xIjMtH
   sZpROnb5XVNtmHXPS530VLX+eq330tyM+NTr9ZKbeGt1JrqHzsyS235WE
   w85aZXG8KXJVikpy0IxnJZb8K+jm8q5jwWa8oJ8sVlqmpy8taX8mB4LWt
   wjl3LoGPrUW/VC8IDn8VBxcrCDtXIRQXNGTyuk1Pd531BqB79ccOvkoc1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="6713515"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="6713515"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="784110711"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="784110711"
Received: from kesooi-mobl1.gar.corp.intel.com (HELO intel.com) ([10.215.155.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:54:03 -0700
Date:   Fri, 13 Oct 2023 12:53:59 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Ville Syrjala <ville.syrjala@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Retry gtt fault when out of fence
 register
Message-ID: <ZSkhxx8bIJSfKHJ0@ashyti-mobl2.lan>
References: <20231012132801.16292-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231012132801.16292-1-ville.syrjala@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Ville,

> If we can't find a free fence register to handle a fault in the GMADR
> range just return VM_FAULT_NOPAGE without populating the PTE so that
> userspace will retry the access and trigger another fault. Eventually
> we should find a free fence and the fault will get properly handled.
> 
> A further improvement idea might be to reserve a fence (or one per CPU?)
> for the express purpose of handling faults without having to retry. But
> that would require some additional work.
> 
> Looks like this may have gotten broken originally by
> commit 39965b376601 ("drm/i915: don't trash the gtt when running out of fences")
> as that changed the errno to -EDEADLK which wasn't handle by the gtt
> fault code either. But later in commit 2feeb52859fc ("drm/i915/gt: Fix
> -EDEADLK handling regression") I changed it again to -ENOBUFS as -EDEADLK
> was now getting used for the ww mutex dance. So this fix only makes
> sense after that last commit.
> 
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9479
> Fixes: 2feeb52859fc ("drm/i915/gt: Fix -EDEADLK handling regression")
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi
