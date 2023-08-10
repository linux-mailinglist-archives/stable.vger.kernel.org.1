Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4FD777059
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 08:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjHJGaz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 02:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjHJGay (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 02:30:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEF6E4D
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 23:30:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 746EE6607214;
        Thu, 10 Aug 2023 07:30:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691649052;
        bh=2HRANds4KauyZ4tz/0avEUDBugYV8SNFefzICY+m6yM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XQAEzZL3dWeYwVjlFyYYODVnr5Bcjr+5Bx1fi1lM2VSYix6XMvAi7xVRPPU2Xwqm6
         k2XOlKuOuhp+SfCX30xQMUwsNuwlv3gNojeaFR/bSzkxFF1cPXwVxs83FafevsqJNB
         46wE83F1ukGgUb6JLIu6HFSQbRBMWnw4zCleRKAtEg7Fxf4urfH+lNUHkBitoqhdxo
         jgPfCY2nODY1NwxA7rgbhMS8bbHnz72daEveieg6L/OYaw3xN4Iwwt6aDerHRx2gQk
         5QAT4Y4tAcvWwlXMU1V0C1x7MBnisNdMbSGIGkps4Z/LlAnghyV6Z45Br/g5ukyITN
         tMly+1PgBwz0Q==
Date:   Thu, 10 Aug 2023 08:30:49 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: Re: [PATCH] drm/shmem-helper: Reset vma->vm_ops before calling
 dma_buf_mmap()
Message-ID: <20230810083049.19bad992@collabora.com>
In-Reply-To: <20230724112610.60974-1-boris.brezillon@collabora.com>
References: <20230724112610.60974-1-boris.brezillon@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 24 Jul 2023 13:26:10 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> The dma-buf backend is supposed to provide its own vm_ops, but some
> implementation just have nothing special to do and leave vm_ops
> untouched, probably expecting this field to be zero initialized (this
> is the case with the system_heap implementation for instance).
> Let's reset vma->vm_ops to NULL to keep things working with these
> implementations.
> 
> Fixes: 26d3ac3cb04d ("drm/shmem-helpers: Redirect mmap for imported dma-buf")
> Cc: <stable@vger.kernel.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Reported-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Queued to drm-misc-fixes.

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 4ea6507a77e5..baaf0e0feb06 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -623,7 +623,13 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
>  	int ret;
>  
>  	if (obj->import_attach) {
> +		/* Reset both vm_ops and vm_private_data, so we don't end up with
> +		 * vm_ops pointing to our implementation if the dma-buf backend
> +		 * doesn't set those fields.
> +		 */
>  		vma->vm_private_data = NULL;
> +		vma->vm_ops = NULL;
> +
>  		ret = dma_buf_mmap(obj->dma_buf, vma, 0);
>  
>  		/* Drop the reference drm_gem_mmap_obj() acquired.*/

