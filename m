Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5C5703A49
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244873AbjEORu1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244752AbjEORt7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:49:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EA41C3B4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CBB562F22
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32296C433EF;
        Mon, 15 May 2023 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172879;
        bh=L4jDGtev27TReWHRZCBduzZwjPFoB9nhDPtCPdj+hTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGAc6b80d7NTMYCPCBdlrkdDK2qyqWbnVVnH54s+JyaQ+lkLxFsE2AKCq2WSsPjn0
         AwWO+yekT4nRzrNYesMOpHZcoH03LQTHbd8fHvDtkTksLJ1Zmf0pS+QGqpOd8LRhM+
         ITQHXMcuU0zDr7N/4LSGzhy5aVIPAO4WpQZUjhj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 297/381] tty: audit: move some local functions out of tty.h
Date:   Mon, 15 May 2023 18:29:08 +0200
Message-Id: <20230515161750.208873154@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit da5d669e00d2c437b3f508d60add417fc74f4bb6 ]

The functions tty_audit_add_data() and tty_audit_tiocsti() are local to
the tty core code, and do not need to be in a "kernel-wide" header file
so move them to drivers/tty/tty.h

Cc: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20210408125134.3016837-9-gregkh@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 094fb49a2d0d ("tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty.h       | 14 ++++++++++++++
 drivers/tty/tty_audit.c |  1 +
 include/linux/tty.h     | 10 ----------
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index f4cd20261e914..f131d538b62b9 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -18,4 +18,18 @@
 #define tty_info_ratelimited(tty, f, ...) \
 		tty_msg(pr_info_ratelimited, tty, f, ##__VA_ARGS__)
 
+/* tty_audit.c */
+#ifdef CONFIG_AUDIT
+void tty_audit_add_data(struct tty_struct *tty, const void *data, size_t size);
+void tty_audit_tiocsti(struct tty_struct *tty, char ch);
+#else
+static inline void tty_audit_add_data(struct tty_struct *tty, const void *data,
+				      size_t size)
+{
+}
+static inline void tty_audit_tiocsti(struct tty_struct *tty, char ch)
+{
+}
+#endif
+
 #endif
diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index 9f906a5b8e810..9b30edee71fe9 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -10,6 +10,7 @@
 #include <linux/audit.h>
 #include <linux/slab.h>
 #include <linux/tty.h>
+#include "tty.h"
 
 struct tty_audit_buf {
 	struct mutex mutex;	/* Protects all data below */
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 9e3725589214e..a1a9c4b8210ea 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -731,20 +731,10 @@ static inline void n_tty_init(void) { }
 
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
-extern void tty_audit_add_data(struct tty_struct *tty, const void *data,
-			       size_t size);
 extern void tty_audit_exit(void);
 extern void tty_audit_fork(struct signal_struct *sig);
-extern void tty_audit_tiocsti(struct tty_struct *tty, char ch);
 extern int tty_audit_push(void);
 #else
-static inline void tty_audit_add_data(struct tty_struct *tty, const void *data,
-				      size_t size)
-{
-}
-static inline void tty_audit_tiocsti(struct tty_struct *tty, char ch)
-{
-}
 static inline void tty_audit_exit(void)
 {
 }
-- 
2.39.2



