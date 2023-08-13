Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1394D77AE1A
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 00:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjHMWA0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 18:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjHMV7S (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:59:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78F12134
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:43:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4597161A2D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBA2C433C8;
        Sun, 13 Aug 2023 21:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963011;
        bh=H5ADKsRsIkNKPBSeZpR5sCvZXoHpETf5T1M8Qcyyy9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fj04lLwRIHmd300vHzekL78wJHQMKtvtFH1RtyptI2sAMzj7LgAIS1NgUGUeUy27V
         DyeU41daYiFFt9X5p1ChW3GT715nKcc3KGK1pMaB9Uq5nfHeWhfcL3WGxamflW2ZE/
         Z4K/F1Yuv/wDYPjR2raoraQ4L0n9Q2r7/Xdjpxhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aleksa Sarai <cyphar@cyphar.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 20/89] io_uring: correct check for O_TMPFILE
Date:   Sun, 13 Aug 2023 23:19:11 +0200
Message-ID: <20230813211711.367652924@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Aleksa Sarai <cyphar@cyphar.com>

Commit 72dbde0f2afbe4af8e8595a89c650ae6b9d9c36f upstream.

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
 io_uring/io_uring.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -4375,9 +4375,11 @@ static int io_openat2(struct io_kiocb *r
 	if (issue_flags & IO_URING_F_NONBLOCK) {
 		/*
 		 * Don't bother trying for O_TRUNC, O_CREAT, or O_TMPFILE open,
-		 * it'll always -EAGAIN
+		 * it'll always -EAGAIN. Note that we test for __O_TMPFILE
+		 * because O_TMPFILE includes O_DIRECTORY, which isn't a flag
+		 * we need to force async for.
 		 */
-		if (req->open.how.flags & (O_TRUNC | O_CREAT | O_TMPFILE))
+		if (req->open.how.flags & (O_TRUNC | O_CREAT | __O_TMPFILE))
 			return -EAGAIN;
 		op.lookup_flags |= LOOKUP_CACHED;
 		op.open_flag |= O_NONBLOCK;


