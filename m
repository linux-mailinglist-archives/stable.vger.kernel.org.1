Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC377C6F6E
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 15:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjJLNkP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 09:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbjJLNkP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 09:40:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3BAD7
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 06:40:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9A8C433C7;
        Thu, 12 Oct 2023 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697118011;
        bh=1o+cuBL+5vr4LFtq3Hovsvd3Zszh2wtTcLRw67oFKsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+hMeWVUuq3TiqwzWYJsenxmi0i66GJx7/yaE8RQ+zJ/uFMlqAV16bWYdURk1cAwk
         jQyxF2eCDaZ+cYREHzCeXQ1c12KHhI8hJ37Jx7HfW9l2zHV0Nwn3xJXimBKkWG3Lcy
         s/Fpm+eH5CjQ80RB8RYE4ISPHBtvjQRxaOkFjyDo=
Date:   Thu, 12 Oct 2023 15:40:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ville Syrjala <ville.syrjala@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Retry gtt fault when out of fence register
Message-ID: <2023101257-chamber-excavator-2063@gregkh>
References: <20231012132801.16292-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231012132801.16292-1-ville.syrjala@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 12, 2023 at 04:28:01PM +0300, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
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
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_mman.c | 1 +
>  1 file changed, 1 insertion(+)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
