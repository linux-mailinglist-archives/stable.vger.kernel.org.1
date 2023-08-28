Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9895978ABD9
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjH1Kel (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjH1KeT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:34:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F66B12F
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:34:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4091561DAA
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5421BC433C8;
        Mon, 28 Aug 2023 10:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218855;
        bh=tw+PZshW9n4Io/4K8o9aLUhy8XPHN69RWJ5kaJAKpYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irRmYEaHjECQJ1b6squyILrLIUIB+v1ExtMv3fGjeQ1aKLQ+Ar1e5CIX/CbJsUBD0
         JrBQ1g9S/ttd3SgMdcxEQqrRVJV6IqO0JUDpORfwhaYaTks2UAdlQ44X5xsXCu/T5q
         k5uBa1VQXXKEl5LEjo1GLPBznUZkEdw08uXWeLNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 108/122] ublk: remove check IO_URING_F_SQE128 in ublk_ch_uring_cmd
Date:   Mon, 28 Aug 2023 12:13:43 +0200
Message-ID: <20230828101200.019265245@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit 9c7c4bc986932218fd0df9d2a100509772028fb1 upstream.

sizeof(struct ublksrv_io_cmd) is 16bytes, which can be held in 64byte SQE,
so not necessary to check IO_URING_F_SQE128.

With this change, we get chance to save half SQ ring memory.

Fixed: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230220041413.1524335-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/ublk_drv.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1223,9 +1223,6 @@ static int __ublk_ch_uring_cmd(struct io
 			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
 			ub_cmd->result);
 
-	if (!(issue_flags & IO_URING_F_SQE128))
-		goto out;
-
 	if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
 		goto out;
 


