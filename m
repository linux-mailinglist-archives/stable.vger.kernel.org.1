Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E715D6F9AD8
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 20:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjEGSVI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 14:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGSVH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 14:21:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E958A6198
        for <stable@vger.kernel.org>; Sun,  7 May 2023 11:21:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E5AC60EA8
        for <stable@vger.kernel.org>; Sun,  7 May 2023 18:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9076DC433D2;
        Sun,  7 May 2023 18:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683483665;
        bh=9nqyIQiN8620yBC94kf7A0AvLdBlFKtT24bM8J2gztA=;
        h=Subject:To:Cc:From:Date:From;
        b=B3xan4YAaTKSsDNHHDqiiKKi59dez8egbomex/aKJcQ/TAQ6xLyFQRY8XfAXS7ATh
         56BEeFZ4pM9S4+RdfcT3yRXupktsZPGMM4rsBf9dlGhhJFUzqbIkm6Vt+tlRl28Sji
         qHaBULYpvw+g4R6dWDtNiyFXo2tLsQtD435zDEjc=
Subject: FAILED: patch "[PATCH] cifs: protect session status check in smb2_reconnect()" failed to apply to 5.10-stable tree
To:     pc@manguebit.com, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 20:20:55 +0200
Message-ID: <2023050755-manicotti-acting-0e64@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5bff9f741af60b143a5ae73417a8ec47fd5ff2f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050755-manicotti-acting-0e64@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5bff9f741af60b143a5ae73417a8ec47fd5ff2f4 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Thu, 27 Apr 2023 16:07:38 -0300
Subject: [PATCH] cifs: protect session status check in smb2_reconnect()

Use @ses->ses_lock to protect access of @ses->ses_status.

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 0521aa1da644..3ce63f0cd9f5 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -175,8 +175,17 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		}
 	}
 	spin_unlock(&tcon->tc_lock);
-	if ((!tcon->ses) || (tcon->ses->ses_status == SES_EXITING) ||
-	    (!tcon->ses->server) || !server)
+
+	ses = tcon->ses;
+	if (!ses)
+		return -EIO;
+	spin_lock(&ses->ses_lock);
+	if (ses->ses_status == SES_EXITING) {
+		spin_unlock(&ses->ses_lock);
+		return -EIO;
+	}
+	spin_unlock(&ses->ses_lock);
+	if (!ses->server || !server)
 		return -EIO;
 
 	spin_lock(&server->srv_lock);
@@ -204,8 +213,6 @@ again:
 	if (rc)
 		return rc;
 
-	ses = tcon->ses;
-
 	spin_lock(&ses->chan_lock);
 	if (!cifs_chan_needs_reconnect(ses, server) && !tcon->need_reconnect) {
 		spin_unlock(&ses->chan_lock);

