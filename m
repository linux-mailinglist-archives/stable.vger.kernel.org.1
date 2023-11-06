Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF96F7E2506
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjKFN13 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjKFN12 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:27:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56763F1
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:27:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B55AC433C8;
        Mon,  6 Nov 2023 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277246;
        bh=sc16UnH8BIGF1yXOHMevOr3/9bp4vkYpVwOjxo5jSlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jd4YIl+j5XgecSlcYvBqDIro2ktKe9xyG86QtbS390lkwhRcnv6xF6eumUulmsqF0
         y100iLXVfwTX795QlWKKUY6gpCTkhg1t72Iv/Ru1Q/fK1cVXWkGQUtA7xgY7VWbCIc
         2mZRF20O4KzbEG/zqgBMVyGOTogPL9dkaQh94FWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 087/128] fs/ntfs3: Fix NULL pointer dereference on error in attr_allocate_frame()
Date:   Mon,  6 Nov 2023 14:04:07 +0100
Message-ID: <20231106130313.097303901@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 9c689c8dc86f8ca99bf91c05f24c8bab38fe7d5f ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 321d55b3ca17d..1d5ac2164d94f 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1583,10 +1583,8 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 			le_b = NULL;
 			attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
 					      0, NULL, &mi_b);
-			if (!attr_b) {
-				err = -ENOENT;
-				goto out;
-			}
+			if (!attr_b)
+				return -ENOENT;
 
 			attr = attr_b;
 			le = le_b;
-- 
2.42.0



