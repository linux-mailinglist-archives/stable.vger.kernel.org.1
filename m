Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66D975518B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjGPT5k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGPT5i (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:57:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28650F1
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:57:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A77F260EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69B4C433C7;
        Sun, 16 Jul 2023 19:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537457;
        bh=o2HE8FSTJpG2d46A+YUA2qvrok8h2oVk4IK33mRwZdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HfRTc206BTIH9taHdv0S90AWvq7nMxAM/S+aAPzAaKPSl0hnZLzsUiu/OJZfgqsf0
         9f3uQXZfbd1kdrmN7USwmOnHWVhWuqtrTHuWOs8hGLNQGthRWdHoU6oNkRVHaK6jLd
         t2oD7Jm8erAfqT2ZTMdRBq0P6thxLjik2+MtI7LY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 102/800] pstore/ram: Add check for kstrdup
Date:   Sun, 16 Jul 2023 21:39:15 +0200
Message-ID: <20230716194951.484110960@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit d97038d5ec2062733c1e016caf9baaf68cf64ea1 ]

Add check for the return value of kstrdup() and return the error
if it fails in order to avoid NULL pointer dereference.

Fixes: e163fdb3f7f8 ("pstore/ram: Regularize prz label allocation lifetime")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230614093733.36048-1-jiasheng@iscas.ac.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/ram_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 966191d3a5ba2..85aaf0fc6d7d1 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -599,6 +599,8 @@ struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
 	raw_spin_lock_init(&prz->buffer_lock);
 	prz->flags = flags;
 	prz->label = kstrdup(label, GFP_KERNEL);
+	if (!prz->label)
+		goto err;
 
 	ret = persistent_ram_buffer_map(start, size, prz, memtype);
 	if (ret)
-- 
2.39.2



