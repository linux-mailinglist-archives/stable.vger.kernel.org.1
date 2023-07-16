Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69703755626
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjGPUsE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjGPUsD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F72E1
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DDE560EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E83C433C9;
        Sun, 16 Jul 2023 20:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540481;
        bh=127lfjd+8xkAwA6OEa9X8oC1WvhgZTDWQiLOofoJrdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9NPUDIaWP7h6AWgz2U0Bqr/pi+OgJpl5y1CJVfirteNqEwrnzQMVamjjyUuaTCOc
         2uZLk69IULi47EiAxhEQbjkIdDYoCFFa45MeRJfm5z9VVDRPP8zYWQhh2K5zrGD2uT
         yIZFfeWIVibJKLXO6mWr/DN1vj8Tz6dHCsSAsYqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        vegard.nossum@oracle.com, stable@vger.kernel.org, Suren Baghdasaryan" 
        <surenb@google.com>, Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 6.1 371/591] mm/mmap: Fix VM_LOCKED check in do_vmi_align_munmap()
Date:   Sun, 16 Jul 2023 21:48:30 +0200
Message-ID: <20230716194933.518126918@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

6.1 backport of the patch [1] uses 'next' vma instead of 'split' vma.
Fix the mistake.

[1] commit 606c812eb1d5 ("mm/mmap: Fix error path in do_vmi_align_munmap()")

Fixes: a149174ff8bb ("mm/mmap: Fix error path in do_vmi_align_munmap()")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2484,7 +2484,7 @@ do_mas_align_munmap(struct ma_state *mas
 			error = mas_store_gfp(&mas_detach, split, GFP_KERNEL);
 			if (error)
 				goto munmap_gather_failed;
-			if (next->vm_flags & VM_LOCKED)
+			if (split->vm_flags & VM_LOCKED)
 				locked_vm += vma_pages(split);
 
 			count++;


