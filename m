Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31397E23CA
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjKFNOk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjKFNOk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:14:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5E994
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:14:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EB0C433C7;
        Mon,  6 Nov 2023 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276477;
        bh=dFry83SkEhp6Z9oFwt3lD5bTUXluOSTi6xNO9iHJemU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qoKyA68Ed084FkqWAphnEKBc+dFFJmXYCwmuWfdOx5/zhDZssE9NDk6EUsJeOZ3HK
         gl7KHO9IN8vBKH8OMh8LiE3knVFvMBHtormFtBHytI9Wo5Qw1fBu3r8Xydcm1XzTtP
         LwsUyy/aUSYiUHvudTXf7HTGFUj0l1hVrzpw4Vno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 38/62] io_uring: kiocb_done() should *not* trust ->ki_pos if ->{read,write}_iter() failed
Date:   Mon,  6 Nov 2023 14:03:44 +0100
Message-ID: <20231106130303.199541332@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 1939316bf988f3e49a07d9c4dd6f660bf4daa53d ]

->ki_pos value is unreliable in such cases.  For an obvious example,
consider O_DSYNC write - we feed the data to page cache and start IO,
then we make sure it's completed.  Update of ->ki_pos is dealt with
by the first part; failure in the second ends up with negative value
returned _and_ ->ki_pos left advanced as if sync had been successful.
In the same situation write(2) does not advance the file position
at all.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/rw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 0218fae12eddc..0133db648d8e9 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -326,7 +326,7 @@ static int kiocb_done(struct io_kiocb *req, ssize_t ret,
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 	unsigned final_ret = io_fixup_rw_res(req, ret);
 
-	if (req->flags & REQ_F_CUR_POS)
+	if (ret >= 0 && req->flags & REQ_F_CUR_POS)
 		req->file->f_pos = rw->kiocb.ki_pos;
 	if (ret >= 0 && (rw->kiocb.ki_complete == io_complete_rw)) {
 		if (!__io_complete_rw_common(req, ret)) {
-- 
2.42.0



