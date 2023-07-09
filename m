Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813E574C3D0
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjGILgh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjGILgh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:36:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327B413D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:36:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC85A60BC4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEF6C433C8;
        Sun,  9 Jul 2023 11:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902595;
        bh=D9fbLPP5lMzZYDzp+E+B0DZs8Pm7X8Gwq2DJEkN7hVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1E3GQsTK5yCtf8s7l64hN5y503qlR91N6PA3iWndWuOvCWW0AsiEVTA0B9NlzqrV2
         pxTaNhnn3yz0hnN/qxijTr6Qq5yeEphN/8SuTjNWVJkIV4dAG5dyEWBjGWc+T8Oi5+
         5RnaTBJs/A4nqy1QnkgBN7D+wOS/RLHOSKweQydE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 425/431] cifs: do all necessary checks for credits within or before locking
Date:   Sun,  9 Jul 2023 13:16:13 +0200
Message-ID: <20230709111501.146153526@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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
 fs/cifs/smb2ops.c   | 19 ++++++++++---------
 fs/cifs/transport.c | 20 ++++++++++----------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 5065398665f11..bb41b9bae262d 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
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
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 24bdd5f4d3bcc..968bfd029b8eb 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -522,6 +522,16 @@ wait_for_free_credits(struct TCP_Server_Info *server, const int num_credits,
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
@@ -547,15 +557,6 @@ wait_for_free_credits(struct TCP_Server_Info *server, const int num_credits,
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
@@ -569,7 +570,6 @@ wait_for_free_credits(struct TCP_Server_Info *server, const int num_credits,
 			 * for servers that are slow to hand out credits on
 			 * new sessions.
 			 */
-			spin_lock(&server->req_lock);
 			if (!optype && num_credits == 1 &&
 			    server->in_flight > 2 * MAX_COMPOUND &&
 			    *credits <= MAX_COMPOUND) {
-- 
2.39.2



