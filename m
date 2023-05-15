Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F077038D2
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244314AbjEORfR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244313AbjEORev (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:34:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32344C9E7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:33:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14B2F62D76
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A10AC433EF;
        Mon, 15 May 2023 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171981;
        bh=1O3SMvTGFm3hQCJ79tdKQ9yjpHspQL5nzyUZz/PHxGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J8GZpNs0gA2/IV6OgkDcs4wgtpaS0dZ4wVGK0HffdHST7Mk6uiFVXmLVx9vcJsqws
         rQjoVUFhWWk9vhDW3/dUedOh4oSBY1j0puZD/ClUxoqmX7MBZb+NsU8/0/3iag1/2m
         sd8lirSNNU+GBA0P+PzR5oaALfUMl/JDl4GBSFrg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tim Murray <timmurray@google.com>,
        John Stultz <jstultz@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 5.15 118/134] locking/rwsem: Add __always_inline annotation to __down_read_common() and inlined callers
Date:   Mon, 15 May 2023 18:29:55 +0200
Message-Id: <20230515161707.067231801@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: John Stultz <jstultz@google.com>

commit 92cc5d00a431e96e5a49c0b97e5ad4fa7536bd4b upstream.

Apparently despite it being marked inline, the compiler
may not inline __down_read_common() which makes it difficult
to identify the cause of lock contention, as the blocked
function in traceevents will always be listed as
__down_read_common().

So this patch adds __always_inline annotation to the common
function (as well as the inlined helper callers) to force it to
be inlined so the blocking function will be listed (via Wchan)
in traceevents.

Fixes: c995e638ccbb ("locking/rwsem: Fold __down_{read,write}*()")
Reported-by: Tim Murray <timmurray@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20230503023351.2832796-1-jstultz@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/locking/rwsem.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1221,7 +1221,7 @@ static struct rw_semaphore *rwsem_downgr
 /*
  * lock for reading
  */
-static inline int __down_read_common(struct rw_semaphore *sem, int state)
+static __always_inline int __down_read_common(struct rw_semaphore *sem, int state)
 {
 	int ret = 0;
 	long count;
@@ -1239,17 +1239,17 @@ out:
 	return ret;
 }
 
-static inline void __down_read(struct rw_semaphore *sem)
+static __always_inline void __down_read(struct rw_semaphore *sem)
 {
 	__down_read_common(sem, TASK_UNINTERRUPTIBLE);
 }
 
-static inline int __down_read_interruptible(struct rw_semaphore *sem)
+static __always_inline int __down_read_interruptible(struct rw_semaphore *sem)
 {
 	return __down_read_common(sem, TASK_INTERRUPTIBLE);
 }
 
-static inline int __down_read_killable(struct rw_semaphore *sem)
+static __always_inline int __down_read_killable(struct rw_semaphore *sem)
 {
 	return __down_read_common(sem, TASK_KILLABLE);
 }


