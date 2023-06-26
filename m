Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF25373E919
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjFZScn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjFZSc1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:32:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2989B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:32:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C11EA60F24
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11C3C433C0;
        Mon, 26 Jun 2023 18:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804336;
        bh=R3xLn3LrKMnRyXEZ+DITys4ZK78OIrcJCLL2O/Ho3b0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VTIt2PmDeHu6mOr3pIu0sf1qbfgqtBMel4gwHR0+8vHrwS2C8vN+Q+1r/q8JhVsRS
         G9NdOCi5I+JbI5c+KFtECv4dAOlzVg0EoLDi7Cv1XaUEb57WUjl5kqAaWmQkDmsyN8
         g0uu8cDayMsOnvhq2qU3Vgw5xKIHe9X8jRGLCEaw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 122/170] io_uring/net: use the correct msghdr union member in io_sendmsg_copy_hdr
Date:   Mon, 26 Jun 2023 20:11:31 +0200
Message-ID: <20230626180806.031333298@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 26fed83653d0154704cadb7afc418f315c7ac1f0 ]

Rather than assign the user pointer to msghdr->msg_control, assign it
to msghdr->msg_control_user to make sparse happy. They are in a union
so the end result is the same, but let's avoid new sparse warnings and
squash this one.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306210654.mDMcyMuB-lkp@intel.com/
Fixes: cac9e4418f4c ("io_uring/net: save msghdr->msg_control for retries")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 41f828d93c899..2b44126a876ef 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -190,7 +190,7 @@ static int io_sendmsg_copy_hdr(struct io_kiocb *req,
 	ret = sendmsg_copy_msghdr(&iomsg->msg, sr->umsg, sr->msg_flags,
 					&iomsg->free_iov);
 	/* save msg_control as sys_sendmsg() overwrites it */
-	sr->msg_control = iomsg->msg.msg_control;
+	sr->msg_control = iomsg->msg.msg_control_user;
 	return ret;
 }
 
@@ -289,7 +289,7 @@ int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (req_has_async_data(req)) {
 		kmsg = req->async_data;
-		kmsg->msg.msg_control = sr->msg_control;
+		kmsg->msg.msg_control_user = sr->msg_control;
 	} else {
 		ret = io_sendmsg_copy_hdr(req, &iomsg);
 		if (ret)
-- 
2.39.2



