Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954EA7A3AF9
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240551AbjIQULT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbjIQULE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:11:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470197
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:10:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3C2C433C8;
        Sun, 17 Sep 2023 20:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981459;
        bh=YFK/3zNY1PQNMBimBwD8XRUkTOFxjk9jQBcETvJBRQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3tcd97ZlrqWs3St99obUkPisTg9KiyY4Y5rwYKxUEpB4iGWbKN35j5Tq3ihQwGiX
         2XN2L/ypjofe5od6TcfMWdwomyAWxLOHLSiOKjiB3GGUmQb/nHhn2gb8mhKyM0SM72
         VqfXxfru+uT/kxYc8eIZSyjuESB4gDrO8cMZpv98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wang Ming <machel@vivo.com>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 058/511] fs: Fix error checking for d_hash_and_lookup()
Date:   Sun, 17 Sep 2023 21:08:05 +0200
Message-ID: <20230917191115.288363402@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Ming <machel@vivo.com>

[ Upstream commit 0d5a4f8f775ff990142cdc810a84eae078589d27 ]

The d_hash_and_lookup() function returns error pointers or NULL.
Most incorrect error checks were fixed, but the one in int path_pts()
was forgotten.

Fixes: eedf265aa003 ("devpts: Make each mount of devpts an independent filesystem.")
Signed-off-by: Wang Ming <machel@vivo.com>
Message-Id: <20230713120555.7025-1-machel@vivo.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 885b0e93ee966..ea2785103376e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2836,7 +2836,7 @@ int path_pts(struct path *path)
 	dput(path->dentry);
 	path->dentry = parent;
 	child = d_hash_and_lookup(parent, &this);
-	if (!child)
+	if (IS_ERR_OR_NULL(child))
 		return -ENOENT;
 
 	path->dentry = child;
-- 
2.40.1



