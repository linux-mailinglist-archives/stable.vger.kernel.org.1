Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB08726DDA
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbjFGUqU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbjFGUqE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:46:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60035272D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:45:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E867C645CD
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BD8C433D2;
        Wed,  7 Jun 2023 20:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170742;
        bh=bx1fSDwKup6zzm0PIgqOfVIQpFp7kiXiD60zkhg5pUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSGb7qwqdA4oZj6T5XBfyYuPhk1j3GyenGiFjxvvq/r/L4VNsi+Ez4DOHj8YfaEI7
         vjlaD6UgbHatVdkB6yqlY1CAkv3Ki5XzSHXfMKHlhY1F7iSODGyjYS4d9ykWpUciqq
         aCeUaVVZH0lSt0TKO5EOh4f/YXNSsH0Yzt9DASVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Noordhuis <info@bnoordhuis.nl>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 183/225] io_uring: undeprecate epoll_ctl support
Date:   Wed,  7 Jun 2023 22:16:16 +0200
Message-ID: <20230607200920.374677703@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
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

From: Ben Noordhuis <info@bnoordhuis.nl>

commit 4ea0bf4b98d66a7a790abb285539f395596bae92 upstream.

Libuv recently started using it so there is at least one consumer now.

Cc: stable@vger.kernel.org
Fixes: 61a2732af4b0 ("io_uring: deprecate epoll_ctl support")
Link: https://github.com/libuv/libuv/pull/3979
Signed-off-by: Ben Noordhuis <info@bnoordhuis.nl>
Link: https://lore.kernel.org/r/20230506095502.13401-1-info@bnoordhuis.nl
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/epoll.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/io_uring/epoll.c b/io_uring/epoll.c
index 9aa74d2c80bc..89bff2068a19 100644
--- a/io_uring/epoll.c
+++ b/io_uring/epoll.c
@@ -25,10 +25,6 @@ int io_epoll_ctl_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_epoll *epoll = io_kiocb_to_cmd(req, struct io_epoll);
 
-	pr_warn_once("%s: epoll_ctl support in io_uring is deprecated and will "
-		     "be removed in a future Linux kernel version.\n",
-		     current->comm);
-
 	if (sqe->buf_index || sqe->splice_fd_in)
 		return -EINVAL;
 
-- 
2.41.0



