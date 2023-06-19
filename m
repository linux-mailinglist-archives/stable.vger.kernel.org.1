Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7F4735405
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjFSKvQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjFSKum (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BB419C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAE3E60B42
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF30AC433C8;
        Mon, 19 Jun 2023 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171817;
        bh=bV8sI2xMyBPz4ESuFVu+hu+Qnuj0PNcMlNVTcf/ap9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+yYdZ69qGnlSIygztw74QJK1M4IsBDM0iVfvsY7op1GKw667No4KdSheC2n4SAxV
         FL4x+I+36tkAQ4jF76WnInsap75GH6AMl9GO6m38toKRlWPA0Qc2Jq6xYygPIa8VS+
         6naoSN7qbE2CIczCoI5lPs6XdoBGYOKd1I5UOeP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 143/166] cifs: fix lease break oops in xfstest generic/098
Date:   Mon, 19 Jun 2023 12:30:20 +0200
Message-ID: <20230619102201.669158305@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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

From: Steve French <stfrench@microsoft.com>

[ Upstream commit c774e6779f38bf36f0cce65e30793704bab4b0d7 ]

umount can race with lease break so need to check if
tcon->ses->server is still valid to send the lease
break response.

Reviewed-by: Bharath SM <bharathsm@microsoft.com>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Fixes: 59a556aebc43 ("SMB3: drop reference to cfile before sending oplock break")
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 9a4c33ffb75fa..87dcffece7623 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -5146,9 +5146,13 @@ void cifs_oplock_break(struct work_struct *work)
 	 * disconnected since oplock already released by the server
 	 */
 	if (!oplock_break_cancelled) {
-		rc = tcon->ses->server->ops->oplock_response(tcon, persistent_fid,
+		/* check for server null since can race with kill_sb calling tree disconnect */
+		if (tcon->ses && tcon->ses->server) {
+			rc = tcon->ses->server->ops->oplock_response(tcon, persistent_fid,
 				volatile_fid, net_fid, cinode);
-		cifs_dbg(FYI, "Oplock release rc = %d\n", rc);
+			cifs_dbg(FYI, "Oplock release rc = %d\n", rc);
+		} else
+			pr_warn_once("lease break not sent for unmounted share\n");
 	}
 
 	cifs_done_oplock_break(cinode);
-- 
2.39.2



