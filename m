Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBD576AE21
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjHAJgN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjHAJf4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:35:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3362708
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 737F0613E2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875CEC433C8;
        Tue,  1 Aug 2023 09:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882446;
        bh=brnI0aWeulcmZKDmA06WqhfxXqaHfgPAw8Y6jBhDdEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4o4qecsajYmEDW8aQFgwBVdkcZa1nw+pMsVSKUk+h5Ylla7K3xQO88n9wbkaNZmV
         /uLYKe7HQOSqgeS4QZAdnTSDSdkuxVQHhexLH2NMlDNcbpIt+eGBemyNJqY4dGW6bM
         AhYqtdU/uXfhLgB/U2fJnm3xTnd5Jtm75s61bu0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Thomas Lamprecht <t.lamprecht@proxmox.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Fiona Ebner <f.ebner@proxmox.com>
Subject: [PATCH 6.1 108/228] mm: suppress mm fault logging if fatal signal already pending
Date:   Tue,  1 Aug 2023 11:19:26 +0200
Message-ID: <20230801091926.698484835@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 5f0bc0b042fc77ff70e14c790abdec960cde4ec1 ]

Commit eda0047296a1 ("mm: make the page fault mmap locking killable")
intentionally made it much easier to trigger the "page fault fails
because a fatal signal is pending" situation, by having the mmap locking
fail early in that case.

We have long aborted page faults in other fatal cases when the actual IO
for a page is interrupted by SIGKILL - which is particularly useful for
the traditional case of NFS hanging due to network issues, but local
filesystems could cause it too if you happened to get the SIGKILL while
waiting for a page to be faulted in (eg lock_folio_maybe_drop_mmap()).

So aborting the page fault wasn't a new condition - but it now triggers
earlier, before we even get to 'handle_mm_fault()'.  And as a result the
error doesn't go through our 'fault_signal_pending()' logic, and doesn't
get filtered away there.

Normally you'd never even notice, because if a fatal signal is pending,
the new SIGSEGV we send ends up being ignored anyway.

But it turns out that there is one very noticeable exception: if you
enable 'show_unhandled_signals', the aborted page fault will be logged
in the kernel messages, and you'll get a scary line looking something
like this in your logs:

  pverados[2183248]: segfault at 55e5a00f9ae0 ip 000055e5a00f9ae0 sp 00007ffc0720bea8 error 14 in perl[55e5a00d4000+195000] likely on CPU 10 (core 4, socket 0)

which is rather misleading.  It's not really a segfault at all, it's
just "the thread was killed before the page fault completed, so we
aborted the page fault".

Fix this by just making it clear that a pending fatal signal means that
any new signal coming in after that is implicitly handled.  This will
avoid the misleading logging, since now the signal isn't 'unhandled' any
more.

Reported-and-tested-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
Link: https://lore.kernel.org/lkml/8d063a26-43f5-0bb7-3203-c6a04dc159f8@proxmox.com/
Acked-by: Oleg Nesterov <oleg@redhat.com>
Fixes: eda0047296a1 ("mm: make the page fault mmap locking killable")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/signal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index d140672185a48..5d45f5da2b36e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -561,6 +561,10 @@ bool unhandled_signal(struct task_struct *tsk, int sig)
 	if (handler != SIG_IGN && handler != SIG_DFL)
 		return false;
 
+	/* If dying, we handle all new signals by ignoring them */
+	if (fatal_signal_pending(tsk))
+		return false;
+
 	/* if ptraced, let the tracer determine */
 	return !tsk->ptrace;
 }
-- 
2.39.2



