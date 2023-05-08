Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B486FACE9
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbjEHL33 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbjEHL3O (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:29:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AA03C489
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:28:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C53DD62672
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAFAC433EF;
        Mon,  8 May 2023 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545313;
        bh=CjKytRevELX7kf3IJ2TCy9akXHAjAiVJumBW8p7gxpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1yOB97jvkTb6lhM4j+tM9KH73da0SCGXyuqbkvzRulUNpfymFUpwpKcY+9JbgE6eZ
         gVYOVX6q3Zb7irwLggI4rL9TzY2FQLZotw1dPmCneD5ZnE3Z3cAzLbDngf/Om2xdBM
         peREeezJdr8pTLibYYbAo+UJLj/NBQVrpRqHgKLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.3 694/694] debugobject: Ensure pool refill (again)
Date:   Mon,  8 May 2023 11:48:49 +0200
Message-Id: <20230508094458.989119558@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 0af462f19e635ad522f28981238334620881badc upstream.

The recent fix to ensure atomicity of lookup and allocation inadvertently
broke the pool refill mechanism.

Prior to that change debug_objects_activate() and debug_objecs_assert_init()
invoked debug_objecs_init() to set up the tracking object for statically
initialized objects. That's not longer the case and debug_objecs_init() is
now the only place which does pool refills.

Depending on the number of statically initialized objects this can be
enough to actually deplete the pool, which was observed by Ido via a
debugobjects OOM warning.

Restore the old behaviour by adding explicit refill opportunities to
debug_objects_activate() and debug_objecs_assert_init().

Fixes: 63a759694eed ("debugobject: Prevent init race with static objects")
Reported-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/r/871qk05a9d.ffs@tglx
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/debugobjects.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -587,6 +587,16 @@ static struct debug_obj *lookup_object_o
 	return NULL;
 }
 
+static void debug_objects_fill_pool(void)
+{
+	/*
+	 * On RT enabled kernels the pool refill must happen in preemptible
+	 * context:
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+		fill_pool();
+}
+
 static void
 __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
@@ -595,12 +605,7 @@ __debug_object_init(void *addr, const st
 	struct debug_obj *obj;
 	unsigned long flags;
 
-	/*
-	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context:
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
-		fill_pool();
+	debug_objects_fill_pool();
 
 	db = get_bucket((unsigned long) addr);
 
@@ -685,6 +690,8 @@ int debug_object_activate(void *addr, co
 	if (!debug_objects_enabled)
 		return 0;
 
+	debug_objects_fill_pool();
+
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
@@ -894,6 +901,8 @@ void debug_object_assert_init(void *addr
 	if (!debug_objects_enabled)
 		return;
 
+	debug_objects_fill_pool();
+
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);


