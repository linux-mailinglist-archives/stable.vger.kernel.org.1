Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3170C755185
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGPT5W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGPT5V (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:57:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B0DEE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E84A60EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70945C433C7;
        Sun, 16 Jul 2023 19:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537439;
        bh=aNZ79TRuYE9AabEZpTW3AOU83Gak0BtyEQwaFS8AAzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jki4sSImLzDALwOyVclPmQteAhwgjF2HuAI9S3nuUH4zalI1F0K8HgNX8ZH4MswU+
         CaIJSqQXEczXdawntN7jKurjqAK+QV5w7Qk7SD4SkqtbJAfGJLbf+8iFH59YsGjtl0
         GD/Af0ZtqzQ/Ynkdutve37BjjkuVnytN+3l2dggw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot <syzbot+00a3779539a23cbee38c@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 097/800] reiserfs: Initialize sec->length in reiserfs_security_init().
Date:   Sun, 16 Jul 2023 21:39:10 +0200
Message-ID: <20230716194951.366859558@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit d031f4e8b493df299123fbb4ec13db870584ed28 ]

syzbot is reporting that sec->length is not initialized.

Since security_inode_init_security() returns 0 when initxattrs is provided
but call_int_hook(inode_init_security) returned -EOPNOTSUPP, control will
reach to "if (sec->length && ...) {" without initializing sec->length.

Reported-by: syzbot <syzbot+00a3779539a23cbee38c@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=00a3779539a23cbee38c
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 52ca4b6435a4 ("reiserfs: Switch to security_inode_init_security()")
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/reiserfs/xattr_security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
index 6e0a099dd7886..078dd8cc312fc 100644
--- a/fs/reiserfs/xattr_security.c
+++ b/fs/reiserfs/xattr_security.c
@@ -67,6 +67,7 @@ int reiserfs_security_init(struct inode *dir, struct inode *inode,
 
 	sec->name = NULL;
 	sec->value = NULL;
+	sec->length = 0;
 
 	/* Don't add selinux attributes on xattrs - they'll never get used */
 	if (IS_PRIVATE(dir))
-- 
2.39.2



