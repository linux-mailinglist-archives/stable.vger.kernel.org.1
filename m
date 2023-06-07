Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B21726F3C
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbjFGU4i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbjFGU4g (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:56:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4022D1
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E6A06435A
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A179CC433D2;
        Wed,  7 Jun 2023 20:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171393;
        bh=zZUC8aaFm/jkONN7zs5EB7FITz4Q2JwrL19L7MMvPr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVzQU2lrBbGy5/2FaNyQUrGLvaHils6a87emEzT1oko7p0e6WS/+ekVYMHlwqqvnC
         VwrZ3juQ+09lYLBWbdP8EIyyA0/DbDu6yk6xDMHtWaEwZQawtPRDfOy/PNYs5TJQz+
         EuwNyeWBjmPq5JAIgKNlwCqShEzgezT8YKJf7ulE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 76/99] gcc-12: disable -Wdangling-pointer warning for now
Date:   Wed,  7 Jun 2023 22:17:08 +0200
Message-ID: <20230607200902.607835578@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit f7d63b50898172b9eb061b9e2daad61b428792d0 upstream.

[ Upstream commit 49beadbd47c270a00754c107a837b4f29df4c822 ]

While the concept of checking for dangling pointers to local variables
at function exit is really interesting, the gcc-12 implementation is not
compatible with reality, and results in false positives.

For example, gcc sees us putting things on a local list head allocated
on the stack, which involves exactly those kinds of pointers to the
local stack entry:

  In function ‘__list_add’,
      inlined from ‘list_add_tail’ at include/linux/list.h:102:2,
      inlined from ‘rebuild_snap_realms’ at fs/ceph/snap.c:434:2:
  include/linux/list.h:74:19: warning: storing the address of local variable ‘realm_queue’ in ‘*&realm_27(D)->rebuild_item.prev’ [-Wdangling-pointer=]
     74 |         new->prev = prev;
        |         ~~~~~~~~~~^~~~~~

But then gcc - understandably - doesn't really understand the big
picture how the doubly linked list works, so doesn't see how we then end
up emptying said list head in a loop and the pointer we added has been
removed.

Gcc also complains about us (intentionally) using this as a way to store
a kind of fake stack trace, eg

  drivers/acpi/acpica/utdebug.c:40:38: warning: storing the address of local variable ‘current_sp’ in ‘acpi_gbl_entry_stack_pointer’ [-Wdangling-pointer=]
     40 |         acpi_gbl_entry_stack_pointer = &current_sp;
        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~

which is entirely reasonable from a compiler standpoint, and we may want
to change those kinds of patterns, but not not.

So this is one of those "it would be lovely if the compiler were to
complain about us leaving dangling pointers to the stack", but not this
way.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    4 ++++
 1 file changed, 4 insertions(+)

--- a/Makefile
+++ b/Makefile
@@ -783,6 +783,10 @@ endif
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
 
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
+
+# These result in bogus false positives
+KBUILD_CFLAGS += $(call cc-disable-warning, dangling-pointer)
+
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
 else


