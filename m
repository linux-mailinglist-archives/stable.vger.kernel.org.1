Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756F479BEF4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239879AbjIKUzc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238224AbjIKNvr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:51:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307C4CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:51:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5773AC433C9;
        Mon, 11 Sep 2023 13:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440302;
        bh=sBuIOgnkAgv/5QIX+/bp4D04mTDAe+4jgZsmG2SbRdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zf6kMt2JUyQgxcrlEGlwAtPGvNXlJBKBtvoQHu5H9Kkoklh+Rj8R2HPxFP8tGLkei
         JAOD1Lsrzoiu7mxn4+oHQ7Lg1Jzcupk1FjVtuH5MEspp57XaTFLmttK1dk7S18gaYl
         1CH0BHLciwFaF15DT6/hrOkStLlKY75FJOP7kE1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 014/739] splice: fsnotify_access(in), fsnotify_modify(out) on success in tee
Date:   Mon, 11 Sep 2023 15:36:53 +0200
Message-ID: <20230911134651.416837051@linuxfoundation.org>
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

[ Upstream commit 576d498e0ac5caff2d9f6312573ab54d98f12d32 ]

Same logic applies here: this can fill up the pipe, and pollers that rely
on getting IN_MODIFY notifications never wake up.

Fixes: 983652c69199 ("splice: report related fsnotify events")
Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
Link: https://bugs.debian.org/1039488
Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
Acked-by: Jan Kara <jack@suse.cz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Message-Id: <10d76dd8c85017ae3cd047c9b9a32e26daefdaa2.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 5f38d921dc074..2e4cab57fb2ff 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1931,6 +1931,11 @@ long do_tee(struct file *in, struct file *out, size_t len, unsigned int flags)
 		}
 	}
 
+	if (ret > 0) {
+		fsnotify_access(in);
+		fsnotify_modify(out);
+	}
+
 	return ret;
 }
 
-- 
2.40.1



