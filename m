Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92ED977575F
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjHIKpP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjHIKpN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355DD10F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE8A86310A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9500C433C8;
        Wed,  9 Aug 2023 10:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577912;
        bh=E2kngVvmYhXhRm7A7RS/2bXhBCvHEC73Wo1T4WB+Aqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kK4zJsOdi7oRsjRCdjd6C5RghFg2tdVnxthyWDRBmE4qM2s8vZp+D1FRDEYcbA84I
         UzxnmHq+pxHohw8rVPuDW08+TJ39W3PesHT7qd9yYyAbnkKvFZN1OYALcRrWdjjcg7
         OkK6pk7N2YmOLC2BkMaZ6GTk8T3aUeAkWDzcqtek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.4 001/165] mm: lock_vma_under_rcu() must check vma->anon_vma under vma lock
Date:   Wed,  9 Aug 2023 12:38:52 +0200
Message-ID: <20230809103642.770076335@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jann Horn <jannh@google.com>

commit 657b5146955eba331e01b9a6ae89ce2e716ba306 upstream.

lock_vma_under_rcu() tries to guarantee that __anon_vma_prepare() can't
be called in the VMA-locked page fault path by ensuring that
vma->anon_vma is set.

However, this check happens before the VMA is locked, which means a
concurrent move_vma() can concurrently call unlink_anon_vmas(), which
disassociates the VMA's anon_vma.

This means we can get UAF in the following scenario:

  THREAD 1                   THREAD 2
  ========                   ========
  <page fault>
    lock_vma_under_rcu()
      rcu_read_lock()
      mas_walk()
      check vma->anon_vma

                             mremap() syscall
                               move_vma()
                                vma_start_write()
                                 unlink_anon_vmas()
                             <syscall end>

    handle_mm_fault()
      __handle_mm_fault()
        handle_pte_fault()
          do_pte_missing()
            do_anonymous_page()
              anon_vma_prepare()
                __anon_vma_prepare()
                  find_mergeable_anon_vma()
                    mas_walk() [looks up VMA X]

                             munmap() syscall (deletes VMA X)

                    reusable_anon_vma() [called on freed VMA X]

This is a security bug if you can hit it, although an attacker would
have to win two races at once where the first race window is only a few
instructions wide.

This patch is based on some previous discussion with Linus Torvalds on
the security list.

Cc: stable@vger.kernel.org
Fixes: 5e31275cc997 ("mm: add per-VMA lock and helper functions to control it")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5410,27 +5410,28 @@ retry:
 	if (!vma_is_anonymous(vma))
 		goto inval;
 
-	/* find_mergeable_anon_vma uses adjacent vmas which are not locked */
-	if (!vma->anon_vma)
-		goto inval;
-
 	if (!vma_start_read(vma))
 		goto inval;
 
 	/*
+	 * find_mergeable_anon_vma uses adjacent vmas which are not locked.
+	 * This check must happen after vma_start_read(); otherwise, a
+	 * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
+	 * from its anon_vma.
+	 */
+	if (unlikely(!vma->anon_vma))
+		goto inval_end_read;
+
+	/*
 	 * Due to the possibility of userfault handler dropping mmap_lock, avoid
 	 * it for now and fall back to page fault handling under mmap_lock.
 	 */
-	if (userfaultfd_armed(vma)) {
-		vma_end_read(vma);
-		goto inval;
-	}
+	if (userfaultfd_armed(vma))
+		goto inval_end_read;
 
 	/* Check since vm_start/vm_end might change before we lock the VMA */
-	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
-		vma_end_read(vma);
-		goto inval;
-	}
+	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
+		goto inval_end_read;
 
 	/* Check if the VMA got isolated after we found it */
 	if (vma->detached) {
@@ -5442,6 +5443,9 @@ retry:
 
 	rcu_read_unlock();
 	return vma;
+
+inval_end_read:
+	vma_end_read(vma);
 inval:
 	rcu_read_unlock();
 	count_vm_vma_lock_event(VMA_LOCK_ABORT);


