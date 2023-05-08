Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686256FA537
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjEHKHF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjEHKHE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:07:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDD14EEF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3DE962368
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E4DC433A1;
        Mon,  8 May 2023 10:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540422;
        bh=QODmLeWTAz9RKEEaeeGKaYCn8X4IkuVq3+Ace9GQhbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bym7azA7mcecguXSe6NyZwOAGiBefN3Z7PT2A3RWZvQPxBavig31faChfEuczxg00
         yIjfizm3+Z8jvRSy3CewdLMaIwhqrczqmr8Pi/dYO1lKUGghV5qt9uEU9h+DPKnH8o
         BJlOQIMx5GMUOhaGwirF7btjb2LFFjL8KccZ8EKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 359/611] io_uring/rsrc: use nospeced indexes
Date:   Mon,  8 May 2023 11:43:21 +0200
Message-Id: <20230508094434.067176525@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 953c37e066f05a3dca2d74643574b8dfe8a83983 ]

We use array_index_nospec() for registered buffer indexes, but don't use
it while poking into rsrc tags, fix that.

Fixes: 634d00df5e1cf ("io_uring: add full-fledged dynamic buffers support")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/f02fafc5a9c0dd69be2b0618c38831c078232ff0.1681395792.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/rsrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 4426d0e15174f..cce95164204f3 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -562,7 +562,7 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		}
 
 		ctx->user_bufs[i] = imu;
-		*io_get_tag_slot(ctx->buf_data, offset) = tag;
+		*io_get_tag_slot(ctx->buf_data, i) = tag;
 	}
 
 	if (needs_switch)
-- 
2.39.2



