Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F5E775D89
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjHILim (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjHILil (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:38:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0EA1FD2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:38:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0ACE6359C
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAD0C433C7;
        Wed,  9 Aug 2023 11:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581120;
        bh=XQC8+iGxxE9zBySSBhy5e8kBDg4YBjsFmK52LaxctyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BcCnwpq0vv69kAA3Fwhvx0eBd2ljZ1rVHGxmh4m6z2HJiLcTEc7RQ/XwdYxWEjoe+
         WaGcvY7HtZ3SfoM/0YavGGjw3Kkp1mB1qarSZmixehcrgCY39tQHPI1Clwz75IlzzW
         lyDXwAMs5Vk7D4J+G9Zl3YD4y0ze+JxSsFCmY0Yo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10 111/201] io_uring: treat -EAGAIN for REQ_F_NOWAIT as final for io-wq
Date:   Wed,  9 Aug 2023 12:41:53 +0200
Message-ID: <20230809103647.508267884@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit a9be202269580ca611c6cebac90eaf1795497800 upstream.

io-wq assumes that an issue is blocking, but it may not be if the
request type has asked for a non-blocking attempt. If we get
-EAGAIN for that case, then we need to treat it as a final result
and not retry or arm poll for it.

Cc: stable@vger.kernel.org # 5.10+
Link: https://github.com/axboe/liburing/issues/897
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -6895,6 +6895,14 @@ static void io_wq_submit_work(struct io_
 			 */
 			if (ret != -EAGAIN || !(req->ctx->flags & IORING_SETUP_IOPOLL))
 				break;
+
+			/*
+			 * If REQ_F_NOWAIT is set, then don't wait or retry with
+			 * poll. -EAGAIN is final for that case.
+			 */
+			if (req->flags & REQ_F_NOWAIT)
+				break;
+
 			cond_resched();
 		} while (1);
 	}


