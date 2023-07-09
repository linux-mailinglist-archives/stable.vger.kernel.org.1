Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC1174C206
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjGILOf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjGILOe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:14:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB09E12A
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AEFD60BC4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7722EC433C7;
        Sun,  9 Jul 2023 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901272;
        bh=ANrfaKyJP2FUXOaM31vYzQIlBUTQnUVpURxMjTlfYhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J2TmXLKxMcupYV3st+JR8Q3VPaGif2WpTk23nqO7CSlR0L6p6nHtk3k2nhPJyBM9x
         J4PH9KAXO4tz3ZxATlniessi/uDG1m9Kqa+P6T82T/CdGGkC5DRc2uuxljuWoS2kRD
         jN+PeYQeIpH1j2pCxEK/ANV4U6XqdKQqSVgPonMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.4 3/8] mm: lock newly mapped VMA which can be modified after it becomes visible
Date:   Sun,  9 Jul 2023 13:14:09 +0200
Message-ID: <20230709111345.397858220@linuxfoundation.org>
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

From: Suren Baghdasaryan <surenb@google.com>

commit 33313a747e81af9f31d0d45de78c9397fa3655eb upstream.

mmap_region adds a newly created VMA into VMA tree and might modify it
afterwards before dropping the mmap_lock.  This poses a problem for page
faults handled under per-VMA locks because they don't take the mmap_lock
and can stumble on this VMA while it's still being modified.  Currently
this does not pose a problem since post-addition modifications are done
only for file-backed VMAs, which are not handled under per-VMA lock.
However, once support for handling file-backed page faults with per-VMA
locks is added, this will become a race.

Fix this by write-locking the VMA before inserting it into the VMA tree.
Other places where a new VMA is added into VMA tree do not modify it
after the insertion, so do not need the same locking.

Cc: stable@vger.kernel.org
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mmap.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2804,6 +2804,8 @@ cannot_expand:
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
 
+	/* Lock the VMA since it is modified after insertion into VMA tree */
+	vma_start_write(vma);
 	vma_iter_store(&vmi, vma);
 	mm->map_count++;
 	if (vma->vm_file) {


