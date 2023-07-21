Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB7775CEEF
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjGUQ0D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjGUQZn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:25:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E8B5BB5
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E23561D2A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DF8C433C8;
        Fri, 21 Jul 2023 16:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956549;
        bh=X80EkxakP5s8ZAQYk5VOTP9TmuOIfEq+3sKaf5bC3Pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIpEpHx/yLYEP+2xNvVRCC2Z1dP0sbYCJDaLqEliba5XH/nR/gWMgCXgv4mQVx45G
         TkeWohhDeZ2gh8jKdVTXyDx41w2l/LcWls/Wedw1uvXkzKTR8fWplot/kE8di6O/lD
         PnWKHHyHkrJxwdGlOGtQAdNHK9ih9OIbaRVriGoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>
Subject: [PATCH 6.4 189/292] fs: dlm: make F_SETLK use unkillable wait_event
Date:   Fri, 21 Jul 2023 18:04:58 +0200
Message-ID: <20230721160537.013358904@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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

From: Alexander Aring <aahringo@redhat.com>

commit 0f2b1cb89ccdbdcedf7143f4153a4da700a05f48 upstream.

While a non-waiting posix lock request (F_SETLK) is waiting for
user space processing (in dlm_controld), wait for that processing
to complete with an unkillable wait_event(). This makes F_SETLK
behave the same way for F_RDLCK, F_WRLCK and F_UNLCK. F_SETLKW
continues to use wait_event_killable().

Cc: stable@vger.kernel.org
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/dlm/plock.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -155,25 +155,29 @@ int dlm_posix_lock(dlm_lockspace_t *lock
 
 	send_op(op);
 
-	rv = wait_event_killable(recv_wq, (op->done != 0));
-	if (rv == -ERESTARTSYS) {
-		spin_lock(&ops_lock);
-		/* recheck under ops_lock if we got a done != 0,
-		 * if so this interrupt case should be ignored
-		 */
-		if (op->done != 0) {
+	if (op->info.wait) {
+		rv = wait_event_killable(recv_wq, (op->done != 0));
+		if (rv == -ERESTARTSYS) {
+			spin_lock(&ops_lock);
+			/* recheck under ops_lock if we got a done != 0,
+			 * if so this interrupt case should be ignored
+			 */
+			if (op->done != 0) {
+				spin_unlock(&ops_lock);
+				goto do_lock_wait;
+			}
+			list_del(&op->list);
 			spin_unlock(&ops_lock);
-			goto do_lock_wait;
-		}
-		list_del(&op->list);
-		spin_unlock(&ops_lock);
 
-		log_debug(ls, "%s: wait interrupted %x %llx pid %d",
-			  __func__, ls->ls_global_id,
-			  (unsigned long long)number, op->info.pid);
-		do_unlock_close(&op->info);
-		dlm_release_plock_op(op);
-		goto out;
+			log_debug(ls, "%s: wait interrupted %x %llx pid %d",
+				  __func__, ls->ls_global_id,
+				  (unsigned long long)number, op->info.pid);
+			do_unlock_close(&op->info);
+			dlm_release_plock_op(op);
+			goto out;
+		}
+	} else {
+		wait_event(recv_wq, (op->done != 0));
 	}
 
 do_lock_wait:


