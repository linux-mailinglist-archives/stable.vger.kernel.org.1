Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF00776178A
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjGYLtQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGYLtK (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:49:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89DB1FC4
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3215661655
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434CEC433C8;
        Tue, 25 Jul 2023 11:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285734;
        bh=Kg764/fQnGf9//IqecEFoW9xsUZGmY/CZTvSAa9ylzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zGNIaCWxu9fV3uMIlLRado+WFj8DyY3F7IWRxQAO0VtX1CcEWzpEaaMHa/NbaPWBR
         thP96iiWEuPWDG/ExCy+4USKoTbMDVNmDYkK+qFcnc/ppQN35QXTnMkHfGopRZtHES
         9QlBBkgDYybbCuQKm1g06h45pQouhzXwPnkioM+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot <syzbot+7937ba6a50bdd00fffdf@syzkaller.appspotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 284/313] debugobjects: Recheck debug_objects_enabled before reporting
Date:   Tue, 25 Jul 2023 12:47:17 +0200
Message-ID: <20230725104533.367229441@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 8b64d420fe2450f82848178506d3e3a0bd195539 ]

syzbot is reporting false a positive ODEBUG message immediately after
ODEBUG was disabled due to OOM.

  [ 1062.309646][T22911] ODEBUG: Out of memory. ODEBUG disabled
  [ 1062.886755][ T5171] ------------[ cut here ]------------
  [ 1062.892770][ T5171] ODEBUG: assert_init not available (active state 0) object: ffffc900056afb20 object type: timer_list hint: process_timeout+0x0/0x40

  CPU 0 [ T5171]                CPU 1 [T22911]
  --------------                --------------
  debug_object_assert_init() {
    if (!debug_objects_enabled)
      return;
    db = get_bucket(addr);
                                lookup_object_or_alloc() {
                                  debug_objects_enabled = 0;
                                  return NULL;
                                }
                                debug_objects_oom() {
                                  pr_warn("Out of memory. ODEBUG disabled\n");
                                  // all buckets get emptied here, and
                                }
    lookup_object_or_alloc(addr, db, descr, false, true) {
      // this bucket is already empty.
      return ERR_PTR(-ENOENT);
    }
    // Emits false positive warning.
    debug_print_object(&o, "assert_init");
  }

Recheck debug_object_enabled in debug_print_object() to avoid that.

Reported-by: syzbot <syzbot+7937ba6a50bdd00fffdf@syzkaller.appspotmail.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/492fe2ae-5141-d548-ebd5-62f5fe2e57f7@I-love.SAKURA.ne.jp
Closes: https://syzkaller.appspot.com/bug?extid=7937ba6a50bdd00fffdf
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/debugobjects.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 26fa04335537b..b0e4301d74954 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -474,6 +474,15 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
 	struct debug_obj_descr *descr = obj->descr;
 	static int limit;
 
+	/*
+	 * Don't report if lookup_object_or_alloc() by the current thread
+	 * failed because lookup_object_or_alloc()/debug_objects_oom() by a
+	 * concurrent thread turned off debug_objects_enabled and cleared
+	 * the hash buckets.
+	 */
+	if (!debug_objects_enabled)
+		return;
+
 	if (limit < 5 && descr != descr_test) {
 		void *hint = descr->debug_hint ?
 			descr->debug_hint(obj->object) : NULL;
-- 
2.39.2



