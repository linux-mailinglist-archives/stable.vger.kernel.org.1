Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F43775D18
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjHILdr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjHILdq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:33:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D01E3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE2FB6346B
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9434C433C7;
        Wed,  9 Aug 2023 11:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580825;
        bh=ThE9WBsDcCqK+yf7CSKqcMWSS5THlmEZZNfvC4oUKYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AuB04WgEM3wF9i/4pSNl4Yq4owFwM2NE20YI86BUY0wrDP7P2U8zV2u+UvG6mLIob
         o6OsTaOrl0GKLlNRigjtsb/isfKh6BEG3vgJQ6n96+qgK/HDD3WUX2f1eoxLFXZNYX
         EUzUGkainaMbQlqLpdJvkXxN7LRlwJqs8VaOKHzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 143/154] ceph: use kill_anon_super helper
Date:   Wed,  9 Aug 2023 12:42:54 +0200
Message-ID: <20230809103641.595194478@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 470a5c77eac0e07bfe60413fb3d314b734392bc3 ]

ceph open-codes this around some other activity and the rationale
for it isn't clear. There is no need to delay free_anon_bdev until
the end of kill_sb.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Stable-dep-of: e7e607bd0048 ("ceph: defer stopping mdsc delayed_work")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/super.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index d40658d5e8089..279334f955702 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1174,14 +1174,13 @@ static struct dentry *ceph_mount(struct file_system_type *fs_type,
 static void ceph_kill_sb(struct super_block *s)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
-	dev_t dev = s->s_dev;
 
 	dout("kill_sb %p\n", s);
 
 	ceph_mdsc_pre_umount(fsc->mdsc);
 	flush_fs_workqueues(fsc);
 
-	generic_shutdown_super(s);
+	kill_anon_super(s);
 
 	fsc->client->extra_mon_dispatch = NULL;
 	ceph_fs_debugfs_cleanup(fsc);
@@ -1189,7 +1188,6 @@ static void ceph_kill_sb(struct super_block *s)
 	ceph_fscache_unregister_fs(fsc);
 
 	destroy_fs_client(fsc);
-	free_anon_bdev(dev);
 }
 
 static struct file_system_type ceph_fs_type = {
-- 
2.40.1



