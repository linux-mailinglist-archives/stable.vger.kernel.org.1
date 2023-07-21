Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E91A75D301
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGUTGJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjGUTGI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8DD30DB
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:05:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA72261D8E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F62C433C7;
        Fri, 21 Jul 2023 19:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966358;
        bh=2GGiDpXqr6ZG6zTUWp7hXFbEWJqu9Ilt5M5JIbNdVm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+swW7RHt2CBKE1oZI4SL0ISLf2qMlO061vEziHXAhwsYpASU1uznJmSna6AEYSa/
         AYj+juK4eREQNMurmtclqbTG5oFGPqg3HckGoOFC70J4SMwrtEytNXFT7ft55lvlXi
         oftb3yS2cUB94nxbv7Gn01EUKbu7jtbCdNrs5qLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 287/532] kernfs: fix missing kernfs_idr_lock to remove an ID from the IDR
Date:   Fri, 21 Jul 2023 18:03:11 +0200
Message-ID: <20230721160629.987186745@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 90677cfbcf9c2..6a1cb2a182b67 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -637,7 +637,9 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
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



