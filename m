Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DAC719D57
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjFANWZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjFANWV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:22:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BFF1A8
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A853261AF5
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AE0C4339B;
        Thu,  1 Jun 2023 13:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625727;
        bh=tRLvT91wGfWp24uirKSMXa5dwGy+OpqTKJw8sdTaS84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMuyDH++hMQ7YG7CLTHUYQqXT+ZK3pBrDydhqOMUTCHHCyp+2NyJnNttqU/r7pKYH
         rbZh97MH6sM2aMbfxnZxpqS0AgMoLNiXnNIAVYca0w+DLfD5lHdDs2gJLFjodJIJKH
         GWyXQ67dq2jGwRa0yMmddM1g8Ghm2tJkHLEiPZZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Lee Jones <lee@kernel.org>
Subject: [PATCH 5.4 10/16] io_uring: always grab lock in io_cancel_async_work()
Date:   Thu,  1 Jun 2023 14:21:05 +0100
Message-Id: <20230601131932.434586757@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131931.947241286@linuxfoundation.org>
References: <20230601131931.947241286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

No upstream commit exists for this patch.

It's not necessarily safe to check the task_list locklessly, remove
this micro optimization and always grab task_lock before deeming it
empty.

Reported-and-tested-by: Lee Jones <lee@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/io_uring.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3738,9 +3738,6 @@ static void io_cancel_async_work(struct
 {
 	struct io_kiocb *req;
 
-	if (list_empty(&ctx->task_list))
-		return;
-
 	spin_lock_irq(&ctx->task_lock);
 
 	list_for_each_entry(req, &ctx->task_list, task_list) {


