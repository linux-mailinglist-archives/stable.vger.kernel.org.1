Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9B777ABC4
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjHMVZg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjHMVZf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C780110EA
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:25:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66FA462930
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E17CC433C8;
        Sun, 13 Aug 2023 21:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961934;
        bh=0+RZHS5a2ndIWK1TdSudHizWXOtlw48VKn/tL2U7yDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SBqHgaGGlqTIDs5KIHuZ541NANhEUinuiQEsnU4C/S9DJgMECpqx3vkUwnGJl4NVx
         uZcs6ebUC3gakzMJcMaDcbcwo3vSev141vED8ad31JKaK+0Y89Fh41B1ot2Iolwr2l
         /moiwbFGemU40uJKT63JX8M5RYI9jws3q83nJTjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aleksa Sarai <cyphar@cyphar.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.4 051/206] io_uring: correct check for O_TMPFILE
Date:   Sun, 13 Aug 2023 23:17:01 +0200
Message-ID: <20230813211726.472448485@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aleksa Sarai <cyphar@cyphar.com>

commit 72dbde0f2afbe4af8e8595a89c650ae6b9d9c36f upstream.

O_TMPFILE is actually __O_TMPFILE|O_DIRECTORY. This means that the old
check for whether RESOLVE_CACHED can be used would incorrectly think
that O_DIRECTORY could not be used with RESOLVE_CACHED.

Cc: stable@vger.kernel.org # v5.12+
Fixes: 3a81fd02045c ("io_uring: enable LOOKUP_CACHED path resolution for filename lookups")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Link: https://lore.kernel.org/r/20230807-resolve_cached-o_tmpfile-v3-1-e49323e1ef6f@cyphar.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/openclose.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -35,9 +35,11 @@ static bool io_openat_force_async(struct
 {
 	/*
 	 * Don't bother trying for O_TRUNC, O_CREAT, or O_TMPFILE open,
-	 * it'll always -EAGAIN
+	 * it'll always -EAGAIN. Note that we test for __O_TMPFILE because
+	 * O_TMPFILE includes O_DIRECTORY, which isn't a flag we need to force
+	 * async for.
 	 */
-	return open->how.flags & (O_TRUNC | O_CREAT | O_TMPFILE);
+	return open->how.flags & (O_TRUNC | O_CREAT | __O_TMPFILE);
 }
 
 static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)


