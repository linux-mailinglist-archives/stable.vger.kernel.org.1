Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA7B7C6FC3
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 15:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjJLNxp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 09:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjJLNxn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 09:53:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A957CBA
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697118822; x=1728654822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tu87ZBuoFyYCD6VoBfWYqvOjb4rDBWx+QTveoO5psEs=;
  b=fCbZc690pBhhIGYaUnwAmqoh9WGenFTeB4ZvbNWRRCekPABaXaV5uiR7
   YIO5cMpXNhbWhvHrQubt16Tlm5AoLe0k9I0Y6mnl8lI9qZqERNyjskQBO
   M5VQWpegXvwuodr75Gi9z8Ar4Yl5xLsCd0C3XrpHqV40m9AbHDycmz4tJ
   mREtBo4lkOYGK8wrpxI14XhB5qiJFExAnxe5TnjIcpltSibf1sK7yDq3W
   P8Pdcp/dBhp0KLiRmaqt3uu5GT6NBw9zMAQO8le1vcg3ie0FuRZ1qFULT
   Ji0AA9lSS+sGCR2V/KiWG81dPmOA7pODIr53RIw5z9DBO1WLcVqhV8zUR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="375282745"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="375282745"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 06:53:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="704191747"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="704191747"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga003.jf.intel.com with SMTP; 12 Oct 2023 06:53:39 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 12 Oct 2023 16:53:38 +0300
Date:   Thu, 12 Oct 2023 16:53:38 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Retry gtt fault when out of fence register
Message-ID: <ZSf6YjQuCjtUi5h_@intel.com>
References: <20231012132801.16292-1-ville.syrjala@linux.intel.com>
 <2023101257-chamber-excavator-2063@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023101257-chamber-excavator-2063@gregkh>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 12, 2023 at 03:40:08PM +0200, Greg KH wrote:
> On Thu, Oct 12, 2023 at 04:28:01PM +0300, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
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
> > ---
> >  drivers/gpu/drm/i915/gem/i915_gem_mman.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Say what now?

-- 
Ville Syrjälä
Intel
