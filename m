Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C89D7553F3
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjGPUYv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjGPUYu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:24:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13275126
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:24:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A677160EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72C2C433C7;
        Sun, 16 Jul 2023 20:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539089;
        bh=jCGXrgC9uocQPlJ9eyEqeHh082rRqrlK1w1eIj/JJeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nAnlpbD0hg+FGalAtgJj5sncZUOlelXz2FXykjvHmgsFrlL8kxnfXBpepOAJIW6/O
         4A9q8FctrKD1xJSPuxdIGFvy0auF1KuRKE8aIHd9ZvKu4D8OuaCimhPGDCpKiN11po
         0ccBIXJ2NyC9Khlc4LKrJodRUpmgczWkPqvxrKCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 683/800] f2fs: fix error path handling in truncate_dnode()
Date:   Sun, 16 Jul 2023 21:48:56 +0200
Message-ID: <20230716195004.988785348@linuxfoundation.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit 0135c482fa97e2fd8245cb462784112a00ed1211 ]

If truncate_node() fails in truncate_dnode(), it missed to call
f2fs_put_page(), fix it.

Fixes: 7735730d39d7 ("f2fs: fix to propagate error from __get_meta_page()")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 834c6f099c955..6bdb1bed29ec9 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -943,8 +943,10 @@ static int truncate_dnode(struct dnode_of_data *dn)
 	dn->ofs_in_node = 0;
 	f2fs_truncate_data_blocks(dn);
 	err = truncate_node(dn);
-	if (err)
+	if (err) {
+		f2fs_put_page(page, 1);
 		return err;
+	}
 
 	return 1;
 }
-- 
2.39.2



