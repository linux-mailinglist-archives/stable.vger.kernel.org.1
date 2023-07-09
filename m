Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8908C74C207
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjGILOj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjGILOi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:14:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D8813D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:14:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58F5360BC7
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D889C433C8;
        Sun,  9 Jul 2023 11:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901275;
        bh=UjjBGhzKOxEVuuaGuLBSd+9oLMENGkyHQzkPSfEKTso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkudsO6YSH5oY98Y5ggs2OpxIdxc4Bb3/1Nkw4Cp0u2Mb6oyUWkATIRlBXAgaFcBu
         l5lbQ4qrfALbsjFZt/xjMd26BLPVwEfSo/7yfgPQv5DyEe1CbXtA/m52iXBGxOcnQe
         ssGjfwefgT94LaifPKHgYnEGUjESarBfR+Q9QxZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.4 4/8] mm: lock newly mapped VMA with corrected ordering
Date:   Sun,  9 Jul 2023 13:14:10 +0200
Message-ID: <20230709111345.430583721@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111345.297026264@linuxfoundation.org>
References: <20230709111345.297026264@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hugh Dickins <hughd@google.com>

commit 1c7873e3364570ec89343ff4877e0f27a7b21a61 upstream.

Lockdep is certainly right to complain about

  (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_write+0x2d/0x3f
                 but task is already holding lock:
  (&mapping->i_mmap_rwsem){+.+.}-{3:3}, at: mmap_region+0x4dc/0x6db

Invert those to the usual ordering.

Fixes: 33313a747e81 ("mm: lock newly mapped VMA which can be modified after it becomes visible")
Cc: stable@vger.kernel.org
Signed-off-by: Hugh Dickins <hughd@google.com>
Tested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mmap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2801,11 +2801,11 @@ cannot_expand:
 	if (vma_iter_prealloc(&vmi))
 		goto close_and_free_vma;
 
+	/* Lock the VMA since it is modified after insertion into VMA tree */
+	vma_start_write(vma);
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
 
-	/* Lock the VMA since it is modified after insertion into VMA tree */
-	vma_start_write(vma);
 	vma_iter_store(&vmi, vma);
 	mm->map_count++;
 	if (vma->vm_file) {


