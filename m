Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32A979C0E0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbjIKVF5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239890AbjIKObA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:31:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7627DE4B
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:30:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB12BC433C8;
        Mon, 11 Sep 2023 14:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442656;
        bh=8vTeSm86SYWMXK/Yr/uFMr3A3HTfi0YPez9RowAd0Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9EOBnyQmzl7jkKa8heGThNilwNbzmkfO6olH4UUE1JTNfReH0dbzrsCc+kO973mQ
         GlXn/mcC7qJ7NOGaEpe6h4Qb8VVHYxHRdm5s7hPXUKMtGkEb5g4ELs4mGoByjXzaEW
         qarZeiiN+rtsOcLOpB9SaGHctUq7tF7Rd2c33Cag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wang Ming <machel@vivo.com>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 102/737] fs: Fix error checking for d_hash_and_lookup()
Date:   Mon, 11 Sep 2023 15:39:21 +0200
Message-ID: <20230911134653.363644114@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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
index 7e5cb92feab3f..e18c8c9f1d9c6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2890,7 +2890,7 @@ int path_pts(struct path *path)
 	dput(path->dentry);
 	path->dentry = parent;
 	child = d_hash_and_lookup(parent, &this);
-	if (!child)
+	if (IS_ERR_OR_NULL(child))
 		return -ENOENT;
 
 	path->dentry = child;
-- 
2.40.1



