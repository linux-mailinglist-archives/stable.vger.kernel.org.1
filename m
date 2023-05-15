Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EB37038F0
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbjEORgt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242368AbjEOReo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:34:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E794A171E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D53D62D6F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF36C433EF;
        Mon, 15 May 2023 17:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171968;
        bh=PmhdoCEqnlpEksxNakpkb9184xVT2K+vGBFofhNjEBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RMSAlmSdKwciqIlyr5hKawGJJu6SEr+xRgf43b9Cmi4UaR0dtNlnLZEbjz8pPnQ1k
         WxIOEZNaY9XAjYj4v4xyl/lLaQA++P3H04Lwi6FhwlTvJioNx+irEWayhYFPx6Cn8u
         HM5HThLJWB3dN5NRzE9ILx3sVjkbXYSTpSvlnk1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 114/134] ksmbd: fix kernel oops from idr_remove()
Date:   Mon, 15 May 2023 18:29:51 +0200
Message-Id: <20230515161706.927108854@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 17ea92a9f6d0b9a97aaec5ab748e4591d70a562c ]

There is a report that kernel oops happen from idr_remove().

kernel: BUG: kernel NULL pointer dereference, address: 0000000000000010
kernel: RIP: 0010:idr_remove+0x1/0x20
kernel:  __ksmbd_close_fd+0xb2/0x2d0 [ksmbd]
kernel:  ksmbd_vfs_read+0x91/0x190 [ksmbd]
kernel:  ksmbd_fd_put+0x29/0x40 [ksmbd]
kernel:  smb2_read+0x210/0x390 [ksmbd]
kernel:  __process_request+0xa4/0x180 [ksmbd]
kernel:  __handle_ksmbd_work+0xf0/0x290 [ksmbd]
kernel:  handle_ksmbd_work+0x2d/0x50 [ksmbd]
kernel:  process_one_work+0x21d/0x3f0
kernel:  worker_thread+0x50/0x3d0
kernel:  rescuer_thread+0x390/0x390
kernel:  kthread+0xee/0x120
kthread_complete_and_exit+0x20/0x20
kernel:  ret_from_fork+0x22/0x30

While accessing files, If connection is disconnected, windows send
session setup request included previous session destroy. But while still
processing requests on previous session, this request destroy file
table, which mean file table idr will be freed and set to NULL.
So kernel oops happen from ft->idr in __ksmbd_close_fd().
This patch don't directly destroy session in destroy_previous_session().
It just set to KSMBD_SESS_EXITING so that connection will be
terminated after finishing the rest of requests.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 7b4323373d84 ("ksmbd: fix deadlock in ksmbd_find_crypto_ctx()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/mgmt/user_session.c | 2 ++
 fs/ksmbd/smb2pdu.c           | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index 0c7b5335c12af..9c4a9c8c02795 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -241,6 +241,8 @@ struct ksmbd_session *ksmbd_session_lookup_all(struct ksmbd_conn *conn,
 	sess = ksmbd_session_lookup(conn, id);
 	if (!sess && conn->binding)
 		sess = ksmbd_session_lookup_slowpath(id);
+	if (sess && sess->state != SMB2_SESSION_VALID)
+		sess = NULL;
 	return sess;
 }
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index e17f7a5dd9974..8bfe2a6c05f92 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -600,6 +600,7 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 {
 	struct ksmbd_session *prev_sess = ksmbd_session_lookup_slowpath(id);
 	struct ksmbd_user *prev_user;
+	struct channel *chann;
 
 	if (!prev_sess)
 		return;
@@ -615,8 +616,11 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 	}
 
 	put_session(prev_sess);
-	xa_erase(&conn->sessions, prev_sess->id);
-	ksmbd_session_destroy(prev_sess);
+	prev_sess->state = SMB2_SESSION_EXPIRED;
+	write_lock(&prev_sess->chann_lock);
+	list_for_each_entry(chann, &prev_sess->ksmbd_chann_list, chann_list)
+		chann->conn->status = KSMBD_SESS_EXITING;
+	write_unlock(&prev_sess->chann_lock);
 }
 
 /**
-- 
2.39.2



