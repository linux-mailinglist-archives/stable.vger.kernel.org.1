Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC2A7CAE15
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 17:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjJPPt3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 11:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjJPPt2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 11:49:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8831DEA
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697471367; x=1729007367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9Mv8kh/CUzFcN00rxrVSrH6ocuROm3sFvBVoQRNdq8g=;
  b=Eo9aeNFWSKjdDAk4kP5GawCmQ0+rOeZCtOtrCri7UgCD4OBoLvbc7PX8
   3avrM9G/qkLJeDFxzwZO7yw+H/rqf3+xCI+RMahbEykz3oM40y2bebagT
   psAyDmnrWVNU4WWvh3ZOsUKdGv7iK5bxFBfzJ2eYMXgCgxHpjl0bFkOzD
   FSlGo47JeQupv5MC5IhMDRkUnhM44X1EFEh7uxfSMxvhZXNGZNdcdtlwF
   9QQVSaotckm3Bou+gpGbi5luZ1usRBu+TZ2qkGZpYV9kYri02Dcjm398M
   RIWoC0i0SoPJP+OH3exHqsYuK1UzezV97ZIPXLP2zO+zAeDNKLJpplrWw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="449773082"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="449773082"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 08:49:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="790840889"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="790840889"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 16 Oct 2023 08:49:24 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 16 Oct 2023 18:49:23 +0300
Date:   Mon, 16 Oct 2023 18:49:23 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Retry gtt fault when out of fence
 register
Message-ID: <ZS1bg_LpDKlC0bEE@intel.com>
References: <20231012132801.16292-1-ville.syrjala@linux.intel.com>
 <ZSkhxx8bIJSfKHJ0@ashyti-mobl2.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSkhxx8bIJSfKHJ0@ashyti-mobl2.lan>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 12:53:59PM +0200, Andi Shyti wrote:
> Hi Ville,
> 
> > If we can't find a free fence register to handle a fault in the GMADR
> > range just return VM_FAULT_NOPAGE without populating the PTE so that
> > userspace will retry the access and trigger another fault. Eventually
> > we should find a free fence and the fault will get properly handled.
> > 
> > A further improvement idea might be to reserve a fence (or one per CPU?)
> > for the express purpose of handling faults without having to retry. But
> > that would require some additional work.
> > 
> > Looks like this may have gotten broken originally by
> > commit 39965b376601 ("drm/i915: don't trash the gtt when running out of fences")
> > as that changed the errno to -EDEADLK which wasn't handle by the gtt
> > fault code either. But later in commit 2feeb52859fc ("drm/i915/gt: Fix
> > -EDEADLK handling regression") I changed it again to -ENOBUFS as -EDEADLK
> > was now getting used for the ww mutex dance. So this fix only makes
> > sense after that last commit.
> > 
> > Cc: stable@vger.kernel.org
> > Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9479
> > Fixes: 2feeb52859fc ("drm/i915/gt: Fix -EDEADLK handling regression")
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Thanks. Pushed to gt-next.

-- 
Ville Syrjälä
Intel
