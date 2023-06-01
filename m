Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A309719D58
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjFANW0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbjFANWV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:22:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B4D124
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:22:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A85D961627
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9A0C433EF;
        Thu,  1 Jun 2023 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625733;
        bh=7gAUeDBuAEwBbWXLfgD4+4tlWntu2cygakOOQJajQvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2B2Geh9VcL25y9U2/bn22PtHc8hjgjiki7SPuwFAFoTfbxyUZrAHdYJSnqxDUspnn
         nP5LUJYpIzEV/hEzHu1WQFjLSGG9bMJeOwZzJNsTuPo/N/QtU0pJOSsFhjB/E9of13
         8kQz+JmSanIYt91yGJeM6zDErvzJEdN/pc5PONQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Lee Jones <lee@kernel.org>
Subject: [PATCH 5.4 12/16] io_uring: have io_kill_timeout() honor the request references
Date:   Thu,  1 Jun 2023 14:21:07 +0100
Message-Id: <20230601131932.526569560@linuxfoundation.org>
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

Don't free the request unconditionally, if the request is issued async
then someone else may be holding a submit reference to it.

Reported-and-tested-by: Lee Jones <lee@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/io_uring.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -551,7 +551,8 @@ static void io_kill_timeout(struct io_ki
 		atomic_inc(&req->ctx->cq_timeouts);
 		list_del(&req->list);
 		io_cqring_fill_event(req->ctx, req->user_data, 0);
-		__io_free_req(req);
+		if (refcount_dec_and_test(&req->refs))
+			__io_free_req(req);
 	}
 }
 


