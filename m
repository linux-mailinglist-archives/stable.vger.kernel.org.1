Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716A079E1E6
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 10:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjIMIVn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 04:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238521AbjIMIVm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 04:21:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F807198C
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 01:21:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93D4C433C8;
        Wed, 13 Sep 2023 08:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694593298;
        bh=6Ib3STfLxrxNfjN2le33q4olyH2aFs+zKRZ9BIRujeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMq6p97ViHfJbFS17EHiOhN6kijOb9s9s+GmZHrT4DlAp/ZC5IZuR7Qoi0KELduta
         oeNtULkjAxCWVoBzz4mSec+MA+wLxNV4YvKEeWAjV+qrBch29mxOyUbYq4Kq6jlGcz
         tKR+P3RrAOSookNv5oorLhwgwA8gzEj9APbih5QA=
Date:   Wed, 13 Sep 2023 10:21:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     stable@vger.kernel.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH 6.1.y,6.4.y] drm/virtio: Conditionally allocate
 virtio_gpu_fence
Message-ID: <2023091322-silk-drone-fd5b@gregkh>
References: <20230912123534.893716-1-hi@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912123534.893716-1-hi@alyssa.is>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 12, 2023 at 12:35:34PM +0000, Alyssa Ross wrote:
> From: Gurchetan Singh <gurchetansingh@chromium.org>
> 
> We don't want to create a fence for every command submission.  It's
> only necessary when userspace provides a waitable token for submission.
> This could be:
> 
> 1) bo_handles, to be used with VIRTGPU_WAIT
> 2) out_fence_fd, to be used with dma_fence apis
> 3) a ring_idx provided with VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK
>    + DRM event API
> 4) syncobjs in the future
> 
> The use case for just submitting a command to the host, and expecting
> no response.  For example, gfxstream has GFXSTREAM_CONTEXT_PING that
> just wakes up the host side worker threads.  There's also
> CROSS_DOMAIN_CMD_SEND which just sends data to the Wayland server.
> 
> This prevents the need to signal the automatically created
> virtio_gpu_fence.
> 
> In addition, VIRTGPU_EXECBUF_RING_IDX is checked when creating a
> DRM event object.  VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK is
> already defined in terms of per-context rings.  It was theoretically
> possible to create a DRM event on the global timeline (ring_idx == 0),
> if the context enabled DRM event polling.  However, that wouldn't
> work and userspace (Sommelier).  Explicitly disallow it for
> clarity.
> 
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com> # edited coding style
> Link: https://patchwork.freedesktop.org/patch/msgid/20230707213124.494-1-gurchetansingh@chromium.org
> (cherry picked from commit 70d1ace56db6c79d39dbe9c0d5244452b67e2fde)
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 30 +++++++++++++++-----------
>  1 file changed, 18 insertions(+), 12 deletions(-)

Both patches applied, thanks.

greg k-h
