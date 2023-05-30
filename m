Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A4D716DC0
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 21:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjE3TkW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 15:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjE3TkV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 15:40:21 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E692C9
        for <stable@vger.kernel.org>; Tue, 30 May 2023 12:40:20 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53f460cd829so2482774a12.1
        for <stable@vger.kernel.org>; Tue, 30 May 2023 12:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685475619; x=1688067619;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=31LmgMj0i/ryER6BqsnfnbOKZjYT+fTIJ/AmWQEZtpA=;
        b=lyVAlCRYWdrf+9r6kfPdDeR+gZDab2Gc+PapBlBpK8hlXBdBO+xDA3K5ZMYbgSK3s5
         hZPIiugR7LFV68dmgUARtLskcb7ao9yf6HlWQlkhAwy7Nqs0zXO+LT0nv0Mhek7ZtEVG
         987zWXB1qBp9nvdJ1wK8pAmLuY3uvnKUeWzatQTOdkU6ArMoGhMCYFX+EtBhXoLhlsdo
         fbzzlQwhx+Hp1KKBRJEhGT0oDMs+lLng2DIpfvBOEAdwWt3uAWrhQo7YtOO1hvcOsw+h
         g++YaqjMRaSEjKtJSAUM/4kB9GZArh9qY+6hwN0TR/yS8JamXBsIl/4Gy5bvCHHuY9dU
         816Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685475619; x=1688067619;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31LmgMj0i/ryER6BqsnfnbOKZjYT+fTIJ/AmWQEZtpA=;
        b=CDa7Oc+RLb7nGQmF7t3yHkJ3D2B+HyTh3u5yhawBK3xADB0dg3uLy6fpgSYyHjdgju
         L32ENw817AVJex6PVYnijC1FE+uOqvdXeyevo+TBkAxy+vzL7q1ibH3JkfjqyF/NBV1b
         vAYocDUwneLRjDnYkP0Z8UEOXNB3zxQqyGh4cxGc3B7+ZpCkqIcMcotH4SAkdG8t7Tkl
         YI4G5fDxlRdqz+PO3YDQYT9lN7iEKymSYPSAYHPhY05lAaC6JSbrftHTlLjSxMhJdRrm
         VDjgUj0m5qDiAhniWP8SXh29a5JSd5hsKxyogNGDbeb37PSAVmevow8DSV3oIO9kEaxw
         KWWw==
X-Gm-Message-State: AC+VfDzTW71AJ6Ft5407iITbLwlzfgVsqNXyLx8LVmNlP3BGyiEAPK5e
        O9lhJHUQ26nQOiWD/N8NqvHnjxbBcSDzlF6MuzOacI5hjG7Rbsyxd5Z2uBM1nT8grRWJ0Wt73yo
        22Jzz0BbGAr7z8f0uoanhwNEHznp32fMsBZGWx8ju/6xmNKVAATLVSUxuUGFJwwYtvrA=
X-Google-Smtp-Source: ACHHUZ7Sc+x3LXj7YElW68eKRUtedDinf5sFBKQ3hCZ1u0LVq5eTxsRoe78ZaoVjPiogZF2ugeARIfNV0w4OwA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a65:6850:0:b0:534:7596:7791 with SMTP id
 q16-20020a656850000000b0053475967791mr629176pgt.1.1685475619458; Tue, 30 May
 2023 12:40:19 -0700 (PDT)
Date:   Tue, 30 May 2023 19:40:14 +0000
In-Reply-To: <2023052806-sprite-program-51a5@gregkh>
Mime-Version: 1.0
References: <2023052806-sprite-program-51a5@gregkh>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230530194014.1682324-1-cmllamas@google.com>
Subject: [PATCH 5.10.y] binder: fix UAF caused by faulty buffer cleanup
From:   Carlos Llamas <cmllamas@google.com>
To:     stable@vger.kernel.org
Cc:     Carlos Llamas <cmllamas@google.com>,
        Zi Fan Tan <zifantan@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit bdc1c5fac982845a58d28690cdb56db8c88a530d upstream.

In binder_transaction_buffer_release() the 'failed_at' offset indicates
the number of objects to clean up. However, this function was changed by
commit 44d8047f1d87 ("binder: use standard functions to allocate fds"),
to release all the objects in the buffer when 'failed_at' is zero.

This introduced an issue when a transaction buffer is released without
any objects having been processed so far. In this case, 'failed_at' is
indeed zero yet it is misinterpreted as releasing the entire buffer.

