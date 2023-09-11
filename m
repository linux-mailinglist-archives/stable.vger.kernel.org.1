Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8F879C0B5
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359410AbjIKWQa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238220AbjIKNvo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:51:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3786DFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:51:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E32BC433C7;
        Mon, 11 Sep 2023 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440299;
        bh=oMhuhl/F1EIE13KgjlzwH8HaUbcIL3ZVAUh45OWsgsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ndj1yDKYeN4Nm1VZwhRV9TX5VtX7eJc5l5i2UHofW3Vf4bb2ssFYuUmlaM0BtvQMK
         Fuz01yBILctEnFX2Udqt4yf4Q6yJjTZ1nvB+OaPX5xkYaqHxorK4FbsqRYeBwHUF8B
         Zy2iVn5A29wrn0QvGn+en1TfKixW0ClV+a3V8DFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 013/739] splice: fsnotify_access(fd)/fsnotify_modify(fd) in vmsplice
Date:   Mon, 11 Sep 2023 15:36:52 +0200
Message-ID: <20230911134651.384245330@linuxfoundation.org>
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

[ Upstream commit 7f0f1ea069e52d5a16921abd59377a7da6c25149 ]

Same logic applies here: this can fill up the pipe and pollers that rely
on getting IN_MODIFY notifications never wake up.

Fixes: 983652c69199 ("splice: report related fsnotify events")
Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
Link: https://bugs.debian.org/1039488
Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
Acked-by: Jan Kara <jack@suse.cz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Message-Id: <8d9ad5acb9c5c1dd2376a2ff5da6ac3183115389.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 53831eb0fefa8..5f38d921dc074 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1462,6 +1462,9 @@ static long vmsplice_to_user(struct file *file, struct iov_iter *iter,
 		pipe_unlock(pipe);
 	}
 
+	if (ret > 0)
+		fsnotify_access(file);
+
 	return ret;
 }
 
@@ -1491,8 +1494,10 @@ static long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
 	if (!ret)
 		ret = iter_to_pipe(iter, pipe, buf_flag);
 	pipe_unlock(pipe);
-	if (ret > 0)
+	if (ret > 0) {
 		wakeup_pipe_readers(pipe);
+		fsnotify_modify(file);
+	}
 	return ret;
 }
 
-- 
2.40.1



