Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEB07E23BC
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjKFNOD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjKFNOC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:14:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B21A9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:13:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9645C433C7;
        Mon,  6 Nov 2023 13:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276438;
        bh=Xl8eRNXqdCHcrhAQ220ds7SkR4j/K1MqE55/hNFKWOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f+ku9NvhioWZcHcyyRmNyJDPHaW8NFtRWmX2BJaqHiyaeC6FAIjRHtLcSGoTwAd8D
         mDgV4VioKa5K2wBOGxYxYHjERy56C+13H9ndb4idG1VUnG5Nu3p2E3F9sL9M/ugzM8
         g9oQ/bl2GdFRbH3/n6BXH9H2BpcwZ+czImHbRT/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 14/62] fs/ntfs3: Fix possible NULL-ptr-deref in ni_readpage_cmpr()
Date:   Mon,  6 Nov 2023 14:03:20 +0100
Message-ID: <20231106130302.340821618@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 32e9212256b88f35466642f9c939bb40cfb2c2de ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 166c3c49530ec..bb7e33c240737 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2149,7 +2149,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 
 	for (i = 0; i < pages_per_frame; i++) {
 		pg = pages[i];
-		if (i == idx)
+		if (i == idx || !pg)
 			continue;
 		unlock_page(pg);
 		put_page(pg);
-- 
2.42.0



