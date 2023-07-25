Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F9076112E
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjGYKsY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjGYKsX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0768173F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52D9E6165C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613A0C433C7;
        Tue, 25 Jul 2023 10:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282101;
        bh=sqJB2OOTz2MJahsANIM9yn0mCcr/cCmdEUWTyysMqVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxHdmqKiX979bWwxzm9ngWi9QofuPX+jPtI/qwrqS/s3YQk4DR/1NUfS0bg3sFLo3
         PAtJF99ujjUiOOM3ZZ09/euZDLkIBEjn4ju4S0EUjouFD3x0UUtHfDLCyyI+gT9JSK
         9vFB20JjCAGFIyNa7/b/6hVbPT4T7QxPKJW5ZT1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.4 001/227] io_uring: treat -EAGAIN for REQ_F_NOWAIT as final for io-wq
Date:   Tue, 25 Jul 2023 12:42:48 +0200
Message-ID: <20230725104514.870622178@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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
@@ -2032,6 +2032,14 @@ fail:
 		ret = io_issue_sqe(req, issue_flags);
 		if (ret != -EAGAIN)
 			break;
+
+		/*
+		 * If REQ_F_NOWAIT is set, then don't wait or retry with
+		 * poll. -EAGAIN is final for that case.
+		 */
+		if (req->flags & REQ_F_NOWAIT)
+			break;
+
 		/*
 		 * We can get EAGAIN for iopolled IO even though we're
 		 * forcing a sync submission from here, since we can't


