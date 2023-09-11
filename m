Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68AD79BCFF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345958AbjIKVWp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbjIKO51 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:57:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337F7E58
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:57:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595AAC433CA;
        Mon, 11 Sep 2023 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444242;
        bh=rgZtY447ewqeyEfWbr7m4lhlqCsv3i/mmUDA5RFnn4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQeTlz2YCJxgapgCLXm6rH2pSFclNEEb22BmbPXNBWkSvFelBYmTd3Z55woOLcZd2
         nr8z9gH8Ao+T6J75X1jWY1Z2uDzrjHFI9jjE5oMtuWHxxThyXdqREXXD3UdiPGS63S
         NILF3krj6ir7J71Ul/FtF8cWM3hTgk2FUtfi96Rk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.4 660/737] io_uring: break iopolling on signal
Date:   Mon, 11 Sep 2023 15:48:39 +0200
Message-ID: <20230911134708.962220468@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

commit dc314886cb3d0e4ab2858003e8de2917f8a3ccbd upstream.

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
 io_uring/io_uring.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1689,6 +1689,9 @@ static int io_iopoll_check(struct io_rin
 			break;
 		nr_events += ret;
 		ret = 0;
+
+		if (task_sigpending(current))
+			return -EINTR;
 	} while (nr_events < min && !need_resched());
 
 	return ret;


