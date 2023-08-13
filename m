Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4156877AD58
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjHMVtL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjHMVsu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:48:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0F11720
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:40:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E6CB6131F
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C83FC433C7;
        Sun, 13 Aug 2023 21:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962802;
        bh=Zy8BM5nQ9z6OQ6GJS8rjUhptOxwEu1298/w69jkEYY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1IIKTpYBe1mJ6N5UOTexbPRw+QV0RuTjo+KYWx0QTzEcPqhjNW3IwzxmNz4ru336k
         N4UrCDU7eeRdgL/nHEEVL++UyKQJ5AtdIU0SIhRVHYZIjGYEUqktyKFFilOtI6QRpf
         yXnXd0oIWJ3VG4ziZ861fVLIjvQrO7PArs0zMy5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Roman Stratiienko <r.stratiienko@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5.10 13/68] drm/shmem-helper: Reset vma->vm_ops before calling dma_buf_mmap()
Date:   Sun, 13 Aug 2023 23:19:14 +0200
Message-ID: <20230813211708.560867144@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
References: <20230813211708.149630011@linuxfoundation.org>
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
@@ -614,7 +614,13 @@ int drm_gem_shmem_mmap(struct drm_gem_ob
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


