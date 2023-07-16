Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33757553B9
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjGPUWR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjGPUWQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:22:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3646790
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:22:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9E7B60DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C0CC433C8;
        Sun, 16 Jul 2023 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538935;
        bh=xmj9AElFo3wHOchIoNzrbAlUEFk4jSK+ubQvw9qLn5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2dzaGLpC0acu7rYQ6HMMSTWoueYqodPTPQ07Oa/8ZRL7YsvwNvBF5+kW0Zx4ZmWFg
         MzupOoaROtNxOAnTEzzelhXlqYcAJawgLnHz/+4MpxL8wDn5qWngacoQ80UbnXswq9
         4nyuGklTaTgBb3RzHUYCs5FbQOQbffx/B3s5jBZ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 599/800] kernfs: fix missing kernfs_idr_lock to remove an ID from the IDR
Date:   Sun, 16 Jul 2023 21:47:32 +0200
Message-ID: <20230716195003.015835830@linuxfoundation.org>
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

From: Muchun Song <songmuchun@bytedance.com>

[ Upstream commit 30480b988f88c279752f3202a26b6fee5f586aef ]

The root->ino_idr is supposed to be protected by kernfs_idr_lock, fix
it.

Fixes: 488dee96bb62 ("kernfs: allow creating kernfs objects with arbitrary uid/gid")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230523024017.24851-1-songmuchun@bytedance.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 45b6919903e6b..5a1a4af9d3d29 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -655,7 +655,9 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	return kn;
 
  err_out3:
+	spin_lock(&kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
+	spin_unlock(&kernfs_idr_lock);
  err_out2:
 	kmem_cache_free(kernfs_node_cache, kn);
  err_out1:
-- 
2.39.2



