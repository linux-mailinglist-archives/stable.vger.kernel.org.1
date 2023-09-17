Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D3D7A3A91
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbjIQUFz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240456AbjIQUFn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:05:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C681BF
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:05:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A628C433CD;
        Sun, 17 Sep 2023 20:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981134;
        bh=t7h2EM9HYJE6ootVcH3EadxRnyLeZX2q5CR5aCSViSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSRPsfz+Eeo5tfRlFKhV4fEgzcbhxHz+J7q+tx/i9L2gpNzgjKS8na11iFF7IKshY
         zSxTIEnF+htoKMofXWYPS18jl9ZzZpxN94JIjViR9nSkgeBUT7N7KsRZfolrVBQpOQ
         MYihcZ5WTcPEmwmxZd4mhyGpNAo+jg+4FJcMkrWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, zdi-disclosures@trendmicro.com
Subject: [PATCH 5.15 010/511] ksmbd: no response from compound read
Date:   Sun, 17 Sep 2023 21:07:17 +0200
Message-ID: <20230917191114.081889800@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit e202a1e8634b186da38cbbff85382ea2b9e297cf ]

ksmbd doesn't support compound read. If client send read-read in
compound to ksmbd, there can be memory leak from read buffer.
Windows and linux clients doesn't send it to server yet. For now,
No response from compound read. compound read will be supported soon.

Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21587, ZDI-CAN-21588
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index f5506853ac0fa..e0b54cd70f041 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6253,6 +6253,11 @@ int smb2_read(struct ksmbd_work *work)
 
 	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
+	if (work->next_smb2_rcv_hdr_off) {
+		work->send_no_response = 1;
+		err = -EOPNOTSUPP;
+		goto out;
+	}
 
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_PIPE)) {
-- 
2.40.1



