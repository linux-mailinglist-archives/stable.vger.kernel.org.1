Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCB479B72F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbjIKUzp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbjIKNvl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:51:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493BAFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:51:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAC1C433C8;
        Mon, 11 Sep 2023 13:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440296;
        bh=qlkctebdvAhGs81wGo53psdRpraTM0jujkiPybSlBMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ihT84OflhQtlmTMAyGqlRMrRDj0vwe0VMBEqQwZ8hVGeiAsIzuB9vjPn3v+xKMOE0
         8GmkqmnKAfa4jgrp2QbplDjm9fONV5EGcUzqW7yGMCWeXUQkqZgRLvMLrJnJa6ARiq
         2d0GVNNw0Le71PlH0XigIuY2509T28OiI9VQX3gE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 012/739] splice: always fsnotify_access(in), fsnotify_modify(out) on success
Date:   Mon, 11 Sep 2023 15:36:51 +0200
Message-ID: <20230911134651.353536267@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

[ Upstream commit 12ee4b66af34f8e72f3b2fd93a946a955efe7c86 ]

The current behaviour caused an asymmetry where some write APIs
(write, sendfile) would notify the written-to/read-from objects,
but splice wouldn't.

This affected userspace which uses inotify, most notably coreutils
tail -f, to monitor pipes.
If the pipe buffer had been filled by a splice-family function:
  * tail wouldn't know and thus wouldn't service the pipe, and
  * all writes to the pipe would block because it's full,
thus service was denied.
(For the particular case of tail -f this could be worked around
 with ---disable-inotify.)

Fixes: 983652c69199 ("splice: report related fsnotify events")
Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
Link: https://bugs.debian.org/1039488
Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
Acked-by: Jan Kara <jack@suse.cz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Message-Id: <604ec704d933e0e0121d9e107ce914512e045fad.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 3e2a31e1ce6a8..53831eb0fefa8 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1269,10 +1269,8 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
 			flags |= SPLICE_F_NONBLOCK;
 
-		return splice_pipe_to_pipe(ipipe, opipe, len, flags);
-	}
-
-	if (ipipe) {
+		ret = splice_pipe_to_pipe(ipipe, opipe, len, flags);
+	} else if (ipipe) {
 		if (off_in)
 			return -ESPIPE;
 		if (off_out) {
@@ -1297,18 +1295,11 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 		ret = do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
 
-		if (ret > 0)
-			fsnotify_modify(out);
-
 		if (!off_out)
 			out->f_pos = offset;
 		else
 			*off_out = offset;
-
-		return ret;
-	}
-
-	if (opipe) {
+	} else if (opipe) {
 		if (off_out)
 			return -ESPIPE;
 		if (off_in) {
@@ -1324,18 +1315,25 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 
 		ret = splice_file_to_pipe(in, opipe, &offset, len, flags);
 
-		if (ret > 0)
-			fsnotify_access(in);
-
 		if (!off_in)
 			in->f_pos = offset;
 		else
 			*off_in = offset;
+	} else {
+		ret = -EINVAL;
+	}
 
-		return ret;
+	if (ret > 0) {
+		/*
+		 * Generate modify out before access in:
+		 * do_splice_from() may've already sent modify out,
+		 * and this ensures the events get merged.
+		 */
+		fsnotify_modify(out);
+		fsnotify_access(in);
 	}
 
-	return -EINVAL;
+	return ret;
 }
 
 static long __do_splice(struct file *in, loff_t __user *off_in,
-- 
2.40.1



