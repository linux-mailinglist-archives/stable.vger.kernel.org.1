Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F9577AE0E
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 00:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjHMWAS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 18:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjHMV7J (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCC226A2
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE0D461A2D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFA3C433C7;
        Sun, 13 Aug 2023 21:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963033;
        bh=1cd9f9Nrl60F2vSrMupFiHB7YwJgpEozzReFfBxYsyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vOLp3ENEvtyAvENey2rvgyIiNhqK70nIEFJuqqqm7nH2b2RktlsyglIhYQDcTEfPT
         QLREW/ICLQaOW68RI5RGnvd5fE+VbjCu5OmWsXKwsV26S/bTaBpriN+SboxguyQFwX
         Bq8Sf1dFQ266tsjpQz+j+N6EZojD3aYUajFiFOq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Roman Stratiienko <r.stratiienko@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5.15 09/89] drm/shmem-helper: Reset vma->vm_ops before calling dma_buf_mmap()
Date:   Sun, 13 Aug 2023 23:19:00 +0200
Message-ID: <20230813211711.058012414@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Boris Brezillon <boris.brezillon@collabora.com>

commit 07dd476f6116966cb2006e25fdcf48f0715115ff upstream.

The dma-buf backend is supposed to provide its own vm_ops, but some
implementation just have nothing special to do and leave vm_ops
untouched, probably expecting this field to be zero initialized (this
is the case with the system_heap implementation for instance).
Let's reset vma->vm_ops to NULL to keep things working with these
implementations.

Fixes: 26d3ac3cb04d ("drm/shmem-helpers: Redirect mmap for imported dma-buf")
Cc: <stable@vger.kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Reported-by: Roman Stratiienko <r.stratiienko@gmail.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Tested-by: Roman Stratiienko <r.stratiienko@gmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230724112610.60974-1-boris.brezillon@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -591,7 +591,13 @@ int drm_gem_shmem_mmap(struct drm_gem_sh
 	int ret;
 
 	if (obj->import_attach) {
+		/* Reset both vm_ops and vm_private_data, so we don't end up with
+		 * vm_ops pointing to our implementation if the dma-buf backend
+		 * doesn't set those fields.
+		 */
 		vma->vm_private_data = NULL;
+		vma->vm_ops = NULL;
+
 		ret = dma_buf_mmap(obj->dma_buf, vma, 0);
 
 		/* Drop the reference drm_gem_mmap_obj() acquired.*/


