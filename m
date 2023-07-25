Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2069B760B29
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 09:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjGYHHm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 03:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjGYHH2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 03:07:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5861F173B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 00:07:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DEF836606FD7;
        Tue, 25 Jul 2023 08:07:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690268846;
        bh=u6AapRusf8eDzXb/4ah8sQepeL593ZRLW7FlM4jWC+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hcTYaYJhrp5SypF+nMltehy5RPVRrvBNWKk3LABd3equzoki1ajluNbpjGz3hyQHQ
         pKpulvAmeClPdPjqyIO2p0UvVdt5HOoMvBxlrwJPplJWTmBgJKBIRSXp1ITyUzdbRS
         f5Ri02K1NXlFKrn7T6AhQ9jSkFTu0n0ygZ32z2ti28Y6jFQiXqVJ9DOsnk2J1YqnhS
         G0U+B8i33txQNDz3UlKNJ4iTgfCaJL9hwHzlRKsgWsZa/x1tI6HGkhr0/8NHmE1d1o
         0PwUa11W9cOm3uPmInLq2cuVF/+W1YhFWeNqVnGhTQlW4ggJe02HP6/lOgy4VEoVM9
         PcGHHf85XNzVw==
Date:   Tue, 25 Jul 2023 09:07:22 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: Re: [PATCH] drm/shmem-helper: Reset vma->vm_ops before calling
 dma_buf_mmap()
Message-ID: <20230725090722.379021ea@collabora.com>
In-Reply-To: <20230724112610.60974-1-boris.brezillon@collabora.com>
References: <20230724112610.60974-1-boris.brezillon@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Adding Roman's tested-by coming from [1]

Tested-by: Roman Stratiienko <r.stratiienko@gmail.com>

[1]https://gitlab.freedesktop.org/mesa/mesa/-/issues/9416#note_2013722

> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
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

