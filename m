Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4DD7CAE3C
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 17:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjJPPwt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 11:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJPPwr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 11:52:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1627DAB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697471566; x=1729007566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=o9K5auazarub6zyjU0typwbV8WvA0XLH8AwvkWCQ/qs=;
  b=fQ7zZprKCENDTYj9mYrG5DvPk8f6uuGhTf7jmX4b9NPsmn8/DYYSTUHH
   qNWDnylwbReW1jcRMBJgZkICJBRDizRMNLEa/A2mL119vd42Clqsg1mcb
   HKwzQ1rsSNgrGvBCtJY8wUW3ATPkfkBrHtw4bJ24CinC0G5Zo3IkLfBvW
   FsrGVOEJNuzTCkBUH/gDeTgd9I52kJbpUfmDbRm3reyuSdx1ZYRiNOXTw
   jXeg9RhFfxjJKqqGR23quMvI7MR3GuaW1vHxyQa3VPDLbf/mvZKltBVEV
   zVAZrOAkri0dJ57MTxWftwzGu0QCS7ygxG6vMCBCf7UJl5iATFbUOHvJ4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="449774080"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="449774080"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 08:52:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="790842138"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="790842138"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 16 Oct 2023 08:52:43 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 16 Oct 2023 18:52:42 +0300
Date:   Mon, 16 Oct 2023 18:52:42 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Retry gtt fault when out of fence register
Message-ID: <ZS1cSv7GZAf8SKfz@intel.com>
References: <20231012132801.16292-1-ville.syrjala@linux.intel.com>
 <2023101257-chamber-excavator-2063@gregkh>
 <ZSf6YjQuCjtUi5h_@intel.com>
 <2023101202-conjure-shortwave-6ebc@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023101202-conjure-shortwave-6ebc@gregkh>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 12, 2023 at 06:12:26PM +0200, Greg KH wrote:
> On Thu, Oct 12, 2023 at 04:53:38PM +0300, Ville Syrjälä wrote:
> > On Thu, Oct 12, 2023 at 03:40:08PM +0200, Greg KH wrote:
> > > On Thu, Oct 12, 2023 at 04:28:01PM +0300, Ville Syrjala wrote:
> > > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > 
> > > > If we can't find a free fence register to handle a fault in the GMADR
> > > > range just return VM_FAULT_NOPAGE without populating the PTE so that
> > > > userspace will retry the access and trigger another fault. Eventually
> > > > we should find a free fence and the fault will get properly handled.
> > > > 
> > > > A further improvement idea might be to reserve a fence (or one per CPU?)
> > > > for the express purpose of handling faults without having to retry. But
> > > > that would require some additional work.
> > > > 
> > > > Looks like this may have gotten broken originally by
> > > > commit 39965b376601 ("drm/i915: don't trash the gtt when running out of fences")
> > > > as that changed the errno to -EDEADLK which wasn't handle by the gtt
> > > > fault code either. But later in commit 2feeb52859fc ("drm/i915/gt: Fix
> > > > -EDEADLK handling regression") I changed it again to -ENOBUFS as -EDEADLK
> > > > was now getting used for the ww mutex dance. So this fix only makes
> > > > sense after that last commit.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9479
> > > > Fixes: 2feeb52859fc ("drm/i915/gt: Fix -EDEADLK handling regression")
> > > > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > ---
> > > >  drivers/gpu/drm/i915/gem/i915_gem_mman.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > 
> > > <formletter>
> > > 
> > > This is not the correct way to submit patches for inclusion in the
> > > stable kernel tree.  Please read:
> > >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > > for how to do this properly.
> > > 
> > > </formletter>
> > 
> > Say what now?
> 
> Sorry, my bot thought this was a patch sent only to stable, I've kicked
> it a bit and it shouldn't do that again...

Ah OK, thanks.

I was a bit worried that my reading comprehension had deterirated enough
that I couldn't figure iut what new requirement in the process I had
violated :)

-- 
Ville Syrjälä
Intel
