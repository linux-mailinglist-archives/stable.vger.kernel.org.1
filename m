Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7C77ED09F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbjKOT4p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbjKOT42 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:56:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5581E1A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:56:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF35AC433C7;
        Wed, 15 Nov 2023 19:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078184;
        bh=LoOsZO7kiJj3CfheIMNGqINKAhquKSxH67kqJOJ/GQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RavQ76YoHOrlE+BSzIP6thh185OCei4VKSuw+rBX6xYeID+8M0Qd983kmw8klZpOT
         iH0XTlaa223afo/PW8YBkJ+2HFKMJ1wRSH1Z90Xnu3VUIMLhfBFg3r2dRqVbIrUhMI
         QocHO8rU1LNqYzoMNrevRUeQFUnZ4LX2JEhd+Yfs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gabriel Krisman Bertazi <krisman@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 139/379] io_uring/kbuf: Fix check of BID wrapping in provided buffers
Date:   Wed, 15 Nov 2023 14:23:34 -0500
Message-ID: <20231115192653.346676307@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriel Krisman Bertazi <krisman@suse.de>

[ Upstream commit ab69838e7c75b0edb699c1a8f42752b30333c46f ]

Commit 3851d25c75ed0 ("io_uring: check for rollover of buffer ID when
providing buffers") introduced a check to prevent wrapping the BID
counter when sqe->off is provided, but it's off-by-one too
restrictive, rejecting the last possible BID (65534).

i.e., the following fails with -EINVAL.

     io_uring_prep_provide_buffers(sqe, addr, size, 0xFFFF, 0, 0);

Fixes: 3851d25c75ed ("io_uring: check for rollover of buffer ID when providing buffers")
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
Link: https://lore.kernel.org/r/20231005000531.30800-2-krisman@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/kbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index acc37e5a6d4e1..e45602b02a9f1 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -347,7 +347,7 @@ int io_provide_buffers_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 	tmp = READ_ONCE(sqe->off);
 	if (tmp > USHRT_MAX)
 		return -E2BIG;
-	if (tmp + p->nbufs >= USHRT_MAX)
+	if (tmp + p->nbufs > USHRT_MAX)
 		return -EINVAL;
 	p->bid = tmp;
 	return 0;
-- 
2.42.0



