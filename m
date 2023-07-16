Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B1D75545F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjGPU3p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjGPU3p (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:29:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B511B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B817760EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B1AC433C7;
        Sun, 16 Jul 2023 20:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539383;
        bh=YBXxUtiOP9irPSJNhIF9AQV2FJcqrrBdzJ71qkwF4wM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z3WNF8CaYy3vnNFvvfKhc6/lODdn/gOGsnm9ykRuYRWRRMn1YeBB3gsDGg+CWWdW7
         riJPSQxAmYo5ix3LvMfxM7LdX1RUYR9qvJKKDmEt7k97DPF/DGCO1J/vZSqmZkBa+e
         giuFW2wtbYhILIZpUt6xW7hWBo0HATnQCsjhU3Ys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 759/800] btrfs: add block-group tree to lockdep classes
Date:   Sun, 16 Jul 2023 21:50:12 +0200
Message-ID: <20230716195006.774048806@linuxfoundation.org>
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

From: David Sterba <dsterba@suse.com>

commit 1a1b0e729d227f9f758f7b5f1c997e874e94156e upstream.

The block group tree was not present among the lockdep classes. We could
get potentially lockdep warnings but so far none has been seen, also
because block-group-tree is a relatively new feature.

CC: stable@vger.kernel.org # 6.1+
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/locking.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -57,8 +57,8 @@
 
 static struct btrfs_lockdep_keyset {
 	u64			id;		/* root objectid */
-	/* Longest entry: btrfs-free-space-00 */
-	char			names[BTRFS_MAX_LEVEL][20];
+	/* Longest entry: btrfs-block-group-00 */
+	char			names[BTRFS_MAX_LEVEL][24];
 	struct lock_class_key	keys[BTRFS_MAX_LEVEL];
 } btrfs_lockdep_keysets[] = {
 	{ .id = BTRFS_ROOT_TREE_OBJECTID,	DEFINE_NAME("root")	},
@@ -72,6 +72,7 @@ static struct btrfs_lockdep_keyset {
 	{ .id = BTRFS_DATA_RELOC_TREE_OBJECTID,	DEFINE_NAME("dreloc")	},
 	{ .id = BTRFS_UUID_TREE_OBJECTID,	DEFINE_NAME("uuid")	},
 	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	DEFINE_NAME("free-space") },
+	{ .id = BTRFS_BLOCK_GROUP_TREE_OBJECTID, DEFINE_NAME("block-group") },
 	{ .id = 0,				DEFINE_NAME("tree")	},
 };
 


