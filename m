Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143BA75560D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjGPUrC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjGPUrB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDC8D9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AEB860EA2
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4943C433C7;
        Sun, 16 Jul 2023 20:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540419;
        bh=eS+UyUz8srakJcfiKtXumDf28wuRPZ1CmhV5tbGHFBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4tKP0TY0Ns83WK9Ars+OleOJopNfLPufzfJhYwqm58xIEew3wr0zxJB6dyszDn+G
         SDlTJwnF7r4s4F7dMm1QTXZf7kcNsAUPNHMYOVmgBzudCcrZoQgFvpZ3QKd2R6EV7x
         nsDeL8YqLSw/r7w1Zq80tx25ACwB0tPkGHFfM+Cw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 357/591] cifs: do all necessary checks for credits within or before locking
Date:   Sun, 16 Jul 2023 21:48:16 +0200
Message-ID: <20230716194933.149496967@linuxfoundation.org>
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

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 326a8d04f147e2bf393f6f9cdb74126ee6900607 ]

All the server credits and in-flight info is protected by req_lock.
Once the req_lock is held, and we've determined that we have enough
credits to continue, this lock cannot be dropped till we've made the
changes to credits and in-flight count.

However, we used to drop the lock in order to avoid deadlock with
the recent srv_lock. This could cause the checks already made to be
invalidated.

Fixed it by moving the server status check to before locking req_lock.

Fixes: d7d7a66aacd6 ("cifs: avoid use of global locks for high contention data")
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c   | 19 ++++++++++---------
 fs/smb/client/transport.c | 20 ++++++++++----------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index d512440d35b6f..e6a191a7499e8 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -208,6 +208,16 @@ smb2_wait_mtu_credits(struct TCP_Server_Info *server, unsigned int size,
 
 	spin_lock(&server->req_lock);
 	while (1) {
+		spin_unlock(&server->req_lock);
+
+		spin_lock(&server->srv_lock);
+		if (server->tcpStatus == CifsExiting) {
+			spin_unlock(&server->srv_lock);
+			return -ENOENT;
+		}
+		spin_unlock(&server->srv_lock);
+
+		spin_lock(&server->req_lock);
 		if (server->credits <= 0) {
 			spin_unlock(&server->req_lock);
 			cifs_num_waiters_inc(server);
@@ -218,15 +228,6 @@ smb2_wait_mtu_credits(struct TCP_Server_Info *server, unsigned int size,
 				return rc;
 			spin_lock(&server->req_lock);
 		} else {
-			spin_unlock(&server->req_lock);
-			spin_lock(&server->srv_lock);
-			if (server->tcpStatus == CifsExiting) {
-				spin_unlock(&server->srv_lock);
-				return -ENOENT;
-			}
-			spin_unlock(&server->srv_lock);
-
-			spin_lock(&server->req_lock);
 			scredits = server->credits;
 			/* can deadlock with reopen */
 			if (scredits <= 8) {
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index c961b90f92b9f..e03ffcf7e201c 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -549,6 +549,16 @@ wait_for_free_credits(struct TCP_Server_Info *server, const int num_credits,
 	}
 
 	while (1) {
+		spin_unlock(&server->req_lock);
+
+		spin_lock(&server->srv_lock);
+		if (server->tcpStatus == CifsExiting) {
+			spin_unlock(&server->srv_lock);
+			return -ENOENT;
+		}
+		spin_unlock(&server->srv_lock);
+
+		spin_lock(&server->req_lock);
 		if (*credits < num_credits) {
 			scredits = *credits;
 			spin_unlock(&server->req_lock);
@@ -574,15 +584,6 @@ wait_for_free_credits(struct TCP_Server_Info *server, const int num_credits,
 				return -ERESTARTSYS;
 			spin_lock(&server->req_lock);
 		} else {
-			spin_unlock(&server->req_lock);
-
-			spin_lock(&server->srv_lock);
-			if (server->tcpStatus == CifsExiting) {
-				spin_unlock(&server->srv_lock);
-				return -ENOENT;
-			}
-			spin_unlock(&server->srv_lock);
-
 			/*
 			 * For normal commands, reserve the last MAX_COMPOUND
 			 * credits to compound requests.
@@ -596,7 +597,6 @@ wait_for_free_credits(struct TCP_Server_Info *server, const int num_credits,
 			 * for servers that are slow to hand out credits on
 			 * new sessions.
 			 */
-			spin_lock(&server->req_lock);
 			if (!optype && num_credits == 1 &&
 			    server->in_flight > 2 * MAX_COMPOUND &&
 			    *credits <= MAX_COMPOUND) {
-- 
2.39.2