This leads to use-after-free errors where nodes are incorrectly freed
and subsequently accessed. Such is the case in the following KASAN
report:

  ==================================================================
  BUG: KASAN: slab-use-after-free in binder_thread_read+0xc40/0x1f30
  Read of size 8 at addr ffff4faf037cfc58 by task poc/474

  CPU: 6 PID: 474 Comm: poc Not tainted 6.3.0-12570-g7df047b3f0aa #5
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   dump_backtrace+0x94/0xec
   show_stack+0x18/0x24
   dump_stack_lvl+0x48/0x60
   print_report+0xf8/0x5b8
   kasan_report+0xb8/0xfc
   __asan_load8+0x9c/0xb8
   binder_thread_read+0xc40/0x1f30
   binder_ioctl+0xd9c/0x1768
   __arm64_sys_ioctl+0xd4/0x118
   invoke_syscall+0x60/0x188
  [...]

  Allocated by task 474:
   kasan_save_stack+0x3c/0x64
   kasan_set_track+0x2c/0x40
   kasan_save_alloc_info+0x24/0x34
   __kasan_kmalloc+0xb8/0xbc
   kmalloc_trace+0x48/0x5c
   binder_new_node+0x3c/0x3a4
   binder_transaction+0x2b58/0x36f0
   binder_thread_write+0x8e0/0x1b78
   binder_ioctl+0x14a0/0x1768
   __arm64_sys_ioctl+0xd4/0x118
   invoke_syscall+0x60/0x188
  [...]

  Freed by task 475:
   kasan_save_stack+0x3c/0x64
   kasan_set_track+0x2c/0x40
   kasan_save_free_info+0x38/0x5c
   __kasan_slab_free+0xe8/0x154
   __kmem_cache_free+0x128/0x2bc
   kfree+0x58/0x70
   binder_dec_node_tmpref+0x178/0x1fc
   binder_transaction_buffer_release+0x430/0x628
   binder_transaction+0x1954/0x36f0
   binder_thread_write+0x8e0/0x1b78
   binder_ioctl+0x14a0/0x1768
   __arm64_sys_ioctl+0xd4/0x118
   invoke_syscall+0x60/0x188
  [...]
  ==================================================================

In order to avoid these issues, let's always calculate the intended
'failed_at' offset beforehand. This is renamed and wrapped in a helper
function to make it clear and convenient.

Fixes: 32e9f56a96d8 ("binder: don't detect sender/target during buffer cleanup")
Reported-by: Zi Fan Tan <zifantan@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Acked-by: Todd Kjos <tkjos@google.com>
Link: https://lore.kernel.org/r/20230505203020.4101154-1-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[cmllamas: resolve trivial conflict due to missing commit 9864bb4801331]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b403c7f063b0..dbae98f09658 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2267,24 +2267,23 @@ static void binder_deferred_fd_close(int fd)
 static void binder_transaction_buffer_release(struct binder_proc *proc,
 					      struct binder_thread *thread,
 					      struct binder_buffer *buffer,
-					      binder_size_t failed_at,
+					      binder_size_t off_end_offset,
 					      bool is_failure)
 {
 	int debug_id = buffer->debug_id;
-	binder_size_t off_start_offset, buffer_offset, off_end_offset;
+	binder_size_t off_start_offset, buffer_offset;
 
 	binder_debug(BINDER_DEBUG_TRANSACTION,
 		     "%d buffer release %d, size %zd-%zd, failed at %llx\n",
 		     proc->pid, buffer->debug_id,
 		     buffer->data_size, buffer->offsets_size,
-		     (unsigned long long)failed_at);
+		     (unsigned long long)off_end_offset);
 
 	if (buffer->target_node)
 		binder_dec_node(buffer->target_node, 1, 0);
 
 	off_start_offset = ALIGN(buffer->data_size, sizeof(void *));
-	off_end_offset = is_failure && failed_at ? failed_at :
-				off_start_offset + buffer->offsets_size;
+
 	for (buffer_offset = off_start_offset; buffer_offset < off_end_offset;
 	     buffer_offset += sizeof(binder_size_t)) {
 		struct binder_object_header *hdr;
@@ -2444,6 +2443,21 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 	}
 }
 
+/* Clean up all the objects in the buffer */
+static inline void binder_release_entire_buffer(struct binder_proc *proc,
+						struct binder_thread *thread,
+						struct binder_buffer *buffer,
+						bool is_failure)
+{
+	binder_size_t off_end_offset;
+
+	off_end_offset = ALIGN(buffer->data_size, sizeof(void *));
+	off_end_offset += buffer->offsets_size;
+
+	binder_transaction_buffer_release(proc, thread, buffer,
+					  off_end_offset, is_failure);
+}
+
 static int binder_translate_binder(struct flat_binder_object *fp,
 				   struct binder_transaction *t,
 				   struct binder_thread *thread)
@@ -3926,7 +3940,7 @@ binder_free_buf(struct binder_proc *proc,
 		binder_node_inner_unlock(buf_node);
 	}
 	trace_binder_transaction_buffer_release(buffer);
-	binder_transaction_buffer_release(proc, thread, buffer, 0, is_failure);
+	binder_release_entire_buffer(proc, thread, buffer, is_failure);
 	binder_alloc_free_buf(&proc->alloc, buffer);
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

