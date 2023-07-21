Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C580C75CED0
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjGUQYg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjGUQYX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:24:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EFC5267
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:20:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8810261CC1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840A7C433A9;
        Fri, 21 Jul 2023 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956450;
        bh=EAJoxQn5mk0pC34/hY8NYrSGyHA2pdyQPstyYezC+DI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M92833IwaB/heHFZJJTSyX5j42JYQJ2+GpDU/kF0SLtEwn9V6V0iA6uemAcPMMhs4
         ZoRo/uMBf6XxJqFBQGVSobMPQT7v2N9otM4263+SL1xd3yAWW2y2OIph0rBdOYXbpi
         A7oS63DgorBlbwsfqgl17ungzlWoARVFmUrPFUzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>
Subject: [PATCH 6.4 190/292] fs: dlm: fix mismatch of plock results from userspace
Date:   Fri, 21 Jul 2023 18:04:59 +0200
Message-ID: <20230721160537.055099680@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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

From: Alexander Aring <aahringo@redhat.com>

commit 57e2c2f2d94cfd551af91cedfa1af6d972487197 upstream.

When a waiting plock request (F_SETLKW) is sent to userspace
for processing (dlm_controld), the result is returned at a
later time. That result could be incorrectly matched to a
different waiting request in cases where the owner field is
the same (e.g. different threads in a process.) This is fixed
by comparing all the properties in the request and reply.

The results for non-waiting plock requests are now matched
based on list order because the results are returned in the
same order they were sent.

Cc: stable@vger.kernel.org
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/dlm/plock.c |   58 ++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 13 deletions(-)

--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -395,7 +395,7 @@ static ssize_t dev_read(struct file *fil
 		if (op->info.flags & DLM_PLOCK_FL_CLOSE)
 			list_del(&op->list);
 		else
-			list_move(&op->list, &recv_list);
+			list_move_tail(&op->list, &recv_list);
 		memcpy(&info, &op->info, sizeof(info));
 	}
 	spin_unlock(&ops_lock);
@@ -433,20 +433,52 @@ static ssize_t dev_write(struct file *fi
 	if (check_version(&info))
 		return -EINVAL;
 
+	/*
+	 * The results for waiting ops (SETLKW) can be returned in any
+	 * order, so match all fields to find the op.  The results for
+	 * non-waiting ops are returned in the order that they were sent
+	 * to userspace, so match the result with the first non-waiting op.
+	 */
 	spin_lock(&ops_lock);
-	list_for_each_entry(iter, &recv_list, list) {
-		if (iter->info.fsid == info.fsid &&
-		    iter->info.number == info.number &&
-		    iter->info.owner == info.owner) {
-			list_del_init(&iter->list);
-			memcpy(&iter->info, &info, sizeof(info));
-			if (iter->data)
-				do_callback = 1;
-			else
-				iter->done = 1;
-			op = iter;
-			break;
+	if (info.wait) {
+		list_for_each_entry(iter, &recv_list, list) {
+			if (iter->info.fsid == info.fsid &&
+			    iter->info.number == info.number &&
+			    iter->info.owner == info.owner &&
+			    iter->info.pid == info.pid &&
+			    iter->info.start == info.start &&
+			    iter->info.end == info.end &&
+			    iter->info.ex == info.ex &&
+			    iter->info.wait) {
+				op = iter;
+				break;
+			}
 		}
+	} else {
+		list_for_each_entry(iter, &recv_list, list) {
+			if (!iter->info.wait) {
+				op = iter;
+				break;
+			}
+		}
+	}
+
+	if (op) {
+		/* Sanity check that op and info match. */
+		if (info.wait)
+			WARN_ON(op->info.optype != DLM_PLOCK_OP_LOCK);
+		else
+			WARN_ON(op->info.fsid != info.fsid ||
+				op->info.number != info.number ||
+				op->info.owner != info.owner ||
+				op->info.optype != info.optype);
+
+		list_del_init(&op->list);
+		memcpy(&op->info, &info, sizeof(info));
+		if (op->data)
+			do_callback = 1;
+		else
+			op->done = 1;
 	}
 	spin_unlock(&ops_lock);
 


