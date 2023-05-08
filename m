Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126616FAE6C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbjEHLon (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbjEHLo1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:44:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649DB150D5
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4143A63663
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8C0C433EF;
        Mon,  8 May 2023 11:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546232;
        bh=rlsRX6LZY4isiFob/7yTl8dcBKH0/qJJmNNOtO1ZwQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sbeQYr7LAvDu3Qkf7HaRnB3tnOdwRWfN1hAJ5v1WtOmMUkYPmz5IjthG2tw25zKJQ
         QhlG6qlfSB00RUnHuirCevYEWdlQTa4KQvEen0iw5FspSmNt1vDfR4JneMrDeWsMTA
         p7ZFb0TyHXu5JX/795/vuK4q0O1ySrrBDrk55Mio=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 301/371] fs/ntfs3: Add check for kmemdup
Date:   Mon,  8 May 2023 11:48:22 +0200
Message-Id: <20230508094824.002251306@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit e6c3cef24cb0d045f99d5cb039b344874e3cfd74 ]

Since the kmemdup may return NULL pointer,
it should be better to add check for the return value
in order to avoid NULL pointer dereference.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fslog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 20abdb2682860..88218831527c2 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -4256,6 +4256,10 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	rec_len -= t32;
 
 	attr_names = kmemdup(Add2Ptr(lrh, t32), rec_len, GFP_NOFS);
+	if (!attr_names) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	lcb_put(lcb);
 	lcb = NULL;
-- 
2.39.2



