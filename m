Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7FC7A3CE9
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241170AbjIQUgv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241180AbjIQUgg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:36:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96389118
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:36:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F61C433C8;
        Sun, 17 Sep 2023 20:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982990;
        bh=QeSncU3ZBMuRN5pVqIjwOFIFuEV/cUE5X6MGkLSZ4QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oam+J6Ly2FRW5HWWyJSpMATjx4xXPKJ/LM+bQy/jYlt6ZtfAcNGA6Thyc3FoZPxAa
         BH9V3urKgFcRXfexmPRQNk9ro7KZi00/5JYs3GI9nvVrYXP1uf6WuzN96fnXpYtBR2
         rXvUMLl8D2v4wtNOJ5/Tebq4kpXXQ6ZZik2cMu+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 375/511] io_uring: break iopolling on signal
Date:   Sun, 17 Sep 2023 21:13:22 +0200
Message-ID: <20230917191122.859107509@linuxfoundation.org>
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

From: Pavel Begunkov <asml.silence@gmail.com>

[ upstream commit dc314886cb3d0e4ab2858003e8de2917f8a3ccbd ]

Don't keep spinning iopoll with a signal set. It'll eventually return
back, e.g. by virtue of need_resched(), but it's not a nice user
experience.

Cc: stable@vger.kernel.org
Fixes: def596e9557c9 ("io_uring: support for IO polling")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/eeba551e82cad12af30c3220125eb6cb244cc94c.1691594339.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2668,6 +2668,11 @@ static int io_iopoll_check(struct io_rin
 				break;
 		}
 		ret = io_do_iopoll(ctx, &nr_events, min);
+
+		if (task_sigpending(current)) {
+			ret = -EINTR;
+			goto out;
+		}
 	} while (!ret && nr_events < min && !need_resched());
 out:
 	mutex_unlock(&ctx->uring_lock);


