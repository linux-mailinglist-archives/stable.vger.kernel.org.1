Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B726FA8EE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjEHKqb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbjEHKqI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:46:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D50229FF8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:45:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9646D628B7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D69C433D2;
        Mon,  8 May 2023 10:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542745;
        bh=BW96ZvDK83h+uaBf2m1kow07Qd7lkBQ6tXjIxjqt7Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MwFl3yepWSyr10G+fJFZsCjgpNKfY2CpaFEZTF3cVFwfGOY+7+LXC+cq0+WKRJKdw
         cbpni2m8yr4StTaaVWD6sQZyeZOO384/mXc96J4BvhNZ+JDbUDXY1xYPxtFxAH4u1f
         QexYD3fMNmI09cxXtDVANgg/eGf2s8mZDjtZVTrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 535/663] fs/ntfs3: Add check for kmemdup
Date:   Mon,  8 May 2023 11:46:01 +0200
Message-Id: <20230508094446.304927077@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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
index c6eb371a36951..dc723f03d6bb2 100644
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



