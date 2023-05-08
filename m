Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA386FACE4
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbjEHL3D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbjEHL2d (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4213C3DA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 086C562672
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BF3C433EF;
        Mon,  8 May 2023 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545297;
        bh=MV2/obIo1SmIrVNPfDMX+Putmo3myiKA/3YBD6AfvVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1g0Aw52yTO4Ka1KUbqT+vXJJ7LK64I1X7dhC6d1VCi4J/QcSbKqR5Fc1IIkHPU/bD
         +5RBnu1iSnjo6GPTAKxDx8LAEw8RaXN5xbhAgcsmPRKMu6wGQhWwM5mt/Y0sro2J/O
         LST1QCLQi9gFQ0fuXGCIUzdgSn0BAEN9mKe0AxuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.3 689/694] cifs: protect session status check in smb2_reconnect()
Date:   Mon,  8 May 2023 11:48:44 +0200
Message-Id: <20230508094458.763040460@linuxfoundation.org>
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

From: Paulo Alcantara <pc@manguebit.com>

commit 5bff9f741af60b143a5ae73417a8ec47fd5ff2f4 upstream.

Use @ses->ses_lock to protect access of @ses->ses_status.

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/smb2pdu.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -175,8 +175,17 @@ smb2_reconnect(__le16 smb2_command, stru
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


