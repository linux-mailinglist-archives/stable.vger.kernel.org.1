Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49776AFE7
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjHAJvO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjHAJvC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:51:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA56269D
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1E15614DF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF6FC433C8;
        Tue,  1 Aug 2023 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883430;
        bh=P0cv7mtuM/xucLEWDgmSXOUo/dHnKUBWmknw7veC/7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vcZlREsfgRqm3EcMds8Rgm8DzzHArjFdwXrP4m2AY5Hr8gh5AfdGcKXrtDsC1qcYk
         bmDRiWyB0xyDjI9z1kT4boTqqZXo4a7Grf1K0cy571CX2APVWRDykIszZVyCHSaLCL
         WZUITx6Ys3WK2ZfrU7J0sQySBtlX5zltV+CCh2Wk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 234/239] mm: lock VMA in dup_anon_vma() before setting ->anon_vma
Date:   Tue,  1 Aug 2023 11:21:38 +0200
Message-ID: <20230801091934.461315217@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jann Horn <jannh@google.com>

commit d8ab9f7b644a2c9b64de405c1953c905ff219dc9 upstream.

When VMAs are merged, dup_anon_vma() is called with `dst` pointing to the
VMA that is being expanded to cover the area previously occupied by
another VMA.  This currently happens while `dst` is not write-locked.

This means that, in the `src->anon_vma && !dst->anon_vma` case, as soon as
the assignment `dst->anon_vma = src->anon_vma` has happened, concurrent
page faults can happen on `dst` under the per-VMA lock.  This is already
icky in itself, since such page faults can now install pages into `dst`
that are attached to an `anon_vma` that is not yet tied back to the
`anon_vma` with an `anon_vma_chain`.  But if `anon_vma_clone()` fails due
to an out-of-memory error, things get much worse: `anon_vma_clone()` then
reverts `dst->anon_vma` back to NULL, and `dst` remains completely
unconnected to the `anon_vma`, even though we can have pages in the area
covered by `dst` that point to the `anon_vma`.

This means the `anon_vma` of such pages can be freed while the pages are
still mapped into userspace, which leads to UAF when a helper like
folio_lock_anon_vma_read() tries to look up the anon_vma of such a page.

This theoretically is a security bug, but I believe it is really hard to
actually trigger as an unprivileged user because it requires that you can
make an order-0 GFP_KERNEL allocation fail, and the page allocator tries
pretty hard to prevent that.

I think doing the vma_start_write() call inside dup_anon_vma() is the most
straightforward fix for now.

For a kernel-assisted reproducer, see the notes section of the patch mail.

Link: https://lkml.kernel.org/r/20230721034643.616851-1-jannh@google.com
Fixes: 5e31275cc997 ("mm: add per-VMA lock and helper functions to control it")
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mmap.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -647,6 +647,7 @@ static inline int dup_anon_vma(struct vm
 	 * anon pages imported.
 	 */
 	if (src->anon_vma && !dst->anon_vma) {
+		vma_start_write(dst);
 		dst->anon_vma = src->anon_vma;
 		return anon_vma_clone(dst, src);
 	}


